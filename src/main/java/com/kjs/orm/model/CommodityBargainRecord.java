package com.kjs.orm.model;

import com.kjs.common.bean.BaseEntity;

import java.util.Date;

public class CommodityBargainRecord extends BaseEntity {

    private String commodityName;

    private Integer directionId;

    private Integer industryId;

    private Integer courseTicketId;

    private String bargainer;

    private String bargainHelpers;

    private Date bargainBeginTime;

    private Date bargainSuccessTime;

    private Integer status;

    public String getCommodityName() {
        return commodityName;
    }

    public void setCommodityName(String commodityName) {
        this.commodityName = commodityName == null ? null : commodityName.trim();
    }

    public Integer getDirectionId() {
        return directionId;
    }

    public void setDirectionId(Integer directionId) {
        this.directionId = directionId;
    }

    public Integer getIndustryId() {
        return industryId;
    }

    public void setIndustryId(Integer industryId) {
        this.industryId = industryId;
    }

    public Integer getCourseTicketId() {
        return courseTicketId;
    }

    public void setCourseTicketId(Integer courseTicketId) {
        this.courseTicketId = courseTicketId;
    }

    public String getBargainer() {
        return bargainer;
    }

    public void setBargainer(String bargainer) {
        this.bargainer = bargainer == null ? null : bargainer.trim();
    }

    public String getBargainHelpers() {
        return bargainHelpers;
    }

    public void setBargainHelpers(String bargainHelpers) {
        this.bargainHelpers = bargainHelpers == null ? null : bargainHelpers.trim();
    }

    public Date getBargainBeginTime() {
        return bargainBeginTime;
    }

    public void setBargainBeginTime(Date bargainBeginTime) {
        this.bargainBeginTime = bargainBeginTime;
    }

    public Date getBargainSuccessTime() {
        return bargainSuccessTime;
    }

    public void setBargainSuccessTime(Date bargainSuccessTime) {
        this.bargainSuccessTime = bargainSuccessTime;
    }

    public Integer getStatus() {
        return status;
    }

    public void setStatus(Integer status) {
        this.status = status;
    }
}