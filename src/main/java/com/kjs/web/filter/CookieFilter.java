package com.kjs.web.filter;

import com.kjs.common.bean.ParamUtil;
import com.kjs.common.bean.SystemUrl;
import com.kjs.common.constant.SessionConstant;
import com.kjs.common.constant.SystemConstant;
import com.kjs.common.utils.CookieUtils;
import com.kjs.common.utils.ShiroUtils;
import com.kjs.orm.mapper.AuthorityUsersMapper;
import com.kjs.orm.model.AuthorityUsers;
import org.apache.shiro.web.filter.AccessControlFilter;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import javax.annotation.Resource;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;

/**
 *  验证当前请求是否有登录cookie,如果有取出来cookie中的用户ID,自动登录.
 */
public class CookieFilter extends AccessControlFilter {

    private final static Logger logger = LoggerFactory.getLogger(CookieFilter.class);

    @Resource
    private SystemUrl systemUrl;

    @Resource
    private AuthorityUsersMapper authorityUsersDao;

    /**
     * 验证当前请求是否有cookie,有自动登录,无拒绝此次请求,跳转到登录页面
     * @param servletRequest
     * @param servletResponse
     * @param o
     * @return true 认证此次请求 false 拒绝此次请求,执行onAccessDenied
     * @throws Exception
     */
    @Override
    protected boolean isAccessAllowed(ServletRequest servletRequest, ServletResponse servletResponse, Object o) throws Exception {
        HttpServletRequest  req = (HttpServletRequest)servletRequest;
        boolean flag = false;
        if(!ShiroUtils.isLogin()){
            //没有登录走cookie逻辑
            Cookie cookie = CookieUtils.getCookieByKey(req.getCookies(), SystemConstant.LOGIN_COOKIE_KEY);
            if(null!=cookie){
                AuthorityUsers u =  authorityUsersDao.findById(Long.valueOf(cookie.getValue()));//获取用户
                //自动登录
                ShiroUtils.login(u.getId(),u.getEmail(),u.getPassword());
                ShiroUtils.getSession().setAttribute(SessionConstant.LOGIN_USER,u);
                flag = true;
            }
        }

        return flag;
    }

    /**
     * 如果当前请求被拒绝,进行处理。返回true,表示需要继续处理,false表示已经处理.
     * @param servletRequest
     * @param servletResponse
     * @return
     * @throws Exception
     */
    @Override
    protected boolean onAccessDenied(ServletRequest servletRequest, ServletResponse servletResponse) throws Exception {
        return true;
    }


}
