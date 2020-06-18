package com.kjs.orm.mapper;

import com.kjs.orm.core.BaseMapper;
import com.kjs.orm.model.SetPlanTag;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface SetPlanTagMapper extends BaseMapper<SetPlanTag,Long> {

    List<SetPlanTag> searchTagsByPlanId(Integer planId);

    /**
     * 根据计划ID删除标签
     * @param planId
     */
    void deleteObj(@Param("planId") Integer planId);

}