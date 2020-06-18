package com.kjs.orm.model;

import com.kjs.common.bean.BaseEntity;
import com.kjs.common.utils.ShortDateSerializer;
import org.apache.ibatis.type.Alias;
import org.codehaus.jackson.map.annotate.JsonSerialize;

import java.util.Date;

/**
 * POJO:AuthorityUserActionState
 * 
 * @author duia_builder
 * @date 2016-5-23
 */
@SuppressWarnings("serial")
@Alias("AuthorityUserActionState")
public class AuthorityUserActionState extends BaseEntity {
	
	
	private Integer	userId;		 /* 用户id */ 
	private Date	currentLoginTime;		 /* 本次登录时间 */ 
	private Date	lastLogoutTime;		 /* 最后注销时间 */ 
	private Integer	online;		 /* 是否在线 */ 
	private String	userSessionId;		 /* session_id */ 

	// getter && setter
	// 在setter方法最后加上"return this;"并把返回参数改为AuthorityUserActionState可以实现连缀设置属性
	
	public Integer getUserId() {
		return userId;
	}

	public AuthorityUserActionState setUserId(Integer userId) {
		this.userId = userId;
		return this;
	}
	
	@JsonSerialize(using = ShortDateSerializer.class)
	public Date getCurrentLoginTime() {
		return currentLoginTime;
	}

	public AuthorityUserActionState setCurrentLoginTime(Date currentLoginTime) {
		this.currentLoginTime = currentLoginTime;
		return this;
	}
	
	@JsonSerialize(using = ShortDateSerializer.class)
	public Date getLastLogoutTime() {
		return lastLogoutTime;
	}

	public AuthorityUserActionState setLastLogoutTime(Date lastLogoutTime) {
		this.lastLogoutTime = lastLogoutTime;
		return this;
	}
	
	
	public Integer getOnline() {
		return online;
	}

	public AuthorityUserActionState setOnline(Integer online) {
		this.online = online;
		return this;
	}
	
	
	public String getUserSessionId() {
		return userSessionId;
	}

	public AuthorityUserActionState setUserSessionId(String userSessionId) {
		this.userSessionId = userSessionId;
		return this;
	}
	
	@Override
	public String toString() {
		return "AuthorityUserActionState [" + "id=" + getId() + ", userId=" + userId + ", currentLoginTime=" + currentLoginTime + ", lastLogoutTime=" + lastLogoutTime + ", online=" + online + ", userSessionId=" + userSessionId +  "]";
	}
}
