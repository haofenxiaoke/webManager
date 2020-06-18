package com.kjs.web.controller.task;

import com.alibaba.fastjson.JSON;
import com.google.common.collect.Maps;
import com.kjs.common.bean.ParamUtil;
import com.kjs.common.dto.BroadcastDto;
import com.kjs.orm.mapper.VipInfoMapper;
import com.kjs.orm.model.VipInfo;
import com.kjs.service.PushService;
import com.kjs.service.kjs.course.CourseService;
import org.apache.commons.lang3.RandomStringUtils;
import org.apache.commons.lang3.RandomUtils;
import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.data.redis.core.BoundListOperations;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import javax.annotation.Resource;
import java.io.IOException;
import java.util.List;
import java.util.Map;
import java.util.Properties;

import static com.kjs.common.constant.SystemConstant.BROADCAST_BUY_REDIS_COUNT_KEY;
import static com.kjs.common.constant.SystemConstant.BROADCAST_BUY_REDIS_LIST_KEY;

/**
 * Created by 李恒名 on 2016/7/25.
 * 定时任务
 */
@Component
public class TimeTask {

    private final static Logger logger = LoggerFactory.getLogger(TimeTask.class);
    @Resource
    private RedisTemplate redisTemplate;
    @Resource
    private CourseService courseService;

    /*
     *课程章节平均分
     */
    @Scheduled(cron = "0 4 00 ? * MON")//每每周周一的4点执行一次
    public void updateScore() {
        try {
            courseService.updateScore();
            logger.error("更新课程平均分成功");
        } catch (Exception e) {
            logger.error("更新课程平均分失败:", e);
        }
    }

    /**
     * 每日凌晨清空会员购买列表
     */
    @Scheduled(cron = "59 59 23 * * ?")
    public void cleanRecentlyBuyList() {
        if (redisTemplate.hasKey(BROADCAST_BUY_REDIS_LIST_KEY)) {
            redisTemplate.delete(BROADCAST_BUY_REDIS_LIST_KEY);
        }
        if (redisTemplate.hasKey(BROADCAST_BUY_REDIS_COUNT_KEY)) {
            redisTemplate.delete(BROADCAST_BUY_REDIS_COUNT_KEY);
        }
    }

    /**
     * 每日2MIN 会员购买数量+1
     */

    @Scheduled(fixedRate = 1000 * 60 * 2)
    public void increaseRecentlyBuyCount() {
        if (redisTemplate.hasKey(BROADCAST_BUY_REDIS_COUNT_KEY)) {
            Integer count = (Integer) redisTemplate.opsForValue().get(BROADCAST_BUY_REDIS_COUNT_KEY);
            redisTemplate.opsForValue().set(BROADCAST_BUY_REDIS_COUNT_KEY, count + 1);
        } else {
            redisTemplate.opsForValue().set(BROADCAST_BUY_REDIS_COUNT_KEY, 1);
        }

    }

    /**
     * 会员广播推送每3秒一次~
     */
    @Resource
    private VipInfoMapper vipInfoMapper;
    @Resource
    private PushService pushService;
    @Value("${app.push.topic.buy}")
    private String topic;
    @Scheduled(fixedRate = 3000)
    public void pushBuyBroadcast() throws IOException {
        if ( StringUtils.equals(ParamUtil.hostUrl, "http://back.kuaijishizi.com") ||  StringUtils.equals(ParamUtil.hostUrl, "http://back.shejiniu.net")) {//是否为正式环境
            final long recently = 3000;//最近所指的时间，单位毫秒
            BoundListOperations ops = redisTemplate.boundListOps(BROADCAST_BUY_REDIS_LIST_KEY);
            List<BroadcastDto> list = ops.range(0, -1);
            BroadcastDto broadcast = null;
            //查找符合条件的订单数据
            for (BroadcastDto broadcastDto : list) {
                if (System.currentTimeMillis() - broadcastDto.getBuyDate().getTime() < recently) {
                    broadcast = broadcastDto;
                }
            }

            //假数据
            String[] cities = new String[]{"北京市", "上海市", "广州市", "深圳市", "杭州市", "成都市", "郑州市", "南京市", "武汉市", "重庆市", "南宁市", "天津市"};
            String[] mobilePrefix = new String[]{"131", "132", "137", "138", "139", "152", "153", "182", "180", "185", "186", "189", "188"};
            List<VipInfo> vipInfoList = vipInfoMapper.queryAll();

            Integer price = 0;
            for(VipInfo vipInfo : vipInfoList){
                if(vipInfo.getDays() == 360){
                    price = vipInfo.getPrice();
                }
            }

            //填充假数据
            if (broadcast == null) {
                broadcast = new BroadcastDto();
                broadcast.setCity(cities[RandomUtils.nextInt(0, cities.length)]);
                broadcast.setMobile(mobilePrefix[RandomUtils.nextInt(0, mobilePrefix.length)] + "*****" + RandomStringUtils.randomNumeric(3));
                broadcast.setPrice(price);
            }

            Map<String, Object> data = Maps.newHashMap();
            data.put("city",broadcast.getCity());
            data.put("mobile",broadcast.getMobile());
            data.put("price",broadcast.getPrice());

            String message = JSON.toJSONString(data);

            Properties properties = new Properties();
            properties.load(Thread.currentThread().getContextClassLoader().getResourceAsStream("param.properties"));
            String  topic = properties.getProperty("app.push.topic.buy");
            pushService.publishPush(topic, message, null);

        }

    }
}
