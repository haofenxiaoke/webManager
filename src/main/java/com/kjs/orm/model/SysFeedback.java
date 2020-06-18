package com.kjs.orm.model;

import com.kjs.common.bean.BaseEntity;
import com.kjs.common.utils.ShortDateSerializer;
import org.apache.ibatis.type.Alias;
import org.codehaus.jackson.map.annotate.JsonSerialize;

import java.util.Date;

/**
 * POJO:SysFeedback
 * 
 * @author duia_builder
 * @date 2016-5-23
 */
@SuppressWarnings("serial")
@Alias("SysFeedback")
public class SysFeedback extends BaseEntity {
	public static Integer REPLY_STATUS_UNREPLY = 0;//未回复
	public static Integer REPLY_STATUS_REPLIED = 1;//已回复

	private String	feedbackTitle;		 /* 意见标题 */
	private String	feedbackDesc;		 /* 意见描述 */ 
	private String	imgUrl;		 /* 截图上传url */ 
	private String	phone;		 /* 联系电话 */ 
	private Long	userId;		 /* 用户ID(主键) */
	private Date	feedbackAddTime;		 /* 创建时间 */ 
	private String	feedbackReply;		 /* 回复内容 */ 
	private Date	feedbackReplyTime;		 /* 回复时间 */
	private Long	feedbackReplyUserid;		 /* 回复者id(主键)*/
	private String	flowerName;		 /* 回复人花名 */ 
	private Integer replyStatus;//回复状态 1表示已回复，0表示未回复

	//连表查询字段
	private String username;//账号
	private String nickName;//昵称

	// getter && setter
	// 在setter方法最后加上"return this;"并把返回参数改为SysFeedback可以实现连缀设置属性
	
	public String getFeedbackTitle() {
		return feedbackTitle;
	}

	public SysFeedback setFeedbackTitle(String feedbackTitle) {
		this.feedbackTitle = feedbackTitle;
		return this;
	}
	
	
	public String getFeedbackDesc() {
		return feedbackDesc;
	}

	public SysFeedback setFeedbackDesc(String feedbackDesc) {
		this.feedbackDesc = feedbackDesc;
		return this;
	}
	
	
	public String getImgUrl() {
		return imgUrl;
	}

	public SysFeedback setImgUrl(String imgUrl) {
		this.imgUrl = imgUrl;
		return this;
	}
	
	
	public String getPhone() {
		return phone;
	}

	public SysFeedback setPhone(String phone) {
		this.phone = phone;
		return this;
	}
	
	
	@JsonSerialize(using = ShortDateSerializer.class)
	public Date getFeedbackAddTime() {
		return feedbackAddTime;
	}

	public SysFeedback setFeedbackAddTime(Date feedbackAddTime) {
		this.feedbackAddTime = feedbackAddTime;
		return this;
	}
	
	
	public String getFeedbackReply() {
		return feedbackReply;
	}

	public SysFeedback setFeedbackReply(String feedbackReply) {
		this.feedbackReply = feedbackReply;
		return this;
	}
	
	@JsonSerialize(using = ShortDateSerializer.class)
	public Date getFeedbackReplyTime() {
		return feedbackReplyTime;
	}

	public SysFeedback setFeedbackReplyTime(Date feedbackReplyTime) {
		this.feedbackReplyTime = feedbackReplyTime;
		return this;
	}
	
	
	public Long getFeedbackReplyUserid() {
		return feedbackReplyUserid;
	}

	public SysFeedback setFeedbackReplyUserid(Long feedbackReplyUserid) {
		this.feedbackReplyUserid = feedbackReplyUserid;
		return this;
	}
	
	
	public String getFlowerName() {
		return flowerName;
	}

	public SysFeedback setFlowerName(String flowerName) {
		this.flowerName = flowerName;
		return this;
	}

	public Integer getReplyStatus() {
		return replyStatus;
	}

	public void setReplyStatus(Integer replyStatus) {
		this.replyStatus = replyStatus;
	}


	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	public Long getUserId() {
		return userId;
	}

	public void setUserId(Long userId) {
		this.userId = userId;
	}

	public String getNickName() {
		return nickName;
	}

	public void setNickName(String nickName) {
		this.nickName = nickName;
	}

	@Override
	public String toString() {
		return "SysFeedback{" +
				"feedbackTitle='" + feedbackTitle + '\'' +
				", feedbackDesc='" + feedbackDesc + '\'' +
				", imgUrl='" + imgUrl + '\'' +
				", phone='" + phone + '\'' +
				", userId=" + userId +
				", feedbackAddTime=" + feedbackAddTime +
				", feedbackReply='" + feedbackReply + '\'' +
				", feedbackReplyTime=" + feedbackReplyTime +
				", feedbackReplyUserid=" + feedbackReplyUserid +
				", flowerName='" + flowerName + '\'' +
				", replyStatus=" + replyStatus +
				", username='" + username + '\'' +
				", nickName='" + nickName + '\'' +
				'}';
	}
}
