package com.kjs.web.controller.kjs.system;

import com.kjs.common.bean.DataTablePageModel;
import com.kjs.common.bean.ResponseJsonModel;
import com.kjs.common.bean.annotation.AdminLogAnn;
import com.kjs.common.bean.annotation.PermissionAnn;
import com.kjs.common.bean.enums.OperLevel;
import com.kjs.common.bean.enums.OperType;
import com.kjs.common.constant.HttpConstant;
import com.kjs.common.utils.RequestParamUtils;
import com.kjs.common.utils.ShiroUtils;
import com.kjs.common.utils.StringUtil;
import com.kjs.orm.model.CategoryDirection;
import com.kjs.orm.model.SysTag;
import com.kjs.service.kjs.category.spi.ICategoryDirectionService;
import com.kjs.service.kjs.system.spi.ISysTagService;
import com.kjs.web.serach.kjs.system.SysTagSerachBean;
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
import java.util.*;

/**
 * Created by Administrator on 2016/6/12 0012.
 */
@Controller
@RequestMapping("/tag")
public class SysTagController {
    private final static Logger logger = LoggerFactory.getLogger(SysTagController.class);
    @Resource
    private ISysTagService sysTagService;
    @Resource
    private ICategoryDirectionService categoryDirectionService;
    /**
     * 跳转到分类方向管理页面
     * @return
     */
    @PermissionAnn(menuCode = "tag",msg = "你没有进入分类管理方向页面的权限!")
    @RequestMapping(value = "/manager")
    public String forwardManager(Model model){
        return "sysTag/tag_info";
    }
    /**
     * 标签管理列表
     * @return
     */
    @PermissionAnn(menuCode = "tag",operCode = "find",msg = "你没有查看标签管理的查询权限!")
    @ResponseBody
    @RequestMapping(value = "/cate/list",method = RequestMethod.POST)
    public DataTablePageModel serachCateInfo(SysTagSerachBean serachBean){
        Long[] ids = categoryDirectionService.findCateIdsByUserIdAndResourceCodeAndOperationCode(ShiroUtils.getSessionUser().getId(), "tag", "find");
        if(ids!=null && ids.length> 0) {
            serachBean.setDerectionIds(ids);
        }
        this.sysTagService.findCatePage(serachBean);
        return serachBean;
    }
    /**
     * 获取课程优势标签列表
     */
    @PermissionAnn(menuCode = "tag",operCode = "find",msg = "你没有查询标签的权限!")
    @ResponseBody
    @RequestMapping(value = "/typeTagList")
    public  ResponseJsonModel searchSysTag(Model model,HttpServletRequest request){
        ResponseJsonModel responseJsonModel = new ResponseJsonModel();
        String type=request.getParameter("type");
        String courseId=request.getParameter("courseId");
        Integer directionId = Integer.valueOf((String) request.getParameter("directionId"));
        List<SysTag> sysTags=new ArrayList<SysTag>();

        sysTags=this.sysTagService.queryAllAdvantages(Integer.parseInt(type),directionId);

        responseJsonModel.setResult(sysTags);
        return responseJsonModel;


    }
    /**
     * 获取课程优势标签列表
     */
    @PermissionAnn(menuCode = "tag",operCode = "find",msg = "你没有查询标签的权限!")
    @ResponseBody
    @RequestMapping(value = "/courseAdvantageTagList")
    public  ResponseJsonModel writeBackAdvantage(Model model,HttpServletRequest request){
        ResponseJsonModel responseJsonModel = new ResponseJsonModel();
        String type=request.getParameter("type");
        String courseId=request.getParameter("courseId");
        List<SysTag> sysTags=new ArrayList<SysTag>();
        sysTags=this.sysTagService.getTagListByCourseId(Integer.parseInt(courseId));
        responseJsonModel.setResult(sysTags);
        return responseJsonModel;
    }

