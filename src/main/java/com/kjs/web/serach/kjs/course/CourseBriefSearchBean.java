package com.kjs.web.serach.kjs.course;

import com.kjs.common.bean.DataTablePageModel;

/**
 * Created by Administrator on 2016/6/17 0017.
 */
public class CourseBriefSearchBean extends DataTablePageModel {
    private int id;  /*id*/
    private int courseId;/*课程id*/
    private String summary;/*课程介绍*/
    private String jobDuty;/*岗位职责*/
    private Integer teacherId;/*老师id*/
    private String teacherBrief;/*老师介绍*/
    private String createDate;/*创建日期*/
    private String updateDate;/*更新日期*/
    private int deletes;/*删除标记位*/

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getCourseId() {
        return courseId;
    }

    public void setCourseId(int courseId) {
        this.courseId = courseId;
    }

    public String getSummary() {
        return summary;
    }

    public void setSummary(String summary) {
        this.summary = summary;
    }

    public String getJobDuty() {
        return jobDuty;
    }

    public void setJobDuty(String jobDuty) {
        this.jobDuty = jobDuty;
    }

    public Integer getTeacherId() {
        return teacherId;
    }

    public void setTeacherId(Integer teacherId) {
        this.teacherId = teacherId;
    }

    public String getTeacherBrief() {
        return teacherBrief;
    }

    public void setTeacherBrief(String teacherBrief) {
        this.teacherBrief = teacherBrief;
    }

    public String getCreateDate() {
        return createDate;
    }

    public void setCreateDate(String createDate) {
        this.createDate = createDate;
    }

    public String getUpdateDate() {
        return updateDate;
    }

    public void setUpdateDate(String updateDate) {
        this.updateDate = updateDate;
    }

    public int getDeletes() {
        return deletes;
    }

    public void setDeletes(int deletes) {
        this.deletes = deletes;
    }

    @Override
    public String toString() {
        return "CourseBriefSearchBean{" +
                "id=" + id +
                ", courseId=" + courseId +
                ", summary='" + summary + '\'' +
                ", jobDuty='" + jobDuty + '\'' +
                ", teacherId=" + teacherId +
                ", teacherBrief='" + teacherBrief + '\'' +
                ", createDate='" + createDate + '\'' +
                ", updateDate='" + updateDate + '\'' +
                ", deletes=" + deletes +
                '}';
    }
}
