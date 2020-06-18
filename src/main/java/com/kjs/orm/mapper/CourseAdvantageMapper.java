package com.kjs.orm.mapper;

import com.kjs.orm.core.BaseMapper;
import com.kjs.orm.model.CourseAdvantage;

public interface CourseAdvantageMapper extends BaseMapper<CourseAdvantage,Long> {

    public void deleteCourseAdvantage(Integer courseId);
	
}