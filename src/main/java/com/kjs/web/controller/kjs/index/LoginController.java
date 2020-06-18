package com.kjs.web.controller.kjs.index;

import com.kjs.common.constant.SystemConstant;
import com.kjs.common.dto.login.LoginDto;
import com.kjs.common.utils.CookieUtils;
import com.kjs.common.utils.ShiroUtils;
import com.kjs.orm.model.AuthorityUsers;
import com.kjs.service.kjs.authority.spi.IAuthorityUsersService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * 后台登录控制器
 * 只能没有登录的用户可以访问
 * Created by wangsongpeng on 2015/11/11.
 */

@RequestMapping(value = "/auth")
@Controller
public class LoginController {

    private final static Logger logger = LoggerFactory.getLogger(LoginController.class);

    @Resource(name = "AuthorityUsers")
    private IAuthorityUsersService authorityUsers;/*用户业务逻辑对象*/

    /**
     * 跳转登录页面
      * @param request
     * @param response
     * @return
     */
    @RequestMapping(value = "/login")
    public String redirectLogin(HttpServletRequest request, HttpServletResponse response){
           //如果已经登录过,跳转到首页
           if(ShiroUtils.isLogin()){
               return "redirect:/";
           }
           return "login/login";
    }

    /**
     * 登出
     * @param request
     * @param response
     * @return
     */
    @RequestMapping(value = "/signOut")
    public String signOut(HttpServletRequest request, HttpServletResponse response){
        if(ShiroUtils.isLogin()){
            response.addCookie(CookieUtils.removeCookie(SystemConstant.LOGIN_COOKIE_KEY));//删除保持登录cookie
            ShiroUtils.logout();
        }
        return "redirect:/auth/login";
    }

    /**
     * 验证登录,通过用户的Email或Mobile进行验证
     * @param request
     * @param response
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "/check",method = RequestMethod.POST)
    public LoginDto checkLogin(HttpServletRequest request, HttpServletResponse response, AuthorityUsers users,boolean isrem) {
        return  authorityUsers.checkLogin(users,response,isrem);
    }
}
