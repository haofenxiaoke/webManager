package com.kjs.service;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;
import com.github.kevinsawicki.http.HttpRequest;
import com.google.common.collect.Maps;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.scheduling.annotation.Async;
import org.springframework.stereotype.Service;

import java.io.IOException;
import java.util.Map;
import java.util.Properties;

/**
 * Created by 李恒名 on 2016/12/29.
 * <p>
 * 异步推送服务
 */
@Service
@Async
public class PushService {
    private final Logger logger = LoggerFactory.getLogger(getClass());

    private String url;

    public void publishPush(String topic, String message, Map<String, Object> opts) {
        Map<String, String> data = Maps.newLinkedHashMap();
        data.put("topic", topic);
        data.put("message", message);
        if (opts != null) {
            data.put("optsJSON", JSON.toJSONString(opts));
        }
        try {
            String body = HttpRequest.post(url + "/push/publish").form(data).body();
            JSONObject result = JSON.parseObject(body);
            Integer state = result.getInteger("state");
            if (200 != state) {
                logger.warn(result.getString("stateInfo"));
            } else {
                logger.debug("消息推送成功，內容：" + message);
            }
        } catch (Exception e) {
            logger.error(e.getMessage(), e);
        }

    }

    public void aliasPush(String alias, String message, Map<String, Object> opts) {
        Map<String, String> data = Maps.newLinkedHashMap();
        data.put("alias", alias);
        data.put("message", message);
        if (opts != null) {
            data.put("optsJSON", JSON.toJSONString(opts));
        }
        try {
            String body = HttpRequest.post(url + "/push/alias").form(data).body();
            JSONObject result = JSON.parseObject(body);
            Integer state = result.getInteger("state");
            if (200 != state) {
                logger.warn(result.getString("stateInfo"));
            } else {
                logger.debug("消息推送成功，內容：" + message);
            }
        } catch (Exception e) {
            logger.error(e.getMessage(), e);
        }
    }

    {
        try {
            Properties properties = new Properties();
            properties.load(Thread.currentThread().getContextClassLoader().getResourceAsStream("param.properties"));
            url = properties.getProperty("api.url");
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

}
