package com.kjs.service.kjs.course;

import com.kjs.orm.mapper.CourseAdvantageMapper;
import com.kjs.orm.model.CourseAdvantage;
import com.kjs.service.core.BaseService;
import com.kjs.service.kjs.course.spi.ICourseAdvantageService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;

/**
 * Service Implementation:CourseAdvantage
 * @author duia_builder
 * @date 2016-5-23
 */
@Service
public class CourseAdvantageService extends BaseService<CourseAdvantage,Long> implements ICourseAdvantageService {

    @Resource
    private CourseAdvantageMapper courseAdvatageDao;
    @Override
    public void deleteCourseAdvantage(Integer courseId) {
        courseAdvatageDao.deleteCourseAdvantage(courseId);
    }
}
