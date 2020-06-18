package com.kjs.common.exception;
import com.kjs.common.bean.DataTablePageModel;
import com.kjs.common.bean.ResponseJsonModel;
import com.kjs.common.constant.HttpConstant;
import com.kjs.common.exception.authority.UnAuthorityException;
import com.fasterxml.jackson.databind.ObjectMapper;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Component;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.method.HandlerMethod;
import org.springframework.web.servlet.HandlerExceptionResolver;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;

/**
 * 系统异常管理
 * Created by wangsongpeng on 2015/10/23.
 */
@Component
public class CustomExceptionHandler implements HandlerExceptionResolver {
    private static final Logger logger = LoggerFactory.getLogger(CustomExceptionHandler.class);
    @Override
    public ModelAndView resolveException(HttpServletRequest request, HttpServletResponse response, Object o, Exception e){
        ModelAndView mv = new ModelAndView();
        HandlerMethod method = null!=o?method =(HandlerMethod)o:null;//获取抛出异常的方法对象
        if(null!=method){
            String redirect = "/error/all_ex";//重定向页面,默认all_ex.jsp总异常页面
            String message = "控制器" + method.getBean() + "方法" + method.getMethod().getName() + "出现异常,异常信息:" + e;
            logger.error(message);
            //根据异常选择相应的异常处理页面,并打印异常
            if(e instanceof UnAuthorityException){
                logger.error("无权限异常:",e);
                redirect = "/error/un_auth";//无权限页面
            }else if(e instanceof  RuntimeException){
                logger.error("运行时异常:",e);
                redirect = "/error/runtime_ex";//运行时异常页面
            }else{
                logger.error("异常:",e);
            }
            if(null!=method.getMethodAnnotation(ResponseBody.class)){
                //如果返回的是纯Json数据

                response.setContentType(MediaType.APPLICATION_JSON_VALUE);
                Object obj = getResponseJsonModel(method.getMethod().getReturnType(),message);
                if(null == obj){
                    throw new RuntimeException(this.getClass().getName()+"方法返回的JSON对象无法转换返回",e);
                }
                try{
                    PrintWriter writer =  response.getWriter();
                    writer.write(new ObjectMapper().writeValueAsString(obj));
                }catch (IOException ex){
                    throw new RuntimeException(e);
                }
                return mv;
            }else{
                //如果返回的是jsp数据
                StackTraceElement[] stack =   e.getStackTrace();//获取异常堆栈
                mv.addObject("e",e);////添加异常信息到Request中,Key e
                mv.addObject("stack",stack);
                mv.setViewName(redirect);//Get方法,跳转到相应jsp页面
            }
        }else{
            throw new NullPointerException("CustomExceptionHandler中HandlerMethod为空!");
        }
        return mv;
    }


    private Object getResponseJsonModel(Class c,String message){
           if(c.isAssignableFrom(DataTablePageModel.class)){
             //返回的是DataTablePageModel对象
             DataTablePageModel tablePageModel = new DataTablePageModel();
             tablePageModel.setError("系统出现异常:"+message);
             return tablePageModel;
           }else if(c.isAssignableFrom(ResponseJsonModel.class)){
               //返回的是responseJsonModel对象
               ResponseJsonModel rjm = new ResponseJsonModel();
               rjm.setCode(HttpConstant.ERROR_CODE);
               rjm.setMsg("系统出现异常:" + message);
               return rjm;
           }
           return null;
    }
}
