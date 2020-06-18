package com.kjs.common.utils;


import javax.servlet.http.HttpServletRequest;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.Map;

/**
 * Created by zhenghui on 2016/5/24.
 */
public class RequestParamUtils {
    public static Map getParamValues(HttpServletRequest request){
        Map paramMap = new HashMap();
        Enumeration paramNames = request.getParameterNames();
        while (paramNames.hasMoreElements()) {
            String paramName = (String) paramNames.nextElement();

            String[] paramValues = request.getParameterValues(paramName);
            if (paramValues.length == 1) {
                String paramValue = paramValues[0];
                if (paramValue.length() != 0) {
                    paramMap.put(paramName, paramValue);
                }
            }
        }
        return paramMap;
    }

    public static Integer switchToInteger(Object str){
        return StringUtil.isEmpty(str)?0:Integer.valueOf(str.toString());
    }

    public static Long switchToLong(Object str){
        return StringUtil.isEmpty(str)?0:Long.valueOf(str.toString());
    }
}
