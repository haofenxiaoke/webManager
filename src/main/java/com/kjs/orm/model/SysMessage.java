package com.kjs.orm.model;

import com.kjs.common.bean.BaseEntity;
import org.apache.ibatis.type.Alias;

import java.util.Date;

/**
 * POJO:SysMessage
 * 
 * @author duia_builder
 * @date 2016-5-23
 */
@SuppressWarnings("serial")
@Alias("SysMessage")
public class SysMessage extends BaseEntity {
	public static final Integer SEND_OBJECT_FREE = 0;
	public static final Integer SEND_OBJECT_PAID = 1;
	public static final Integer SEND_OBJECT_PERSON = 2;

	private Integer type;		 /* 消息类型 */
	private String	title;		 /* 消息内容 */
	private String	content;		 /* 消息内容 */
	private Date	sendtime;		 /* 消息发送时间 */
	private Long senderId;//发送者id
	private Integer	resourcesId;		 /* 资源id */
	private String senderName;
	private Integer sendObject; //发送对象 0免费学员 1 付费学员 2个人


	@Override
	public String toString() {
		return "SysMessage{" +
				"type=" + type +
				", title='" + title + '\'' +
				", content='" + content + '\'' +
				", sendtime=" + sendtime +
				", senderId=" + senderId +
				", resourcesId=" + resourcesId +
				", senderName='" + senderName + '\'' +
				", sendObject=" + sendObject +
				'}';
	}

	public Integer getType() {
		return type;
	}

	public void setType(Integer type) {
		this.type = type;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public Date getSendtime() {
		return sendtime;
	}

	public void setSendtime(Date sendtime) {
		this.sendtime = sendtime;
	}

	public Long getSenderId() {
		return senderId;
	}

	public void setSenderId(Long senderId) {
		this.senderId = senderId;
	}

	public Integer getResourcesId() {
		return resourcesId;
	}

	public void setResourcesId(Integer resourcesId) {
		this.resourcesId = resourcesId;
	}

	public String getSenderName() {
		return senderName;
	}

	public void setSenderName(String senderName) {
		this.senderName = senderName;
	}

	public Integer getSendObject() {
		return sendObject;
	}

	public void setSendObject(Integer sendObject) {
		this.sendObject = sendObject;
	}
}
