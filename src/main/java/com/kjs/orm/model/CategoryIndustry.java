package com.kjs.orm.model;

import com.kjs.common.bean.BaseEntity;
import com.kjs.common.utils.ShortDateSerializer;
import org.apache.ibatis.type.Alias;
import org.codehaus.jackson.map.annotate.JsonSerialize;

import java.util.Date;

/**
 * POJO:CategoryIndustry
 * 
 * @author duia_builder
 * @date 2016-5-23
 */
@SuppressWarnings("serial")
@Alias("CategoryIndustry")
public class CategoryIndustry extends BaseEntity {
	
	
	private Integer	directionId;		 /* 方向id */ 
	private String	categoryDesc;		 /* 类别描述 */ 
	private Integer	userid;		 /* 用户id */ 
	private Integer	orderNum;		 /* 排序 */ 
	private Date	createTime;		 /* 创建日期 */ 
	private Integer	deleted;		 /* 删除标识1删除0使用 */
	private String iconUrl;  /* 行业小图标URL */

	// getter && setter
	// 在setter方法最后加上"return this;"并把返回参数改为CategoryIndustry可以实现连缀设置属性
	
	public Integer getDirectionId() {
		return directionId;
	}

	public CategoryIndustry setDirectionId(Integer directionId) {
		this.directionId = directionId;
		return this;
	}
	
	
	public String getCategoryDesc() {
		return categoryDesc;
	}

	public CategoryIndustry setCategoryDesc(String categoryDesc) {
		this.categoryDesc = categoryDesc;
		return this;
	}
	
	
	public Integer getUserid() {
		return userid;
	}

	public CategoryIndustry setUserid(Integer userid) {
		this.userid = userid;
		return this;
	}
	
	
	public Integer getOrderNum() {
		return orderNum;
	}

	public CategoryIndustry setOrderNum(Integer orderNum) {
		this.orderNum = orderNum;
		return this;
	}
	
	@JsonSerialize(using = ShortDateSerializer.class)
	public Date getCreateTime() {
		return createTime;
	}

	public CategoryIndustry setCreateTime(Date createTime) {
		this.createTime = createTime;
		return this;
	}
	
	
	public Integer getDeleted() {
		return deleted;
	}

	public CategoryIndustry setDeleted(Integer deleted) {
		this.deleted = deleted;
		return this;
	}

	public String getIconUrl() {
		return iconUrl;
	}

	public void setIconUrl(String iconUrl) {
		this.iconUrl = iconUrl;
	}

	@Override
	public String toString() {
		return "CategoryIndustry [" + "id=" + getId() + ", directionId=" + directionId + ", categoryDesc=" + categoryDesc + ", userid=" + userid + ", orderNum=" + orderNum + ", createTime=" + createTime + ", deleted=" + deleted+ ", iconUrl=" + iconUrl +  "]";
	}
}
