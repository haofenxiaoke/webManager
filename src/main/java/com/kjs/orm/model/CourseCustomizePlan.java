package com.kjs.orm.model;

import com.kjs.common.bean.BaseEntity;
import com.kjs.common.utils.ShortDateSerializer;
import org.apache.ibatis.type.Alias;
import org.codehaus.jackson.map.annotate.JsonSerialize;

import java.util.Date;

/**
 * POJO:CourseCustomizePlan
 * 
 * @author duia_builder
 * @date 2016-5-23
 */
@SuppressWarnings("serial")
@Alias("CourseCustomizePlan")
public class CourseCustomizePlan extends BaseEntity {
	
	
	private String	planDescribe;		 /* 描述 */ 
	private Integer	directionId;		 /* 方向id */ 
	private Integer	industryId;		 /* 行业id */ 
	private Integer	positionId;		 /* 职位id */ 
	private Integer	userid;		 /* 学生id */ 
	private String	duration;		 /* 建议时间(通关天数) */ 
	private String	completeProgress;		 /* 完成进度 */ 
	private Date	optime;		 /* 创建时间 */ 
	private Boolean	deleted;		 /* 删除标识1删除0使用 */
	private Integer setPlanId;

	// getter && setter
	// 在setter方法最后加上"return this;"并把返回参数改为CourseCustomizePlan可以实现连缀设置属性
	
	public String getPlanDescribe() {
		return planDescribe;
	}

	public CourseCustomizePlan setPlanDescribe(String planDescribe) {
		this.planDescribe = planDescribe;
		return this;
	}
	
	
	public Integer getDirectionId() {
		return directionId;
	}

	public CourseCustomizePlan setDirectionId(Integer directionId) {
		this.directionId = directionId;
		return this;
	}
	
	
	public Integer getIndustryId() {
		return industryId;
	}

	public CourseCustomizePlan setIndustryId(Integer industryId) {
		this.industryId = industryId;
		return this;
	}
	
	
	public Integer getPositionId() {
		return positionId;
	}

	public CourseCustomizePlan setPositionId(Integer positionId) {
		this.positionId = positionId;
		return this;
	}
	
	
	public Integer getUserid() {
		return userid;
	}

	public CourseCustomizePlan setUserid(Integer userid) {
		this.userid = userid;
		return this;
	}
	
	
	public String getDuration() {
		return duration;
	}

	public CourseCustomizePlan setDuration(String duration) {
		this.duration = duration;
		return this;
	}
	
	
	public String getCompleteProgress() {
		return completeProgress;
	}

	public CourseCustomizePlan setCompleteProgress(String completeProgress) {
		this.completeProgress = completeProgress;
		return this;
	}
	
	@JsonSerialize(using = ShortDateSerializer.class)
	public Date getOptime() {
		return optime;
	}

	public CourseCustomizePlan setOptime(Date optime) {
		this.optime = optime;
		return this;
	}
	
	
	public Boolean getDeleted() {
		return deleted;
	}

	public CourseCustomizePlan setDeleted(Boolean deleted) {
		this.deleted = deleted;
		return this;
	}

	public Integer getSetPlanId() {
		return setPlanId;
	}

	public void setSetPlanId(Integer setPlanId) {
		this.setPlanId = setPlanId;
	}

	@Override
	public String toString() {
		return "CourseCustomizePlan [" + "id=" + getId() + ", planDescribe=" + planDescribe + ", directionId=" + directionId + ", industryId=" + industryId + ", positionId=" + positionId + ", userid=" + userid + ", duration=" + duration + ", completeProgress=" + completeProgress + ", optime=" + optime + ", deleted=" + deleted+ ", setPlanId=" + setPlanId +  "]";
	}
}
