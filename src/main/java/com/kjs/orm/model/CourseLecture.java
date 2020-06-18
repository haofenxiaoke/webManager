package com.kjs.orm.model;

import com.kjs.common.bean.BaseEntity;
import com.kjs.common.utils.ShortDateSerializer;
import org.apache.ibatis.type.Alias;
import org.codehaus.jackson.map.annotate.JsonSerialize;

import java.util.Date;

/**
 * POJO:CourseLecture
 * 
 * @author duia_builder
 * @date 2016-5-23
 */
@SuppressWarnings("serial")
@Alias("CourseLecture")
public class CourseLecture extends BaseEntity {
	
	
	private Integer	courseId;		 /* 课程id */ 
	private String	lectureName;		 /* 讲座的名称 */ 
	private Integer	lectureOrder;		 /* 讲座的顺序 */ 
	private String	lectureDesc;		 /* 讲座的描述 */ 
	private String	lecturePptUrl;		 /* 讲座pdf存放路径 */ 
	private Integer	lecturePlayNumber;		 /* 讲座播放数量 */ 
	private String	videoId;		 /* 视频id */ 
	private String	videoLength;		 /* 视频的长度 */ 
	private Integer	isvipVideo;		 /* 是否会员视频(试听) 1试听0会员 */
	private String	fileTitle;		 /* 转换前文件名称 */
	private int fileLength;/*文件大小*/
	private String	lectureConverswfUrl;		 /* 转换成html后的存量路径 */ 
	private Integer	lectureScore;		 /* 讲座平均评分 */ 
	private Integer	userId;		 /* 用户id */ 
	private Integer	publishState;		 /* 发布状态（1发布0未发布） */ 
	private Date	publishDate;		 /* 发布日期 */ 
	private Boolean	deleted;		 /* 删除标识1删除0使用 */
	private String videoUnique;/*乐视ID的唯一标识*/
	private String ccVideoUnique;/*cc视频vu 播放用*/

	// getter && setter
	// 在setter方法最后加上"return this;"并把返回参数改为CourseLecture可以实现连缀设置属性
	
	public Integer getCourseId() {
		return courseId;
	}

	public CourseLecture setCourseId(Integer courseId) {
		this.courseId = courseId;
		return this;
	}
	
	
	public String getLectureName() {
		return lectureName;
	}

	public CourseLecture setLectureName(String lectureName) {
		this.lectureName = lectureName;
		return this;
	}
	
	
	public Integer getLectureOrder() {
		return lectureOrder;
	}

	public CourseLecture setLectureOrder(Integer lectureOrder) {
		this.lectureOrder = lectureOrder;
		return this;
	}
	
	
	public String getLectureDesc() {
		return lectureDesc;
	}

	public CourseLecture setLectureDesc(String lectureDesc) {
		this.lectureDesc = lectureDesc;
		return this;
	}
	
	
	public String getLecturePptUrl() {
		return lecturePptUrl;
	}

	public CourseLecture setLecturePptUrl(String lecturePptUrl) {
		this.lecturePptUrl = lecturePptUrl;
		return this;
	}
	
	
	public Integer getLecturePlayNumber() {
		return lecturePlayNumber;
	}

	public CourseLecture setLecturePlayNumber(Integer lecturePlayNumber) {
		this.lecturePlayNumber = lecturePlayNumber;
		return this;
	}
	
	
	public String getVideoId() {
		return videoId;
	}

	public CourseLecture setVideoId(String videoId) {
		this.videoId = videoId;
		return this;
	}
	
	
	public String getVideoLength() {
		return videoLength;
	}

	public CourseLecture setVideoLength(String videoLength) {
		this.videoLength = videoLength;
		return this;
	}


	public Integer getIsvipVideo() {
		return isvipVideo;
	}

	public CourseLecture setIsvipVideo(Integer isvipVideo) {
		this.isvipVideo = isvipVideo;
		return this;
	}


	public String getFileTitle() {
		return fileTitle;
	}

	public CourseLecture setFileTitle(String fileTitle) {
		this.fileTitle = fileTitle;
		return this;
	}

	public int getFileLength() {
		return fileLength;
	}

	public void setFileLength(int fileLength) {
		this.fileLength = fileLength;
	}

	public String getLectureConverswfUrl() {
		return lectureConverswfUrl;
	}

	public CourseLecture setLectureConverswfUrl(String lectureConverswfUrl) {
		this.lectureConverswfUrl = lectureConverswfUrl;
		return this;
	}
	
	
	public Integer getLectureScore() {
		return lectureScore;
	}

	public CourseLecture setLectureScore(Integer lectureScore) {
		this.lectureScore = lectureScore;
		return this;
	}
	
	
	public Integer getUserId() {
		return userId;
	}

	public CourseLecture setUserId(Integer userId) {
		this.userId = userId;
		return this;
	}
	
	
	public Integer getPublishState() {
		return publishState;
	}

	public CourseLecture setPublishState(Integer publishState) {
		this.publishState = publishState;
		return this;
	}
	
	@JsonSerialize(using = ShortDateSerializer.class)
	public Date getPublishDate() {
		return publishDate;
	}

	public CourseLecture setPublishDate(Date publishDate) {
		this.publishDate = publishDate;
		return this;
	}
	
	
	public Boolean getDeleted() {
		return deleted;
	}

	public CourseLecture setDeleted(Boolean deleted) {
		this.deleted = deleted;
		return this;
	}

	public String getVideoUnique() {
		return videoUnique;
	}

	public void setVideoUnique(String videoUnique) {
		this.videoUnique = videoUnique;
	}

	public String getCcVideoUnique() {
		return ccVideoUnique;
	}

	public void setCcVideoUnique(String ccVideoUnique) {
		this.ccVideoUnique = ccVideoUnique;
	}

	@Override
	public String toString() {
		return "CourseLecture{" +
				"courseId=" + courseId +
				", lectureName='" + lectureName + '\'' +
				", lectureOrder=" + lectureOrder +
				", lectureDesc='" + lectureDesc + '\'' +
				", lecturePptUrl='" + lecturePptUrl + '\'' +
				", lecturePlayNumber=" + lecturePlayNumber +
				", videoId='" + videoId + '\'' +
				", videoLength='" + videoLength + '\'' +
				", isvipVideo=" + isvipVideo +
				", fileTitle='" + fileTitle + '\'' +
				", fileLength=" + fileLength +
				", lectureConverswfUrl='" + lectureConverswfUrl + '\'' +
				", lectureScore=" + lectureScore +
				", userId=" + userId +
				", publishState=" + publishState +
				", publishDate=" + publishDate +
				", deleted=" + deleted +
				", videoUnique='" + videoUnique + '\'' +
				", ccVideoUnique='" + ccVideoUnique + '\'' +
				'}';
	}
}
