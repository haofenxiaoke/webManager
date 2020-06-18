package com.kjs.service.kjs.course.spi;

import com.kjs.orm.model.CourseIndustry;
import com.kjs.service.core.spi.IBaseService;

/**
 * Service Interface:CourseIndustry
 * @author duia_builder
 * @date 2016-5-23
 */
public interface ICourseIndustryService extends IBaseService<CourseIndustry,Long> {

    /**
     * 保存课程和行业的对应关系
     * @param courseIndustry
     */
    public void saveCourseIndustry(CourseIndustry courseIndustry);

    /**
     * 将某课程的 课程行业对应关系设置为删除状态
     * @param courseId
     */
    public void deleteCourseIndustry(Integer courseId);

    Boolean countCheckDelInd(Integer industryId);
	
}