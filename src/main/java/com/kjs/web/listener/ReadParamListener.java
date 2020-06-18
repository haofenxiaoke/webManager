package com.kjs.web.listener;
import com.kjs.common.bean.ParamUtil;
import com.kjs.common.utils.EvaluateUtil;

import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;
import javax.servlet.annotation.WebListener;
/**
 * 读取参数监听器
 * Created by wangsongpeng on 2015/11/4.
 */
@WebListener(value = "ReadParamListener")
public class ReadParamListener implements ServletContextListener {
    /**
     * 容器启动时,触发方法,执行后,容器创建filter,需要初始化的servlet
     * @param servletContextEvent
     */
    @Override
    public void contextInitialized(ServletContextEvent servletContextEvent) {
        EvaluateUtil EvaluateUtil = new EvaluateUtil();
        EvaluateUtil.autoEvalVal();
        servletContextEvent.getServletContext().setAttribute("imageServicePath", ParamUtil.imageServicePath);
    }
    /**
     * 容器销毁时,触发方法.
     * @param servletContextEvent
     */
    @Override
    public void contextDestroyed(ServletContextEvent servletContextEvent) {

    }


}
