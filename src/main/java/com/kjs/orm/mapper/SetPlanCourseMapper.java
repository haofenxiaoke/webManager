package com.kjs.orm.mapper;

import com.kjs.orm.core.BaseMapper;
import com.kjs.orm.model.SetPlanCourse;
import com.kjs.web.serach.kjs.plan.PlanManagerSerachBean;
import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Map;

public interface SetPlanCourseMapper extends BaseMapper<SetPlanCourse,Long> {

    List<Map> pageInfo(PlanManagerSerachBean serachBean);

    Long countInfo(PlanManagerSerachBean serachBean);

    void updateByCondition(@Param("curId")Integer curId, @Param("preId")Integer preId);

    /**
     * 根据计划ID删除标签
     * @param planId
     */
    void deleteObj(@Param("planId") Integer planId);

}