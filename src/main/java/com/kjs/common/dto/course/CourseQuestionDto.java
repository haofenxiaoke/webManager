package com.kjs.common.dto.course;

import java.util.Date;

/**
 * Created by 李恒名 on 2016/6/19.
 */
public class CourseQuestionDto {
    //连表查询字段
    private Long id;
    private String courseName;//课程名
    private String username;//用户名
    private String nickName;//昵称
    private String content;//内容
    private String lectureName;//当节视频名称
    private Date submitDate;//提交时间
    private Integer replyStatus;//回复状态 1回复0未回复

    @Override
    public String toString() {
        return "CourseQuestionDto{" +
                "id=" + id +
                ", courseName='" + courseName + '\'' +
                ", username='" + username + '\'' +
                ", nickName='" + nickName + '\'' +
                ", content='" + content + '\'' +
                ", lectureName='" + lectureName + '\'' +
                ", submitDate=" + submitDate +
                ", replyStatus=" + replyStatus +
                '}';
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getCourseName() {
        return courseName;
    }

    public void setCourseName(String courseName) {
        this.courseName = courseName;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getNickName() {
        return nickName;
    }

    public void setNickName(String nickName) {
        this.nickName = nickName;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public String getLectureName() {
        return lectureName;
    }

    public void setLectureName(String lectureName) {
        this.lectureName = lectureName;
    }

    public Date getSubmitDate() {
        return submitDate;
    }

    public void setSubmitDate(Date submitDate) {
        this.submitDate = submitDate;
    }

    public Integer getReplyStatus() {
        return replyStatus;
    }

    public void setReplyStatus(Integer replyStatus) {
        this.replyStatus = replyStatus;
    }
}
