package com.kjs.service.kjs.plan;

import com.kjs.common.utils.RequestParamUtils;
import com.kjs.common.utils.SortUtils;
import com.kjs.orm.mapper.SetCustomizePlanMapper;
import com.kjs.orm.mapper.SetPlanCourseMapper;
import com.kjs.orm.mapper.SetPlanTagMapper;
import com.kjs.orm.model.SetCustomizePlan;
import com.kjs.orm.model.SetPlanCourse;
import com.kjs.orm.model.SetPlanTag;
import com.kjs.service.core.BaseService;
import com.kjs.service.kjs.plan.spi.ISetCustomizePlanService;
import com.kjs.web.controller.kjs.index.IndexController;
import com.kjs.web.serach.kjs.plan.PlanManagerSerachBean;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.CollectionUtils;

import javax.annotation.Resource;
import java.util.Date;
import java.util.List;
import java.util.Map;

/**
 * Service Implementation:SetCustomizePlan
 * @author duia_builder
 * @date 2016-5-23
 */
@Service
public class SetCustomizePlanService extends BaseService<SetCustomizePlan,Long> implements ISetCustomizePlanService {
    @Resource
    private SetCustomizePlanMapper setCustomizePlanDao;
    @Resource
    private SetPlanTagMapper setPlanTagDao;
    @Resource
    private SetPlanCourseMapper setPlanCourseDao;

    @Override
    public void findPage(PlanManagerSerachBean serachBean) {
        List<Map> list = this.setCustomizePlanDao.pageInfo(serachBean);
        if(!CollectionUtils.isEmpty(list))
        {
            SortUtils.sortTheList(list, "create_time", SortUtils.SORT_ORDER_ASC);
            long count = this.setCustomizePlanDao.countInfo(serachBean);
            serachBean.setRecordsTotal(count);
            serachBean.setRecordsFiltered(count);
            serachBean.setData(list);
        }
    }

    public void searchSelectCoursePage(PlanManagerSerachBean serachBean) {
        List<Map> list = this.setCustomizePlanDao.pageCourseInfo(serachBean);
        if(!CollectionUtils.isEmpty(list))
        {
            SortUtils.sortTheList(list, "create_time", SortUtils.SORT_ORDER_ASC);
            long count = this.setCustomizePlanDao.countCourseInfo(serachBean);
            serachBean.setRecordsTotal(count);
            serachBean.setRecordsFiltered(count);
            serachBean.setData(list);
        }
    }

    @Override
    public void savaPlanByIds(SetCustomizePlan setCustomizePlan) {
        setCustomizePlanDao.savePlanByIds(setCustomizePlan);
    }

    @Override
    public void removeEmp(SetCustomizePlan plan) {
        plan = setCustomizePlanDao.findById(plan.getId());
        SetCustomizePlan newPlan = new SetCustomizePlan();
        newPlan.setState(false);
        newPlan.setDeleted(false);
        newPlan.setCreateTime(new Date());
        newPlan.setDirectionId(plan.getDirectionId());
        newPlan.setIndustryId(plan.getIndustryId());
        newPlan.setPositionId(plan.getPositionId());
        newPlan.setPlanDescribe(plan.getPlanDescribe());
        this.setCustomizePlanDao.save(newPlan);
        //删除旧的计划
        this.setCustomizePlanDao.deleteByIds(new Long[]{plan.getId()});
        //删除计划对应得课程表
        setPlanCourseDao.deleteObj(plan.getId().intValue());
        //删除计划对应得标签
        setPlanTagDao.deleteObj(plan.getId().intValue());
    }

    @Override
    public void updatePlanEmp(Map paramMap) {
        if(paramMap!=null){
            Integer planId = Integer.valueOf((String) paramMap.get("id"));

            SetCustomizePlan plan = new SetCustomizePlan();
            plan.setId(planId.longValue());
            plan.setStuNum(Integer.valueOf((String) paramMap.get("stuNum")));
            plan.setStuMonthNum(Integer.valueOf((String) paramMap.get("stuMonthNum")));
            plan.setCreateTime(new Date());
            this.update(plan);

            setPlanTagDao.deleteObj(planId);

            for (Object key : paramMap.keySet()) {
                String keystr = (String)key;
                if(keystr.contains("planTag")){
                    String k =keystr.split("planTag")[1];
                    SetPlanTag planTag = new SetPlanTag();
                    planTag.setPlanId(planId);
                    planTag.setDeleted(false);
                    planTag.setOrderNum(Integer.valueOf((String) paramMap.get("orderNum" + k)));
                    planTag.setPlanTagId(Integer.valueOf((String) paramMap.get(key)));
                    planTag.setCreateTime(new Date());
                    this.setPlanTagDao.save(planTag);

                }
            }
        }
        //
    }

    @Override
    public void updateStageEmp(Map paramMap) {
        if(paramMap!=null && paramMap.size()>0){
            Long firstid = RequestParamUtils.switchToLong(paramMap.get("firstid"));
            Integer firstnum = RequestParamUtils.switchToInteger(paramMap.get("firstnum"));
            Long lastid = RequestParamUtils.switchToLong(paramMap.get("lastid"));
            Integer lastnum = RequestParamUtils.switchToInteger(paramMap.get("lastnum"));

            SetPlanCourse planCourse = new SetPlanCourse();
            planCourse.setId(firstid);
            planCourse.setPlanStage(firstnum);
            this.setPlanCourseDao.update(planCourse);
            planCourse.setId(lastid);
            planCourse.setPlanStage(lastnum);
            this.setPlanCourseDao.update(planCourse);
        }
    }

    @Override
    @Transactional
    public void updateStagePlansEmp(Map paramMap) {
        if(paramMap!=null && paramMap.size()>0){
            Long planId = RequestParamUtils.switchToLong(paramMap.get("planId"));
            String orders = (String) paramMap.get("orders");

            //更新计划状态
            SetCustomizePlan plan = new SetCustomizePlan();
            plan.setId(planId);
            plan.setCreateTime(new Date());
            plan.setState(true);
            this.setCustomizePlanDao.update(plan);

            String[] arry = orders.split(",");
            if(arry!=null && arry.length>0){
                for(String obj:arry){
                    String[] data = obj.split(":");
                    Integer num = RequestParamUtils.switchToInteger(data[0]);
                    Long id = RequestParamUtils.switchToLong(data[1]);
                    SetPlanCourse planCourse = new SetPlanCourse();
                    planCourse.setId(id);
                    planCourse.setPlanStage(num);
                    //阶段重新排序
                    this.setPlanCourseDao.update(planCourse);
                }
            }
        }
    }
}
