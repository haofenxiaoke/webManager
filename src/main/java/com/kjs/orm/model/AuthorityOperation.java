package com.kjs.orm.model;

import com.kjs.common.bean.BaseEntity;
import com.kjs.common.utils.ShortDateSerializer;
import org.apache.ibatis.type.Alias;
import org.codehaus.jackson.map.annotate.JsonSerialize;

import java.util.Date;

/**
 * POJO:AuthorityOperation
 * 
 * @author duia_builder
 * @date 2016-1-20
 */
@SuppressWarnings("serial")
@Alias("AuthorityOperation")
public class AuthorityOperation extends BaseEntity {
	
	
	private String	name;		 /* 操作名称 */ 
	private String	code;		 /* 操作代码 */ 
	private String	description;		 /* 操作描述 */ 
	private Long	menuId;		 /* 操作所属菜单ID */
	private Long	lastModifyUserId;
	private Date	lastModifyDatetime;		

	// getter && setter
	// 在setter方法最后加上"return this;"并把返回参数改为AuthorityOperation可以实现连缀设置属性
	
	public String getName() {
		return name;
	}

	public AuthorityOperation setName(String name) {
		this.name = name;
		return this;
	}
	
	
	public String getCode() {
		return code;
	}

	public AuthorityOperation setCode(String code) {
		this.code = code;
		return this;
	}
	
	
	public String getDescription() {
		return description;
	}

	public AuthorityOperation setDescription(String description) {
		this.description = description;
		return this;
	}
	
	
	public Long getMenuId() {
		return menuId;
	}

	public AuthorityOperation setMenuId(Long menuId) {
		this.menuId = menuId;
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

	public AuthorityOperation setLastModifyDatetime(Date lastModifyDatetime) {
		this.lastModifyDatetime = lastModifyDatetime;
		return this;
	}
	
	@Override
	public String toString() {
		return "AuthorityOperation [" + "id=" + getId() + ", name=" + name + ", code=" + code + ", description=" + description + ", menuId=" + menuId + ", lastModifyUserId=" + lastModifyUserId + ", lastModifyDatetime=" + lastModifyDatetime +  "]";
	}
}
