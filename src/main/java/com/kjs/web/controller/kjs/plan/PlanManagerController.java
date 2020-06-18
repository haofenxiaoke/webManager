package com.kjs.web.controller.kjs.plan;

import com.kjs.common.bean.DataTablePageModel;
import com.kjs.common.bean.MenuCacheModel;
import com.kjs.common.bean.ResponseJsonModel;
import com.kjs.common.bean.annotation.AdminLogAnn;
import com.kjs.common.bean.annotation.PermissionAnn;
import com.kjs.common.bean.enums.OperLevel;
import com.kjs.common.bean.enums.OperType;
import com.kjs.common.utils.RequestParamUtils;
import com.kjs.common.utils.ShiroUtils;
import com.kjs.orm.model.CourseCustomizePlan;
import com.kjs.orm.model.SetCustomizePlan;
import com.kjs.service.kjs.category.spi.ICategoryDirectionService;
import com.kjs.service.kjs.course.CourseCustomizePlanService;
import com.kjs.service.kjs.plan.spi.ISetCustomizePlanService;
import com.kjs.service.kjs.plan.spi.ISetPlanCourseService;
import com.kjs.service.kjs.plan.spi.ISetPlanTagService;
import com.kjs.web.serach.kjs.plan.PlanManagerSerachBean;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import java.util.Date;
import java.util.Map;

/**
 * 学员管理控制器
 * Created by wangsongpeng on 2016/2/25.
 */
@Controller
@RequestMapping("/plan")
public class PlanManagerController {
    private final static Logger logger = LoggerFactory.getLogger(PlanManagerController.class);
    @Resource
    private ISetCustomizePlanService setCustomizePlanService;
    @Resource
    private ISetPlanCourseService setPlanCourseService;
    @Resource
    private ISetPlanTagService setPlanTagService;
    @Resource
    ICategoryDirectionService categoryDirectionService;
    @Resource
    private MenuCacheModel menuCacheModel;
    @Resource
    private CourseCustomizePlanService courseCustomizePlanService;

    /**
     * 跳转到定制计划管理页面
     * @return
     */
    @PermissionAnn(menuCode = "plan",msg = "你没有进入定制计划管理页面的权限!")
    @RequestMapping(value = "/manager")
    public String forwardManager(Model model){
        return "plan/plan_tab";
    }

    /**
     * 定制计划管理列表
     * @return
     */
    @PermissionAnn(menuCode = "plan",operCode = "find",msg = "你没有定制计划页面的查询权限!")
    @ResponseBody
    @RequestMapping(value = "/list",method = RequestMethod.POST)
    public DataTablePageModel serachVipInfo(PlanManagerSerachBean serachBean){
        Long[] ids = categoryDirectionService.findCateIdsByUserIdAndResourceCodeAndOperationCode(ShiroUtils.getSessionUser().getId(), "plan", "find");
        if(ids!=null && ids.length>0){
            serachBean.setDerectionIds(ids);
        }
        this.setCustomizePlanService.findPage(serachBean);
        return serachBean;
    }

    /**
     * 根据id查询定制计划数据
     * @param model
     */
    @AdminLogAnn(operType = OperType.SYSTEM,operLevel = OperLevel.NORM,operDescribe = "查询定制计划信息")
    @PermissionAnn(menuCode = "plan",operCode = "search",msg = "你没有查询定制计划信息的权限!")
    @ResponseBody
    @RequestMapping(value = "/entity",method = RequestMethod.POST)
    public ResponseJsonModel serachEmpEntity(Model model, Long id){
        ResponseJsonModel responseJsonModel = new ResponseJsonModel();
        SetCustomizePlan plan =   this.setCustomizePlanService.findById(id);
        responseJsonModel.setResult(plan);
        return responseJsonModel;
    }

