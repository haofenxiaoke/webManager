package com.kjs.web.controller.kjs.authority;
import com.kjs.common.bean.annotation.AdminLogAnn;
import com.kjs.common.bean.enums.OperLevel;
import com.kjs.common.bean.enums.OperType;
import com.kjs.common.bean.ResponseJsonModel;
import com.kjs.common.bean.DataTablePageModel;
import com.kjs.common.bean.annotation.PermissionAnn;
import com.kjs.common.constant.HttpConstant;
import com.kjs.common.constant.SystemConstant;
import com.kjs.common.thread.SendDuiaEmailThread;
import com.kjs.common.utils.MD5;
import com.kjs.common.utils.PassWordUtils;
import com.kjs.common.utils.ShiroUtils;
import com.kjs.common.utils.StringUtil;
import com.kjs.orm.model.AuthorityUserRole;
import com.kjs.orm.model.AuthorityUsers;
import com.kjs.service.kjs.authority.spi.IAuthorityUsersService;
import com.kjs.web.serach.kjs.authority.AuthorityUserDetailBean;
import com.kjs.web.serach.kjs.authority.AuthorityUserSerachBean;
import com.kjs.web.serach.kjs.authority.AuthorityUserWechatBean;

import org.apache.commons.codec.digest.DigestUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.scheduling.concurrent.ThreadPoolTaskExecutor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import java.util.Date;
import java.util.List;

/**
 * 对啊网权限员工控制器
 * Created by wangsongpeng on 2016/1/14.
 */
@Controller
@RequestMapping(value = "/user")
public class AuthorityUserController {

    private final static Logger logger = LoggerFactory.getLogger(AuthorityUserController.class);
    @Resource
    private IAuthorityUsersService authorityUserService;

    @Resource(name = "sendEmailThreadPool")
    private ThreadPoolTaskExecutor sendEmailThreadPool;

    /**
     * 跳转到员工管理页面
     * @return
     */
    @PermissionAnn(menuCode = "user",msg = "你没有进入员工管理页面的权限!")
    @RequestMapping(value = "/manager")
    public String forwardEmpManager(Model model){
      return "authority/authority_user";
    }


    /**
     * 查询员工信息
     * @return
     */
    @PermissionAnn(menuCode = "user",operCode = "find",msg = "你没有员工管理页面的查询权限!")
    @ResponseBody
    @RequestMapping(value = "/serach",method = RequestMethod.POST)
    public DataTablePageModel serachEmpInfo(AuthorityUserSerachBean userSerachBean){
        authorityUserService.findUserPage(userSerachBean);
        return userSerachBean;
    }


