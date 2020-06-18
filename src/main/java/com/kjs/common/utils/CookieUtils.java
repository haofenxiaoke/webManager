package com.kjs.common.utils;
import org.apache.commons.lang.StringUtils;

import javax.servlet.http.Cookie;
/**
 * Created by wsp
 */
public class CookieUtils {
    /**
     * 创建登录cookie
     * @param key    cookie名
     * @param value  cookie值
     * @param expire cookie生存周期
     * @return
     */
    public static Cookie createLoginCookie(String key, String value, int expire) {
        //创建cookie
        Cookie cookie = new Cookie(key, value);
        cookie.setPath("/");
        cookie.setMaxAge(expire);
        cookie.setHttpOnly(true);
        return cookie;
    }

    /**
     * 根据cookie的key获取cookie
     * @return
     */
    public static Cookie getCookieByKey(Cookie[] cookies,String key){
       Cookie cookie = null;
       if(null!=cookies&&cookies.length>0&&StringUtils.isNotBlank(key)){
           for(Cookie c:cookies){
               if(c.getName().equalsIgnoreCase(key)){
                   cookie = c;
               }
           }
       }
       return cookie;
    }

    /**
     * 根据cookie key 删除cookie
     * @param key
     * @return
     */
    public static Cookie removeCookie(String key) {
        Cookie cookie = new Cookie(key, null);
        cookie.setPath("/");
        cookie.setMaxAge(0);
        return cookie;
    }


}
