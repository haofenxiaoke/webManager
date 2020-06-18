package com.kjs.service.kjs.course.spi;

import com.kjs.orm.model.CourseAdvantage;
import com.kjs.service.core.spi.IBaseService;

/**
 * Service Interface:CourseAdvantage
 * @author duia_builder
 * @date 2016-5-23
 */
public interface ICourseAdvantageService extends IBaseService<CourseAdvantage,Long> {
    /**
     * 删除某课程关联的课程优势标签
     * @param courseId
     */
    public void deleteCourseAdvantage(Integer courseId);
}