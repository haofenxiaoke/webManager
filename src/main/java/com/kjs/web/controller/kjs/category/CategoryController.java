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
import com.kjs.orm.model.CategoryDirection;
import com.kjs.service.kjs.authority.spi.IAuthorityOperationService;
import com.kjs.service.kjs.category.spi.ICategoryDirectionService;
import com.kjs.web.serach.kjs.category.CategorySerachBean;
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
import java.util.List;
import java.util.Map;

/**
 * 分类方向管理控制器
 * Created by wangsongpeng on 2016/2/25.
 */
@Controller
@RequestMapping("/cate")
public class CategoryController {
    private final static Logger logger = LoggerFactory.getLogger(CategoryController.class);
    @Resource
    private ICategoryDirectionService categoryDirectionService;
    @Resource
    private IAuthorityOperationService authorityOperationService;
    @Resource
    private MenuCacheModel menuCacheModel;

    /**
     * 跳转到分类方向管理页面
     * @return
     */
    @PermissionAnn(menuCode = "cate",msg = "你没有进入分类管理方向页面的权限!")
    @RequestMapping(value = "/manager")
    public String forwardManager(Model model){
        return "category/category_direction";
    }

    /**
     * 分类方向列表
     * @return
     */
    @PermissionAnn(menuCode = "cate",operCode = "find",msg = "你没有分类管理方向页面的查询权限!")
    @ResponseBody
    @RequestMapping(value = "/list",method = RequestMethod.POST)
    public DataTablePageModel serachCategoryInfo(CategorySerachBean serachBean){
        Long[] ids = categoryDirectionService.findCateIdsByUserIdAndResourceCodeAndOperationCode(ShiroUtils.getSessionUser().getId(), "cate", "find");
        if(ids!=null && ids.length>0){
            serachBean.setDerectionIds(ids);
        }
        this.categoryDirectionService.findCategoryPage(serachBean);
        return serachBean;
    }
    /**
     * 分类方向列表
     * @return
     */
    @PermissionAnn(menuCode = "cate",operCode = "find",msg = "你没有分类管理方向页面的查询权限!")
    @ResponseBody
    @RequestMapping(value = "/allList",method = RequestMethod.POST)
    public ResponseJsonModel serachAllCategoryInfo(){
        List<CategoryDirection> list=categoryDirectionService.findAllCates();
        ResponseJsonModel responseJsonModel=new ResponseJsonModel();
        responseJsonModel.setResult(list);
        return responseJsonModel;
    }


    /**
     * 根据id查询分类方向数据
     * @param model
     */
    @AdminLogAnn(operType = OperType.AUTH,operLevel = OperLevel.NORM,operDescribe = "修改分类方向")
    @PermissionAnn(menuCode = "cate",operCode = "update",msg = "你没有修改分类方向的权限!")
    @ResponseBody
    @RequestMapping(value = "/entity",method = RequestMethod.POST)
    public ResponseJsonModel serachEmpEntity(Model model, Long id){
        ResponseJsonModel responseJsonModel = new ResponseJsonModel();
        CategoryDirection cates =   this.categoryDirectionService.findById(id);
        responseJsonModel.setResult(cates);
        return responseJsonModel;
    }

    /**
     *  新增
     * @param cate
     * @return
     */
    @AdminLogAnn(operType = OperType.SYSTEM,operLevel = OperLevel.NORM,operDescribe = "新增分类方向")
    @PermissionAnn(menuCode = "cate",operCode = "save",msg = "你没有新增分类方向的权限!")
    @ResponseBody
    @RequestMapping(value = "/save",method = RequestMethod.POST)
    public ResponseJsonModel saveEmp(CategoryDirection cate)throws Exception{
        Date now = new Date();
        cate.setCreateTime(now);
        cate.setDeleted(0);
        cate.setUserid(ShiroUtils.getSessionUser().getId().intValue());
        this.categoryDirectionService.save(cate);
        logger.warn("新增方向:" + cate.getCategoryDesc());
        return new ResponseJsonModel();
    }

