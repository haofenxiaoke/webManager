package com.kjs.orm.model;

import com.kjs.common.bean.BaseEntity;
import com.kjs.common.utils.ShortDateSerializer;
import org.apache.ibatis.type.Alias;
import org.codehaus.jackson.map.annotate.JsonSerialize;

import java.util.Date;

/**
 * POJO:UserVip
 * 
 * @author duia_builder
 * @date 2016-5-23
 */
@SuppressWarnings("serial")
@Alias("UserVip")
public class UserVip extends BaseEntity {
	
	
	private Integer	userId;		 /* 用户id */ 
	private Integer	vipId;		 /* 会员id */
	private Integer orderId;
	private String	vipName;		 /* 会员名称 */ 
	private Date	addTime;		 /* 购买时间 */ 
	private Date	startDate;		 /* 有效期开始日期 */ 
	private Date	endDate;		 /* 有效期结束日期 */ 
	private String	describle;		 /* 描述 */ 

	// getter && setter
	// 在setter方法最后加上"return this;"并把返回参数改为UserVip可以实现连缀设置属性
	
	public Integer getUserId() {
		return userId;
	}


	public Integer getVipId() {
		return vipId;
	}


	
	public String getVipName() {
		return vipName;
	}

	public UserVip setVipName(String vipName) {
		this.vipName = vipName;
		return this;
	}
	
	@JsonSerialize(using = ShortDateSerializer.class)
	public Date getAddTime() {
		return addTime;
	}

	public UserVip setAddTime(Date addTime) {
		this.addTime = addTime;
		return this;
	}
	
	@JsonSerialize(using = ShortDateSerializer.class)
	public Date getStartDate() {
		return startDate;
	}

	public UserVip setStartDate(Date startDate) {
		this.startDate = startDate;
		return this;
	}
	
	@JsonSerialize(using = ShortDateSerializer.class)
	public Date getEndDate() {
		return endDate;
	}

	public UserVip setEndDate(Date endDate) {
		this.endDate = endDate;
		return this;
	}
	
	
	public String getDescrible() {
		return describle;
	}

	public UserVip setDescrible(String describle) {
		this.describle = describle;
		return this;
	}


	public void setUserId(Integer userId) {
		this.userId = userId;
	}

	public void setVipId(Integer vipId) {
		this.vipId = vipId;
	}

	public Integer getOrderId() {
		return orderId;
	}

	public void setOrderId(Integer orderId) {
		this.orderId = orderId;
	}

	@Override
	public String toString() {
		return "UserVip [" + "id=" + getId() + ", userId=" + userId + ", vipId=" + vipId + ", vipName=" + vipName + ", addTime=" + addTime + ", startDate=" + startDate + ", endDate=" + endDate + ", describle=" + describle +  "]";
	}
}
