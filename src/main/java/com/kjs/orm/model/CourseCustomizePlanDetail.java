package com.kjs.orm.model;

import com.kjs.common.bean.BaseEntity;
import com.kjs.common.utils.ShortDateSerializer;
import org.apache.ibatis.type.Alias;
import org.codehaus.jackson.map.annotate.JsonSerialize;

import java.util.Date;

/**
 * POJO:CourseCustomizePlanDetail
 * 
 * @author duia_builder
 * @date 2016-5-23
 */
@SuppressWarnings("serial")
@Alias("CourseCustomizePlanDetail")
public class CourseCustomizePlanDetail extends BaseEntity {
	
	
	private Integer	planId;		 /* 计划ID */ 
	private Integer	planDay;		 /* 计划时长（天数） */ 
	private Integer	planStage;		 /* 计划阶段 */ 
	private String	describle;		 /* 计划阶段描述 */ 
	private Integer	stageHour;		 /* 阶段时长（时） */ 
	private Integer	stageLectureNode;		 /* 阶段听课（节数） */ 
	private Integer	stageDataNode;		 /* 阶段资料（节数） */ 
	private Integer	stageCourseId;		 /* 阶段课程视频id */ 
	private Integer	planDuration;		 /* 计划通关天数 */ 
	private Integer	completeProgress;		 /* 完成进度 */ 
	private Date	optime;		 /* 创建时间 */ 
	private Integer	userid;		 /* 创建人 */ 
	private Boolean	deleted;		 /* 删除标识1删除0使用 */

	// getter && setter
	// 在setter方法最后加上"return this;"并把返回参数改为CourseCustomizePlanDetail可以实现连缀设置属性
	
	public Integer getPlanId() {
		return planId;
	}

	public CourseCustomizePlanDetail setPlanId(Integer planId) {
		this.planId = planId;
		return this;
	}
	
	
	public Integer getPlanDay() {
		return planDay;
	}

	public CourseCustomizePlanDetail setPlanDay(Integer planDay) {
		this.planDay = planDay;
		return this;
	}
	
	
	public Integer getPlanStage() {
		return planStage;
	}

	public CourseCustomizePlanDetail setPlanStage(Integer planStage) {
		this.planStage = planStage;
		return this;
	}
	
	
	public String getDescrible() {
		return describle;
	}

	public CourseCustomizePlanDetail setDescrible(String describle) {
		this.describle = describle;
		return this;
	}
	
	
	public Integer getStageHour() {
		return stageHour;
	}

	public CourseCustomizePlanDetail setStageHour(Integer stageHour) {
		this.stageHour = stageHour;
		return this;
	}
	
	
	public Integer getStageLectureNode() {
		return stageLectureNode;
	}

	public CourseCustomizePlanDetail setStageLectureNode(Integer stageLectureNode) {
		this.stageLectureNode = stageLectureNode;
		return this;
	}
	
	
	public Integer getStageDataNode() {
		return stageDataNode;
	}

	public CourseCustomizePlanDetail setStageDataNode(Integer stageDataNode) {
		this.stageDataNode = stageDataNode;
		return this;
	}
	
	
	public Integer getStageCourseId() {
		return stageCourseId;
	}

	public CourseCustomizePlanDetail setStageCourseId(Integer stageCourseId) {
		this.stageCourseId = stageCourseId;
		return this;
	}
	
	
	public Integer getPlanDuration() {
		return planDuration;
	}

	public CourseCustomizePlanDetail setPlanDuration(Integer planDuration) {
		this.planDuration = planDuration;
		return this;
	}
	
	
	public Integer getCompleteProgress() {
		return completeProgress;
	}

	public CourseCustomizePlanDetail setCompleteProgress(Integer completeProgress) {
		this.completeProgress = completeProgress;
		return this;
	}
	
	@JsonSerialize(using = ShortDateSerializer.class)
	public Date getOptime() {
		return optime;
	}

	public CourseCustomizePlanDetail setOptime(Date optime) {
		this.optime = optime;
		return this;
	}
	
	
	public Integer getUserid() {
		return userid;
	}

	public CourseCustomizePlanDetail setUserid(Integer userid) {
		this.userid = userid;
		return this;
	}
	
	
	public Boolean getDeleted() {
		return deleted;
	}

	public CourseCustomizePlanDetail setDeleted(Boolean deleted) {
		this.deleted = deleted;
		return this;
	}
	
	@Override
	public String toString() {
		return "CourseCustomizePlanDetail [" + "id=" + getId() + ", planId=" + planId + ", planDay=" + planDay + ", planStage=" + planStage + ", describle=" + describle + ", stageHour=" + stageHour + ", stageLectureNode=" + stageLectureNode + ", stageDataNode=" + stageDataNode + ", stageCourseId=" + stageCourseId + ", planDuration=" + planDuration + ", completeProgress=" + completeProgress + ", optime=" + optime + ", userid=" + userid + ", deleted=" + deleted +  "]";
	}
}
