package com.kjs.orm.model;

import com.kjs.common.bean.BaseEntity;
import com.kjs.common.utils.ShortDateSerializer;
import org.apache.ibatis.type.Alias;
import org.codehaus.jackson.map.annotate.JsonSerialize;

import java.util.Date;

/**
 * POJO:CourseIndustry
 * 
 * @author duia_builder
 * @date 2016-5-23
 */
@SuppressWarnings("serial")
@Alias("CourseIndustry")
public class CourseIndustry extends BaseEntity {
	
	
	private Integer	courseId;		 /* 课程id */ 
	private Integer	industryId;		 /* 行业id */ 
	private Date	createTime;		 /* 设置时间 */ 
	private Integer	authorityUserId;		 /* 设置人id */ 

	// getter && setter
	// 在setter方法最后加上"return this;"并把返回参数改为CourseIndustry可以实现连缀设置属性
	
	public Integer getCourseId() {
		return courseId;
	}

	public CourseIndustry setCourseId(Integer courseId) {
		this.courseId = courseId;
		return this;
	}
	
	
	public Integer getIndustryId() {
		return industryId;
	}

	public CourseIndustry setIndustryId(Integer industryId) {
		this.industryId = industryId;
		return this;
	}
	
	@JsonSerialize(using = ShortDateSerializer.class)
	public Date getCreateTime() {
		return createTime;
	}

	public CourseIndustry setCreateTime(Date createTime) {
		this.createTime = createTime;
		return this;
	}
	
	
	public Integer getAuthorityUserId() {
		return authorityUserId;
	}

	public CourseIndustry setAuthorityUserId(Integer authorityUserId) {
		this.authorityUserId = authorityUserId;
		return this;
	}
	
	@Override
	public String toString() {
		return "CourseIndustry [" + "id=" + getId() + ", courseId=" + courseId + ", industryId=" + industryId + ", createTime=" + createTime + ", authorityUserId=" + authorityUserId +  "]";
	}
}
