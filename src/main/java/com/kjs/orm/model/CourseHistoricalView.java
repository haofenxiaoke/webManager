package com.kjs.orm.model;

import com.kjs.common.bean.BaseEntity;
import com.kjs.common.utils.ShortDateSerializer;
import org.apache.ibatis.type.Alias;
import org.codehaus.jackson.map.annotate.JsonSerialize;

import java.util.Date;

/**
 * POJO:CourseHistoricalView
 * 
 * @author duia_builder
 * @date 2016-5-23
 */
@SuppressWarnings("serial")
@Alias("CourseHistoricalView")
public class CourseHistoricalView extends BaseEntity {
	
	
	private Integer	liveId;		 /* 视频ID */ 
	private String	courseName;		 /* 视频名称 */ 
	private String	courseUrl;		 /* 课程封面url */ 
	private Integer	courseStu;		 /* 课程学生数 */ 
	private Integer	courseScore;		 /* 课程评分 */ 
	private Integer	lectureNum;		 /* 讲座节数 */ 
	private Integer	lectureTotal;		 /* 讲座总节数 */ 
	private Integer	lectureScore;		 /* 讲座评分 */ 
	private Integer	watchTime;		 /* 观看时长 */ 
	private Integer	watchProgress;		 /* 观看进度 */ 
	private Date	lastWatchTime;		 /* 最后观看时间 */ 
	private Integer	userid;		 /* 用户ID */ 
	private Integer	usertype;		 /* 用户类型(0临时用户1普通用户2vip用户) */ 

	// getter && setter
	// 在setter方法最后加上"return this;"并把返回参数改为CourseHistoricalView可以实现连缀设置属性
	
	public Integer getLiveId() {
		return liveId;
	}

	public CourseHistoricalView setLiveId(Integer liveId) {
		this.liveId = liveId;
		return this;
	}
	
	
	public String getCourseName() {
		return courseName;
	}

	public CourseHistoricalView setCourseName(String courseName) {
		this.courseName = courseName;
		return this;
	}
	
	
	public String getCourseUrl() {
		return courseUrl;
	}

	public CourseHistoricalView setCourseUrl(String courseUrl) {
		this.courseUrl = courseUrl;
		return this;
	}
	
	
	public Integer getCourseStu() {
		return courseStu;
	}

	public CourseHistoricalView setCourseStu(Integer courseStu) {
		this.courseStu = courseStu;
		return this;
	}
	
	
	public Integer getCourseScore() {
		return courseScore;
	}

	public CourseHistoricalView setCourseScore(Integer courseScore) {
		this.courseScore = courseScore;
		return this;
	}
	
	
	public Integer getLectureNum() {
		return lectureNum;
	}

	public CourseHistoricalView setLectureNum(Integer lectureNum) {
		this.lectureNum = lectureNum;
		return this;
	}
	
	
	public Integer getLectureTotal() {
		return lectureTotal;
	}

	public CourseHistoricalView setLectureTotal(Integer lectureTotal) {
		this.lectureTotal = lectureTotal;
		return this;
	}
	
	
	public Integer getLectureScore() {
		return lectureScore;
	}

	public CourseHistoricalView setLectureScore(Integer lectureScore) {
		this.lectureScore = lectureScore;
		return this;
	}
	
	
	public Integer getWatchTime() {
		return watchTime;
	}

	public CourseHistoricalView setWatchTime(Integer watchTime) {
		this.watchTime = watchTime;
		return this;
	}
	
	
	public Integer getWatchProgress() {
		return watchProgress;
	}

	public CourseHistoricalView setWatchProgress(Integer watchProgress) {
		this.watchProgress = watchProgress;
		return this;
	}
	
	@JsonSerialize(using = ShortDateSerializer.class)
	public Date getLastWatchTime() {
		return lastWatchTime;
	}

	public CourseHistoricalView setLastWatchTime(Date lastWatchTime) {
		this.lastWatchTime = lastWatchTime;
		return this;
	}
	
	
	public Integer getUserid() {
		return userid;
	}

	public CourseHistoricalView setUserid(Integer userid) {
		this.userid = userid;
		return this;
	}
	
	
	public Integer getUsertype() {
		return usertype;
	}

	public CourseHistoricalView setUsertype(Integer usertype) {
		this.usertype = usertype;
		return this;
	}
	
	@Override
	public String toString() {
		return "CourseHistoricalView [" + "id=" + getId() + ", liveId=" + liveId + ", courseName=" + courseName + ", courseUrl=" + courseUrl + ", courseStu=" + courseStu + ", courseScore=" + courseScore + ", lectureNum=" + lectureNum + ", lectureTotal=" + lectureTotal + ", lectureScore=" + lectureScore + ", watchTime=" + watchTime + ", watchProgress=" + watchProgress + ", lastWatchTime=" + lastWatchTime + ", userid=" + userid + ", usertype=" + usertype +  "]";
	}
}
