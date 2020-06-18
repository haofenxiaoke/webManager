package com.kjs.service.kjs.course.spi;

import com.kjs.orm.model.CourseQuestionReply;
import com.kjs.service.core.spi.IBaseService;

import java.io.IOException;

/**
 * Service Interface:CourseQuestionReply
 * @author duia_builder
 * @date 2016-5-23
 */
public interface ICourseQuestionReplyService extends IBaseService<CourseQuestionReply,Long> {

    void reply(CourseQuestionReply reply) throws IOException;

}