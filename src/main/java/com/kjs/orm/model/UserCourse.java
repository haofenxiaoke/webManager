package com.kjs.orm.model;


import com.kjs.common.bean.BaseEntity;
import org.apache.ibatis.type.Alias;

import java.util.Date;

/**
 * POJO:UserCourse
 * 
 * @author duia_builder
 * @date 2016-5-23
 */
@SuppressWarnings("serial")
@Alias("UserCourse")
public class UserCourse extends BaseEntity {
	
	
	private Integer	userid;		 /* 用户id */ 
	private Integer	courseid;		 /* 课程id */ 
	private Date createTime;		 /* 创建日期 */
	private Integer	latestLecture;		 /* 最近观看章节 */ 
	private Integer	userCourseScore;		 /* 用户课程评分 */ 
	private Integer	watchProgress;		 /* 用户观看进度 */ 
	private Boolean	deleted;		 /* 删除标识1删除0使用 */

	// getter && setter
	// 在setter方法最后加上"return this;"并把返回参数改为UserCourse可以实现连缀设置属性
	
	public Integer getUserid() {
		return userid;
	}

	public UserCourse setUserid(Integer userid) {
		this.userid = userid;
		return this;
	}
	
	
	public Integer getCourseid() {
		return courseid;
	}

	public UserCourse setCourseid(Integer courseid) {
		this.courseid = courseid;
		return this;
	}

	public Date getCreateTime() {
		return createTime;
	}

	public void setCreateTime(Date createTime) {
		this.createTime = createTime;
	}

	public Integer getLatestLecture() {
		return latestLecture;
	}

	public UserCourse setLatestLecture(Integer latestLecture) {
		this.latestLecture = latestLecture;
		return this;
	}
	
	
	public Integer getUserCourseScore() {
		return userCourseScore;
	}

	public UserCourse setUserCourseScore(Integer userCourseScore) {
		this.userCourseScore = userCourseScore;
		return this;
	}
	
	
	public Integer getWatchProgress() {
		return watchProgress;
	}

	public UserCourse setWatchProgress(Integer watchProgress) {
		this.watchProgress = watchProgress;
		return this;
	}
	
	
	public Boolean getDeleted() {
		return deleted;
	}

	public UserCourse setDeleted(Boolean deleted) {
		this.deleted = deleted;
		return this;
	}
	
	@Override
	public String toString() {
		return "UserCourse [" + "id=" + getId() + ", userid=" + userid + ", courseid=" + courseid + ", createTime=" + createTime + ", latestLecture=" + latestLecture + ", userCourseScore=" + userCourseScore + ", watchProgress=" + watchProgress + ", deleted=" + deleted +  "]";
	}
}
