package com.kjs.orm.model;

import com.kjs.common.bean.BaseEntity;
import com.kjs.common.utils.ShortDateSerializer;
import org.apache.ibatis.type.Alias;
import org.codehaus.jackson.map.annotate.JsonSerialize;

import java.util.Date;

/**
 * POJO:CourseSuitable
 * 
 * @author duia_builder
 * @date 2016-5-23
 */
@SuppressWarnings("serial")
@Alias("CourseSuitable")
public class CourseSuitable extends BaseEntity {
	
	
	private Integer	courseId;		 /* 课程id */ 
	private Integer	suitableId;		 /* 适合对象id */ 
	private Date	createTime;		 /* 设置时间 */ 
	private Integer	userId;		 /* 设置人id */ 

	// getter && setter
	// 在setter方法最后加上"return this;"并把返回参数改为CourseSuitable可以实现连缀设置属性
	
	public Integer getCourseId() {
		return courseId;
	}

	public CourseSuitable setCourseId(Integer courseId) {
		this.courseId = courseId;
		return this;
	}
	
	
	public Integer getSuitableId() {
		return suitableId;
	}

	public CourseSuitable setSuitableId(Integer suitableId) {
		this.suitableId = suitableId;
		return this;
	}
	
	@JsonSerialize(using = ShortDateSerializer.class)
	public Date getCreateTime() {
		return createTime;
	}

	public CourseSuitable setCreateTime(Date createTime) {
		this.createTime = createTime;
		return this;
	}
	
	
	public Integer getUserId() {
		return userId;
	}

	public CourseSuitable setUserId(Integer userId) {
		this.userId = userId;
		return this;
	}
	
	@Override
	public String toString() {
		return "CourseSuitable [" + "id=" + getId() + ", courseId=" + courseId + ", suitableId=" + suitableId + ", createTime=" + createTime + ", userId=" + userId +  "]";
	}
}
