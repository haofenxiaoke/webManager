package com.kjs.orm.model;

import com.kjs.common.bean.BaseEntity;
import com.kjs.common.utils.ShortDateSerializer;
import org.apache.ibatis.type.Alias;
import org.codehaus.jackson.map.annotate.JsonSerialize;

import java.util.Date;

/**
 * POJO:CourseQuestionReply
 * 
 * @author duia_builder
 * @date 2016-5-23
 */
@SuppressWarnings("serial")
@Alias("CourseQuestionReply")
public class CourseQuestionReply extends BaseEntity {
	
	
	private Long	questionId;		 /* 问题id */
	private Long	replyUserid;		 /* 回复人 */
	private String	replyContent;		 /* 回复内容 */ 
	private Date	replyTime;		 /* 回复时间 */ 
	private Integer 	deleted;		 /* 是否屏蔽(1正常0屏蔽) */

	//连表字段
	private String flowerName;//回复者花名
	// getter && setter
	// 在setter方法最后加上"return this;"并把返回参数改为CourseQuestionReply可以实现连缀设置属性

	public Long getQuestionId() {
		return questionId;
	}

	public void setQuestionId(Long questionId) {
		this.questionId = questionId;
	}

	public Long getReplyUserid() {
		return replyUserid;
	}

	public CourseQuestionReply setReplyUserid(Long replyUserid) {
		this.replyUserid = replyUserid;
		return this;
	}

	public String getReplyContent() {
		return replyContent;
	}

	public CourseQuestionReply setReplyContent(String replyContent) {
		this.replyContent = replyContent;
		return this;
	}
	
	@JsonSerialize(using = ShortDateSerializer.class)
	public Date getReplyTime() {
		return replyTime;
	}

	public CourseQuestionReply setReplyTime(Date replyTime) {
		this.replyTime = replyTime;
		return this;
	}
	
	
	public Integer getDeleted() {
		return deleted;
	}

	public CourseQuestionReply setDeleted(Integer deleted) {
		this.deleted = deleted;
		return this;
	}

	public String getFlowerName() {
		return flowerName;
	}

	public void setFlowerName(String flowerName) {
		this.flowerName = flowerName;
	}

	@Override
	public String toString() {
		return "CourseQuestionReply [" + "id=" + getId() + ", questionId=" + questionId + ", replyUserid=" + replyUserid + ", replyContent=" + replyContent + ", replyTime=" + replyTime + ", deleted=" + deleted +  "]";
	}
}
