package com.kjs.common.enums;

import com.fasterxml.jackson.annotation.JsonValue;

import java.util.HashMap;
import java.util.Map;

/**
 * 响应异常枚举
 * @author  李恒名
 * @date 2016年6月22日10:34:15
 */
public enum ResponseErrorEnum {

    ILLEGAL_PARAMS("ILLEGAL_PARAMS", "请求参数不合法!"),
    INTERNAL_SERVER_ERROR("INTERNAL_SERVER_ERROR", "接口内部异常!");

    private ResponseErrorEnum(String code, String message) {
        this.code = code;
        this.message = message;
    }

    // 序列化enum
    @JsonValue
    private Map<String, Object> serialize() {
        Map<String, Object> valueMap = new HashMap<>(2);
        valueMap.put("code", this.code);
        valueMap.put("message", this.message);
        return valueMap;
    }

    private String code;

    private String message;

    public String getCode() {
        return code;
    }

    public String getMessage() {
        return message;
    }
}
