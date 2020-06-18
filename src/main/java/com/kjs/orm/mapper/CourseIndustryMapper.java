package com.kjs.orm.mapper;

import com.kjs.orm.core.BaseMapper;
import com.kjs.orm.model.CourseIndustry;
import org.apache.ibatis.annotations.Param;

public interface CourseIndustryMapper extends BaseMapper<CourseIndustry,Long> {

      void deleteCourseIndustry(Integer courseId);

      int countCheckDelInd(@Param("industryId") Integer industryId);

}