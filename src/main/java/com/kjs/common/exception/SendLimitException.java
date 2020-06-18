package com.kjs.common.exception;

/**
 * Created by 李恒名 on 2016/10/31.
 */
public class SendLimitException extends SmsSendException {
    public SendLimitException() {
    }

    public SendLimitException(String message) {
        super(message);
    }

    public SendLimitException(String message, Throwable cause) {
        super(message, cause);
    }
}
