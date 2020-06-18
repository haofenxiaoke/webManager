package com.kjs.common.utils;

import com.cloopen.rest.sdk.CCPRestSmsSDK;
import com.kjs.common.exception.SendLimitException;
import com.kjs.common.exception.SmsSendException;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.util.HashMap;

/**
 * 手机验证码发送工具类
 * Created by wsp on 2015/6/2.
 * <p>
 * // templates.add(new Template("7107", "【对啊网】欢迎加入对啊网.*您的验证码是(.*)。视频，做题，直播学习，快来和老师同学一起互动学习！", 1));
 * //templates.add(new Template("7110", "感谢您(.*)选择对啊网直播课程，您的订单已经生成，请在2小时内支付，支付后将成为对啊网正式学员，享受VIP学员服务！官方客服QQ800055346【对啊网】", 1));
 * // templates.add(new Template("7111", "恭喜您(.*)已成功购买对啊网直播课程，课程已经自动开通，请进入对啊网个人中心我的班级，按照课表上课，有问题请点击个人中心右侧的管家服务【对啊网】", 1));
 */
public class CCPRestSmsUtilBean {
    private  CCPRestSmsSDK restAPI;
    private  final Logger logger = LoggerFactory.getLogger(getClass());

    public CCPRestSmsUtilBean(String appId){
        restAPI = new CCPRestSmsSDK();
        restAPI.setAppId(appId);
        restAPI.init("app.cloopen.com", "8883");
        restAPI.setAccount("8a216da85557cb1501555839272a01ab", "ee145e96e8884063b3e0b51fcefdfb6d");
    }

    public  void send(String phones, String templateId, String[] datas) throws SmsSendException {
        HashMap<String, Object> result = restAPI.sendTemplateSMS(phones, templateId, datas);
        String statusCode = (String) result.get("statusCode");
        if (!"000000".equals(statusCode)) {
            if ("160040".equals(statusCode) || "160041".equals(statusCode)) {
                String message = "该手机号：" + phones + "的模板ID：" + templateId + "短信已超出当天发送次数限制";
                logger.warn(message);
                throw new SendLimitException(message);
            } else {
                String message = "短信验证码发送失败，错误码=" + statusCode + " 错误信息= " + result.get("statusMsg");
                logger.error(message);
                throw new SmsSendException(message);
            }
        }
    }

}

