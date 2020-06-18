package com.kjs.orm.mapper;

import com.kjs.orm.core.BaseMapper;
import com.kjs.orm.model.CourseText;
import com.kjs.orm.model.CourseTicket;

public interface CourseTicketMapper extends BaseMapper<CourseTicket,Long> {
    int deleteByPrimaryKey(Integer id);

    int insert(CourseTicket record);

    int insertSelective(CourseTicket record);

    CourseTicket selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(CourseTicket record);

    int updateByPrimaryKey(CourseTicket record);
}