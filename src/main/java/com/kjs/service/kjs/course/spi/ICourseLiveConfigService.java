package com.kjs.service.kjs.course.spi;

import com.kjs.orm.model.CourseLive;
import com.kjs.orm.model.CourseLiveConfig;
import com.kjs.service.core.spi.IBaseService;

import java.util.List;
import java.util.Map;

/**
 * Service Interface:CourseLiveConfig
 * @author kjs_builder
 * @date 2017-3-29
 */
public interface ICourseLiveConfigService extends IBaseService<CourseLiveConfig,Long> {


    Map findAllConfigLive();

    List<CourseLive> findliveListByIdAndType(Integer directionId, Integer type);

    List<Integer> findAllIds();
    List<Integer> findAllCourseIds();
}