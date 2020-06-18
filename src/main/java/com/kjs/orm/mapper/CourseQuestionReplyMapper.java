package com.kjs.orm.mapper;

import com.kjs.common.bean.annotation.CleanCache;
import com.kjs.orm.core.BaseMapper;
import com.kjs.orm.model.CourseQuestionReply;

import java.util.List;
import java.util.Map;
@CleanCache(key="com.kjs.orm.mapper.CourseQuestionReplyMapper")
public interface CourseQuestionReplyMapper extends BaseMapper<CourseQuestionReply,Long> {
    List<Map> getQuestionReply(Map paramMap);
}