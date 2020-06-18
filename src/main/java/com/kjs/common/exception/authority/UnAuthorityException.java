package com.kjs.common.exception.authority;
import com.kjs.common.exception.BaseException;
/**
 * 无权限异常类
 * Created by wangsongpeng on 2016/2/17.
 */
public class UnAuthorityException extends BaseException{

    public UnAuthorityException() {
        super();
    }

    public UnAuthorityException(String message) {
        super(message);
    }

    public UnAuthorityException(String message,Throwable cause){
        super(message,cause);
    }
}
