package com.kjs.web.controller.kjs.user;

import com.kjs.common.bean.DataTablePageModel;
import com.kjs.common.bean.MenuCacheModel;
import com.kjs.common.bean.ResponseJsonModel;
import com.kjs.common.bean.annotation.AdminLogAnn;
import com.kjs.common.bean.annotation.PermissionAnn;
import com.kjs.common.bean.enums.OperLevel;
import com.kjs.common.bean.enums.OperType;
import com.kjs.common.utils.RequestParamUtils;
import com.kjs.common.utils.ShiroUtils;
import com.kjs.common.utils.StringUtil;
import com.kjs.orm.model.UserStu;
import com.kjs.service.kjs.authority.spi.IAuthorityOperationService;
import com.kjs.service.kjs.category.spi.ICategoryDirectionService;
import com.kjs.service.kjs.course.spi.ICourseQuestionService;
import com.kjs.service.kjs.user.spi.IUserLectureDataService;
import com.kjs.service.kjs.user.spi.IUserLectureService;
import com.kjs.service.kjs.user.spi.IUserStuService;
import com.kjs.service.kjs.user.spi.IUserVipService;
import com.kjs.common.dto.user.ExportCsvForAnswerDto;
import com.kjs.web.serach.kjs.user.UserManagerSerachBean;
import com.kjs.web.serach.kjs.user.UserStuSerachBean;
import org.apache.commons.codec.digest.DigestUtils;
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
 * 学员管理控制器
 * Created by wangsongpeng on 2016/2/25.
 */
@Controller
@RequestMapping("/stu")
public class UserManagerController {
    private final static Logger logger = LoggerFactory.getLogger(UserManagerController.class);
    @Resource
    private IUserStuService userStuService;
    @Resource
    private IUserLectureService userLectureService;
    @Resource
    private IUserLectureDataService userrLectureDataService;
    @Resource
    private ICourseQuestionService courseQuestionService;
    @Resource
    private IUserVipService userVipService;
    @Resource
    ICategoryDirectionService categoryDirectionService;
    @Resource
    private IAuthorityOperationService authorityOperationService;
    @Resource
    private MenuCacheModel menuCacheModel;

    /**
     * 跳转到学员管理管理页面
     * @return
     */
    @PermissionAnn(menuCode = "stu",msg = "你没有进入学员管理页面的权限!")
    @RequestMapping(value = "/manager")
    public String forwardManager(Model model){
        return "user/stu_tab";
    }

    /**
     * 学员管理列表
     * @return
     */
    @PermissionAnn(menuCode = "stu",operCode = "find",msg = "你没有查询学员管理用户信息的权限!")
    @ResponseBody
    @RequestMapping(value = "/list",method = RequestMethod.POST)
    public DataTablePageModel serachVipInfo(UserStuSerachBean serachBean){
        this.userStuService.findCategoryPage(serachBean);
        return serachBean;
    }

    /**
     * 根据id查询学员用户数据
     * @param model
     */
    @AdminLogAnn(operType = OperType.SYSTEM,operLevel = OperLevel.NORM,operDescribe = "查询学员用户信息")
    @PermissionAnn(menuCode = "stu",operCode = "search",msg = "你没有查询学员用户信息的权限!")
    @ResponseBody
    @RequestMapping(value = "/entity",method = RequestMethod.POST)
    public ResponseJsonModel serachEmpEntity(Model model, Long id){
        ResponseJsonModel responseJsonModel = new ResponseJsonModel();
        UserStu stu =   this.userStuService.findDetail(id);
        responseJsonModel.setResult(stu);
        return responseJsonModel;
    }

    /**
     *  更新
     * @param
     * @return
     */
    @AdminLogAnn(operType = OperType.SYSTEM,operLevel = OperLevel.NORM,operDescribe = "修改学员信息")
    @PermissionAnn(menuCode = "stu",operCode = "save",msg = "你没有修改学员信息的权限!")
    @ResponseBody
    @RequestMapping(value = "/update",method = RequestMethod.POST)
    public ResponseJsonModel updateEmp(UserStu userStu)throws Exception{
        if(StringUtil.isNotEmpty(userStu.getPassword())){
            userStu.setPassword(DigestUtils.md5Hex(userStu.getPassword()));
        }
        userStu.setLastModifyDatetime(new Date());
        userStu.setLastModifyUserId(ShiroUtils.getSessionUser().getId().intValue());
        userStu.setLastModifyUserEmail(ShiroUtils.getSessionUser().getEmail());
        this.userStuService.update(userStu);
        logger.warn("修改学员信息:" + userStu.getId() + "-" + userStu.getUsername());
        return new ResponseJsonModel();
    }

