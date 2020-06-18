package com.kjs.orm.model;

import com.kjs.common.bean.BaseEntity;
import com.kjs.common.utils.ShortDateSerializer;
import org.apache.ibatis.type.Alias;
import org.codehaus.jackson.map.annotate.JsonSerialize;

import java.util.Date;

/**
 * POJO:SetPlanTag
 * 
 * @author duia_builder
 * @date 2016-6-15
 */
@SuppressWarnings("serial")
@Alias("SetPlanTag")
public class SetPlanTag extends BaseEntity {
	
	
	private Integer	planId;		 /* 计划id */ 
	private Integer	planTagId;		 /* 计划标签ID */ 
	private Integer	orderNum;		 /* 排序 */ 
	private Date	createTime;		 /* 创建时间 */ 
	private Boolean	deleted;		 /* 删除标识1删除0使用 */ 

	// getter && setter
	// 在setter方法最后加上"return this;"并把返回参数改为SetPlanTag可以实现连缀设置属性
	
	public Integer getPlanId() {
		return planId;
	}

	public SetPlanTag setPlanId(Integer planId) {
		this.planId = planId;
		return this;
	}
	
	
	public Integer getPlanTagId() {
		return planTagId;
	}

	public SetPlanTag setPlanTagId(Integer planTagId) {
		this.planTagId = planTagId;
		return this;
	}
	
	
	public Integer getOrderNum() {
		return orderNum;
	}

	public SetPlanTag setOrderNum(Integer orderNum) {
		this.orderNum = orderNum;
		return this;
	}
	
	@JsonSerialize(using = ShortDateSerializer.class)
	public Date getCreateTime() {
		return createTime;
	}

	public SetPlanTag setCreateTime(Date createTime) {
		this.createTime = createTime;
		return this;
	}
	
	
	public Boolean getDeleted() {
		return deleted;
	}

	public SetPlanTag setDeleted(Boolean deleted) {
		this.deleted = deleted;
		return this;
	}
	
	@Override
	public String toString() {
		return "SetPlanTag [" + "id=" + getId() + ", planId=" + planId + ", planTagId=" + planTagId + ", orderNum=" + orderNum + ", createTime=" + createTime + ", deleted=" + deleted +  "]";
	}
}
