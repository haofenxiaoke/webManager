package com.kjs.service.kjs.course.spi;

import com.kjs.orm.model.CourseText;
import com.kjs.service.core.spi.IBaseService;

/**
 * Service Interface:CourseText
 * @author duia_builder
 * @date 2016-5-23
 */
public interface ICourseTextService extends IBaseService<CourseText,Long> {
    /**
     * 保存长字段
     * @param courseText
     * @return
     */
	public  void saveCourseText(CourseText courseText);

    /**
     * 根据课程Id删除课程长字段
     * @param courseId
     */
    public void deleteCourseText(Integer courseId);

    /**
     * 根据课程Id删选课程长字段
     * @param courseId
     * @return
     */
    public CourseText selectByCourseId(Integer courseId);
}