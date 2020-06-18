package com.kjs.web.interceptor;

import com.kjs.common.bean.MenuCacheModel;
import com.kjs.common.bean.annotation.PermissionAnn;
import com.kjs.common.constant.SystemConstant;
import com.kjs.common.exception.authority.UnAuthorityException;
import com.kjs.common.permission.Permission;
import com.kjs.common.utils.ShiroUtils;
import com.kjs.common.dto.auth.MenuDto;
import org.springframework.util.CollectionUtils;
import org.springframework.web.method.HandlerMethod;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.List;

/**
 * 权限拦截器
 * Created by wangsongpeng on 2016/3/2.
 */
public class PermissionInterceptor extends HandlerInterceptorAdapter {
    @Resource
    private MenuCacheModel menuCacheModel;


    /**
     * 在方法触发之前触发
     *
     * @param request
     * @param response
     * @param handler
     * @return true 继续下一个拦截器 false 完成之前拦截器的方法,执行下面的控制器方法
     * @throws Exception
     */
    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
        if (!ShiroUtils.isLogin()) {
            //如果没有登录
            return false;
        }
        HandlerMethod method = (HandlerMethod) handler;//获取当前要执行的方法
        PermissionAnn p = method.getMethodAnnotation(PermissionAnn.class);//获取权限注解
        if (null != p) {
            String category = p.category();//
            String operCode = p.operCode();
            if (category.startsWith("#")) {
                String name = category.substring(category.indexOf("#") + 1);
                //动态参数绑定
                category = request.getParameter(name);
            }

            if (operCode.startsWith("#")) {
                String name = operCode.substring(operCode.indexOf("#") + 1);
                //动态参数绑定
                operCode = request.getParameter(name);
            }
            //验证是否有权限
            if (ShiroUtils.hasNotPermission(new Permission(p.menuCode(), operCode, category))) {
                throw new UnAuthorityException(p.msg());
            }
        }
        return true;
    }

    /**
     * 在方法触发之后触发
     *
     * @param request
     * @param response
     * @param handler
     * @param modelAndView
     * @throws Exception
     */
    @Override
    public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler, ModelAndView modelAndView) throws Exception {
        HandlerMethod method = (HandlerMethod) handler;
        if(null == modelAndView){
            modelAndView = new ModelAndView();
        }
        if (request.getMethod().equalsIgnoreCase("GET")) {
            //如果是Get方法,菜单点击
            PermissionAnn p = method.getMethodAnnotation(PermissionAnn.class);
            if (null != p) {
                modelAndView.addObject("code", p.menuCode());
            }
            if(ShiroUtils.isLogin()){
                long uid =ShiroUtils.getSessionUser().getId();
                List<MenuDto> ms =  menuCacheModel.getMenu(uid);
                if(CollectionUtils.isEmpty(ms)){
                    menuCacheModel.loadUserMenu(uid);
                    ms = menuCacheModel.getMenu(uid);
                }
                request.setAttribute(SystemConstant.USER_MENU,ms);
            }

        }


    }
}
