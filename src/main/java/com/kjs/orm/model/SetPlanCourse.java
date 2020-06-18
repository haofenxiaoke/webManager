package com.kjs.orm.model;

import com.kjs.common.bean.BaseEntity;
import com.kjs.common.utils.ShortDateSerializer;
import org.apache.ibatis.type.Alias;
import org.codehaus.jackson.map.annotate.JsonSerialize;

import java.util.Date;

/**
 * POJO:SetPlanCourse
 * 
 * @author duia_builder
 * @date 2016-5-23
 */
@SuppressWarnings("serial")
@Alias("SetPlanCourse")
public class SetPlanCourse extends BaseEntity {
	
	
	private Integer	planId;		 /* 计划id */ 
	private Integer	planCourseId;		 /* 视频id */ 
	private Integer	planStage;		 /* 阶段 */ 
	private Date	createTime;		 /* 创建时间 */ 
	private Boolean	deleted;		 /* 删除标识1删除0使用 */

	// getter && setter
	// 在setter方法最后加上"return this;"并把返回参数改为SetPlanCourse可以实现连缀设置属性
	
	public Integer getPlanId() {
		return planId;
	}

	public SetPlanCourse setPlanId(Integer planId) {
		this.planId = planId;
		return this;
	}
	
	
	public Integer getPlanCourseId() {
		return planCourseId;
	}

	public SetPlanCourse setPlanCourseId(Integer planCourseId) {
		this.planCourseId = planCourseId;
		return this;
	}
	
	
	public Integer getPlanStage() {
		return planStage;
	}

	public SetPlanCourse setPlanStage(Integer planStage) {
		this.planStage = planStage;
		return this;
	}
	
	@JsonSerialize(using = ShortDateSerializer.class)
	public Date getCreateTime() {
		return createTime;
	}

	public SetPlanCourse setCreateTime(Date createTime) {
		this.createTime = createTime;
		return this;
	}
	
	
	public Boolean getDeleted() {
		return deleted;
	}

	public SetPlanCourse setDeleted(Boolean deleted) {
		this.deleted = deleted;
		return this;
	}
	
	@Override
	public String toString() {
		return "SetPlanCourse [" + "id=" + getId() + ", planId=" + planId + ", planCourseId=" + planCourseId + ", planStage=" + planStage + ", createTime=" + createTime + ", deleted=" + deleted +  "]";
	}
}
