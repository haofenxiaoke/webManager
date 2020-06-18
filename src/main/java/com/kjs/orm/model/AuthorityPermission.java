package com.kjs.orm.model;

import com.kjs.common.bean.BaseEntity;
import com.kjs.common.utils.ShortDateSerializer;
import org.apache.ibatis.type.Alias;
import org.codehaus.jackson.map.annotate.JsonSerialize;

import java.util.Date;

/**
 * POJO:AuthorityPermission
 * 
 * @author duia_builder
 * @date 2016-1-20
 */
@SuppressWarnings("serial")
@Alias("AuthorityPermission")
public class AuthorityPermission extends BaseEntity {
	
	
	private Long roleId;		 /* 角色ID */
	private Long	resourcesId;		 /*资源ID */
	private String  resourceCode;        /*资源代码 */
	private Long	operationId;		 /*操作ID */
	private String  operationCode;       /*操作代码*/
	private String	categoryId;		 /* sku实例ID */
	private String	permissionCode;		 /* 权限代码(shiro中的形式,资源:操作:sku) */ 
	private Long	lastModifyUserId;
	private Date	lastModifyDatetime;


	public AuthorityPermission() {
	}

	public AuthorityPermission(Long roleId, Long resourcesId, Long operationId, String categoryId,
							   String resourceCode, String operationCode, Long lastModifyUserId, Date lastModifyDatetime) {
		this.roleId = roleId;
		this.resourcesId = resourcesId;
		this.operationId = operationId;
		this.categoryId = categoryId;
		this.resourceCode = resourceCode;
		this.operationCode = operationCode;
		this.permissionCode = this.getCode();
		this.lastModifyUserId = lastModifyUserId;
		this.lastModifyDatetime = lastModifyDatetime;
	}

	public Long getRoleId() {
		return roleId;
	}

	public void setRoleId(Long roleId) {
		this.roleId = roleId;
	}

	public Long getResourcesId() {
		return resourcesId;
	}

	public void setResourcesId(Long resourcesId) {
		this.resourcesId = resourcesId;
	}

	public Long getOperationId() {
		return operationId;
	}

	public void setOperationId(Long operationId) {
		this.operationId = operationId;
	}

	public String getCategoryId() {
		return categoryId;
	}

	public AuthorityPermission setCategoryId(String categoryId) {
		this.categoryId = categoryId;
		return this;
	}
	
	
	public String getPermissionCode() {
		return this.permissionCode;
	}

	public AuthorityPermission setPermissionCode(String permissionCode) {
		this.permissionCode = permissionCode;
		return this;
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

	public AuthorityPermission setLastModifyDatetime(Date lastModifyDatetime) {
		this.lastModifyDatetime = lastModifyDatetime;
		return this;
	}

	public String getResourceCode() {
		return resourceCode;
	}

	public void setResourceCode(String resourceCode) {
		this.resourceCode = resourceCode;
	}

	public String getOperationCode() {
		return operationCode;
	}

	public void setOperationCode(String operationCode) {
		this.operationCode = operationCode;
	}

	public String getCode(){
		return this.getResourceCode()+":"+this.getOperationCode()+":"+this.getCategoryId();
	}

	@Override
	public String toString() {
		return "AuthorityPermission{" +
				"roleId=" + roleId +
				", resourcesId=" + resourcesId +
				", resourceCode='" + resourceCode + '\'' +
				", operationId=" + operationId +
				", operationCode='" + operationCode + '\'' +
				", categoryId='" + categoryId + '\'' +
				", permissionCode='" + permissionCode + '\'' +
				", lastModifyUserId=" + lastModifyUserId +
				", lastModifyDatetime=" + lastModifyDatetime +
				'}';
	}
}
