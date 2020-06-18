package com.kjs.service.kjs.course.spi;

import com.kjs.orm.model.CourseSuitable;
import com.kjs.service.core.spi.IBaseService;

/**
 * Service Interface:CourseSuitable
 * @author duia_builder
 * @date 2016-5-23
 */
public interface ICourseSuitableService extends IBaseService<CourseSuitable,Long> {
    /**
     * 删除某课程关联的适合对象标签
     * @param courseId
     */
    public void deleteCourseSuitable(Integer courseId);
	
}