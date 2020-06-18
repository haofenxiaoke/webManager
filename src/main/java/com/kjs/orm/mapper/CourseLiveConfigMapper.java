package com.kjs.orm.mapper;

import com.kjs.orm.core.BaseMapper;
import com.kjs.orm.model.CourseLive;
import com.kjs.orm.model.CourseLiveConfig;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface CourseLiveConfigMapper extends BaseMapper<CourseLiveConfig,Long> {
    List<CourseLiveConfig> findAllConfigLive();
    List<CourseLive> findliveListByIdAndType(@Param("categoryId") Integer categoryId, @Param("type")Integer type);
    List<Integer> findAllIds();
    List<Integer> findAllCourseIds();
}