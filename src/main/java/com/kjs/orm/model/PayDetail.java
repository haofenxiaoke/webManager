package com.kjs.orm.model;

import com.kjs.common.bean.BaseEntity;
import org.apache.ibatis.type.Alias;

import java.util.Date;

/**
 * POJO:PayDetail
 * 
 * @author duia_builder
 * @date 2016-7-27
 */
@SuppressWarnings("serial")
@Alias("PayDetail")
public class PayDetail extends BaseEntity {
	
	
	private Integer	userId;		 /* 用户id */ 
	private Integer	orderId;		 /* 订单id */ 
	private Double	money;		 /* 金额 */ 
	private String	payNum;		 /* 支付流水号 */ 
	private String	payType;		 /* 支付类型1支付宝2微信支付3财付通4银联 */ 
	private String	payBank;		
	private Date	ctime;		 /* 创建时间 */ 
	private Date	mtime;		 /* 修改时间 */ 

	// getter && setter
	// 在setter方法最后加上"return this;"并把返回参数改为PayDetail可以实现连缀设置属性
	
	public Integer getUserId() {
		return userId;
	}

	public PayDetail setUserId(Integer userId) {
		this.userId = userId;
		return this;
	}
	
	
	public Integer getOrderId() {
		return orderId;
	}

	public PayDetail setOrderId(Integer orderId) {
		this.orderId = orderId;
		return this;
	}
	
	
	public Double getMoney() {
		return money;
	}

	public PayDetail setMoney(Double money) {
		this.money = money;
		return this;
	}
	
	
	public String getPayNum() {
		return payNum;
	}

	public PayDetail setPayNum(String payNum) {
		this.payNum = payNum;
		return this;
	}
	
	
	public String getPayType() {
		return payType;
	}

	public PayDetail setPayType(String payType) {
		this.payType = payType;
		return this;
	}
	
	
	public String getPayBank() {
		return payBank;
	}

	public PayDetail setPayBank(String payBank) {
		this.payBank = payBank;
		return this;
	}
	
	public Date getCtime() {
		return ctime;
	}

	public PayDetail setCtime(Date ctime) {
		this.ctime = ctime;
		return this;
	}
	
	public Date getMtime() {
		return mtime;
	}

	public PayDetail setMtime(Date mtime) {
		this.mtime = mtime;
		return this;
	}
	
	@Override
	public String toString() {
		return "PayDetail [" + "id=" + getId() + ", userId=" + userId + ", orderId=" + orderId + ", money=" + money + ", payNum=" + payNum + ", payType=" + payType + ", payBank=" + payBank + ", ctime=" + ctime + ", mtime=" + mtime +  "]";
	}
}
