package com.kjs.common.dto;

import java.util.Date;

/**
 * Created by zhenghui on 2016/7/7.
 */
public class CourseDto {
    private Integer id; /* 主键标识 */
    private String coverUrl; /* 课程封面url */
    private Integer courseStuNum; /* 学生数 */
    private Integer score; /* 平均分 */
    private Integer lectureNum =0; /* 课程章节 */
    private Integer  finishLectureNum = 0; /* 已看章节 */
    /**
     * 标题
     */
    private String title;
    /**
     * 是否在课程券有效期内
     */
    private Boolean validStatus = false;
    private Date createTime;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getCoverUrl() {
        return coverUrl;
    }

    public void setCoverUrl(String coverUrl) {
        this.coverUrl = coverUrl;
    }

    public Integer getCourseStuNum() {
        return courseStuNum;
    }

    public void setCourseStuNum(Integer courseStuNum) {
        this.courseStuNum = courseStuNum;
    }

    public Integer getScore() {
        return score;
    }

    public void setScore(Integer score) {
        this.score = score;
    }

    public Integer getLectureNum() {
        return lectureNum;
    }

    public void setLectureNum(Integer lectureNum) {
        this.lectureNum = lectureNum;
    }

    public Integer getFinishLectureNum() {
        return finishLectureNum;
    }

    public void setFinishLectureNum(Integer finishLectureNum) {
        this.finishLectureNum = finishLectureNum;
    }

    public Date getCreateTime() {return createTime;}

    public void setCreateTime(Date createTime) {this.createTime = createTime;}

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public Boolean getValidStatus() {
        return validStatus;
    }

    public void setValidStatus(Boolean validStatus) {
        this.validStatus = validStatus;
    }

    @Override
    public String toString() {
        return "CourseDto{" +
                "id=" + id +
                ", coverUrl='" + coverUrl + '\'' +
                ", courseStuNum=" + courseStuNum +
                ", score=" + score +
                ", lectureNum=" + lectureNum +
                ", finishLectureNum=" + finishLectureNum +
                ", title='" + title + '\'' +
                ", validStatus=" + validStatus +
                ", createTime=" + createTime +
                '}';
    }
}
