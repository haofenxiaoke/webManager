package com.kjs.service.kjs.course;

import com.kjs.orm.model.CourseHistoricalView;
import com.kjs.service.core.BaseService;
import com.kjs.service.kjs.course.spi.ICourseHistoricalViewService;
import org.springframework.stereotype.Service;

/**
 * Service Implementation:CourseHistoricalView
 * @author duia_builder
 * @date 2016-5-23
 */
@Service
public class CourseHistoricalViewService extends BaseService<CourseHistoricalView,Long> implements ICourseHistoricalViewService {
}