    /**
     * 获取适合对象标签列表
     */
    @PermissionAnn(menuCode = "tag",operCode = "find",msg = "你没有查询标签的权限!")
    @ResponseBody
    @RequestMapping(value = "/suitableList")
    public  ResponseJsonModel searchSuitableSysTag(Model model,HttpServletRequest request){
        ResponseJsonModel responseJsonModel = new ResponseJsonModel();
        String courseReq=request.getParameter("courseId");
        Integer directionId = Integer.valueOf((String) request.getParameter("directionId"));
        List<SysTag> sysTags=new ArrayList<SysTag>();
        if(StringUtil.isNotEmpty(courseReq)){
            sysTags=this.sysTagService.getTagListByCourseId(Integer.parseInt(courseReq));
        }  else{
            sysTags =   this.sysTagService.getTagList(directionId);
        }

        responseJsonModel.setResult(sysTags);
        return responseJsonModel;


    }

    /**
     * 获取课程适合对象标签列表
     */
    @PermissionAnn(menuCode = "tag",operCode = "find",msg = "你没有查询标签的权限!")
    @ResponseBody
    @RequestMapping(value = "/courseSuitableTagList")
    public  ResponseJsonModel writeBackSuitable(Model model,HttpServletRequest request){
        ResponseJsonModel responseJsonModel = new ResponseJsonModel();
        String type=request.getParameter("type");
        String courseId=request.getParameter("courseId");
        List<SysTag> sysTags=new ArrayList<SysTag>();
        sysTags=this.sysTagService.getSuitableListByCourseId(Integer.parseInt(courseId));
        responseJsonModel.setResult(sysTags);
        return responseJsonModel;


    }

    /**
     * 各类型标签信息列表
     * @return
     */
    @PermissionAnn(menuCode = "tag",operCode = "find",msg = "你没有查询标签信息的查询权限!")
    @ResponseBody
    @RequestMapping(value = "/list",method = RequestMethod.POST)
    public DataTablePageModel serachTagInfo(SysTagSerachBean serachBean){
        this.sysTagService.findPage(serachBean);
        return serachBean;
    }

    /**
     * 根据id查询数据
     * @param model
     */
    @AdminLogAnn(operType = OperType.AUTH,operLevel = OperLevel.NORM,operDescribe = "修改标签信息")
    @PermissionAnn(menuCode = "tag",operCode = "update",msg = "你没有修改标签信息的权限!")
    @ResponseBody
    @RequestMapping(value = "/entity",method = RequestMethod.POST)
    public ResponseJsonModel serachEmpEntity(Model model, Long id){
        ResponseJsonModel responseJsonModel = new ResponseJsonModel();
        SysTag tag =   this.sysTagService.findById(id);
        responseJsonModel.setResult(tag);
        return responseJsonModel;
    }

    /**
     *  新增
     * @param request
     * @return
     */
    @AdminLogAnn(operType = OperType.SYSTEM,operLevel = OperLevel.NORM,operDescribe = "新增标签信息")
    @PermissionAnn(menuCode = "tag",operCode = "save",msg = "你没有新增标签信息的权限!")
    @ResponseBody
    @RequestMapping(value = "/save/{type}/{directionId}",method = RequestMethod.POST)
    public ResponseJsonModel saveEmp(HttpServletRequest request,@PathVariable Integer type,@PathVariable Integer directionId)throws Exception{
        Date now = new Date();
        Map paramMap = RequestParamUtils.getParamValues(request);
        Iterator<Map.Entry<String, String>> it = paramMap.entrySet().iterator();
        while (it.hasNext()) {
            Map.Entry<String, String> entry = it.next();
            if(StringUtil.isNotEmpty(entry.getValue())){
                SysTag tag = new SysTag();
                tag.setType(type);
                tag.setDirectionId(directionId);
                tag.setContent(entry.getValue());
                tag.setCreateTime(now);
                tag.setDeleted(false);
                this.sysTagService.save(tag);
                logger.warn("新增标签信息:" + tag.getContent());
            }
        }

        return new ResponseJsonModel();
    }

