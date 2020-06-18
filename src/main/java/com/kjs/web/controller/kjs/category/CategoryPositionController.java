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
import com.kjs.orm.mapper.CategoryPositionMapper;
import com.kjs.orm.model.CategoryPosition;
import com.kjs.service.kjs.authority.spi.IAuthorityOperationService;
import com.kjs.service.kjs.category.spi.ICategoryDirectionService;
import com.kjs.service.kjs.category.spi.ICategoryIndustryService;
import com.kjs.service.kjs.category.spi.ICategoryPositionService;
import com.kjs.service.kjs.plan.spi.ISetCustomizePlanService;
import com.kjs.web.serach.kjs.category.CategoryPositionSerachBean;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import java.util.Date;
import java.util.List;
import java.util.Map;

/**
 * 菜单管理控制器
 * Created by wangsongpeng on 2016/2/25.
 */
@Controller
@RequestMapping("/position")
public class CategoryPositionController {
    private final static Logger logger = LoggerFactory.getLogger(CategoryPositionController.class);
    @Resource
    private ICategoryPositionService categoryPositionService;
    @Resource
    private ICategoryDirectionService categoryDirectionService;
    @Resource
    private IAuthorityOperationService authorityOperationService;
    @Resource
    private MenuCacheModel menuCacheModel;
    @Resource
    private ICategoryIndustryService categoryIndustryService;
    @Resource
    private ISetCustomizePlanService setCustomizePlanService;
    @Resource
    private CategoryPositionMapper categoryPositionDao;

    /**
     * 分类职位列表
     * @return
     */
    @PermissionAnn(menuCode = "cate",operCode = "find",msg = "你没有分类职位管理页面的查询权限!")
    @ResponseBody
    @RequestMapping(value = "/list",method = RequestMethod.POST)
    public DataTablePageModel serachCategoryInfo(CategoryPositionSerachBean serachBean){
        this.categoryPositionService.findCategoryPage(serachBean);
        return serachBean;
    }

    /**
     * 根据id查询分类职位数据
     * @param model
     */
    @AdminLogAnn(operType = OperType.AUTH,operLevel = OperLevel.NORM,operDescribe = "修改分类职位")
    @PermissionAnn(menuCode = "cate",operCode = "update",msg = "你没有修改分类职位的权限!")
    @ResponseBody
    @RequestMapping(value = "/entity"/*,method = RequestMethod.POST*/)
    public ResponseJsonModel serachEmpEntity(Model model, Long id){
        ResponseJsonModel responseJsonModel = new ResponseJsonModel();
        CategoryPosition cates =   this.categoryPositionService.findById(id);
        responseJsonModel.setResult(cates);
        return responseJsonModel;
    }

    /**
     *  新增
     * @param position
     * @return
     */
    @AdminLogAnn(operType = OperType.SYSTEM,operLevel = OperLevel.NORM,operDescribe = "新增分类职位")
    @PermissionAnn(menuCode = "cate",operCode = "save",msg = "你没有新增分类职位的权限!")
    @ResponseBody
    @RequestMapping(value = "/save",method = RequestMethod.POST)
    public ResponseJsonModel saveEmp(CategoryPosition position)throws Exception{
        Date now = new Date();
        position.setCreateTime(now);
        position.setDeleted(0);
        position.setUserid(ShiroUtils.getSessionUser().getId().intValue());
        this.categoryPositionService.savePosition(position);
        logger.warn("新增分类职位:" + position.getCategoryDesc());
        return new ResponseJsonModel();
    }

    /**
     *  修改
     * @param cate
     * @return
     */
    @AdminLogAnn(operType = OperType.SYSTEM,operLevel = OperLevel.NORM,operDescribe = "修改分类职位")
    @PermissionAnn(menuCode = "cate",operCode = "update",msg = "你没有修改分类职位的权限!")
    @ResponseBody
    @RequestMapping(value = "/update"/*,method = RequestMethod.POST*/)
    public ResponseJsonModel updateEmp(CategoryPosition cate){
        cate.setUserid(ShiroUtils.getSessionUser().getId().intValue());
        this.categoryPositionService.update(cate);
        return new ResponseJsonModel();
    }

    /**
     *  删除
     * @param cate
     * @return
     */
    @AdminLogAnn(operType = OperType.SYSTEM,operLevel = OperLevel.NORM,operDescribe = "修改分类职位")
    @PermissionAnn(menuCode = "cate",operCode = "delete",msg = "你没有删除分类职位的权限!")
    @ResponseBody
    @RequestMapping(value = "/delete",method = RequestMethod.POST)
    public ResponseJsonModel deleteEmp(CategoryPosition cate){
        this.categoryPositionService.deleteById(cate);
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
        this.categoryPositionService.orderBy(paramMap);
        return new ResponseJsonModel();
    }

    /**
     * 验证当前分类职位名称,url,code是否唯一
     * @param
     */
    @ResponseBody
    @RequestMapping(value = "/check/cateDesc",method = RequestMethod.POST)
    public ResponseJsonModel checkCategoryAttr(CategoryPosition cate){
        ResponseJsonModel arm = new ResponseJsonModel();
        if(this.categoryPositionService.checkCateUnique(cate)){
            //唯一
            arm.setCode(HttpConstant.SUCCESS_CODE);
        }else{
            //有重复
            arm.setCode(HttpConstant.ERROR_CODE);
        }
        return arm;
    }
    /**
     * 根据id查询分类职位数据
     * @param model
     */
    @AdminLogAnn(operType = OperType.AUTH,operLevel = OperLevel.NORM,operDescribe = "查询分类下的所有职位")
    @PermissionAnn(menuCode = "cate",operCode = "find",msg = "你没有查询职位的权限!")
    @ResponseBody
    @RequestMapping(value = "/positionList",method = RequestMethod.POST)
    public ResponseJsonModel getPositionByDirectionId(Model model,HttpServletRequest request){
        ResponseJsonModel responseJsonModel = new ResponseJsonModel();
        int directionId=Integer.parseInt(request.getParameter("directionId"));
        List<CategoryPosition> positions =   this.categoryPositionService.getPositionByDirectionId(directionId);
        responseJsonModel.setResult(positions);
        return responseJsonModel;
    }
    /**
     *  删除验证
     * @param cate
     * @return
     */
    @AdminLogAnn(operType = OperType.SYSTEM,operLevel = OperLevel.NORM,operDescribe = "删除分类职位前的验证")
    @ResponseBody
    @RequestMapping(value = "/checkDelUnique",method = RequestMethod.POST)
    public ResponseJsonModel checkDelUniqueEmp(CategoryPosition cate){
        ResponseJsonModel arm = new ResponseJsonModel();
        if(this.categoryPositionService.countCheckDelPos(cate.getId().intValue())){
            //有关联 不能删除
            arm.setCode(HttpConstant.SUCCESS_CODE);
        }else{
            //有重复
            arm.setCode(HttpConstant.ERROR_CODE);
        }
        return arm;
    }

}
