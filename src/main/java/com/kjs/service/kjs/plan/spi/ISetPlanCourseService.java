package com.kjs.service.kjs.plan.spi;

import com.kjs.orm.model.SetPlanCourse;
import com.kjs.service.core.spi.IBaseService;
import com.kjs.web.serach.kjs.plan.PlanManagerSerachBean;

import java.util.Map;

/**
 * Service Interface:SetPlanCourse
 * @author duia_builder
 * @date 2016-5-23
 */
public interface ISetPlanCourseService extends IBaseService<SetPlanCourse,Long> {

    /**
     * 根据条件获取用户的数据(分页)
     * @param serachBean
     */
    void findPage(PlanManagerSerachBean serachBean);

    /**
     * 保存计划课程
     * @param paramMap
     */
    void saveCourses(Map paramMap);

    /**
     * 计划库对应课程更新
     * @param curId 当前课程id
     * @param preId 上版本课程id
     */
    void updatePlanCourse(Integer curId,Integer preId);

    /**
     * 删除计划
     *
     * @param planId
     */
    void deleteObj(Integer planId);
}