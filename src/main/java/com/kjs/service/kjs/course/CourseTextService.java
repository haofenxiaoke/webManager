package com.kjs.service.kjs.course;

import com.kjs.orm.mapper.CourseTextMapper;
import com.kjs.orm.model.CourseText;
import com.kjs.service.core.BaseService;
import com.kjs.service.kjs.course.spi.ICourseTextService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;

/**
 * Service Implementation:CourseText
 * @author duia_builder
 * @date 2016-5-23
 */
@Service
public class CourseTextService extends BaseService<CourseText,Long> implements ICourseTextService {
   @Resource
   private CourseTextMapper courseTextDao;

    @Override
    public void saveCourseText(CourseText courseText) {
         courseTextDao.saveText(courseText);
    }

    @Override
    public void deleteCourseText(Integer courseId) {
        courseTextDao.deleteByCourseId(courseId);
    }

    @Override
    public CourseText selectByCourseId(Integer courseId) {
        return courseTextDao.selectByCourseId(courseId);
    }
}
