package com.kjs.orm.model;

import com.kjs.common.bean.BaseEntity;
import com.kjs.common.utils.ShortDateSerializer;
import org.apache.ibatis.type.Alias;
import org.codehaus.jackson.map.annotate.JsonSerialize;

import java.util.Date;

/**
 * POJO:SysLoginLog
 * 
 * @author duia_builder
 * @date 2016-1-20
 */
@SuppressWarnings("serial")
@Alias("SysLoginLog")
public class SysLoginLog extends BaseEntity {
	
	
	private Integer	userId;		
	private Date	loginDate;		
	private Date	loginTime;		
	private Integer	userType;		
	private Date	loginOutDate;		
	private Date	loginOutTime;		
	private Integer	userOnlineTime;		
	private String	userSessionId;		
	private Integer	loginType;		

	// getter && setter
	// 在setter方法后加"return this;"并把返回参数改为SysLoginLog可以实现连缀设置属
	
	public Integer getUserId() {
		return userId;
	}

	public SysLoginLog setUserId(Integer userId) {
		this.userId = userId;
		return this;
	}
	
	@JsonSerialize(using = ShortDateSerializer.class)
	public Date getLoginDate() {
		return loginDate;
	}

	public SysLoginLog setLoginDate(Date loginDate) {
		this.loginDate = loginDate;
		return this;
	}
	
	@JsonSerialize(using = ShortDateSerializer.class)
	public Date getLoginTime() {
		return loginTime;
	}

	public SysLoginLog setLoginTime(Date loginTime) {
		this.loginTime = loginTime;
		return this;
	}
	
	
	public Integer getUserType() {
		return userType;
	}

	public SysLoginLog setUserType(Integer userType) {
		this.userType = userType;
		return this;
	}
	
	@JsonSerialize(using = ShortDateSerializer.class)
	public Date getLoginOutDate() {
		return loginOutDate;
	}

	public SysLoginLog setLoginOutDate(Date loginOutDate) {
		this.loginOutDate = loginOutDate;
		return this;
	}
	
	@JsonSerialize(using = ShortDateSerializer.class)
	public Date getLoginOutTime() {
		return loginOutTime;
	}

	public SysLoginLog setLoginOutTime(Date loginOutTime) {
		this.loginOutTime = loginOutTime;
		return this;
	}
	
	
	public Integer getUserOnlineTime() {
		return userOnlineTime;
	}

	public SysLoginLog setUserOnlineTime(Integer userOnlineTime) {
		this.userOnlineTime = userOnlineTime;
		return this;
	}
	
	
	public String getUserSessionId() {
		return userSessionId;
	}

	public SysLoginLog setUserSessionId(String userSessionId) {
		this.userSessionId = userSessionId;
		return this;
	}
	
	
	public Integer getLoginType() {
		return loginType;
	}

	public SysLoginLog setLoginType(Integer loginType) {
		this.loginType = loginType;
		return this;
	}
	
	@Override
	public String toString() {
		return "SysLoginLog [" + "id=" + getId() + ", userId=" + userId + ", loginDate=" + loginDate + ", loginTime=" + loginTime + ", userType=" + userType + ", loginOutDate=" + loginOutDate + ", loginOutTime=" + loginOutTime + ", userOnlineTime=" + userOnlineTime + ", userSessionId=" + userSessionId + ", loginType=" + loginType +  "]";
	}
}
