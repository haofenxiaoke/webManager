package com.kjs.web.controller.kjs.teacher;

import com.kjs.common.bean.DataTablePageModel;
import com.kjs.common.bean.ResponseJsonModel;
import com.kjs.common.bean.annotation.AdminLogAnn;
import com.kjs.common.bean.annotation.PermissionAnn;
import com.kjs.common.bean.enums.OperLevel;
import com.kjs.common.bean.enums.OperType;
import com.kjs.common.utils.ShiroUtils;
import com.kjs.orm.model.AuthorityUsers;
import com.kjs.orm.model.Teacher;
import com.kjs.service.kjs.authority.spi.IAuthorityUsersService;
import com.kjs.service.kjs.teacher.spi.ITeacherService;
import com.kjs.web.serach.kjs.teacher.TeacherManagerSerachBean;
import org.apache.commons.collections.CollectionUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import java.util.Date;
import java.util.List;

/**
 * 学员管理控制器
 * Created by wangsongpeng on 2016/2/25.
 */
@Controller
@RequestMapping("/teacher")
public class TeacherManagerController {
    private final static Logger logger = LoggerFactory.getLogger(TeacherManagerController.class);
    @Resource
    private ITeacherService teacherService;
    @Resource
    private IAuthorityUsersService usersService;

    /**
     * 跳转到老师管理管理页面
     * @return
     */
    @PermissionAnn(menuCode = "teacher",msg = "你没有进入老师管理页面的权限!")
    @RequestMapping(value = "/manager")
    public String forwardManager(Model model){
        return "teacher/teacher_manager";
    }

    /**
     * 老师管理列表
     * @return
     */
    @PermissionAnn(menuCode = "teacher",operCode = "find",msg = "你没有查询老师管理信息的权限!")
    @ResponseBody
    @RequestMapping(value = "/list",method = RequestMethod.POST)
    public DataTablePageModel serachTeachers(TeacherManagerSerachBean serachBean){
        this.teacherService.findPage(serachBean);
        return serachBean;
    }

    /**
     * 根据id查询老师数据
     * @param model
     */
    @AdminLogAnn(operType = OperType.SYSTEM,operLevel = OperLevel.NORM,operDescribe = "查询老师信息")
    @PermissionAnn(menuCode = "teacher",operCode = "find",msg = "你没有查询老师信息的权限!")
    @ResponseBody
    @RequestMapping(value = "/entity",method = RequestMethod.POST)
    public ResponseJsonModel serachEmpEntity(Model model, Long id){
        ResponseJsonModel responseJsonModel = new ResponseJsonModel();
        Teacher teacher =   this.teacherService.findById(id);
        responseJsonModel.setResult(teacher);
        return responseJsonModel;
    }

    /**
     *  保存
     * @param
     * @return
     */
    @AdminLogAnn(operType = OperType.SYSTEM,operLevel = OperLevel.NORM,operDescribe = "保存老师信息")
    @PermissionAnn(menuCode = "teacher",operCode = "save",msg = "你没有修改老师信息的权限!")
    @ResponseBody
    @RequestMapping(value = "/save",method = RequestMethod.POST)
    public ResponseJsonModel saveEmp(Teacher teacher)throws Exception{
        teacher.setUserId(ShiroUtils.getSessionUser().getId().intValue());
        teacher.setCtime(new Date());
        this.teacherService.save(teacher);
        logger.warn("修改老师信息:" + teacher.getId() + "-" + teacher.getName());
        return new ResponseJsonModel();
    }

    /**
     *  更新
     * @param
     * @return
     */
    @AdminLogAnn(operType = OperType.SYSTEM,operLevel = OperLevel.NORM,operDescribe = "修改老师信息")
    @PermissionAnn(menuCode = "teacher",operCode = "update",msg = "你没有修改老师信息的权限!")
    @ResponseBody
    @RequestMapping(value = "/update",method = RequestMethod.POST)
    public ResponseJsonModel updateEmp(Teacher teacher)throws Exception{
        this.teacherService.updateEmp(teacher);
        logger.warn("修改老师信息:" + teacher.getId() + "-" + teacher.getName());
        return new ResponseJsonModel();
    }

    /**
     * 根据id查询老师数据
     * @param model
     */
    @AdminLogAnn(operType = OperType.COURSE,operLevel = OperLevel.NORM,operDescribe = "添加直播课")
    @ResponseBody
    @RequestMapping(value = "/entity/user",method = RequestMethod.POST)
    public ResponseJsonModel serachEmpByNum(Model model, AuthorityUsers user){
        ResponseJsonModel responseJsonModel = new ResponseJsonModel();
        List<AuthorityUsers> usersList = this.usersService.search(user);
        if(CollectionUtils.isNotEmpty(usersList)){
            responseJsonModel.setResult(usersList.get(0));
        }
        return responseJsonModel;
    }

    /**
     * 验证是否存在
     */
    @ResponseBody
    @RequestMapping(value = "/check",method = RequestMethod.POST)
    public ResponseJsonModel check(Teacher teacher){
        ResponseJsonModel responseJsonModel = new ResponseJsonModel();
        List<Teacher> teachers = this.teacherService.search(teacher);
        responseJsonModel.setResult(CollectionUtils.isNotEmpty(teachers));
        return responseJsonModel;
    }
    /**
     * 查询老师用户数据
     * @param model
     */
    @ResponseBody
    @RequestMapping(value = "/teacherList",method = RequestMethod.POST)
    public ResponseJsonModel findTeacherList(Model model, AuthorityUsers user){
        ResponseJsonModel responseJsonModel = new ResponseJsonModel();
        List<Teacher> teacerList=teacherService.findTeacherList();
        responseJsonModel.setResult(teacerList);
        return responseJsonModel;
    }
    /**
     * 查询所有老师用户数据
     */
    @AdminLogAnn(operType = OperType.COURSE,operLevel = OperLevel.NORM,operDescribe = "添加直播课")
    @ResponseBody
    @RequestMapping(value = "/course/find",method = RequestMethod.GET)
    public ResponseJsonModel findAllTeacherList(){
        ResponseJsonModel responseJsonModel = new ResponseJsonModel();
        List<Teacher> teacerList=teacherService.findTeacherList();
        responseJsonModel.setResult(teacerList);
        return responseJsonModel;
    }

}
