package com.kjs.common.utils;

import com.kjs.common.bean.ParamUtil;
import com.kjs.orm.model.AuthorityUsers;
import org.apache.commons.mail.EmailException;
import org.apache.commons.mail.SimpleEmail;
import org.slf4j.LoggerFactory;

import java.io.IOException;
import java.util.Properties;

/**
 * Commons email邮箱工具类
 * Created by wangsongpeng on 2016/3/29.
 */
public class EmailUtils {


    private final static org.slf4j.Logger logger;

    private final static Properties properties = new Properties();//属性对象读取邮件配置文件

    static {
        logger = LoggerFactory.getLogger(EmailUtils.class);
        try {
            properties.load(EmailUtils.class.getResourceAsStream("/smtp.properties"));
        }catch (IOException e){
            logger.error("加载邮件配置文件smtp.properties时出现异常",e);
        }

    }


    /**
     * 员工添加成功后发送初始化密码到对啊邮箱
     *
     */
    public static void sendEmpDuiaEmail(AuthorityUsers users){
        SimpleEmail simpleEmail = new SimpleEmail();
        try{
            simpleEmail.setHostName(properties.getProperty("mail.smtp.host"));//邮件服务器地址
            simpleEmail.setSmtpPort(Integer.valueOf(properties.getProperty("mail.smtp.port")));//端口号
            simpleEmail.setAuthentication(properties.getProperty("mail.smtp.user"),properties.getProperty("mail.smtp.pass"));//邮件用户名密码
            simpleEmail.setFrom(properties.getProperty("mail.smtp.from"));//邮件发送人
            simpleEmail.addTo(users.getEmail());//邮件接收人
            simpleEmail.setSubject("新员工密码(系统邮件请勿回复)");//邮件主题
            simpleEmail.setMsg("恭喜您成为"+ParamUtil.PRODUCT_NAME+"网新员工!您的后台系统默认密码为:"+users.getPassword()+"."+"请登录"+ ParamUtil.hostUrl+"后台系统后尽快修改自己的密码.");//邮件正文
            simpleEmail.send();//发送
        }catch (EmailException e){
             logger.error("发送给"+users.getEmail()+"密码邮件时,异常",e);
        }
    }
}
