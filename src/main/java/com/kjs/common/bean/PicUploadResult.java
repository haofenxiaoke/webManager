package com.kjs.common.bean;

public class PicUploadResult {
	private Integer error=0;
	private String url;
	public Integer getError() {
		return error;
	}
	public void setError(Integer error) {
		this.error = error;
	}
	public String getUrl() {
		return url;
	}
	public void setUrl(String url) {
		this.url = url;
	}
	@Override
	public String toString() {
		return "PicUploadResult [error=" + error + ", url=" + url + "]";
	}
	
	

}
