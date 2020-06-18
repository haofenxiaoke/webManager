package com.kjs.service.kjs.course;

import com.kjs.orm.mapper.CourseSuitableMapper;
import com.kjs.orm.model.CourseSuitable;
import com.kjs.service.core.BaseService;
import com.kjs.service.kjs.course.spi.ICourseSuitableService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;

/**
 * Service Implementation:CourseSuitable
 * @author duia_builder
 * @date 2016-5-23
 */
@Service
public class CourseSuitableService extends BaseService<CourseSuitable,Long> implements ICourseSuitableService {

    @Resource
    private CourseSuitableMapper courseSuitableDao;
    @Override
    public void deleteCourseSuitable(Integer courseId) {
        courseSuitableDao.deleteCourseSuitable(courseId);
    }
}
