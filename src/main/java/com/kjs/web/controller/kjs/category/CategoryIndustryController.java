package com.kjs.web.controller.kjs.category;

import com.kjs.common.bean.DataTablePageModel;
import com.kjs.common.bean.MenuCacheModel;
import com.kjs.common.bean.ResponseJsonModel;
import com.kjs.common.bean.annotation.AdminLogAnn;
import com.kjs.common.bean.annotation.PermissionAnn;
import com.kjs.common.bean.enums.OperLevel;
import com.kjs.common.bean.enums.OperType;
import com.kjs.common.constant.HttpConstant;
import com.kjs.common.utils.RequestParamUtils;
import com.kjs.common.utils.ShiroUtils;
import com.kjs.common.utils.SortUtils;
import com.kjs.common.utils.StringUtil;
import com.kjs.orm.model.CategoryIndustry;
import com.kjs.service.kjs.authority.spi.IAuthorityOperationService;
import com.kjs.service.kjs.category.CategoryPositionService;
import com.kjs.service.kjs.category.spi.ICategoryDirectionService;
import com.kjs.service.kjs.category.spi.ICategoryIndustryService;
import com.kjs.service.kjs.course.spi.ICourseIndustryService;
import com.kjs.service.kjs.plan.spi.ISetCustomizePlanService;
import com.kjs.web.serach.kjs.category.CategoryIndustrySerachBean;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.CollectionUtils;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;

/**
 * 分类行业管理控制器
 * Created by wangsongpeng on 2016/2/25.
 */
@Controller
@RequestMapping("/industry")
public class CategoryIndustryController {
    private final static Logger logger = LoggerFactory.getLogger(CategoryIndustryController.class);
    @Resource
    private ICategoryIndustryService categoryIndustryService;
    @Resource
    private ICategoryDirectionService categoryDirectionService;
    @Resource
    private ICourseIndustryService courseIndustryService;
    @Resource
    private IAuthorityOperationService authorityOperationService;
    @Resource
    private MenuCacheModel menuCacheModel;
    @Resource
    private CategoryPositionService categoryPosiionService;
    @Resource
    private ISetCustomizePlanService setCustomizePlanService;

    /**
     * 分类行业列表
     * @return
     */
    @PermissionAnn(menuCode = "cate",operCode = "find",msg = "你没有分类行业管理页面的查询权限!")
    @ResponseBody
    @RequestMapping(value = "/list",method = RequestMethod.POST)
    public DataTablePageModel serachCategoryInfo(CategoryIndustrySerachBean serachBean){
        this.categoryIndustryService.findCategoryPage(serachBean);
        return serachBean;
    }

    /**
     * 根据方向id查询分类行业数据
     * @param model
     */
    @AdminLogAnn(operType = OperType.AUTH,operLevel = OperLevel.NORM,operDescribe = "查询分类下的所有行业")
    @PermissionAnn(menuCode = "cate",operCode = "find",msg = "你没有查询分类行业的权限!")
    @ResponseBody
    @RequestMapping(value = "/industryList",method = RequestMethod.POST)
    public ResponseJsonModel getIndustryByDirectionId(Model model,HttpServletRequest request){
        ResponseJsonModel responseJsonModel = new ResponseJsonModel();
        int directionId=Integer.parseInt(request.getParameter("directionId"));
        List<CategoryIndustry> industries =   this.categoryIndustryService.getIndustryByDirectionId(directionId);
        if(!CollectionUtils.isEmpty(industries))
        {
            SortUtils.sortTheList(industries, "orderNum", SortUtils.SORT_ORDER_ASC);
        }
        responseJsonModel.setResult(industries);
        return responseJsonModel;
    }

    /**
     * 根据课程id查询课程已选择的行业标签
     * @param model
     */
    @AdminLogAnn(operType = OperType.AUTH,operLevel = OperLevel.NORM,operDescribe = "查询课程所选行业标签")
    @PermissionAnn(menuCode = "cate",operCode = "find",msg = "你没有查询分类行业的权限!")
    @ResponseBody
    @RequestMapping(value = "/courseIndustry",method = RequestMethod.POST)
    public ResponseJsonModel getIndustryByCourseId(Model model,HttpServletRequest request){
        ResponseJsonModel responseJsonModel = new ResponseJsonModel();
        String courseid=request.getParameter("courseId");

        List<CategoryIndustry> industries=new ArrayList<CategoryIndustry>();
       if(StringUtil.isNotEmpty(courseid)){
           int courseId=Integer.parseInt(courseid);
          industries =   this.categoryIndustryService.getIndustryByCourseId(courseId);
       }
        responseJsonModel.setResult(industries);
        return responseJsonModel;
    }


