package com.kjs.service.kjs.course;

import com.google.common.collect.Maps;
import com.google.gson.Gson;
import com.kjs.common.aop.LogAspectj;
import com.kjs.common.dto.LiveWatchNumDTO;
import com.kjs.common.dto.WatchNumByDateDTO;
import com.kjs.common.exception.SmsSendException;
import com.kjs.common.utils.CCPRestSmsUtilBean;
import com.kjs.orm.mapper.CategoryDirectionMapper;
import com.kjs.orm.mapper.CourseLiveMapper;
import com.kjs.orm.model.CourseLive;
import com.kjs.service.core.BaseService;
import com.kjs.service.kjs.course.spi.ICourseLiveService;
import org.apache.commons.lang3.time.DateUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.scheduling.concurrent.ThreadPoolTaskScheduler;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.CollectionUtils;

import javax.annotation.PostConstruct;
import javax.annotation.Resource;
import java.text.SimpleDateFormat;
import java.util.*;
import java.util.concurrent.ScheduledFuture;

import static com.kjs.common.bean.ParamUtil.LIVE_BOOK_TEMP_ID;
import static com.kjs.common.constant.SystemConstant.LIVE_BOOKING_USER_KEY;

/**
 * Service Implementation:CourseLive
 * @author duia_builder
 * @date 2016-5-23
 */
@Service
@Transactional
public class CourseLiveService extends BaseService<CourseLive,Long> implements ICourseLiveService {
    private final static Logger logger = LoggerFactory.getLogger(LogAspectj.class);
    @Resource
    private CategoryDirectionMapper categoryDirectionDao;
    @Resource
    private CourseLiveMapper courseLiveMapper;
    @Resource
    private ThreadPoolTaskScheduler threadPoolTaskScheduler;
    @Resource(name = "liveRedisTemplate")
    private RedisTemplate redisTemplate;
    private Map<Long, ScheduledFuture<?>> futureMap = Maps.newConcurrentMap();
    @Resource
    private CCPRestSmsUtilBean ccpRestSmsUtilBean;

    @Override
    public void logicDelete(Long id) {
        CourseLive courseLive = new CourseLive();
        courseLive.setId(id);
        courseLive.setDeleted(1);
        this.iBaseDao.update(courseLive);
    }

    @Override
    public Map findLiveWatchNumByDate(ArrayList<Date> betweenTimes,List<Integer> ids) {
        Map liveWatchNumMap = new HashMap();
        if (CollectionUtils.isEmpty(ids)) {
            return liveWatchNumMap;
        }
        SimpleDateFormat sdfTime = new SimpleDateFormat("yyyy/MM/dd");
        ArrayList<WatchNumByDateDTO> respDtos = new ArrayList<>();
        List<LiveWatchNumDTO> liveWatchNumByDates = courseLiveMapper.findLiveWatchNumByDates(betweenTimes, ids);
        List<LiveWatchNumDTO> liveTitles=courseLiveMapper.findLiveTitlesByLiveIds(ids);
        for (Integer id:ids){
           WatchNumByDateDTO respDto = new WatchNumByDateDTO();
           for (LiveWatchNumDTO dto: liveTitles) {
               if (id.equals(dto.getLiveId()) ){
                   respDto.setLiveTitle(dto.getTitleName());
               }
           }
           respDto.setId(id);
           ArrayList<Integer> numList = new ArrayList<>();
           for (Date date:betweenTimes) {
               LiveWatchNumDTO singNumDto = new LiveWatchNumDTO();
               int num = 0;
               for (LiveWatchNumDTO dto : liveWatchNumByDates) {
                   if (id.equals( dto.getLiveId())) {
                       String format = sdfTime.format(date);
                       String format1 = sdfTime.format(dto.getDate());
                       if (sdfTime.format(date).equals(sdfTime.format(dto.getDate()))) {
                           num = dto.getNumber();
                           break;
                       }
                   }
               }
               numList.add(num);
           }
             respDto.setNumList(numList);
             respDtos.add(respDto);
       }
        liveWatchNumMap.put("numMap", respDtos);
        return liveWatchNumMap;
    }

    @Override
    public void createLiveBookingTask(Date liveTime, Long liveId){
        final  String bookingKey = LIVE_BOOKING_USER_KEY+liveId;
        ScheduledFuture<?> future = threadPoolTaskScheduler.schedule(new Runnable() {
            @Override
            public void run() {
                logger.debug("=======================直播预约发短信开始执行=====================");
                String result = (String) redisTemplate.opsForValue().get(bookingKey);
                Map<String,String> resultMap = new Gson().fromJson(result,HashMap.class);
                if(!CollectionUtils.isEmpty(resultMap)){
                    for(String mobile : resultMap.keySet()){
                        String desc = resultMap.get(mobile);
                        try {
                            logger.debug("=======================直播"+desc+",预约短信已发送[mobile:"+mobile+"]=====================");
                            ccpRestSmsUtilBean.send(mobile, LIVE_BOOK_TEMP_ID, new String[]{desc});
                        } catch (SmsSendException e) {
                            logger.error(e.getMessage(),e);
                        }
                    }
                }
            }
        }, DateUtils.addMinutes(liveTime, - 5));

        futureMap.put(liveId,future);
    }

    @Override
    public void updateLiveBookingTask(Date oldLiveTime, Date liveTime, Long liveId){
        final  String bookingKey = LIVE_BOOKING_USER_KEY+liveId;
        Map<String,String> resultMap = Maps.newHashMap();

        if(!liveTime.equals(oldLiveTime)){
            if(redisTemplate.hasKey(bookingKey)){
                String result = (String) redisTemplate.opsForValue().get(bookingKey);
                resultMap = new Gson().fromJson(result,HashMap.class);
            }

            Boolean exists = this.removeLiveBookingTask(liveId);
            if(exists){
                redisTemplate.opsForValue().set(bookingKey, new Gson().toJson(resultMap));
            }

            createLiveBookingTask(liveTime,liveId);
        }
    }

    @Override
    public Boolean removeLiveBookingTask(final Long liveId){
        Boolean exists = false;
        try{
            ScheduledFuture<?> future = futureMap.get(liveId);
            if(future != null && !future.isCancelled()){
                exists = future.cancel(true);
                logger.debug("=======================直播id:"+liveId+",预约短信任务取消成功！]=====================");
            }
        }catch (Exception e){
            logger.error(e.getMessage(),e);
        }
        return exists;
    }

    @PostConstruct
    public void initScheduled() {
        List<CourseLive> list = courseLiveMapper.initScheduled();
        for (CourseLive courseLive : list) {
            createLiveBookingTask(courseLive.getLiveStart(), courseLive.getId());
        }
    }
}
