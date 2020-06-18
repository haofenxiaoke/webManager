package com.kjs.common.exception.session;
/**
 * redisSession 异常类
 */
import com.kjs.common.exception.BaseException;

/**
 * Created by wangsongpeng on 2016/4/19.
 */
public class RedisSessionException extends BaseException {
    public RedisSessionException() {
        super();
    }

    public RedisSessionException(String message) {
        super(message);
    }

    public RedisSessionException(String message, Throwable cause){
        super(message,cause);
    }

    @Override
    public String getLocalizedMessage() {
        return this.getMessage();
    }

}