    /**
     * 根据id查询分类行业数据
     * @param model
     */
    @AdminLogAnn(operType = OperType.AUTH,operLevel = OperLevel.NORM,operDescribe = "修改分类行业")
    @PermissionAnn(menuCode = "cate",operCode = "update",msg = "你没有修改分类行业的权限!")
    @ResponseBody
    @RequestMapping(value = "/entity",method = RequestMethod.POST)
    public ResponseJsonModel serachEmpEntity(Model model, Long id){
        ResponseJsonModel responseJsonModel = new ResponseJsonModel();
        CategoryIndustry cates =   this.categoryIndustryService.findById(id);
        responseJsonModel.setResult(cates);
        return responseJsonModel;
    }

    /**
     *  新增
     * @param industry
     * @return
     */
    @AdminLogAnn(operType = OperType.SYSTEM,operLevel = OperLevel.NORM,operDescribe = "新增分类行业")
    @PermissionAnn(menuCode = "cate",operCode = "save",msg = "你没有新增分类行业的权限!")
    @ResponseBody
    @RequestMapping(value = "/save",method = RequestMethod.POST)
    public ResponseJsonModel saveEmp(CategoryIndustry industry)throws Exception{
        Date now = new Date();
        industry.setCreateTime(now);
        industry.setDeleted(0);
        industry.setUserid(ShiroUtils.getSessionUser().getId().intValue());
        this.categoryIndustryService.saveIndustry(industry);
        logger.warn("新增分类行业:" + industry.getCategoryDesc());
        return new ResponseJsonModel();
    }

    /**
     *  修改
     * @param cate
     * @return
     */
    @AdminLogAnn(operType = OperType.SYSTEM,operLevel = OperLevel.NORM,operDescribe = "修改分类行业")
    @PermissionAnn(menuCode = "cate",operCode = "update",msg = "你没有修改分类行业的权限!")
    @ResponseBody
    @RequestMapping(value = "/update",method = RequestMethod.POST)
    public ResponseJsonModel updateEmp(CategoryIndustry cate){
        cate.setUserid(ShiroUtils.getSessionUser().getId().intValue());
        this.categoryIndustryService.update(cate);
        return new ResponseJsonModel();
    }

    /**
     *  删除
     * @param cate
     * @return
     */
    @AdminLogAnn(operType = OperType.SYSTEM,operLevel = OperLevel.NORM,operDescribe = "修改分类行业")
    @PermissionAnn(menuCode = "cate",operCode = "delete",msg = "你没有删除分类行业的权限!")
    @ResponseBody
    @RequestMapping(value = "/delete",method = RequestMethod.POST)
    public ResponseJsonModel deleteEmp(CategoryIndustry cate){
        this.categoryIndustryService.deleteById(cate);
        return new ResponseJsonModel();
    }

    /**
     *  排序
     * @param request
     * @return
     */
    @AdminLogAnn(operType = OperType.SYSTEM,operLevel = OperLevel.NORM,operDescribe = "分类行业排版")
    @PermissionAnn(menuCode = "cate",operCode = "find",msg = "你没有分类行业排版的权限!")
    @ResponseBody
    @RequestMapping(value = "/order",method = RequestMethod.POST)
    public ResponseJsonModel orderEmp(HttpServletRequest request){
        Map paramMap = RequestParamUtils.getParamValues(request);
        this.categoryIndustryService.orderBy(paramMap);
        return new ResponseJsonModel();
    }

    /**
     * 验证当前分类行业名称,url,code是否唯一
     * @param
     */
    @ResponseBody
    @RequestMapping(value = "/check/cateDesc",method = RequestMethod.POST)
    public ResponseJsonModel checkCategoryAttr(CategoryIndustry cate){
        ResponseJsonModel arm = new ResponseJsonModel();
        if(this.categoryIndustryService.checkCateUnique(cate)){
            //唯一
            arm.setCode(HttpConstant.SUCCESS_CODE);
        }else{
            //有重复
            arm.setCode(HttpConstant.ERROR_CODE);
        }
        return arm;
    }

    /**
     *  删除验证
     * @param industry
     * @return
     */
    @AdminLogAnn(operType = OperType.SYSTEM,operLevel = OperLevel.NORM,operDescribe = "删除分类行业前的验证")
    @ResponseBody
    @RequestMapping(value = "/checkDelUnique",method = RequestMethod.POST)
    public ResponseJsonModel checkDelUniqueEmp(CategoryIndustry industry){
        ResponseJsonModel arm = new ResponseJsonModel();
        if(this.courseIndustryService.countCheckDelInd(industry.getId().intValue())){
            //有关联 不能删除
            arm.setCode(HttpConstant.SUCCESS_CODE);
        }else{
            //有重复
            arm.setCode(HttpConstant.ERROR_CODE);
        }
        return arm;
    }
}
