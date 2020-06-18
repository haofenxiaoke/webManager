package com.kjs.orm.mapper;

import com.kjs.orm.core.BaseMapper;
import com.kjs.orm.model.CourseLecture;
import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Map;

public interface CourseLectureMapper extends BaseMapper<CourseLecture,Long> {

    public void insertLecture(@Param("list")List<CourseLecture> courseLectureList);

    List<CourseLecture> findByCourseId(Long id);
    /*根据课程ID删除章节*/
    void deleteByCourseId(Integer CourseId);

    /*获取完整的*/
    List<CourseLecture> findByCourseIdComplete(Long courseId);
    /*根据课程ID逻辑删除章节*/
    void deleteLecturesByCourseId(Integer courseId);

    void deleteById(Long id);

    List<CourseLecture> findAll();

	 List<Map> findCourseNum();


}