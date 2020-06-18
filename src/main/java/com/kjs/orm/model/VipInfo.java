package com.kjs.orm.model;

import com.kjs.common.bean.BaseEntity;
import com.kjs.common.utils.ShortDateSerializer;
import org.apache.ibatis.type.Alias;
import org.codehaus.jackson.map.annotate.JsonSerialize;

import java.util.Date;

/**
 * POJO:VipInfo
 * 
 * @author duia_builder
 * @date 2016-5-23
 */
@SuppressWarnings("serial")
@Alias("VipInfo")
public class VipInfo extends BaseEntity {
	
	
	private Boolean	isshelves;		 /* vip状态（是否上架1上架0下架） */
	private Date	addTime;		 /* 添加时间 */ 
	private String	describle;		 /* 描述 */ 
	private Integer	addUserid;		 /* 添加人 */ 
	private Boolean	permission1;		 /* 权限1 */ 
	private Boolean	permission2;		 /* 权限2 */ 
	private Boolean	permission3;		 /* 权限3 */ 
	private Boolean	permission4;		 /* 权限4 */ 
	private Boolean	permission5;		 /* 权限5 */ 
	private Boolean	permission6;		 /* 权限6 */ 
	private Boolean	permission7;		 /* 权限7 */ 
	private Boolean	permission8;		 /* 权限8 */
	private int price;/*价格*/
	/**
	 * 会员对应天数
	 */
	private Integer days;

	// getter && setter
	// 在setter方法最后加上"return this;"并把返回参数改为VipInfo可以实现连缀设置属性
	
	public Boolean getIsshelves() {
		return isshelves;
	}

	public VipInfo setIsshelves(Boolean isshelves) {
		this.isshelves = isshelves;
		return this;
	}
	
	@JsonSerialize(using = ShortDateSerializer.class)
	public Date getAddTime() {
		return addTime;
	}

	public VipInfo setAddTime(Date addTime) {
		this.addTime = addTime;
		return this;
	}
	
	
	public String getDescrible() {
		return describle;
	}

	public VipInfo setDescrible(String describle) {
		this.describle = describle;
		return this;
	}
	
	
	public Integer getAddUserid() {
		return addUserid;
	}

	public VipInfo setAddUserid(Integer addUserid) {
		this.addUserid = addUserid;
		return this;
	}
	
	
	public Boolean getPermission1() {
		return permission1;
	}

	public VipInfo setPermission1(Boolean permission1) {
		this.permission1 = permission1;
		return this;
	}
	
	
	public Boolean getPermission2() {
		return permission2;
	}

	public VipInfo setPermission2(Boolean permission2) {
		this.permission2 = permission2;
		return this;
	}
	
	
	public Boolean getPermission3() {
		return permission3;
	}

	public VipInfo setPermission3(Boolean permission3) {
		this.permission3 = permission3;
		return this;
	}
	
	
	public Boolean getPermission4() {
		return permission4;
	}

	public VipInfo setPermission4(Boolean permission4) {
		this.permission4 = permission4;
		return this;
	}
	
	
	public Boolean getPermission5() {
		return permission5;
	}

	public VipInfo setPermission5(Boolean permission5) {
		this.permission5 = permission5;
		return this;
	}
	
	
	public Boolean getPermission6() {
		return permission6;
	}

	public VipInfo setPermission6(Boolean permission6) {
		this.permission6 = permission6;
		return this;
	}
	
	
	public Boolean getPermission7() {
		return permission7;
	}

	public VipInfo setPermission7(Boolean permission7) {
		this.permission7 = permission7;
		return this;
	}
	
	
	public Boolean getPermission8() {
		return permission8;
	}

	public VipInfo setPermission8(Boolean permission8) {
		this.permission8 = permission8;
		return this;
	}

	public int getPrice() {
		return price;
	}

	public void setPrice(int price) {
		this.price = price;
	}

	public Integer getDays() {
		return days;
	}

	public void setDays(Integer days) {
		this.days = days;
	}

	@Override
	public String toString() {
		return "VipInfo{" +
				"isshelves=" + isshelves +
				", addTime=" + addTime +
				", describle='" + describle + '\'' +
				", addUserid=" + addUserid +
				", permission1=" + permission1 +
				", permission2=" + permission2 +
				", permission3=" + permission3 +
				", permission4=" + permission4 +
				", permission5=" + permission5 +
				", permission6=" + permission6 +
				", permission7=" + permission7 +
				", permission8=" + permission8 +
				", price=" + price +
				", days=" + days +
				'}';
	}
}
