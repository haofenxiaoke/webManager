package com.kjs.common.utils;

import org.apache.commons.lang.StringUtils;

public class StringUtil extends StringUtils {

    public static boolean isEmpty(Object str) {
        return str == null || "".equals(str);
    }

    public static boolean isNotEmpty(Object str) {
        return !isEmpty(str);
    }

}
