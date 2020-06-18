package com.kjs.orm.mapper;

import com.kjs.common.bean.annotation.CleanCache;
import com.kjs.orm.core.BaseMapper;
import com.kjs.orm.model.HomeSet;

import java.util.List;
import java.util.Map;

@CleanCache(key="com.kjs.orm.mapper.HomeSetMapper")
public interface HomeSetMapper extends BaseMapper<HomeSet,Long> {
    /*
     *首页配置管理课程
     */
    List<Map> searchCoursesWithHomeSet();

    List<Map> searchInfo(HomeSet set);

    List<HomeSet> findHomeSet();
}