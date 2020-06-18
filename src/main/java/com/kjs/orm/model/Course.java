package com.kjs.orm.model;

import com.kjs.common.bean.BaseEntity;
import com.kjs.common.utils.ShortDateSerializer;
import org.apache.ibatis.type.Alias;
import org.codehaus.jackson.map.annotate.JsonSerialize;

import java.util.Date;

/**
 * POJO:Course
 * 
 * @author duia_builder
 * @date 2016-5-23
 */
@SuppressWarnings("serial")
@Alias("Course")
public class Course extends BaseEntity {
	
	
	private String	title;		 /* 标题 */ 
	private String	subtitle;		 /* 副标题 */ 
	private Integer	orderIndex;		 /* 课程的顺序 */ 
	private String	summary;		 /* 课程简介 */ 
	private String	coverUrl;		 /* 课程封面url */
	private Integer	publishState;		 /* 课程的发布状态（1已发布0未发布） */
	private Date	publishTime;		 /* 课程发布时间 */ 
	private Date	publishCancelTime;		 /* 课程取消发布时间 */
	private int publishUserid;      /*课程审核人id*/
	private Integer	userid;		 /* 作者id */ 
	private String	authorName;		 /* 课程作者名称 */ 
	private String	authorHeadline;		 /* 课程作者的头衔 */ 
	private String	authorPic;		 /* 课程作者头像URL */ 
	private Integer	score;		 /* 课程的评价分数（评分基数） */
	private Integer scoreNum;      /*课程评分人数基数*/
	private Integer	coursePlayNumber;		 /* 课程播放数量 */ 
	private Integer	courseStuNum;		 /* 课程学生数（购买基数） */ 
	private float	dayLength;		 /* 建议天数 */ 
	private Integer	dayHours;		 /* 建议时长 */ 
	private Integer	dayLecture;		 /* 建议节数 */ 
	private Integer	dayNode;		 /* 建议资料节数 */ 
	private String	learningIdeas;		 /* 学习思路 */
	private Integer	positionId;		 /* 职位id */ 
	private Integer	directionId;		 /* 方向id */
	private Integer    preCourseId;     /*上一版本课程的唯一标识*/
	private Integer version;      /*课程版本号*/
	private Date	createDate;		 /* 创建时间 */ 
	private Date	updateDate;		 /* 更新时间 */ 
	private int	deleted;		 /* 删除标识1删除0使用 */
	private int onlineState;     /*课程的在线状态0下线1上线*/
	private String practiceSid; /*实操做账入口sid*/

	// getter && setter
	// 在setter方法最后加上"return this;"并把返回参数改为Course可以实现连缀设置属性
	
	public String getTitle() {
		return title;
	}

	public Course setTitle(String title) {
		this.title = title;
		return this;
	}
	
	
	public String getSubtitle() {
		return subtitle;
	}

	public Course setSubtitle(String subtitle) {
		this.subtitle = subtitle;
		return this;
	}
	
	
	public Integer getOrderIndex() {
		return orderIndex;
	}

	public Course setOrderIndex(Integer orderIndex) {
		this.orderIndex = orderIndex;
		return this;
	}
	
	
	public String getSummary() {
		return summary;
	}

	public Course setSummary(String summary) {
		this.summary = summary;
		return this;
	}
	
	
	public String getCoverUrl() {
		return coverUrl;
	}

	public Course setCoverUrl(String coverUrl) {
		this.coverUrl = coverUrl;
		return this;
	}
	
	
	public Integer getPublishState() {
		return publishState;
	}

	public Course setPublishState(Integer publishState) {
		this.publishState = publishState;
		return this;
	}
	
	@JsonSerialize(using = ShortDateSerializer.class)
	public Date getPublishTime() {
		return publishTime;
	}

	public Course setPublishTime(Date publishTime) {
		this.publishTime = publishTime;
		return this;
	}

	public int getPublishUserid() {
		return publishUserid;
	}

	public void setPublishUserid(int publishUserid) {
		this.publishUserid = publishUserid;
	}

	public Integer getScoreNum() {
		return scoreNum;
	}

	public void setScoreNum(Integer scoreNum) {
		this.scoreNum = scoreNum;
	}

	@JsonSerialize(using = ShortDateSerializer.class)
	public Date getPublishCancelTime() {
		return publishCancelTime;
	}

	public Course setPublishCancelTime(Date publishCancelTime) {
		this.publishCancelTime = publishCancelTime;
		return this;
	}
	
	
	public Integer getUserid() {
		return userid;
	}

	public Course setUserid(Integer userid) {
		this.userid = userid;
		return this;
	}
	
	
	public String getAuthorName() {
		return authorName;
	}

	public Course setAuthorName(String authorName) {
		this.authorName = authorName;
		return this;
	}
	
	
	public String getAuthorHeadline() {
		return authorHeadline;
	}

