package com.kjs.common.dto.course;

import java.util.Date;

/**
 * Created by Administrator on 2016/5/30 0030.
 */
public class CourseBaseDto {
    private int id;
    private int orderIndex;  //课程顺序
    private int directionId; //方向ID
    private String industryId;//行业ID
    private String positionId;//职位ID
    private String title;     //标题
    private String  courseAdvantage;//课程优势
    private String learningIdeas;//学习思路
    private float score;//评分基数
    private int scoreNum;//评分人数基数
    private int coursePlayNumber;//观看视频人数基数
    private int courseStuNum;//课程购买人数基数
    private float dayLength;//建议学习天数
    private int version ;  //课程版本号
    private int preCourseId;//课程原始版本id号
    private String practiceSid;//实操做账入口sid,多个用英文逗号隔开
    private int dayHours;//建议每天学习时长数
    private int dayLecture;//建议每天学习章节数
    private int dayNode;//建议每天学习的资料章节数
    private String coverUrl;//课程封面url
    private Integer publishUserid;/*审核人id*/
    private int publishState;//课程的发布状态
    private Date  publishTime;//课程发布时间
    private Date publishCancelTime;//课程取消发布时间
    private Integer onlineState;//课程的在线状态0下线 1 在线
    private Date createDate;//课程创建时间
    private Date updateDate;//课程更新时间
    private int userid;//创建课程用户ID
    
    public String getLearningIdeas() {
        return learningIdeas;
    }

    public void setLearningIdeas(String learningIdeas) {
        this.learningIdeas = learningIdeas;
    }


    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getDirectionId() {
        return directionId;
    }

    public void setDirectionId(int directionId) {
        this.directionId = directionId;
    }

    public String getIndustryId() {
        return industryId;
    }

    public void setIndustryID(String industryId) {
        this.industryId = industryId;
    }

    public String getPositionId() {
        return positionId;
    }

