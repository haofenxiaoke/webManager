package com.kjs.service.kjs.course;

import com.kjs.orm.model.CourseCustomizePlan;
import com.kjs.service.core.BaseService;
import com.kjs.service.kjs.course.spi.ICourseCustomizePlanService;
import org.springframework.stereotype.Service;

/**
 * Service Implementation:CourseCustomizePlan
 * @author duia_builder
 * @date 2016-5-23
 */
@Service
public class CourseCustomizePlanService extends BaseService<CourseCustomizePlan,Long> implements ICourseCustomizePlanService {
}