    /**
     *  修改
     * @param cate
     * @return
     */
    @AdminLogAnn(operType = OperType.SYSTEM,operLevel = OperLevel.NORM,operDescribe = "修改分类方向")
    @PermissionAnn(menuCode = "cate",operCode = "update",msg = "你没有修改分类方向的权限!")
    @ResponseBody
    @RequestMapping(value = "/update",method = RequestMethod.POST)
    public ResponseJsonModel updateEmp(CategoryDirection cate){
        cate.setUserid(ShiroUtils.getSessionUser().getId().intValue());
        this.categoryDirectionService.update(cate);
        return new ResponseJsonModel();
    }

    /**
     *  删除
     * @param cate
     * @return
     */
    @AdminLogAnn(operType = OperType.SYSTEM,operLevel = OperLevel.NORM,operDescribe = "修改分类方向")
    @PermissionAnn(menuCode = "cate",operCode = "delete",msg = "你没有删除分类方向的权限!")
    @ResponseBody
    @RequestMapping(value = "/delete",method = RequestMethod.POST)
    public ResponseJsonModel deleteEmp(CategoryDirection cate){
        this.categoryDirectionService.deleteById(cate);
        return new ResponseJsonModel();
    }

    /**
     *  排序
     * @param request
     * @return
     */
    @AdminLogAnn(operType = OperType.SYSTEM,operLevel = OperLevel.NORM,operDescribe = "分类方向排版")
    @PermissionAnn(menuCode = "cate",operCode = "find",msg = "你没有分类方向排版的权限!")
    @ResponseBody
    @RequestMapping(value = "/order",method = RequestMethod.POST)
    public ResponseJsonModel orderEmp(HttpServletRequest request){
        Map paramMap = RequestParamUtils.getParamValues(request);
        this.categoryDirectionService.orderBy(paramMap);
        return new ResponseJsonModel();
    }

    /**
     * 验证当前分类方向名称,url,code是否唯一
     * @param
     */
    @ResponseBody
    @RequestMapping(value = "/check/cateDesc",method = RequestMethod.POST)
    public ResponseJsonModel checkCategoryAttr(CategoryDirection cate){
        ResponseJsonModel arm = new ResponseJsonModel();
        if(this.categoryDirectionService.checkCateUnique(cate)){
            //唯一
            arm.setCode(HttpConstant.SUCCESS_CODE);
        }else{
            //有重复
            arm.setCode(HttpConstant.ERROR_CODE);
        }
        return arm;
    }

    /**
     * 跳转到分类方向管理Tab页面
     * @return
     */
    @PermissionAnn(menuCode = "cate",msg = "你没有进入分类方向管理Tab页面的权限!")
    @RequestMapping(value = "/managerTab/{id}/{desc}")
    public String forwardManagerTab(Model model,@PathVariable Integer id,@PathVariable String desc){
        model.addAttribute("directionId", id);
        model.addAttribute("directionDesc", desc);
        return "category/category_tab";
    }

    /**
     * 获得当前后台用户对应操作所拥有的分类列表
     * @param resourceCode 操作编码
     * @return ResponseJsonModel
     * @author 李恒名
     * @date 2016年6月6日 18:41:37
     */
    @RequestMapping("/list/{resourceCode}/{operationCode}")
    @ResponseBody
    public ResponseJsonModel findCurrentUserCateListByOperationCode(@PathVariable String resourceCode,@PathVariable String operationCode){
        ResponseJsonModel model = new ResponseJsonModel();
        Long id = ShiroUtils.getSessionUser().getId();
        List<CategoryDirection> categoryDirections = categoryDirectionService.findByUserIdAndResourceCodeAndOperationCode(id,resourceCode,operationCode);
        model.setResult(categoryDirections);
        return model;
    }

    /**
     *  删除验证
     * @param cate
     * @return
     */
    @AdminLogAnn(operType = OperType.SYSTEM,operLevel = OperLevel.NORM,operDescribe = "删除分类方向前的验证")
    @ResponseBody
    @RequestMapping(value = "/checkDelUnique",method = RequestMethod.POST)
    public ResponseJsonModel checkDelUniqueEmp(CategoryDirection cate){
        ResponseJsonModel arm = new ResponseJsonModel();
        if(this.categoryDirectionService.checkDelUnique(cate.getId().intValue())){
            //有关联 不能删除
            arm.setCode(HttpConstant.SUCCESS_CODE);
        }else{
            //有重复
            arm.setCode(HttpConstant.ERROR_CODE);
        }
        return arm;
    }
}