    /**
     *  新增
     * @param plan
     * @return
     */
    @AdminLogAnn(operType = OperType.SYSTEM,operLevel = OperLevel.NORM,operDescribe = "新增定制计划信息")
    @PermissionAnn(menuCode = "plan",operCode = "save",msg = "你没有新增定制计划信息的权限!")
    @ResponseBody
    @RequestMapping(value = "/save",method = RequestMethod.POST)
    public ResponseJsonModel saveEmp(SetCustomizePlan plan)throws Exception{
        Date now = new Date();
        plan.setCreateTime(now);
        plan.setDeleted(false);
        this.setCustomizePlanService.save(plan);
        logger.warn("新增定制计划信息:" + plan.getPlanDescribe());
        return new ResponseJsonModel();
    }

    /**
     *  更新
     * @param
     * @return
     */
    @AdminLogAnn(operType = OperType.SYSTEM,operLevel = OperLevel.NORM,operDescribe = "修改定制计划信息")
    @PermissionAnn(menuCode = "plan",operCode = "update",msg = "你没有修改定制计划信息的权限!")
    @ResponseBody
    @RequestMapping(value = "/update",method = RequestMethod.POST)
    public ResponseJsonModel updateEmp(SetCustomizePlan plan)throws Exception{
        plan.setCreateTime(new Date());
        this.setCustomizePlanService.update(plan);
        logger.warn("修改定制计划信息:" + plan.getId() + "-" + plan.getPlanDescribe());
        return new ResponseJsonModel();
    }

    /**
     *  删除
     * @param
     * @return
     */
    @AdminLogAnn(operType = OperType.SYSTEM,operLevel = OperLevel.NORM,operDescribe = "修改定制计划信息")
    @PermissionAnn(menuCode = "plan",operCode = "update",msg = "你没有修改定制计划信息的权限!")
    @ResponseBody
    @RequestMapping(value = "/remove",method = RequestMethod.POST)
    public ResponseJsonModel removeEmp(SetCustomizePlan plan)throws Exception{
        this.setCustomizePlanService.removeEmp(plan);
        logger.warn("删除定制计划信息:" + plan.getId());
        return new ResponseJsonModel();
    }

    /**
     *  更新计划 及插入标签
     * @param
     * @return
     */
    @AdminLogAnn(operType = OperType.SYSTEM,operLevel = OperLevel.NORM,operDescribe = "修改定制计划信息")
    @PermissionAnn(menuCode = "plan",operCode = "update",msg = "你没有修改定制计划信息的权限!")
    @ResponseBody
    @RequestMapping(value = "/updatePlan",method = RequestMethod.POST)
    public ResponseJsonModel updatePlanEmp(HttpServletRequest request)throws Exception{
        Map paramMap = RequestParamUtils.getParamValues(request);
        this.setCustomizePlanService.updatePlanEmp(paramMap);
        logger.warn("更新计划及插入标签信息:" +  paramMap);
        return new ResponseJsonModel();
    }

    /**
     * 跳转到定制计划管理基本信息页面
     * @return
     */
    @PermissionAnn(menuCode = "plan",msg = "你没有进入定制计划管理基本信息页面的权限!")
    @RequestMapping(value = "/baseInfo/{planId}")
    public String forwardManager(Model model,@PathVariable Integer planId){
        SetCustomizePlan plan = new SetCustomizePlan();
        plan = setCustomizePlanService.findById(RequestParamUtils.switchToLong(planId));
        if(plan!=null){
            model.addAttribute("plan", plan);
        }
        Map tagMap = this.setPlanTagService.searchTagsByPlanId(planId);
        if(tagMap!=null){
            model.addAttribute("tagMap", tagMap);
        }
        //当前计划数
        CourseCustomizePlan courseCustomizePlan = new CourseCustomizePlan();
        courseCustomizePlan.setSetPlanId(planId);
        courseCustomizePlan.setDeleted(false);
        Long count = courseCustomizePlanService.count(courseCustomizePlan);
        model.addAttribute("currentCount", count);
        return "plan/plan_tab_base";
    }

    /**
     * 跳转到定制计划管理管理选择课程页面
     * @return
     */
    @PermissionAnn(menuCode = "plan",msg = "你没有进入定制计划管理选择课程页面的权限!")
    @RequestMapping(value = "/selectCourse/{planId}")
    public String forwardSelect(Model model,@PathVariable Integer planId){
        SetCustomizePlan plan = new SetCustomizePlan();
        plan = setCustomizePlanService.findById(RequestParamUtils.switchToLong(planId));
        if(plan!=null){
            model.addAttribute("plan", plan);
        }
        return "plan/plan_tab_select";
    }

