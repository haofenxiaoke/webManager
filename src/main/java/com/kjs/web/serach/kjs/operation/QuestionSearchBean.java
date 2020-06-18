package com.kjs.web.serach.kjs.operation;

import com.kjs.common.bean.DataTablePageModel;
import com.kjs.common.utils.DateUtils;
import org.apache.commons.lang.StringUtils;

import java.util.Date;

/**
 * Created by 李恒名 on 2016/6/19.
 */
public class QuestionSearchBean  extends DataTablePageModel {
    private Long cateId;//方向分类id
    private Long courseId;//课程
    private Long lectureId;//当节视频id
    private Integer replyStatus;//提问回复状态 1已回复0未回复
    private String questionDateStr;
    private Date startQuestionDate;
    private Date endQuestionDate;
    private String content;//搜索内容

    @Override
    public String toString() {
        return "QuestionSearchBean{" +
                "cateId=" + cateId +
                ", courseId=" + courseId +
                ", lectureId=" + lectureId +
                ", replyStatus=" + replyStatus +
                ", questionDateStr='" + questionDateStr + '\'' +
                ", startQuestionDate=" + startQuestionDate +
                ", endQuestionDate=" + endQuestionDate +
                ", content='" + content + '\'' +
                '}';
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public Long getCateId() {
        return cateId;
    }

    public void setCateId(Long cateId) {
        this.cateId = cateId;
    }

    public Long getCourseId() {
        return courseId;
    }

    public void setCourseId(Long courseId) {
        this.courseId = courseId;
    }

    public Long getLectureId() {
        return lectureId;
    }

    public void setLectureId(Long lectureId) {
        this.lectureId = lectureId;
    }

    public Integer getReplyStatus() {
        return replyStatus;
    }

    public void setReplyStatus(Integer replyStatus) {
        this.replyStatus = replyStatus;
    }

    public String getQuestionDateStr() {
        return questionDateStr;
    }

    public void setQuestionDateStr(String questionDateStr) {
        this.questionDateStr = questionDateStr;
        if (StringUtils.isNotEmpty(questionDateStr)) {
            String date[] = questionDateStr.split("/");
            this.startQuestionDate = DateUtils.getFirstDateOfDay(DateUtils.stringtoDate(date[0]));
            this.endQuestionDate = DateUtils.getLastDateOfDay(DateUtils.stringtoDate(date[1]));
        }
    }

    public Date getStartQuestionDate() {
        return startQuestionDate;
    }

    public void setStartQuestionDate(Date startQuestionDate) {
        this.startQuestionDate = startQuestionDate;
    }

    public Date getEndQuestionDate() {
        return endQuestionDate;
    }

    public void setEndQuestionDate(Date endQuestionDate) {
        this.endQuestionDate = endQuestionDate;
    }
}