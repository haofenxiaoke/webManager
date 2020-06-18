package com.kjs.orm.mapper;

import com.kjs.orm.core.BaseMapper;
import com.kjs.orm.model.CourseSuitable;

public interface CourseSuitableMapper extends BaseMapper<CourseSuitable,Long> {

    /**
     * 删除某课程关联的适合对象标签
     * @param courseId
     */
    public void deleteCourseSuitable(Integer courseId);
}