    /**
     * 跳转到定制计划管理管理课程排序页面
     * @return
     */
    @PermissionAnn(menuCode = "plan",msg = "你没有进入定制计划管理课程排序页面的权限!")
    @RequestMapping(value = "/orderCourse/{planId}")
    public String forwardOrder(Model model,@PathVariable Integer planId){
        SetCustomizePlan plan = new SetCustomizePlan();
        plan = setCustomizePlanService.findById(RequestParamUtils.switchToLong(planId));
        model.addAttribute("plan", plan);
        return "plan/plan_tab_order";
    }

    /**
     * 定制计划管理选择课程列表
     * @return
     */
    @PermissionAnn(menuCode = "plan",operCode = "find",msg = "你没有定制计划选择课程页面的查询权限!")
    @ResponseBody
    @RequestMapping(value = "/course/list",method = RequestMethod.POST)
    public DataTablePageModel serachCourseInfo(PlanManagerSerachBean serachBean){
        this.setCustomizePlanService.searchSelectCoursePage(serachBean);
        return serachBean;
    }
    /**
     * 定制计划管理关联课程列表
     * @return
     */
    @PermissionAnn(menuCode = "plan",operCode = "find",msg = "你没有定制计划选择课程页面的查询权限!")
    @ResponseBody
    @RequestMapping(value = "/relation/list",method = RequestMethod.POST)
    public DataTablePageModel serachRelationCourseInfo(PlanManagerSerachBean serachBean){
        this.setPlanCourseService.findPage(serachBean);
        return serachBean;
    }

    /**
     *  新增计划信息对应课程
     * @param request
     * @return
     */
    @AdminLogAnn(operType = OperType.SYSTEM,operLevel = OperLevel.NORM,operDescribe = "新增定制计划信息")
    @PermissionAnn(menuCode = "plan",operCode = "save",msg = "你没有新增定制计划信息的权限!")
    @ResponseBody
    @RequestMapping(value = "/course/save",method = RequestMethod.POST)
    public ResponseJsonModel saveCourseEmp(HttpServletRequest request)throws Exception{
        Map paramMap = RequestParamUtils.getParamValues(request);
        this.setPlanCourseService.saveCourses(paramMap);
        logger.warn("新增定制计划关联课程信息" + paramMap.get("courseIds"));
        return new ResponseJsonModel();
    }

    /**
     *  计划关联课程划分阶段 调整位置
     * @param
     * @return
     */
    @AdminLogAnn(operType = OperType.SYSTEM,operLevel = OperLevel.NORM,operDescribe = "定制计划阶段划分")
    @PermissionAnn(menuCode = "plan",operCode = "update",msg = "你没有定制计划划分阶段的权限!")
    @ResponseBody
    @RequestMapping(value = "/stage/update",method = RequestMethod.POST)
    public ResponseJsonModel updateStageEmp(HttpServletRequest request)throws Exception{
        Map paramMap = RequestParamUtils.getParamValues(request);
        this.setCustomizePlanService.updateStageEmp(paramMap);
        logger.warn("计划关联课程划分阶段:" + paramMap);
        return new ResponseJsonModel();
    }

    /**
     *  计划关联课程划分阶段
     * @param
     * @return
     */
    @AdminLogAnn(operType = OperType.SYSTEM,operLevel = OperLevel.NORM,operDescribe = "定制计划阶段划分")
    @PermissionAnn(menuCode = "plan",operCode = "update",msg = "你没有定制计划划分阶段的权限!")
    @ResponseBody
    @RequestMapping(value = "/stage/updatePlans",method = RequestMethod.POST)
    public ResponseJsonModel updateStagePlansEmp(HttpServletRequest request)throws Exception{
        Map paramMap = RequestParamUtils.getParamValues(request);
        this.setCustomizePlanService.updateStagePlansEmp(paramMap);
        logger.warn("计划关联课程划分阶段排序:" + paramMap);
        return new ResponseJsonModel();
    }

}
