package com.kjs.service.kjs.course;

import com.kjs.orm.model.CourseStudiesDetail;
import com.kjs.service.core.BaseService;
import com.kjs.service.kjs.course.spi.ICourseStudiesDetailService;
import org.springframework.stereotype.Service;

/**
 * Service Implementation:CourseStudiesDetail
 * @author duia_builder
 * @date 2016-5-23
 */
@Service
public class CourseStudiesDetailService extends BaseService<CourseStudiesDetail,Long> implements ICourseStudiesDetailService {
}
