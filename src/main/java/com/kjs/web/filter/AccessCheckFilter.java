package com.kjs.web.filter;
import com.kjs.common.bean.SystemUrl;
import com.kjs.common.utils.ShiroUtils;
import org.apache.shiro.web.filter.AccessControlFilter;
import org.apache.shiro.web.util.WebUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import javax.annotation.Resource;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.List;
/**
 * 请求验证过滤器
 * 验证当前请求是否合法
 * 1:请求是否是被放过的
 * 2:当前请求是否是登录用户发送的
 * Created by wangsongpeng on 2015/9/29.
 */
public class AccessCheckFilter extends AccessControlFilter {

    private final static Logger logger = LoggerFactory.getLogger(AccessCheckFilter.class);
    @Resource
    private SystemUrl systemUrl;

    /**
     * 验证当前请求是否允许, 允许返回true,不允许返回false
     * @param servletRequest
     * @param servletResponse
     * @param o
     * @return
     * @throws Exception
     */
    @Override
    protected boolean isAccessAllowed(ServletRequest servletRequest, ServletResponse servletResponse, Object o) throws Exception {
        HttpServletRequest  req = (HttpServletRequest)servletRequest;
        boolean flag = false;
        if(ShiroUtils.isLogin()){
            //已登录
            flag =  true;
        }else{
            //如果没有登录过
            List<String> urls =  this.systemUrl.getPassUrl();//放过的URL
            for (String u :urls){
                if(this.pathsMatch(u,req)){
                        flag = true;
                        break;
                }
            }
        }
        return flag;
    }

    /**
     *  如果当前请求被拒绝,进行处理。返回true,表示需要继续处理,转到下一个过滤器 false表示已经处理.
     * @param servletRequest
     * @param servletResponse
     * @return
     * @throws Exception
     */
    @Override
    protected boolean onAccessDenied(ServletRequest servletRequest, ServletResponse servletResponse) throws Exception {
        HttpServletRequest  req = (HttpServletRequest)servletRequest;
        HttpServletResponse res = (HttpServletResponse)servletResponse;
        WebUtils.issueRedirect(req, res, systemUrl.getLoginUrl());
        return false;
    }


}
