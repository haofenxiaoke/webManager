package com.kjs.orm.model;


import com.kjs.common.bean.BaseEntity;
import org.apache.ibatis.type.Alias;

import java.util.Date;

/**
 * POJO:UserLectureData
 * 
 * @author duia_builder
 * @date 2016-6-7
 */
@SuppressWarnings("serial")
@Alias("UserLectureData")
public class UserLectureData extends BaseEntity {
	
	
	private Integer	userid;		 /* 用户id */ 
	private Integer	lectureid;		 /* 章节id */ 
	private Date createTime;		 /* 创建日期 */
	private Date	watchTime;		 /* 最近观看时间 */
	private Boolean	deleted;		 /* 删除标识1删除0使用 */ 

	// getter && setter
	// 在setter方法最后加上"return this;"并把返回参数改为UserLectureData可以实现连缀设置属性
	
	public Integer getUserid() {
		return userid;
	}

	public UserLectureData setUserid(Integer userid) {
		this.userid = userid;
		return this;
	}
	
	
	public Integer getLectureid() {
		return lectureid;
	}

	public UserLectureData setLectureid(Integer lectureid) {
		this.lectureid = lectureid;
		return this;
	}

	public Date getCreateTime() {
		return createTime;
	}

	public void setCreateTime(Date createTime) {
		this.createTime = createTime;
	}

	public Date getWatchTime() {
		return watchTime;
	}

	public UserLectureData setWatchTime(Date watchTime) {
		this.watchTime = watchTime;
		return this;
	}
	
	
	public Boolean getDeleted() {
		return deleted;
	}

	public UserLectureData setDeleted(Boolean deleted) {
		this.deleted = deleted;
		return this;
	}
	
	@Override
	public String toString() {
		return "UserLectureData [" + "id=" + getId() + ", userid=" + userid + ", lectureid=" + lectureid + ", createTime=" + createTime + ", watchTime=" + watchTime + ", deleted=" + deleted +  "]";
	}
}
