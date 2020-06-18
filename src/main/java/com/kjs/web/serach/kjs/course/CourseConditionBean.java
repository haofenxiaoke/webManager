package com.kjs.web.serach.kjs.course;

import com.kjs.common.bean.DataTablePageModel;
import com.kjs.common.utils.DateUtils;
import org.apache.commons.lang.StringUtils;

import java.util.Arrays;
import java.util.Date;

/**
 * Created by Administrator on 2016/6/8 0008.
 */
public class CourseConditionBean extends DataTablePageModel {

    private String	title;		 /* 标题 */
    private Integer orderIndex;
    private Integer	publishState;		 /* 课程的发布状态（1已发布0未发布） */
    private Date publishTime;		 /* 课程发布时间 */
    private String createDate;/*课程创建时间*/
    private Integer	directionId;		 /* 方向id */
    private Integer onlineState;
    private Long[] derectionIds;//方向ID数组
    private String updateDate;//更新时间
    private Date startUpdateDate;//更新时间的起始时间
    private Date endUpdateDate;//更新时间的终止时间

    public Long[] getDerectionIds() {
        return derectionIds;
    }

    public void setDerectionIds(Long[] derectionIds) {
        this.derectionIds = derectionIds;
    }

    public String getTitle() {
        return title;
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

    public Date getPublishTime() {
        return publishTime;
    }

    public void setPublishTime(Date publishTime) {
        this.publishTime = publishTime;
    }

    public String getCreateDate() {
        return createDate;
    }

    public void setCreateDate(String createDate) {
        this.createDate = createDate;
    }

    public Integer getDirectionId() {
        return directionId;
    }

    public void setDirectionId(Integer directionId) {
        this.directionId = directionId;
    }

    public Integer getOnlineState() {
        return onlineState;
    }

    public String getUpdateDate() {

        return updateDate;
    }

    public void setUpdateDate(String updateDate) {
        this.updateDate = updateDate;
        if(StringUtils.isNotBlank(updateDate)){
            String date[] =   updateDate.split("/");
            this.startUpdateDate =  DateUtils.getFirstDateOfDay(DateUtils.stringtoDate(date[0]));
            this.endUpdateDate=  DateUtils.getLastDateOfDay(DateUtils.stringtoDate(date[1]));
        }
    }

    public void setOnlineState(Integer onlineState) {
        this.onlineState = onlineState;
    }

    public Date getStartUpdateDate() {
        return startUpdateDate;
    }

    public void setStartUpdateDate(Date startUpdateDate) {
        this.startUpdateDate = startUpdateDate;
    }

    public Date getEndUpdateDate() {
        return endUpdateDate;
    }

    public void setEndUpdateDate(Date endUpdateDate) {
        this.endUpdateDate = endUpdateDate;
    }

    @Override
    public String toString() {
        return "CourseConditionBean{" +
                "title='" + title + '\'' +
                ", publishState=" + publishState +
                ", publishTime=" + publishTime +
                ", createDate='" + createDate + '\'' +
                ", directionId=" + directionId +
                ", onlineState=" + onlineState +
                ", derectionIds=" + Arrays.toString(derectionIds) +
                ", updateDate=" + updateDate +
                ", startUpdateDate=" + startUpdateDate +
                ", endUpdateDate=" + endUpdateDate +
                '}';
    }

	public Integer getOrderIndex() {
		return orderIndex;
	}

	public void setOrderIndex(Integer orderIndex) {
		this.orderIndex = orderIndex;
	}
}
