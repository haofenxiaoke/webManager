package com.kjs.common.bean;

import com.fasterxml.jackson.annotation.JsonInclude;
import com.kjs.common.enums.ResponseErrorEnum;


/**
 * 统一请求返回结果
 * @author  李恒名
 * @date 2016年6月22日10:34:15
 */
@JsonInclude(JsonInclude.Include.NON_EMPTY)
public class ResponseResult {

    private boolean success;

    private String message;

    private Object data;

    /* 不提供直接设置errorCode的接口，只能通过setErrorInfo方法设置错误信息 */
    private String errorCode;

    private ResponseResult() {
    }

    public static  ResponseResult newInstance() {
        return new ResponseResult();
    }

    public boolean isSuccess() {
        return success;
    }

    public void setSuccess(boolean success) {
        this.success = success;
    }

    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }

    public Object getData() {
        return data;
    }

    public void setData(Object data) {
        this.data = data;
    }

    public String getErrorCode() {
        return errorCode;
    }

    // 设置错误信息
    public void setErrorInfo(ResponseErrorEnum responseErrorEnum) {
        this.errorCode = responseErrorEnum.getCode();
        this.message = responseErrorEnum.getMessage();
    }
}
