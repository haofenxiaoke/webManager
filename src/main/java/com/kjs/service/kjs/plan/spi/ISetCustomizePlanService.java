package com.kjs.service.kjs.plan.spi;

import com.kjs.orm.model.SetCustomizePlan;
import com.kjs.service.core.spi.IBaseService;
import com.kjs.web.serach.kjs.plan.PlanManagerSerachBean;

import java.util.Map;

/**
 * Service Interface:SetCustomizePlan
 * @author duia_builder
 * @date 2016-5-23
 */
public interface ISetCustomizePlanService extends IBaseService<SetCustomizePlan,Long> {

    /**
     * 根据条件获取用户的数据(分页)
     * @param serachBean
     */
    void findPage(PlanManagerSerachBean serachBean);

    /**
     * 根据条件获取用户的数据(分页)
     * @param serachBean
     */
    void searchSelectCoursePage(PlanManagerSerachBean serachBean);

    /**
     * 保存计划信息
     * @param setCustomizePlan
     */
    void savaPlanByIds(SetCustomizePlan setCustomizePlan);

    /**
     * 删除计划
     * @param plan
     */
    void removeEmp(SetCustomizePlan plan);

    /**
     *  更新计划 及插入标签
     * @paramMap
     */
    void updatePlanEmp(Map paramMap);

    void updateStageEmp(Map paramMap);

    void updateStagePlansEmp(Map paramMap);

}