    /**
     * 根据员工ID获取当前员工数据
     * @author 嵇俊达
     * @date 2020.4.27
     * @param id
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "/entity"/*,method = RequestMethod.POST*/)
    public ResponseJsonModel serachEmpEntity(Model model, Long id){
        ResponseJsonModel responseJsonModel = new ResponseJsonModel();
        AuthorityUsers users =   this.authorityUserService.findById(id);
        responseJsonModel.setResult(users);
        return responseJsonModel;
    }

    /**
     *  锁定或解锁用户
     * @param user
     * @return
     */
    @PermissionAnn(menuCode = "user",operCode = "lock",msg = "你没有锁定员工的权限!")
    @ResponseBody
    @RequestMapping(value = "/lock",method = RequestMethod.POST)
    public ResponseJsonModel lockingEmp(AuthorityUsers user){
        user.setLastModifyUserId(ShiroUtils.getSessionUser().getId());
        user.setLastModifyUserEmail(ShiroUtils.getSessionUser().getEmail());
        user.setLastModifyDatetime(new Date());
        this.authorityUserService.LockingUser(user);
        return new ResponseJsonModel();
    }


    /**
     *  新增员工
     * @param user
     * @return
     */
    @AdminLogAnn(operType = OperType.SYSTEM,operLevel = OperLevel.NORM,operDescribe = "新增员工")
    @PermissionAnn(menuCode = "user",operCode = "save",msg = "你没有新增员工的权限!")
    @ResponseBody
    @RequestMapping(value = "/save",method = RequestMethod.POST)
    public ResponseJsonModel saveEmp(AuthorityUsers user)throws Exception{
        Date now = new Date();
        user.setCreateDatetime(now);
        user.setLastModifyUserId(ShiroUtils.getSessionUser().getId());
        user.setLastModifyUserEmail(ShiroUtils.getSessionUser().getEmail());
        user.setLastModifyDatetime(now);
        String pwd = PassWordUtils.getRandomPwd(SystemConstant.PASSWORD_BIT);
        user.setPassword(MD5.getMD5(pwd));
        this.authorityUserService.save(user);
        logger.warn("新增员工:" + user.getEmail() + "生成的随机密码为:" + pwd);
        user.setPassword(pwd);
        //添加成功后,发送邮箱*/
        SendDuiaEmailThread sdeThread = new SendDuiaEmailThread(user);
        sendEmailThreadPool.getThreadPoolExecutor().execute(sdeThread);
        return new ResponseJsonModel();
    }

    /**
     *  修改员工
     * @param user
     * @return
     */
    @AdminLogAnn(operType = OperType.SYSTEM,operLevel = OperLevel.NORM,operDescribe = "修改员工")
    @PermissionAnn(menuCode = "user",operCode = "update",msg = "你没有修改员工的权限!")
    @ResponseBody
    @RequestMapping(value = "/update",method = RequestMethod.POST)
    public ResponseJsonModel updateEmp(AuthorityUsers user){
        user.setUserLock(user.getUserStatus());//在职解锁,离职锁定.
        user.setLastModifyUserId(ShiroUtils.getSessionUser().getId());
        user.setLastModifyUserEmail(ShiroUtils.getSessionUser().getEmail());
        user.setLastModifyDatetime(new Date());
        if(StringUtil.isNotEmpty(user.getPassword())){
            user.setPassword(MD5.getMD5(user.getPassword()));
        }
        this.authorityUserService.update(user);
        return new ResponseJsonModel();
    }


    /**
     * 验证当前用户Email邮箱否唯一
     * @param
     */
    @ResponseBody
    @RequestMapping(value = "/check/userEmail",method = RequestMethod.POST)
    public ResponseJsonModel checkEmailAttr(AuthorityUsers users){
        ResponseJsonModel arm = new ResponseJsonModel();
        if(this.authorityUserService.checkUserEmailUnique(users)){
            //唯一
            arm.setCode(HttpConstant.SUCCESS_CODE);
        }else{
            //有重复
            arm.setCode(HttpConstant.ERROR_CODE);
        }
        return arm;
    }

    /**
     * 验证当前用户Email邮箱否唯一
     * @param
     */
    @ResponseBody
    @RequestMapping(value = "/check/userNum",method = RequestMethod.POST)
    public ResponseJsonModel checkNumAttr(AuthorityUsers users){
        ResponseJsonModel arm = new ResponseJsonModel();
        if(this.authorityUserService.checkUserNumUnique(users)){
            //唯一
            arm.setCode(HttpConstant.SUCCESS_CODE);
        }else{
            //有重复
            arm.setCode(HttpConstant.ERROR_CODE);
        }
        return arm;
    }

    /**
     * 跳转个人页面
     *@author 嵇俊达
     * @date 2020.4.26
     * @param model
     * @return
     */
    @RequestMapping({"/passWordAndInfo"})
    public String passWordAndInfo(Model model/*,Long id*/) {
        model.addAttribute("user", ShiroUtils.getSessionUser());
        Long userId=ShiroUtils.getSessionUser().getId();
//        System.out.println(userId);
//        List<AuthorityUserRole> aur=this.authorityUserService.RoleIdByUserId(userId);
        List<AuthorityUserRole> roleId=authorityUserService.RoleIdByUserId(userId);
        System.out.println(roleId);
        model.addAttribute("roleId", roleId);
        model.addAttribute("id", userId);
        System.out.println(model);
        return "authority/userInfo";
    }
    
    /**
     * 微信信息
     * @author 嵇俊达
     * @date 2020.4.27
     */
//   param———————————AuthorityUserWechatBean authorityUserWechatBean
    @ResponseBody
    @RequestMapping(value = {"/savewechat"}/*, method = {org.springframework.web.bind.annotation.RequestMethod.POST}*/)
    public ResponseJsonModel savewechat(Integer wechatStatus,String wechatDi, String wechatUrl,Long id) {
        ResponseJsonModel rjm = new ResponseJsonModel();
        
        try{
        	AuthorityUsers authorityUsers = ShiroUtils.getSessionUser();
//        	Long id=ShiroUtils.getSessionUser().getId();
        	authorityUsers.setId(id);
            authorityUsers.setWechatStatus(wechatStatus);
            authorityUsers.setWechatDi(wechatDi);
            authorityUsers.setWechatUrl(wechatUrl);
        	this.authorityUserService.savewechat(authorityUsers);
            rjm.setMsg("修改成功");
            rjm.setCode(HttpConstant.SUCCESS_CODE);
        } 
        catch (Exception e) {
        	rjm.setCode(HttpConstant.ERROR_CODE);
            rjm.setMsg("修改失败");
		} 
        return rjm;
    } 
    
    
    
    

    /**
     * 修改密码
     *
     * @param authorityUserDetailBean
     * @return
     */
    @ResponseBody
    @RequestMapping(value = {"/updatePassWord"}, method = {org.springframework.web.bind.annotation.RequestMethod.POST})
    public ResponseJsonModel updatePassWord(AuthorityUserDetailBean authorityUserDetailBean) {
        ResponseJsonModel rjm = new ResponseJsonModel();
        AuthorityUsers authorityUsers = ShiroUtils.getSessionUser();
        if (authorityUsers.getPassword().equals(MD5.getMD5(authorityUserDetailBean.getOldPassWord()))) {
            authorityUsers.setPassword(MD5.getMD5(authorityUserDetailBean.getNewPassWord()));
            this.authorityUserService.update(authorityUsers);
            rjm.setMsg("修改成功");
            rjm.setCode(HttpConstant.SUCCESS_CODE);
        } else {
            rjm.setCode(HttpConstant.ERROR_CODE);
            rjm.setMsg("原密码不正确");
        }
        return rjm;
    }

}
