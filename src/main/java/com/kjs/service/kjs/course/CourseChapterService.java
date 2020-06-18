package com.kjs.service.kjs.course;

import com.kjs.orm.model.CourseChapter;
import com.kjs.service.core.BaseService;
import com.kjs.service.kjs.course.spi.ICourseChapterService;
import org.springframework.stereotype.Service;

/**
 * Service Implementation:CourseChapter
 * @author duia_builder
 * @date 2016-5-23
 */
@Service
public class CourseChapterService extends BaseService<CourseChapter,Long> implements ICourseChapterService {
}