    /**
     *  修改
     * @param tag
     * @return
     */
    @AdminLogAnn(operType = OperType.SYSTEM,operLevel = OperLevel.NORM,operDescribe = "修改标签信息")
    @PermissionAnn(menuCode = "tag",operCode = "update",msg = "你没有修改标签信息的权限!")
    @ResponseBody
    @RequestMapping(value = "/update",method = RequestMethod.POST)
    public ResponseJsonModel updateEmp(SysTag tag){
        this.sysTagService.update(tag);
        return new ResponseJsonModel();
    }

    /**
     *  删除
     * @param tag
     * @return
     */
    @AdminLogAnn(operType = OperType.SYSTEM,operLevel = OperLevel.NORM,operDescribe = "修改分类方向")
    @PermissionAnn(menuCode = "tag",operCode = "delete",msg = "你没有删除分类方向的权限!")
    @ResponseBody
    @RequestMapping(value = "/delete",method = RequestMethod.POST)
    public ResponseJsonModel deleteEmp(SysTag tag){
        this.sysTagService.deleteById(tag);
        return new ResponseJsonModel();
    }

    /**
     * 验证当前标签名称是否唯一
     * @param
     */
    @ResponseBody
    @RequestMapping(value = "/check/tagDesc",method = RequestMethod.POST)
    public ResponseJsonModel checkCategoryAttr(SysTag tag){
        ResponseJsonModel arm = new ResponseJsonModel();
        if(this.sysTagService.checkTagUnique(tag)){
            //唯一
            arm.setCode(HttpConstant.SUCCESS_CODE);
        }else{
            //有重复
            arm.setCode(HttpConstant.ERROR_CODE);
        }
        return arm;
    }

    /**
     * 跳转到某个方向标签管理详细Tab页面
     * @return
     */
    @PermissionAnn(menuCode = "tag",msg = "你没有进入学员管理详细Tab页面的权限!")
    @RequestMapping(value = "/managerTab/{directionId}")
    public String forwardManagerTab(Model model,@PathVariable Integer directionId){
        model.addAttribute("directionId", directionId);
        if(StringUtil.isNotEmpty(directionId)){
            CategoryDirection direction = this.categoryDirectionService.findById(directionId.longValue());
            model.addAttribute("cateDesc", direction.getCategoryDesc());
        }
        return "sysTag/tag_tab";
    }

    /**
     * 查询关联适合对象
     * @param serachBean
     */
    @AdminLogAnn(operType = OperType.AUTH,operLevel = OperLevel.NORM,operDescribe = "查询关联适合对象")
    @ResponseBody
    @RequestMapping(value = "/suitable/entity",method = RequestMethod.POST)
    public DataTablePageModel serachSuitableEmpEntity(SysTagSerachBean serachBean){
        this.sysTagService.searchSuitableVideo(serachBean);
        return serachBean;
    }

    /**
     * 查询关联课程优势
     * @param serachBean
     */
    @AdminLogAnn(operType = OperType.AUTH,operLevel = OperLevel.NORM,operDescribe = "查询关联课程优势")
    @ResponseBody
    @RequestMapping(value = "/advantage/entity",method = RequestMethod.POST)
    public DataTablePageModel serachAdvantageEmpEntity(SysTagSerachBean serachBean){
        this.sysTagService.searchAdvantageVideo(serachBean);
        return serachBean;
    }

    /**
     * 查询关联计划
     * @param serachBean
     */
    @AdminLogAnn(operType = OperType.AUTH,operLevel = OperLevel.NORM,operDescribe = "查询关联计划")
    @ResponseBody
    @RequestMapping(value = "/plan/entity",method = RequestMethod.POST)
    public DataTablePageModel serachPlanEmpEntity(SysTagSerachBean serachBean){
        this.sysTagService.searchPlans(serachBean);
        return serachBean;
    }

    /**
     * 根据方向查询标签列表
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "/plan/list/{directionId}",method = RequestMethod.GET)
    public ResponseJsonModel serachAllTagInfo(@PathVariable Integer directionId){
        List<SysTag> list=sysTagService.queryAllPlans(3,directionId);
        ResponseJsonModel responseJsonModel=new ResponseJsonModel();
        responseJsonModel.setResult(list);
        return responseJsonModel;
    }

}
