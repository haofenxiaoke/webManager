package com.kjs.orm.model;

import com.kjs.common.bean.BaseEntity;
import com.kjs.common.utils.ShortDateSerializer;
import org.apache.ibatis.type.Alias;
import org.codehaus.jackson.map.annotate.JsonSerialize;

import java.util.Date;
import java.util.List;

/**
 * POJO:CourseQuestion
 * 
 * @author duia_builder
 * @date 2016-5-23
 */
@SuppressWarnings("serial")
@Alias("CourseQuestion")
public class CourseQuestion extends BaseEntity {
	
	
	private Integer	lectureId;		 /* 视频id */ 
	private Integer	courseId;		 /* 课程id */ 
	private String	questions;		 /* 提问问题 */ 
	private Integer	userid;		 /* 提问人 */
	private Date	questionTime;		 /* 提问时间 */ 
	private Integer	replyNum;		 /* 回复次数 */ 
	private Integer	state;		 /* 是否回复(1是0否) */
	private Integer	hotTop;		 /* 热度置顶(1是0否) */ 
	private Integer	topUserid;		 /* 置顶操作人 */ 
	private Date	topTime;		 /* 置顶时间 */

	//连表字段
	private String nickName;//昵称
	private List<CourseQuestionReply>	replyList;//该问题下的回复列表
	// getter && setter
	// 在setter方法最后加上"return this;"并把返回参数改为CourseQuestion可以实现连缀设置属性
	
	public Integer getLectureId() {
		return lectureId;
	}

	public CourseQuestion setLectureId(Integer lectureId) {
		this.lectureId = lectureId;
		return this;
	}
	
	
	public Integer getcourseId() {
		return courseId;
	}

	public CourseQuestion setcourseId(Integer courseId) {
		this.courseId = courseId;
		return this;
	}
	
	
	public String getQuestions() {
		return questions;
	}

	public CourseQuestion setQuestions(String questions) {
		this.questions = questions;
		return this;
	}
	
	
	public Integer getUserid() {
		return userid;
	}

	public CourseQuestion setUserid(Integer userid) {
		this.userid = userid;
		return this;
	}
	
	@JsonSerialize(using = ShortDateSerializer.class)
	public Date getQuestionTime() {
		return questionTime;
	}

	public CourseQuestion setQuestionTime(Date questionTime) {
		this.questionTime = questionTime;
		return this;
	}
	
	
	public Integer getReplyNum() {
		return replyNum;
	}

	public CourseQuestion setReplyNum(Integer replyNum) {
		this.replyNum = replyNum;
		return this;
	}
	
	
	public Integer getState() {
		return state;
	}

	public CourseQuestion setState(Integer state) {
		this.state = state;
		return this;
	}
	
	
	public Integer getHotTop() {
		return hotTop;
	}

	public CourseQuestion setHotTop(Integer hotTop) {
		this.hotTop = hotTop;
		return this;
	}
	
	
	public Integer getTopUserid() {
		return topUserid;
	}

	public CourseQuestion setTopUserid(Integer topUserid) {
		this.topUserid = topUserid;
		return this;
	}
	
	@JsonSerialize(using = ShortDateSerializer.class)
	public Date getTopTime() {
		return topTime;
	}

	public CourseQuestion setTopTime(Date topTime) {
		this.topTime = topTime;
		return this;
	}

	public List<CourseQuestionReply> getReplyList() {
		return replyList;
	}

	public void setReplyList(List<CourseQuestionReply> replyList) {
		this.replyList = replyList;
	}

	public String getNickName() {
		return nickName;
	}

	public void setNickName(String nickName) {
		this.nickName = nickName;
	}

	@Override
	public String toString() {
		return "CourseQuestion [" + "id=" + getId() + ", lectureId=" + lectureId + ", courseId=" + courseId + ", questions=" + questions + ", userid=" + userid + ", questionTime=" + questionTime + ", replyNum=" + replyNum + ", state=" + state + ", hotTop=" + hotTop + ", topUserid=" + topUserid + ", topTime=" + topTime +  "]";
	}
}
