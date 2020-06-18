package com.kjs.common.exception;

/**
 * 异常处理父类 运行期异常
 * @author wangsongpeng
 */
@SuppressWarnings("serial")
public class BaseException extends RuntimeException {
	
	public BaseException() {
	super();
    }

	public BaseException(String message) {
		super(message);
	}

	public BaseException(String message, Throwable cause){
		   super(message,cause);
	}

	@Override
	public String getLocalizedMessage() {
		return this.getMessage();
	}
}
