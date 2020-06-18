package com.kjs.service.kjs.course;

import com.alibaba.fastjson.JSON;
import com.google.common.collect.Maps;
import com.kjs.orm.mapper.CourseQuestionMapper;
import com.kjs.orm.model.CourseQuestion;
import com.kjs.orm.model.CourseQuestionReply;
import com.kjs.service.PushService;
import com.kjs.service.core.BaseService;
import com.kjs.service.kjs.course.spi.ICourseQuestionReplyService;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.io.IOException;
import java.util.Map;
import java.util.Properties;

/**
 * Service Implementation:CourseQuestionReply
 *
 * @author duia_builder
 * @date 2016-5-23
 */
@Service
public class CourseQuestionReplyService extends BaseService<CourseQuestionReply, Long> implements ICourseQuestionReplyService {
    @Resource
    private CourseQuestionMapper questionDao;
    @Resource
    private PushService pushService;

    @Override
    public void reply(CourseQuestionReply reply) throws IOException {
        this.iBaseDao.save(reply);
        CourseQuestion question = questionDao.findById(reply.getQuestionId());
        question.setState(1);
        question.setReplyNum(question.getReplyNum() + 1);
        questionDao.update(question);
        //推送
        String text = "老师已经回复了你的提问，快去瞧瞧吧";
        Map<String, Object> data = Maps.newLinkedHashMap();
        data.put("text", text);
        data.put("code", 2);
        String message = JSON.toJSONString(data);

        Properties properties = new Properties();
        properties.load(Thread.currentThread().getContextClassLoader().getResourceAsStream("param.properties"));
        String  suffix = properties.getProperty("app.push.alias.suffix");
        String alias = String.valueOf(question.getId()) + suffix;

        //IOS APN 附加参数
        Map<String, Object> aps = Maps.newLinkedHashMap();
        aps.put("alert", text);
        aps.put("badge", 1);
        aps.put("sound", "bingbong.aiff");
        aps.put("code", 2);

        Map<String, Object> apn_json = Maps.newLinkedHashMap();
        apn_json.put("aps", aps);

        Map<String, Object> opts = Maps.newLinkedHashMap();
        opts.put("apn_json", apn_json);
        pushService.aliasPush(alias, message, aps);
    }
}