	public Course setAuthorHeadline(String authorHeadline) {
		this.authorHeadline = authorHeadline;
		return this;
	}
	
	
	public String getAuthorPic() {
		return authorPic;
	}

	public Course setAuthorPic(String authorPic) {
		this.authorPic = authorPic;
		return this;
	}
	
	
	public Integer getScore() {
		return score;
	}

	public Course setScore(Integer score) {
		this.score = score;
		return this;
	}
	
	
	public Integer getCoursePlayNumber() {
		return coursePlayNumber;
	}

	public Course setCoursePlayNumber(Integer coursePlayNumber) {
		this.coursePlayNumber = coursePlayNumber;
		return this;
	}
	
	
	public Integer getCourseStuNum() {
		return courseStuNum;
	}

	public Course setCourseStuNum(Integer courseStuNum) {
		this.courseStuNum = courseStuNum;
		return this;
	}
	
	
	public float getDayLength() {
		return dayLength;
	}

	public Course setDayLength(float dayLength) {
		this.dayLength = dayLength;
		return this;
	}
	
	
	public Integer getDayHours() {
		return dayHours;
	}

	public Course setDayHours(Integer dayHours) {
		this.dayHours = dayHours;
		return this;
	}
	
	
	public Integer getDayLecture() {
		return dayLecture;
	}

	public Course setDayLecture(Integer dayLecture) {
		this.dayLecture = dayLecture;
		return this;
	}
	
	
	public Integer getDayNode() {
		return dayNode;
	}

	public Course setDayNode(Integer dayNode) {
		this.dayNode = dayNode;
		return this;
	}
	
	
	public String getLearningIdeas() {
		return learningIdeas;
	}

	public Course setLearningIdeas(String learningIdeas) {
		this.learningIdeas = learningIdeas;
		return this;
	}
	
	
	public Integer getPositionId() {
		return positionId;
	}

	public Course setPositionId(Integer positionId) {
		this.positionId = positionId;
		return this;
	}
	
	
	public Integer getDirectionId() {
		return directionId;
	}

	public Course setDirectionId(Integer directionId) {
		this.directionId = directionId;
		return this;
	}
	public Integer getVersion() {
		return version;
	}

	public void setVersion(Integer version) {
		this.version = version;
	}

	public Integer getPreCourseId() {
		return preCourseId;
	}

	public void setPreCourseId(Integer preCourseId) {
		this.preCourseId = preCourseId;
	}
	
	@JsonSerialize(using = ShortDateSerializer.class)
	public Date getCreateDate() {
		return createDate;
	}

	public Course setCreateDate(Date createDate) {
		this.createDate = createDate;
		return this;
	}
	
	@JsonSerialize(using = ShortDateSerializer.class)
	public Date getUpdateDate() {
		return updateDate;
	}

	public Course setUpdateDate(Date updateDate) {
		this.updateDate = updateDate;
		return this;
	}
	
	
	public int getDeleted() {
		return deleted;
	}

	public Course setDeleted(int deleted) {
		this.deleted = deleted;
		return this;
	}

	public int getOnlineState() {
		return onlineState;
	}

	public void setOnlineState(int onlineState) {
		this.onlineState = onlineState;
	}

	public String getPracticeSid() {
		return practiceSid;
	}

	public void setPracticeSid(String practiceSid) {
		this.practiceSid = practiceSid;
	}

	@Override
	public String toString() {
		return "Course{" +
				"title='" + title + '\'' +
				", subtitle='" + subtitle + '\'' +
				", orderIndex=" + orderIndex +
				", summary='" + summary + '\'' +
				", coverUrl='" + coverUrl + '\'' +
				", publishState=" + publishState +
				", publishTime=" + publishTime +
				", publishCancelTime=" + publishCancelTime +
				", publishUserid=" + publishUserid +
				", userid=" + userid +
				", authorName='" + authorName + '\'' +
				", authorHeadline='" + authorHeadline + '\'' +
				", authorPic='" + authorPic + '\'' +
				", score=" + score +
				", scoreNum=" + scoreNum +
				", coursePlayNumber=" + coursePlayNumber +
				", courseStuNum=" + courseStuNum +
				", dayLength=" + dayLength +
				", dayHours=" + dayHours +
				", dayLecture=" + dayLecture +
				", dayNode=" + dayNode +
				", learningIdeas='" + learningIdeas + '\'' +
				", positionId=" + positionId +
				", directionId=" + directionId +
				", preCourseId=" + preCourseId +
				", version=" + version +
				", createDate=" + createDate +
				", updateDate=" + updateDate +
				", deleted=" + deleted +
				", onlineState=" + onlineState +
				", practiceSid=" + practiceSid +
				'}';
	}
}
