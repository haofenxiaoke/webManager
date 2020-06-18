package com.kjs.common.dto.wechat;

public class WechatDataDto {
	private String head;
	private Integer showCount;
	private Integer pinCount;
	private Integer copyCount;
	public String getHead() {
		return head;
	}
	public void setHead(String head) {
		this.head = head;
	}
	public Integer getShowCount() {
		return showCount;
	}
	public void setShowCount(Integer showCount) {
		this.showCount = showCount;
	}
	public Integer getPinCount() {
		return pinCount;
	}
	public void setPinCount(Integer pinCount) {
		this.pinCount = pinCount;
	}
	public Integer getCopyCount() {
		return copyCount;
	}
	public void setCopyCount(Integer copyCount) {
		this.copyCount = copyCount;
	}
	@Override
	public String toString() {
		return "WechatDataDto [head=" + head + ", showCount=" + showCount + ", pinCount=" + pinCount + ", copyCount="
				+ copyCount + "]";
	}
	

}
