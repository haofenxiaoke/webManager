package com.kjs.web.serach.kjs.course;

import com.kjs.common.bean.DataTablePageModel;
import com.kjs.common.utils.DateUtils;
import org.apache.commons.lang.StringUtils;

import java.util.Date;

/**
 * Created by  on 2017/3/28.
 */
public class CourseLiveSearchBean extends DataTablePageModel {

    private Long derectionId;//方向ID
    private String courseName;//课程名称
    private String dateString;
    private Date startDate; //起始开课日期
    private Date endDate; //结束开课日期
    private Boolean liveIsOverdue;
    private String  recordingId;/*录播id*/
    private Long[] derectionIds;//方向ID数组
    private Integer liveType;//1：公开课 0：直播

    public String getDateString() {
        return dateString;
    }

    public void setDateString(String dateString) {
        this.dateString = dateString;
        if (StringUtils.isNotBlank(dateString)) {
            String date[] = dateString.split("/");
            this.startDate = DateUtils.getFirstDateOfDay(DateUtils.stringtoDate(date[0]));
            this.endDate = DateUtils.getLastDateOfDay(DateUtils.stringtoDate(date[1]));
        }
    }

    public String getRecordingId() {
        return recordingId;
    }

    public void setRecordingId(String recordingId) {
        this.recordingId = recordingId;
    }

    public Integer getLiveType() {
        return liveType;
    }

    public void setLiveType(Integer liveType) {
        this.liveType = liveType;
    }

    public Long getDerectionId() {
        return derectionId;
    }

    public void setDerectionId(Long derectionId) {
        this.derectionId = derectionId;
    }

    public String getCourseName() {
        return courseName;
    }

    public void setCourseName(String courseName) {
        this.courseName = courseName;
    }

    public Date getStartDate() {
        return startDate;
    }

    public void setStartDate(Date startDate) {
        this.startDate = startDate;
    }

    public Date getEndDate() {
        return endDate;
    }

    public void setEndDate(Date endDate) {
        this.endDate = endDate;
    }

    public Boolean getLiveIsOverdue() {
        return liveIsOverdue;
    }

    public void setLiveIsOverdue(Boolean liveIsOverdue) {
        this.liveIsOverdue = liveIsOverdue;
    }

    public Long[] getDerectionIds() {
        return derectionIds;
    }

    public void setDerectionIds(Long[] derectionIds) {
        this.derectionIds = derectionIds;
    }
}