    public void setPositionId(String positionId) {
        this.positionId = positionId;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getCourseAdvantage() {
        return courseAdvantage;
    }

    public void setCourseAdvantage(String courseAdvantage) {
        this.courseAdvantage = courseAdvantage;
    }



    public float getScore() {
        return score;
    }

    public void setScore(float score) {
        this.score = score;
    }

    public int getCourseStuNum() {
        return courseStuNum;
    }

    public void setCourseStuNum(int courseStuNum) {
        this.courseStuNum = courseStuNum;
    }

    public float getDayLength() {
        return dayLength;
    }

    public void setDayLength(float dayLength) {
        this.dayLength = dayLength;
    }

    public int getDayHours() {
        return dayHours;
    }

    public void setDayHours(int dayHours) {
        this.dayHours = dayHours;
    }

    public int getDayLecture() {
        return dayLecture;
    }

    public void setDayLecture(int dayLecture) {
        this.dayLecture = dayLecture;
    }

    public int getDayNode() {
        return dayNode;
    }

    public void setDayNode(int dayNode) {
        this.dayNode = dayNode;
    }

    public String getCoverUrl() {
        return coverUrl;
    }

    public void setCoverUrl(String coverUrl) {
        this.coverUrl = coverUrl;
    }

    public int getScoreNum() {
        return scoreNum;
    }

    public void setScoreNum(int scoreNum) {
        this.scoreNum = scoreNum;
    }

    public int getPublishState() {
        return publishState;
    }

    public void setPublishState(int publishState) {
        this.publishState = publishState;
    }

    public Date getPublishTime() {
        return publishTime;
    }

    public void setPublishTime(Date publishTime) {
        this.publishTime = publishTime;
    }

    public Date getPublishCancelTime() {
        return publishCancelTime;
    }

    public void setPublishCancelTime(Date publishCancelTime) {
        this.publishCancelTime = publishCancelTime;
    }

    public Date getCreateDate() {
        return createDate;
    }

    public void setCreateDate(Date createDate) {
        this.createDate = createDate;
    }

    public Integer getPublishUserid() {
        return publishUserid;
    }

    public void setPublishUserid(Integer publishUserid) {
        this.publishUserid = publishUserid;
    }

    public Date getUpdateDate() {
        return updateDate;
    }

    public void setUpdateDate(Date updateDate) {
        this.updateDate = updateDate;
    }

    public int getUserid() {
        return userid;
    }

    public void setUserid(int userid) {
        this.userid = userid;
    }

    public void setIndustryId(String industryId) {
        this.industryId = industryId;
    }

    public int getCoursePlayNumber() {
        return coursePlayNumber;
    }

    public void setCoursePlayNumber(int coursePlayNumber) {
        this.coursePlayNumber = coursePlayNumber;
    }

    public int getVersion() {
        return version;
    }

    public void setVersion(int version) {
        this.version = version;
    }

    public int getPreCourseId() {
        return preCourseId;
    }

    public void setPreCourseId(int preCourseId) {
        this.preCourseId = preCourseId;
    }

    public Integer getOnlineState() {
        return onlineState;
    }

    public void setOnlineState(Integer onlineState) {
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
		return "CourseBaseDto [id=" + id + ", orderIndex=" + orderIndex + ", directionId=" + directionId
				+ ", industryId=" + industryId + ", positionId=" + positionId + ", title=" + title
				+ ", courseAdvantage=" + courseAdvantage + ", learningIdeas=" + learningIdeas + ", score=" + score
				+ ", scoreNum=" + scoreNum + ", coursePlayNumber=" + coursePlayNumber + ", courseStuNum=" + courseStuNum
				+ ", dayLength=" + dayLength + ", version=" + version + ", preCourseId=" + preCourseId
				+ ", practiceSid=" + practiceSid + ", dayHours=" + dayHours + ", dayLecture=" + dayLecture
				+ ", dayNode=" + dayNode + ", coverUrl=" + coverUrl + ", publishUserid=" + publishUserid
				+ ", publishState=" + publishState + ", publishTime=" + publishTime + ", publishCancelTime="
				+ publishCancelTime + ", onlineState=" + onlineState + ", createDate=" + createDate + ", updateDate="
				+ updateDate + ", userid=" + userid + ", getLearningIdeas()=" + getLearningIdeas() + ", getId()="
				+ getId() + ", getDirectionId()=" + getDirectionId() + ", getIndustryId()=" + getIndustryId()
				+ ", getPositionId()=" + getPositionId() + ", getTitle()=" + getTitle() + ", getCourseAdvantage()="
				+ getCourseAdvantage() + ", getScore()=" + getScore() + ", getCourseStuNum()=" + getCourseStuNum()
				+ ", getDayLength()=" + getDayLength() + ", getDayHours()=" + getDayHours() + ", getDayLecture()="
				+ getDayLecture() + ", getDayNode()=" + getDayNode() + ", getCoverUrl()=" + getCoverUrl()
				+ ", getScoreNum()=" + getScoreNum() + ", getPublishState()=" + getPublishState()
				+ ", getPublishTime()=" + getPublishTime() + ", getPublishCancelTime()=" + getPublishCancelTime()
				+ ", getCreateDate()=" + getCreateDate() + ", getPublishUserid()=" + getPublishUserid()
				+ ", getUpdateDate()=" + getUpdateDate() + ", getUserid()=" + getUserid() + ", getCoursePlayNumber()="
				+ getCoursePlayNumber() + ", getVersion()=" + getVersion() + ", getPreCourseId()=" + getPreCourseId()
				+ ", getOnlineState()=" + getOnlineState() + ", getPracticeSid()=" + getPracticeSid()
				+ ", getOrderIndex()=" + getOrderIndex() + ", getClass()=" + getClass() + ", hashCode()=" + hashCode()
				+ ", toString()=" + super.toString() + "]";
	}

	public int getOrderIndex() {
		return orderIndex;
	}

	public void setOrderIndex(int orderIndex) {
		this.orderIndex = orderIndex;
	}
}
