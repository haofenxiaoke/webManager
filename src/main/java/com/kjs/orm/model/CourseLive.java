package com.kjs.orm.model;

import com.kjs.common.bean.BaseEntity;
import com.kjs.common.utils.ShortDateSerializer;
import org.apache.ibatis.type.Alias;
import org.codehaus.jackson.map.annotate.JsonSerialize;

import java.util.Date;

/**
 * POJO:CourseLive
 *
 * @author duia_builder
 * @date 2016-5-23
 */
@SuppressWarnings("serial")
@Alias("CourseLive")
public class CourseLive extends BaseEntity {
	private Integer	categoryId;		 /* 方向id */ 
	private String	liveId;
	private String	liveTitle;
	private String	teacherName;
	private String	courseUrl;
	private String	summary;
	private String	recordingId;  /*录播id*/
	private Date	liveStart;		 /* 直播开始时间 */
	private Date	liveEnd;		 /* 直播结束时间 */
	private Integer	type;		 /* 直播类型（1今日0近期） */
	private String	appType;		 /* 客户端（app|web） */ 
	private Long	userid;		 /* 用户id */
	private Date	createTime;		 /* 创建时间 */ 
	private Integer 	deleted;		 /* 删除标识1被删除 */
	private Integer	liveType;		 /* 0:直播 1：公开课 */
	private String cateDirectionName; //方向名称
	private Integer teacherId;        //老师id
	private Integer initNum;        //预约基数
	private Integer subscriptionCount;  //实际预约人数
	// getter && setter
	// 在setter方法最后加上"return this;"并把返回参数改为CourseLive可以实现连缀设置属性


	public Integer getSubscriptionCount() {
		return subscriptionCount;
	}

	public void setSubscriptionCount(Integer subscriptionCount) {
		this.subscriptionCount = subscriptionCount;
	}

	public Integer getInitNum() {
		return initNum;
	}

	public void setInitNum(Integer initNum) {
		this.initNum = initNum;
	}

	public Integer getCategoryId() {
		return categoryId;
	}

	public CourseLive setCategoryId(Integer categoryId) {
		this.categoryId = categoryId;
		return this;
	}

	public Integer getTeacherId() {
		return teacherId;
	}

	public CourseLive setTeacherId(Integer teacherId) {
		this.teacherId = teacherId;
		return this;
	}

	public Integer getLiveType() {
		return liveType;
	}

	public void setLiveType(Integer liveType) {
		this.liveType = liveType;
	}

	public String getLiveId() {
		return liveId;
	}

	public CourseLive setLiveId(String liveId) {
		this.liveId = liveId;
		return this;
	}


	public String getLiveTitle() {
		return liveTitle;
	}

	public CourseLive setLiveTitle(String liveTitle) {
		this.liveTitle = liveTitle;
		return this;
	}


	public String getTeacherName() {
		return teacherName;
	}

	public CourseLive setTeacherName(String teacherName) {
		this.teacherName = teacherName;
		return this;
	}


	public String getCourseUrl() {
		return courseUrl;
	}

	public CourseLive setCourseUrl(String courseUrl) {
		this.courseUrl = courseUrl;
		return this;
	}


	public String getSummary() {
		return summary;
	}

	public CourseLive setSummary(String summary) {
		this.summary = summary;
		return this;
	}

	public String getRecordingId() {
		return recordingId;
	}

	public void setRecordingId(String recordingId) {
		this.recordingId = recordingId;
	}

	public Date getLiveStart() {
		return liveStart;
	}

	public CourseLive setLiveStart(Date liveStart) {
		this.liveStart = liveStart;
		return this;
	}

	public Date getLiveEnd() {
		return liveEnd;
	}

	public CourseLive setLiveEnd(Date liveEnd) {
		this.liveEnd = liveEnd;
		return this;
	}


	public Integer getType() {
		return type;
	}

	public CourseLive setType(Integer type) {
		this.type = type;
		return this;
	}


	public String getAppType() {
		return appType;
	}

	public CourseLive setAppType(String appType) {
		this.appType = appType;
		return this;
	}

	public Long getUserid() {
		return userid;
	}

	public void setUserid(Long userid) {
		this.userid = userid;
	}

	@JsonSerialize(using = ShortDateSerializer.class)
	public Date getCreateTime() {
		return createTime;
	}

	public CourseLive setCreateTime(Date createTime) {
		this.createTime = createTime;
		return this;
	}

	public Integer getDeleted() {
		return deleted;
	}

	public void setDeleted(Integer deleted) {
		this.deleted = deleted;
	}

	public String getCateDirectionName() {
		return cateDirectionName;
	}

	public void setCateDirectionName(String cateDirectionName) {
		this.cateDirectionName = cateDirectionName;
	}

	@Override
	public String toString() {
		return "CourseLive{" +
				"categoryId=" + categoryId +
				", liveId='" + liveId + '\'' +
				", liveTitle='" + liveTitle + '\'' +
				", teacherName='" + teacherName + '\'' +
				", courseUrl='" + courseUrl + '\'' +
				", summary='" + summary + '\'' +
				", recordingId='" + recordingId + '\'' +
				", liveStart=" + liveStart +
				", liveEnd=" + liveEnd +
				", type=" + type +
				", appType='" + appType + '\'' +
				", userid=" + userid +
				", createTime=" + createTime +
				", deleted=" + deleted +
				", cateDirectionName='" + cateDirectionName + '\'' +
				'}';
	}
}
