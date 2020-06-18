package com.kjs.service.kjs.home.spi;

import com.kjs.orm.model.HomeSet;
import com.kjs.service.core.spi.IBaseService;

import java.util.List;
import java.util.Map;

/**
 * Service Interface:HomeSet
 * @author duia_builder
 * @date 2016-5-23
 */
public interface IHomeSetService extends IBaseService<HomeSet,Long> {

    List<Map> queryAllSets();

    List<Map> searchCoursesWithHomeSet();

    HomeSet getSetByType(Integer type,List<HomeSet> setList);

    List<HomeSet> findHomeSet();

    void  updateHomeSet(Integer preCourseId,Integer courseId);

    void saveHotEmp(Map paramMap);

}