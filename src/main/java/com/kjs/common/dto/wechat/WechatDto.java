package com.kjs.common.dto.wechat;

public class WechatDto {
	private Integer id;
	private Integer type;
	private String name;
	private String url;
	private String wechat;
	private String showTime;
	private Integer status;
	private Integer deleted;
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public Integer getType() {
		return type;
	}
	public void setType(Integer type) {
		this.type = type;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getUrl() {
		return url;
	}
	public void setUrl(String url) {
		this.url = url;
	}
	public String getWechat() {
		return wechat;
	}
	public void setWechat(String wechat) {
		this.wechat = wechat;
	}
	public String getShowTime() {
		return showTime;
	}
	public void setShowTime(String showTime) {
		this.showTime = showTime;
	}
	public Integer getStatus() {
		return status;
	}
	public void setStatus(Integer status) {
		this.status = status;
	}
	public Integer getDeleted() {
		return deleted;
	}
	public void setDeleted(Integer deleted) {
		this.deleted = deleted;
	}
	@Override
	public String toString() {
		return "WechatDto [id=" + id + ", type=" + type + ", name=" + name + ", url=" + url + ", wechat=" + wechat
				+ ", showTime=" + showTime + ", status=" + status + ", deleted=" + deleted + "]";
	}
	
	

}
