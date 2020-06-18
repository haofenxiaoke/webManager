package com.kjs.orm.model;

import java.util.Date;
import java.util.List;

import org.apache.ibatis.type.Alias;
import org.codehaus.jackson.map.annotate.JsonSerialize;
import org.springframework.data.annotation.Transient;

import com.kjs.common.bean.BaseEntity;
import com.kjs.common.utils.ShortDateSerializer;

/**
 * POJO:CategoryDirection
 * 
 * @author duia_builder
 * @date 2016-5-23
 */
@SuppressWarnings("serial")
@Alias("CategoryDirection")
public class CategoryDirection extends BaseEntity {

	private String	categoryDesc;		 /* 类别描述 */
	private Integer	userid;		 /* 用户id */ 
	private Integer	orderNum;		 /* 排序 */ 
	private Date	createTime;		 /* 创建日期 */ 
	private Integer	deleted;		 /* 删除标识1删除0使用 */
	
	
	
	@Transient
    List<CategoryIndustry> industries;//该方向下的行业标签列表    主页菜单使用

    @Transient
    List<CategoryPosition> positions;//该方向下的职业列表   主页菜单使用

	public CategoryDirection() {
	}

	public CategoryDirection(Long id,String categoryDesc) {
		this.id = id;
		this.categoryDesc = categoryDesc;
	}
// getter && setter
	// 在setter方法最后加上"return this;"并把返回参数改为CategoryDirection可以实现连缀设置属性

	public String getCategoryDesc() {
		return categoryDesc;
	}

	public CategoryDirection setCategoryDesc(String categoryDesc) {
		this.categoryDesc = categoryDesc;
		return this;
	}
	
	
	public Integer getUserid() {
		return userid;
	}

	public CategoryDirection setUserid(Integer userid) {
		this.userid = userid;
		return this;
	}
	
	
	public Integer getOrderNum() {
		return orderNum;
	}

	public CategoryDirection setOrderNum(Integer orderNum) {
		this.orderNum = orderNum;
		return this;
	}
	
	@JsonSerialize(using = ShortDateSerializer.class)
	public Date getCreateTime() {
		return createTime;
	}

	public CategoryDirection setCreateTime(Date createTime) {
		this.createTime = createTime;
		return this;
	}
	
	
	public Integer getDeleted() {
		return deleted;
	}

	public CategoryDirection setDeleted(Integer deleted) {
		this.deleted = deleted;
		return this;
	}
	
	
	
	
	public List<CategoryIndustry> getIndustries() {
		return industries;
	}

	public void setIndustries(List<CategoryIndustry> industries) {
		this.industries = industries;
	}

	public List<CategoryPosition> getPositions() {
		return positions;
	}

	public void setPositions(List<CategoryPosition> positions) {
		this.positions = positions;
	}

	@Override
	public String toString() {
		return "CategoryDirection [" + "id=" + getId() + ", categoryDesc=" + categoryDesc + ", userid=" + userid + ", orderNum=" + orderNum + ", createTime=" + createTime + ", deleted=" + deleted +  "]";
	}
}
