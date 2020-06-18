package com.kjs.orm.model;

import com.kjs.common.bean.BaseEntity;
import com.kjs.common.utils.ShortDateSerializer;
import org.apache.ibatis.type.Alias;
import org.codehaus.jackson.map.annotate.JsonSerialize;

import java.util.Date;

/**
 * POJO:CourseStudiesDetail
 * 
 * @author duia_builder
 * @date 2016-5-23
 */
@SuppressWarnings("serial")
@Alias("CourseStudiesDetail")
public class CourseStudiesDetail extends BaseEntity {
	
	
	private Integer	planId;		 /* 计划ID */ 
	private Integer	courseId;		 /* 视频ID */ 
	private String	courseName;		 /* 视频名称 */ 
	private String	courseUrl;		 /* 课程封面url */ 
	private Integer	courseStu;		 /* 课程学生数 */ 
	private Integer	courseScore;		 /* 课程评分 */ 
	private Integer	lectureNum;		 /* 讲座节数 */ 
	private Integer	lectureTotal;		 /* 讲座总节数 */ 
	private Date	lastWatchTime;		 /* 最后观看时间 */ 
	private Integer	watchProgress;		 /* 观看进度 */ 
	private Integer	watchTime;		 /* 观看时长 */ 
	private Integer	userid;		 /* 用户ID */ 
	private Integer	usertype;		 /* 用户类型 */ 

	// getter && setter
	// 在setter方法最后加上"return this;"并把返回参数改为CourseStudiesDetail可以实现连缀设置属性
	
	public Integer getPlanId() {
		return planId;
	}

	public CourseStudiesDetail setPlanId(Integer planId) {
		this.planId = planId;
		return this;
	}
	
	
	public Integer getCourseId() {
		return courseId;
	}

	public CourseStudiesDetail setCourseId(Integer courseId) {
		this.courseId = courseId;
		return this;
	}
	
	
	public String getCourseName() {
		return courseName;
	}

	public CourseStudiesDetail setCourseName(String courseName) {
		this.courseName = courseName;
		return this;
	}
	
	
	public String getCourseUrl() {
		return courseUrl;
	}

	public CourseStudiesDetail setCourseUrl(String courseUrl) {
		this.courseUrl = courseUrl;
		return this;
	}
	
	
	public Integer getCourseStu() {
		return courseStu;
	}

	public CourseStudiesDetail setCourseStu(Integer courseStu) {
		this.courseStu = courseStu;
		return this;
	}
	
	
	public Integer getCourseScore() {
		return courseScore;
	}

	public CourseStudiesDetail setCourseScore(Integer courseScore) {
		this.courseScore = courseScore;
		return this;
	}
	
	
	public Integer getLectureNum() {
		return lectureNum;
	}

	public CourseStudiesDetail setLectureNum(Integer lectureNum) {
		this.lectureNum = lectureNum;
		return this;
	}
	
	
	public Integer getLectureTotal() {
		return lectureTotal;
	}

	public CourseStudiesDetail setLectureTotal(Integer lectureTotal) {
		this.lectureTotal = lectureTotal;
		return this;
	}
	
	@JsonSerialize(using = ShortDateSerializer.class)
	public Date getLastWatchTime() {
		return lastWatchTime;
	}

	public CourseStudiesDetail setLastWatchTime(Date lastWatchTime) {
		this.lastWatchTime = lastWatchTime;
		return this;
	}
	
	
	public Integer getWatchProgress() {
		return watchProgress;
	}

	public CourseStudiesDetail setWatchProgress(Integer watchProgress) {
		this.watchProgress = watchProgress;
		return this;
	}
	
	
	public Integer getWatchTime() {
		return watchTime;
	}

	public CourseStudiesDetail setWatchTime(Integer watchTime) {
		this.watchTime = watchTime;
		return this;
	}
	
	
	public Integer getUserid() {
		return userid;
	}

	public CourseStudiesDetail setUserid(Integer userid) {
		this.userid = userid;
		return this;
	}
	
	
	public Integer getUsertype() {
		return usertype;
	}

	public CourseStudiesDetail setUsertype(Integer usertype) {
		this.usertype = usertype;
		return this;
	}
	
	@Override
	public String toString() {
		return "CourseStudiesDetail [" + "id=" + getId() + ", planId=" + planId + ", courseId=" + courseId + ", courseName=" + courseName + ", courseUrl=" + courseUrl + ", courseStu=" + courseStu + ", courseScore=" + courseScore + ", lectureNum=" + lectureNum + ", lectureTotal=" + lectureTotal + ", lastWatchTime=" + lastWatchTime + ", watchProgress=" + watchProgress + ", watchTime=" + watchTime + ", userid=" + userid + ", usertype=" + usertype +  "]";
	}
}