    /**
     * 跳转到学员管理详细Tab页面
     * @return
     */
    @PermissionAnn(menuCode = "stu",msg = "你没有进入学员管理详细Tab页面的权限!")
    @RequestMapping(value = "/managerTab/{user_id}")
    public String forwardManagerTab(Model model,@PathVariable String user_id){
        UserStu userStu = new UserStu();
        userStu = userStuService.findById(RequestParamUtils.switchToLong(user_id));
        if(userStu!=null){
            model.addAttribute("nickName", userStu.getUsername());
            model.addAttribute("userName", userStu.getUserid());
        }
        model.addAttribute("user_id", user_id);
        return "user/stu_detail_tab";
    }

    /**
     * 跳转到学员管理管理基本信息页面
     * @return
     */
    @PermissionAnn(menuCode = "stu",msg = "你没有进入学员管理页面的权限!")
    @RequestMapping(value = "/managerDetail/{detailtype}/{user_id}")
    public String forwardManagerDetail(Model model,@PathVariable String detailtype,@PathVariable String user_id){
        model.addAttribute("detailtype", detailtype);
        model.addAttribute("user_id", user_id);
        return "user/stu_detail_"+detailtype;
    }

    /**
     * 视频记录列表
     * @return
     */
    @PermissionAnn(menuCode = "stu",operCode = "find",msg = "你没有视频记录页面的查询权限!")
    @ResponseBody
    @RequestMapping(value = "/video/list",method = RequestMethod.POST)
    public DataTablePageModel serachUserCourseInfo(UserManagerSerachBean serachBean){
        if(serachBean.getDirectionId() == null){//未选择任何分类的情况下,默认显示该用户所拥有分类下的直播课程信息
            Long[] ids = categoryDirectionService.findCateIdsByUserIdAndResourceCodeAndOperationCode(ShiroUtils.getSessionUser().getId(), "stu", "find");
            serachBean.setDerectionIds(ids);
        }
        this.userLectureService.findPage(serachBean);
        return serachBean;
    }

    /**
     * 资料记录列表
     * @return
     */
    @PermissionAnn(menuCode = "stu",operCode = "find",msg = "你没有资料记录页面的查询权限!")
    @ResponseBody
    @RequestMapping(value = "/lecture/list",method = RequestMethod.POST)
    public DataTablePageModel serachUserLectureInfo(UserManagerSerachBean serachBean){
        if(serachBean.getDirectionId() == null){//未选择任何分类的情况下,默认显示该用户所拥有分类下的直播课程信息
            Long[] ids = categoryDirectionService.findCateIdsByUserIdAndResourceCodeAndOperationCode(ShiroUtils.getSessionUser().getId(), "stu", "find");
            serachBean.setDerectionIds(ids);
        }
        this.userrLectureDataService.findPage(serachBean);
        return serachBean;
    }

    /**
     * 购买记录列表
     * @return
     */
    @PermissionAnn(menuCode = "stu",operCode = "find",msg = "你没有购买记录页面的查询权限!")
    @ResponseBody
    @RequestMapping(value = "/vip/list",method = RequestMethod.POST)
    public DataTablePageModel serachUserVipInfo(UserManagerSerachBean serachBean){
        this.userVipService.findPage(serachBean);
        return serachBean;
    }

    /**
     * 问答记录列表
     * @return
     */
    @PermissionAnn(menuCode = "stu",operCode = "find",msg = "你没有问答记录页面的查询权限!")
    @ResponseBody
    @RequestMapping(value = "/question/list",method = RequestMethod.POST)
    public DataTablePageModel serachCourseQuestionInfo(UserManagerSerachBean serachBean){
        this.courseQuestionService.findPage(serachBean);
        return serachBean;
    }

    /**
     * 根据问题id查询问答记录
     * @param request
     */
    @AdminLogAnn(operType = OperType.SYSTEM,operLevel = OperLevel.NORM,operDescribe = "查询学员用户信息")
    @PermissionAnn(menuCode = "stu",operCode = "search",msg = "你没有查询学员用户信息的权限!")
    @ResponseBody
    @RequestMapping(value = "/question/answers",method = RequestMethod.POST)
    public ResponseJsonModel serachAnswers(HttpServletRequest request){
        ResponseJsonModel responseJsonModel = new ResponseJsonModel();
        Map paramMap = RequestParamUtils.getParamValues(request);
        List<Map> stus =   this.courseQuestionService.serachAnswersById(paramMap);
        responseJsonModel.setResult(stus);
        return responseJsonModel;
    }

    /**
     * 老师答疑导出csv
     * @return
     */
    @AdminLogAnn(operType = OperType.SYSTEM,operLevel = OperLevel.NORM,operDescribe = "老师答疑导出csv")
    @PermissionAnn(menuCode = "stu",operCode = "export",msg = "你没有老师答疑导出csv的权限!")
    @ResponseBody
    @RequestMapping(value = "/export/csv/answers",method = RequestMethod.POST)
    public ResponseJsonModel exportCsvAnswers(UserStuSerachBean serachBean){
        ResponseJsonModel responseJsonModel = new ResponseJsonModel();
        List<UserStu> exportDatas = this.userStuService.exportCsvAnswers(serachBean);
        responseJsonModel.setResult(exportDatas);
        return responseJsonModel;
    }
}
