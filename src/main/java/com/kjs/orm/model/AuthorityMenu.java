package com.kjs.orm.model;

import com.kjs.common.bean.BaseEntity;
import com.kjs.common.utils.ShortDateSerializer;
import org.apache.ibatis.type.Alias;
import org.codehaus.jackson.map.annotate.JsonSerialize;

import java.util.Date;
import java.util.List;

/**
 * POJO:AuthorityMenu
 * 
 * @author duia_builder
 * @date 2016-1-20
 */
@SuppressWarnings("serial")
@Alias("AuthorityMenu")
public class AuthorityMenu extends BaseEntity {
	
	
	private String	menuName;		 /* 菜单名称 */ 
	private String	menuUrl;		 /* 菜单URL */ 
	private int	menuEnable = 1;		 /* 菜单是否启用(1启用0不启用) */
	private Integer	menuParentId;		 /* 上级菜单ID,0为根菜单 */ 
	private String	menuIcon;		 /* 菜单的ICON图标 */
	private String  menuCode;       /*菜单代码*/
	private String  menuDesc;      /*菜单描述*/
	private Long	lastModifyUserId;
	private Date	lastModifyDatetime;


	private List<AuthorityOperation> operationList;/*菜单下的操作*/
	// getter && setter
	// 在setter方法最后加上"return this;"并把返回参数改为AuthorityMenu可以实现连缀设置属性

	public String getMenuName() {
		return menuName;
	}

	public AuthorityMenu setMenuName(String menuName) {
		this.menuName = menuName;
		return this;
	}


	public String getMenuUrl() {
		return menuUrl;
	}

	public AuthorityMenu setMenuUrl(String menuUrl) {
		this.menuUrl = menuUrl;
		return this;
	}


	public int getMenuEnable() {
		return menuEnable;
	}

	public void setMenuEnable(int menuEnable) {
		this.menuEnable = menuEnable;
	}

	public Integer getMenuParentId() {
		return menuParentId;
	}

	public AuthorityMenu setMenuParentId(Integer menuParentId) {
		this.menuParentId = menuParentId;
		return this;
	}


	public String getMenuIcon() {
		return menuIcon;
	}

	public AuthorityMenu setMenuIcon(String menuIcon) {
		this.menuIcon = menuIcon;
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

	public AuthorityMenu setLastModifyDatetime(Date lastModifyDatetime) {
		this.lastModifyDatetime = lastModifyDatetime;
		return this;
	}

	public String getMenuCode() {
		return menuCode;
	}

	public void setMenuCode(String menuCode) {
		this.menuCode = menuCode;
	}

	public String getMenuDesc() {
		return menuDesc;
	}

	public void setMenuDesc(String menuDesc) {
		this.menuDesc = menuDesc;
	}

	public List<AuthorityOperation> getOperationList() {
		return operationList;
	}

	public void setOperationList(List<AuthorityOperation> operationList) {
		this.operationList = operationList;
	}
}
