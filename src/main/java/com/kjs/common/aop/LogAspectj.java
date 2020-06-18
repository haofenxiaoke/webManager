package com.kjs.common.aop;
import com.kjs.common.bean.annotation.AdminLogAnn;
import com.kjs.common.utils.ShiroUtils;
import com.kjs.orm.model.AdminLog;
import com.kjs.service.kjs.log.spi.IAdminLogService;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import org.aspectj.lang.JoinPoint;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Component;
import org.springframework.ui.Model;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

/**
 * 日志Aspectj Aop
 * Created by wangsongpeng on 2015/11/4.
 */
@Component("LogAspectj")
public class LogAspectj {
    private final static Logger logger = LoggerFactory.getLogger(LogAspectj.class);
    @Resource
    private IAdminLogService adminLogService;

    /**
     * 添加日志
     */
    public void saveLog(JoinPoint point,AdminLogAnn logAnn)  {
        logger.debug("开始写后台管理系统日志");
        if(logAnn.enable()){
            try {
                AdminLog adminLog = new AdminLog();
                adminLog.setUserId(ShiroUtils.getSessionUser().getId());/*用户ID*/
                adminLog.setUserName(ShiroUtils.getSessionUser().getUsername());/*用户名*/
                adminLog.setOperName(point.getSignature().toString());/*操作名称*/
                String param = this.convertArgs(point.getArgs());//操作参数
                adminLog.setOperParam(param);//操作参数
                adminLog.setOperDescribe(logAnn.operDescribe());//操作描述
                adminLog.setOperType(logAnn.operType().getValue());//操作类型
                adminLog.setOperLevel(logAnn.operLevel().getValue());//操作级别
                adminLog.setOperTime(new Date());
                this.adminLogService.save(adminLog);
            }catch (JsonProcessingException e){
                logger.error("日志切面出现异常:",e);
            }

        }
    }

    /**
     * 转换成相应的日志参数,去掉不需要的参数
     * @param objs 参数对象数组
     * @return
     */
    private String convertArgs(Object[] objs)throws JsonProcessingException{
        String param = "";
        if(null != objs && objs.length >0){
            List para = new ArrayList<>();
            for(int i = 0; i<objs.length;i++){
               Object o = objs[i];
               if(HttpServletRequest.class.isInstance(o)||
                       HttpServletResponse.class.isInstance(o)||
                       HttpSession.class.isInstance(o)||Model.class.isInstance(o)){
                       continue;
               }
               para.add(o);
            }

            ObjectMapper json = new ObjectMapper();
            param = json.writeValueAsString(para);
        }
        return param;
    }


}
