package com.kjs.orm.model;

import com.kjs.common.bean.BaseEntity;
import com.kjs.common.utils.ShortDateSerializer;
import org.apache.ibatis.type.Alias;
import org.codehaus.jackson.map.annotate.JsonSerialize;

import java.util.Date;

/**
 * POJO:AuthorityRoles
 * 
 * @author duia_builder
 * @date 2016-1-20
 */
@SuppressWarnings("serial")
@Alias("AuthorityRoles")
public class AuthorityRoles extends BaseEntity {
	
	
	private String	name;		 /* 角色名称 */ 
	private Integer	parentId;		 /* 上级角色ID */
	private int     enable = 1;       /*角色开关1:启用0:停用*/
	private Long	lastModifyUserId;
	private Date	lastModifyDatetime;


	// getter && setter
	// 在setter方法最后加上"return this;"并把返回参数改为AuthorityRoles可以实现连缀设置属性
	
	public String getName() {
		return name;
	}

	public AuthorityRoles setName(String name) {
		this.name = name;
		return this;
	}
	
	
	public Integer getParentId() {
		return parentId;
	}

	public AuthorityRoles setParentId(Integer parentId) {
		this.parentId = parentId;
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

	public AuthorityRoles setLastModifyDatetime(Date lastModifyDatetime) {
		this.lastModifyDatetime = lastModifyDatetime;
		return this;
	}


	public int getEnable() {
		return enable;
	}

	public void setEnable(int enable) {
		this.enable = enable;
	}

	@Override
	public String toString() {
		return "AuthorityRoles{" +
				"name='" + name + '\'' +
				", parentId=" + parentId +
				", enable=" + enable +
				", lastModifyUserId=" + lastModifyUserId +
				", lastModifyDatetime=" + lastModifyDatetime +
				'}';
	}
}
