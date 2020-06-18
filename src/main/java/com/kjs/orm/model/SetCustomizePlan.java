package com.kjs.orm.model;

import com.kjs.common.bean.BaseEntity;
import com.kjs.common.utils.ShortDateSerializer;
import org.apache.ibatis.type.Alias;
import org.codehaus.jackson.map.annotate.JsonSerialize;

import java.util.Date;

/**
 * POJO:SetCustomizePlan
 * 
 * @author duia_builder
 * @date 2016-5-23
 */
@SuppressWarnings("serial")
@Alias("SetCustomizePlan")
public class SetCustomizePlan extends BaseEntity {
	
	
	private String	planDescribe;		 /* 描述 */ 
	private Integer	directionId;		 /* 方向id */ 
	private Integer	industryId;		 /* 行业id */ 
	private Integer	positionId;		 /* 职位id */ 
	private Integer	stuNum;		 /* 学习基数 */
	private Integer stuMonthNum; /* 学习月数 */
	private Date	createTime;		 /* 创建时间 */ 
	private Boolean	deleted;		 /* 删除标识1删除0使用 */
	private Boolean state;	/*1启用0未启用*/

	// getter && setter
	// 在setter方法最后加上"return this;"并把返回参数改为SetCustomizePlan可以实现连缀设置属性
	
	public String getPlanDescribe() {
		return planDescribe;
	}

	public SetCustomizePlan setPlanDescribe(String planDescribe) {
		this.planDescribe = planDescribe;
		return this;
	}
	
	
	public Integer getDirectionId() {
		return directionId;
	}

	public SetCustomizePlan setDirectionId(Integer directionId) {
		this.directionId = directionId;
		return this;
	}
	
	
	public Integer getIndustryId() {
		return industryId;
	}

	public SetCustomizePlan setIndustryId(Integer industryId) {
		this.industryId = industryId;
		return this;
	}
	
	
	public Integer getPositionId() {
		return positionId;
	}

	public SetCustomizePlan setPositionId(Integer positionId) {
		this.positionId = positionId;
		return this;
	}

	
	public Integer getStuNum() {
		return stuNum;
	}

	public SetCustomizePlan setStuNum(Integer stuNum) {
		this.stuNum = stuNum;
		return this;
	}

	public Integer getStuMonthNum() {
		return stuMonthNum;
	}

	public void setStuMonthNum(Integer stuMonthNum) {
		this.stuMonthNum = stuMonthNum;
	}

	@JsonSerialize(using = ShortDateSerializer.class)
	public Date getCreateTime() {
		return createTime;
	}

	public SetCustomizePlan setCreateTime(Date createTime) {
		this.createTime = createTime;
		return this;
	}
	
	
	public Boolean getDeleted() {
		return deleted;
	}

	public SetCustomizePlan setDeleted(Boolean deleted) {
		this.deleted = deleted;
		return this;
	}

	public Boolean getState() {
		return state;
	}

	public void setState(Boolean state) {
		this.state = state;
	}

	@Override
	public String toString() {
		return "SetCustomizePlan [" + "id=" + getId() + ", planDescribe=" + planDescribe + ", directionId=" + directionId + ", industryId=" + industryId + ", positionId=" + positionId + ", stuNum=" + stuNum + ",stuMonthNum="+stuMonthNum+ ", createTime=" + createTime + ", deleted=" + deleted + ",state=" + state +  "]";
	}
}
