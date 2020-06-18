package com.kjs.orm.model;

import com.kjs.common.bean.BaseEntity;
import com.kjs.common.utils.ShortDateSerializer;
import org.apache.ibatis.type.Alias;
import org.codehaus.jackson.map.annotate.JsonSerialize;

import java.util.Date;

/**
 * POJO:CategoryPosition
 * 
 * @author duia_builder
 * @date 2016-5-23
 */
@SuppressWarnings("serial")
@Alias("CategoryPosition")
public class CategoryPosition extends BaseEntity {
	
//	timer_status,
//	exam_data,
//	info_status,
//	info_json
	
	private Integer	directionId;		 /* 方向id */ 
	private String	categoryDesc;		 /* 类别描述 */ 
	private Integer	userid;		 /* 用户id */ 
	private Integer	orderNum;		 /* 排序 */ 
	private Date	createTime;		 /* 创建日期 */ 
	private Integer	deleted;		 /* 删除标识1删除0使用 */
	private String iconUrl0; 	/*职位小图标URL，男*/
	private String iconUrl1; 	/*职位小图标URL，女*/
	private Integer timerStatus;
	private	String examDate;
	private Integer	infoStatus;
	private String infoJson;
	private String examDesc;
	
	
	
	
	
	
	

	// getter && setter
	// 在setter方法最后加上"return this;"并把返回参数改为CategoryPosition可以实现连缀设置属性
	
	

	public String getExamDesc() {
		return examDesc;
	}

	public void setExamDesc(String examDesc) {
		this.examDesc = examDesc;
	}

	public Integer getDirectionId() {
		return directionId;
	}

	public CategoryPosition setDirectionId(Integer directionId) {
		this.directionId = directionId;
		return this;
	}
	
	
	public String getCategoryDesc() {
		return categoryDesc;
	}

	public CategoryPosition setCategoryDesc(String categoryDesc) {
		this.categoryDesc = categoryDesc;
		return this;
	}
	
	
	public Integer getUserid() {
		return userid;
	}

	public CategoryPosition setUserid(Integer userid) {
		this.userid = userid;
		return this;
	}
	
	
	public Integer getOrderNum() {
		return orderNum;
	}

	public CategoryPosition setOrderNum(Integer orderNum) {
		this.orderNum = orderNum;
		return this;
	}
	
	@JsonSerialize(using = ShortDateSerializer.class)
	public Date getCreateTime() {
		return createTime;
	}

	public CategoryPosition setCreateTime(Date createTime) {
		this.createTime = createTime;
		return this;
	}
	
	
	public Integer getDeleted() {
		return deleted;
	}

	public CategoryPosition setDeleted(Integer deleted) {
		this.deleted = deleted;
		return this;
	}

	public String getIconUrl0() {
		return iconUrl0;
	}

	public void setIconUrl0(String iconUrl0) {
		this.iconUrl0 = iconUrl0;
	}

	public String getIconUrl1() {
		return iconUrl1;
	}

	public void setIconUrl1(String iconUrl1) {
		this.iconUrl1 = iconUrl1;
	}

	
	
	
	
	
	
	public Integer getTimerStatus() {
		return timerStatus;
	}

	public void setTimerStatus(Integer timerStatus) {
		this.timerStatus = timerStatus;
	}

	public String getExamDate() {
		return examDate;
	}

	public void setExamDate(String examDate) {
		this.examDate = examDate;
	}

	public Integer getInfoStatus() {
		return infoStatus;
	}

	public void setInfoStatus(Integer infoStatus) {
		this.infoStatus = infoStatus;
	}

	public String getInfoJson() {
		return infoJson;
	}

	public void setInfoJson(String infoJson) {
		this.infoJson = infoJson;
	}

	@Override
	public String toString() {
		return "CategoryPosition [directionId=" + directionId + ", categoryDesc=" + categoryDesc + ", userid=" + userid
				+ ", orderNum=" + orderNum  + ", deleted=" + deleted + ", iconUrl0="
				+ iconUrl0 + ", iconUrl1=" + iconUrl1 + ", timerStatus=" + timerStatus + ", examDate=" + examDate
				+ ", infoStatus=" + infoStatus + ", infoJson=" + infoJson + ", examDesc=" + examDesc + "]";
	}

//	@Override
//	public String toString() {
//		return "CategoryPosition [" + "id=" + getId() + ", directionId=" + directionId + ", categoryDesc="
//				+ categoryDesc + ", userid=" + userid + ", orderNum=" + orderNum + ", createTime=" + createTime
//				+ ", deleted=" + deleted + ", iconUrl0=" + iconUrl0+ ", iconUrl1=" + iconUrl1+  "]";
//	}
	 
	
	
	
	
}
