package com.kjs.web.serach.kjs.course;

import com.kjs.common.bean.DataTablePageModel;

import java.util.Date;

/**
 * Created by Administrator on 2016/6/3 0003.
 */
public class CourseSearchBean extends DataTablePageModel {
    private int id;/*课程id*/
    private int orderIndex; /*课程顺序*/
    private String	title;		 /* 标题 */
    private Integer	publishState;		 /* 课程的发布状态（1已发布0未发布） */
    private Date publishTime;		 /* 课程发布时间 */
    private Integer	userid;		 /* 作者id */
    private String authorName;        /*作者*/
    private int publishUserid;/*审核人id*/
    private String publishUserName;/*审核人姓名*/
    private String   examineUserName; /*审核人*/
    private Integer  positionId;		 /* 职位id */
    private String positionName;/*职位名称*/
    private Date createDate;/*课程创建时间*/
    private Integer	directionId;		 /* 方向id */
    private String directionName;/*方向名称*/
    private Integer version;/*版本号*/
    private Integer onlineState; /*在线状态*/

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getPublishUserid() {
        return publishUserid;
    }

    public void setPublishUserid(int publishUserid) {
        this.publishUserid = publishUserid;
    }

    public String getPublishUserName() {
        return publishUserName;
    }

    public void setPublishUserName(String publishUserName) {
        this.publishUserName = publishUserName;
    }

    public String getExamineUserName() {
        return examineUserName;
    }

    public void setExamineUserName(String examineUserName) {
        this.examineUserName = examineUserName;
    }

    public Date getPublishTime() {
        return publishTime;
    }

    public void setPublishTime(Date publishTime) {
        this.publishTime = publishTime;
    }

    public String getPositionName() {
        return positionName;
    }

    public void setPositionName(String positionName) {
        this.positionName = positionName;
    }

    public String getDirectionName() {
        return directionName;
    }

    public void setDirectionName(String directionName) {
        this.directionName = directionName;
    }

    public String getTitle() {
        return title;
    }

    public Date getCreateDate() {
        return createDate;
    }

    public void setCreateDate(Date createDate) {
        this.createDate = createDate;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public Integer getPublishState() {
        return publishState;
    }

    public void setPublishState(Integer publishState) {
        this.publishState = publishState;
    }

    public Integer getUserid() {
        return userid;
    }

    public void setUserid(Integer userid) {
        this.userid = userid;
    }

    public Integer getPositionId() {
        return positionId;
    }

    public void setPositionId(Integer positionId) {
        this.positionId = positionId;
    }

    public Integer getDirectionId() {
        return directionId;
    }

    public void setDirectionId(Integer directionId) {
        this.directionId = directionId;
    }


    public String getAuthorName() {
        return authorName;
    }

    public void setAuthorName(String authorName) {
        this.authorName = authorName;
    }

    public Integer getVersion() {
        return version;
    }

    public void setVersion(Integer version) {
        this.version = version;
    }

    public Integer getOnlineState() {
        return onlineState;
    }

    public void setOnlineState(Integer onlineState) {
        this.onlineState = onlineState;
    }

    @Override
	public String toString() {
		return "CourseSearchBean [id=" + id + ", orderIndex=" + orderIndex + ", title=" + title + ", publishState="
				+ publishState + ", publishTime=" + publishTime + ", userid=" + userid + ", authorName=" + authorName
				+ ", publishUserid=" + publishUserid + ", publishUserName=" + publishUserName + ", examineUserName="
				+ examineUserName + ", positionId=" + positionId + ", positionName=" + positionName + ", createDate="
				+ createDate + ", directionId=" + directionId + ", directionName=" + directionName + ", version="
				+ version + ", onlineState=" + onlineState + ", getId()=" + getId() + ", getPublishUserid()="
				+ getPublishUserid() + ", getPublishUserName()=" + getPublishUserName() + ", getExamineUserName()="
				+ getExamineUserName() + ", getPublishTime()=" + getPublishTime() + ", getPositionName()="
				+ getPositionName() + ", getDirectionName()=" + getDirectionName() + ", getTitle()=" + getTitle()
				+ ", getCreateDate()=" + getCreateDate() + ", getPublishState()=" + getPublishState() + ", getUserid()="
				+ getUserid() + ", getPositionId()=" + getPositionId() + ", getDirectionId()=" + getDirectionId()
				+ ", getAuthorName()=" + getAuthorName() + ", getVersion()=" + getVersion() + ", getOnlineState()="
				+ getOnlineState() + ", getOrderIndex()=" + getOrderIndex() + ", getDraw()=" + getDraw()
				+ ", getStart()=" + getStart() + ", getLength()=" + getLength() + ", getData()=" + getData()
				+ ", getRecordsTotal()=" + getRecordsTotal() + ", getRecordsFiltered()=" + getRecordsFiltered()
				+ ", getError()=" + getError() + ", toString()=" + super.toString() + ", getTotalPage()="
				+ getTotalPage() + ", getTotalResult()=" + getTotalResult() + ", getCurrentPage()=" + getCurrentPage()
				+ ", getCurrentIndex()=" + getCurrentIndex() + ", getShowCount()=" + getShowCount() + ", getResult()="
				+ getResult() + ", getClass()=" + getClass() + ", hashCode()=" + hashCode() + "]";
	}

	public int getOrderIndex() {
		return orderIndex;
	}

	public void setOrderIndex(int orderIndex) {
		this.orderIndex = orderIndex;
	}
}
