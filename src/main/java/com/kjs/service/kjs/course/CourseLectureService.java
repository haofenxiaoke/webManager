package com.kjs.service.kjs.course;

import com.kjs.orm.mapper.CourseLectureMapper;
import com.kjs.orm.model.CourseLecture;
import com.kjs.service.core.BaseService;
import com.kjs.service.kjs.course.spi.ICourseLectureService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.io.*;
import java.net.MalformedURLException;
import java.net.URL;
import java.net.URLConnection;
import java.util.List;

/**
 * Service Implementation:CourseLecture
 * @author duia_builder
 * @date 2016-5-23
 */
@Service
public class CourseLectureService extends BaseService<CourseLecture,Long> implements ICourseLectureService {
    @Resource
    private CourseLectureMapper courseLectureDao;

    @Override
    public void insertLecture(List<CourseLecture> courseLectureList) {
        courseLectureDao.insertLecture(courseLectureList);
    }

    @Override
    public List<CourseLecture> findByCourseId(Long id) {
        return courseLectureDao.findByCourseId(id);
    }

    @Override
    public void deleteByCourseId(Integer courseId) {
        courseLectureDao.deleteByCourseId(courseId);
    }

    @Override
    public List<CourseLecture> findByCourseIdComplete(Long id) {
        return courseLectureDao.findByCourseIdComplete(id);
    }

    @Override
    public void deleteLecturesByCourseId(Integer courseId) {
        courseLectureDao.deleteLecturesByCourseId(courseId);
    }

    @Override
    public void deleteById(Long id) {
        courseLectureDao.deleteById(id);
    }

    @Override
    public void findAll() {
        List<CourseLecture> courseLectureList=courseLectureDao.findAll();
        for(CourseLecture courseLecture:courseLectureList) {
            if (courseLecture.getLecturePptUrl() != null && courseLecture.getLecturePptUrl() != "") {
                URL url = null;
                try {
                    url = new URL(courseLecture.getLecturePptUrl());
                    URLConnection connection = url.openConnection();
                    Integer FileLength= connection.getContentLength();
                   // System.out.println(courseLecture.getLecturePptUrl()+"--"+FileLength);
                    courseLecture.setFileLength(FileLength);
                    courseLectureDao.update(courseLecture);
                } catch (MalformedURLException e) {
                    e.printStackTrace();
                } catch (UnsupportedEncodingException e) {
                    e.printStackTrace();
                } catch (IOException e) {
                    e.printStackTrace();
                }



            }
        }
    }
}
