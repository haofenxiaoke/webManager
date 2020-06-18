package com.kjs.orm.mapper;

import com.kjs.orm.core.BaseMapper;
import com.kjs.orm.model.SetCustomizePlan;
import com.kjs.web.serach.kjs.plan.PlanManagerSerachBean;
import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Map;

public interface SetCustomizePlanMapper extends BaseMapper<SetCustomizePlan,Long> {

    List<Map> pageInfo(PlanManagerSerachBean serachBean);

    Long countInfo(PlanManagerSerachBean serachBean);

    List<Map> pageCourseInfo(PlanManagerSerachBean serachBean);

    Long countCourseInfo(PlanManagerSerachBean serachBean);

    void savePlanByIds(SetCustomizePlan setCustomizePlan);

    int countCheckDel(@Param("directionId")Integer directionId,@Param("positionId")Integer positionId);

    void deletePlanByCate(@Param("industryId")Integer industryId,@Param("positionId")Integer positionId);

}