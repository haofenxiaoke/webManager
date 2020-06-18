package com.kjs.common.dto.user;


import com.cloopen.rest.sdk.utils.DateUtil;

import java.util.Date;

/**
 * Created by zhenghui on 2017/2/24.
 */
public class ExportCsvForAnswerDto {
    private Integer id;
    private String userName;
    private String nickName;
    private String content;
    private String courseTitle;
    private String lectureName;
    private Date questionTime;
    private Integer replyStatus;
    private String flowerName;
    private String teacherName;
    private Date replyTime;
    private String replyContent;
    private String answers;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getUserName() {
        return userName;
    }


    public void setUserName(String userName) {
        this.userName = userName;
    }

    public String getNickName() {
        return nickName;
    }

    public void setNickName(String nickName) {this.nickName = nickName;}

    public String getContent() {
        return content.replaceAll(",","，").replaceAll("\r","").replaceAll("\n","").replaceAll("\"","“");
    }

    public void setContent(String content) {
        this.content = content;
    }

    public String getCourseTitle() {
        return courseTitle;
    }

    public void setCourseTitle(String courseTitle) {
        this.courseTitle = courseTitle;
    }

    public String getLectureName() {
        return lectureName;
    }

    public void setLectureName(String lectureName) {
        this.lectureName = lectureName;
    }

    public String getQuestionTime() {
        return DateUtil.dateToStr(questionTime,12);
    }

    public void setQuestionTime(Date questionTime) {
        this.questionTime = questionTime;
    }

    public Integer getReplyStatus() {
        return replyStatus;
    }

    public void setReplyStatus(Integer replyStatus) {
        this.replyStatus = replyStatus;
    }

    public String getFlowerName() {
        return flowerName;
    }

    public void setFlowerName(String flowerName) {
        this.flowerName = flowerName;
    }

    public String getTeacherName() {
        return teacherName;
    }

    public void setTeacherName(String teacherName) {
        this.teacherName = teacherName;
    }

    public String getReplyTime() {
        return DateUtil.dateToStr(replyTime,12);
    }

    public void setReplyTime(Date replyTime) {
        this.replyTime = replyTime;
    }

    public String getReplyContent() {
        return replyContent;
    }

    public void setReplyContent(String replyContent) {
        this.replyContent = replyContent;
    }

    public String getAnswers() {
        return answers;
    }

    public void setAnswers(String answers) {
        this.answers = answers;
    }
}
