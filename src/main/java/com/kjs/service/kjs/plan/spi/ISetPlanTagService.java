package com.kjs.service.kjs.plan.spi;

import com.kjs.orm.model.SetPlanTag;
import com.kjs.service.core.spi.IBaseService;

import java.util.Map;

/**
 * Service Interface:SetPlanTag
 * @author duia_builder
 * @date 2016-6-15
 */
public interface ISetPlanTagService extends IBaseService<SetPlanTag,Long> {
    /**
     * 根据计划ID获取标签信息
     * @param planId
     * @return
     */
	Map searchTagsByPlanId(Integer planId);

    /**
     * 删除计划
     *
     * @param planId
     */
    void deleteObj(Integer planId);

}