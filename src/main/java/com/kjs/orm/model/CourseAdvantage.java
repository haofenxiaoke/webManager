package com.kjs.orm.model;

import com.kjs.common.bean.BaseEntity;
import com.kjs.common.utils.ShortDateSerializer;
import org.apache.ibatis.type.Alias;
import org.codehaus.jackson.map.annotate.JsonSerialize;

import java.util.Date;

/**
 * POJO:CourseAdvantage
 * 
 * @author duia_builder
 * @date 2016-5-23
 */
@SuppressWarnings("serial")
@Alias("CourseAdvantage")
public class CourseAdvantage extends BaseEntity {
	
	
	private Integer	courseId;		 /* 课程id */ 
	private Integer	advantageId;		 /* 课程优势id */ 
	private Date	createTime;		 /* 设置时间 */ 
	private Integer	userId;		 /* 设置人id */ 

	// getter && setter
	// 在setter方法最后加上"return this;"并把返回参数改为CourseAdvantage可以实现连缀设置属性
	
	public Integer getCourseId() {
		return courseId;
	}

	public CourseAdvantage setCourseId(Integer courseId) {
		this.courseId = courseId;
		return this;
	}
	
	
	public Integer getAdvantageId() {
		return advantageId;
	}

	public CourseAdvantage setAdvantageId(Integer advantageId) {
		this.advantageId = advantageId;
		return this;
	}
	
	@JsonSerialize(using = ShortDateSerializer.class)
	public Date getCreateTime() {
		return createTime;
	}

	public CourseAdvantage setCreateTime(Date createTime) {
		this.createTime = createTime;
		return this;
	}
	
	
	public Integer getUserId() {
		return userId;
	}

	public CourseAdvantage setUserId(Integer userId) {
		this.userId = userId;
		return this;
	}
	
	@Override
	public String toString() {
		return "CourseAdvantage [" + "id=" + getId() + ", courseId=" + courseId + ", advantageId=" + advantageId + ", createTime=" + createTime + ", userId=" + userId +  "]";
	}
}
