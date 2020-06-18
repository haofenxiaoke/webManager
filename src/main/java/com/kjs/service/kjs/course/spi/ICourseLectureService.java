package com.kjs.service.kjs.course.spi;

import com.kjs.orm.model.CourseLecture;
import com.kjs.service.core.spi.IBaseService;

import java.util.List;

/**
 * Service Interface:CourseLecture
 * @author duia_builder
 * @date 2016-5-23
 */
public interface ICourseLectureService extends IBaseService<CourseLecture,Long> {
    /**
     * 批量插入课程
     * @param courseLectureList
     */
    public void insertLecture(List<CourseLecture> courseLectureList);

    List<CourseLecture> findByCourseId(Long id);

    /*查询完整的章节对象*/
    List<CourseLecture> findByCourseIdComplete(Long id);
    /*根据课程Id删除章节*/
    void deleteByCourseId(Integer courseId);
    /*g根据课程ID逻辑删除章节*/
    void  deleteLecturesByCourseId(Integer courseId);
    /*根据Id删除章节*/
    void deleteById(Long id);
    /*获取所有章节*/
    void findAll();
}