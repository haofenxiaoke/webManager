package com.kjs.orm.model;

import com.kjs.common.bean.BaseEntity;
import com.kjs.common.utils.ShortDateSerializer;
import org.apache.ibatis.type.Alias;
import org.codehaus.jackson.map.annotate.JsonSerialize;

import java.util.Date;

/**
 * POJO:AuthorityUserRole
 * 
 * @author duia_builder
 * @date 2016-1-20
 */
@SuppressWarnings("serial")
@Alias("AuthorityUserRole")
public class AuthorityUserRole extends BaseEntity {
	
	
	private Long	userId;		 /* 用户ID */
	private Long	roleId;		 /* 角色ID */
	private Long	lastModifyUserId;
	private Date	lastModifyDatetime;		

	// getter && setter
	// 在setter方法最后加上"return this;"并把返回参数改为AuthorityUserRole可以实现连缀设置属性


	public Long getUserId() {
		return userId;
	}

	public void setUserId(Long userId) {
		this.userId = userId;
	}

	public Long getRoleId() {
		return roleId;
	}

	public void setRoleId(Long roleId) {
		this.roleId = roleId;
	}

	public Long getLastModifyUserId() {
		return lastModifyUserId;
	}

	public void setLastModifyUserId(Long lastModifyUserId) {
		this.lastModifyUserId = lastModifyUserId;
	}

	@JsonSerialize(using = ShortDateSerializer.class)
	public Date getLastModifyDatetime() {
		return lastModifyDatetime;
	}

	public AuthorityUserRole setLastModifyDatetime(Date lastModifyDatetime) {
		this.lastModifyDatetime = lastModifyDatetime;
		return this;
	}
	
	@Override
	public String toString() {
		return "AuthorityUserRole [" + "id=" + getId() + ", userId=" + userId + ", roleId=" + roleId + ", lastModifyUserId=" + lastModifyUserId + ", lastModifyDatetime=" + lastModifyDatetime +  "]";
	}
}
