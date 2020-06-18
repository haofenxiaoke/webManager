package com.kjs.common.exception;

/**
 * Created by 李恒名 on 2016/10/31.
 */
public class SmsSendException extends Exception {
    public SmsSendException() {
    }

    public SmsSendException(String message) {
        super(message);
    }
    public SmsSendException(String message, Throwable cause) {
        super(message, cause);
    }
}
