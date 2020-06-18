package com.kjs.orm.mapper;

import com.kjs.common.bean.annotation.CleanCache;
import com.kjs.orm.core.BaseMapper;
import com.kjs.orm.model.CourseText;

@CleanCache(key="com.kjs.orm.mapper.CourseTextMapper")
public interface CourseTextMapper extends BaseMapper<CourseText,Long> {
   void saveText(CourseText courseText);

   void deleteByCourseId(Integer courseId);

   void  delByCourseId(Integer courseId);

   CourseText selectByCourseId(Integer courseId);
}