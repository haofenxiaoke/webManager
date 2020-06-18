package com.kjs.orm.model;


import com.kjs.common.bean.BaseEntity;
import org.apache.ibatis.type.Alias;

import java.util.Date;

/**
 * POJO:UserLecture
 * 
 * @author duia_builder
 * @date 2016-5-23
 */
@SuppressWarnings("serial")
@Alias("UserLecture")
public class UserLecture extends BaseEntity {
	
	
	private Integer	userid;		 /* 用户id */ 
	private Integer	lectureid;		 /* 章节id */ 
	private Date createTime;		 /* 创建日期 */
	private Date	watchTime;		 /* 最近观看时间 */
	private Integer	userCourseScore;		 /* 用户课程评分 */ 
	private Integer	watchProgress;		 /* 用户观看进度 */ 
	private Boolean	deleted;		 /* 删除标识1删除0使用 */

	// getter && setter
	// 在setter方法最后加上"return this;"并把返回参数改为UserLecture可以实现连缀设置属性
	
	public Integer getUserid() {
		return userid;
	}

	public UserLecture setUserid(Integer userid) {
		this.userid = userid;
		return this;
	}
	
	
	public Integer getLectureid() {
		return lectureid;
	}

	public UserLecture setLectureid(Integer lectureid) {
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

	public UserLecture setWatchTime(Date watchTime) {
		this.watchTime = watchTime;
		return this;
	}
	
	
	public Integer getUserCourseScore() {
		return userCourseScore;
	}

	public UserLecture setUserCourseScore(Integer userCourseScore) {
		this.userCourseScore = userCourseScore;
		return this;
	}
	
	
	public Integer getWatchProgress() {
		return watchProgress;
	}

	public UserLecture setWatchProgress(Integer watchProgress) {
		this.watchProgress = watchProgress;
		return this;
	}
	
	
	public Boolean getDeleted() {
		return deleted;
	}

	public UserLecture setDeleted(Boolean deleted) {
		this.deleted = deleted;
		return this;
	}
	
	@Override
	public String toString() {
		return "UserLecture [" + "id=" + getId() + ", userid=" + userid + ", lectureid=" + lectureid + ", createTime=" + createTime + ", watchTime=" + watchTime + ", userCourseScore=" + userCourseScore + ", watchProgress=" + watchProgress + ", deleted=" + deleted +  "]";
	}
}
