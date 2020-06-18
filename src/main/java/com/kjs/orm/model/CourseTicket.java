package com.kjs.orm.model;

import com.kjs.common.bean.BaseEntity;

import java.util.Date;

public class CourseTicket extends BaseEntity {
    private Integer id;

    private String code;

    private String commodityName;

    private Integer commodityBargainRecordId;

    private String bargainer;

    private String exchangeUserPhone;

    private Integer exchangeUserId;

    private Date validityBeginTime;

    private Date validityEndTime;

    private Integer status;

    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code == null ? null : code.trim();
    }

    public String getCommodityName() {
        return commodityName;
    }

    public void setCommodityName(String commodityName) {
        this.commodityName = commodityName == null ? null : commodityName.trim();
    }

    public Integer getCommodityBargainRecordId() {
        return commodityBargainRecordId;
    }

    public void setCommodityBargainRecordId(Integer commodityBargainRecordId) {
        this.commodityBargainRecordId = commodityBargainRecordId;
    }

    public String getBargainer() {
        return bargainer;
    }

    public void setBargainer(String bargainer) {
        this.bargainer = bargainer == null ? null : bargainer.trim();
    }

    public String getExchangeUserPhone() {
        return exchangeUserPhone;
    }

    public void setExchangeUserPhone(String exchangeUserPhone) {
        this.exchangeUserPhone = exchangeUserPhone == null ? null : exchangeUserPhone.trim();
    }

    public Integer getExchangeUserId() {
        return exchangeUserId;
    }

    public void setExchangeUserId(Integer exchangeUserId) {
        this.exchangeUserId = exchangeUserId;
    }

    public Date getValidityBeginTime() {
        return validityBeginTime;
    }

    public void setValidityBeginTime(Date validityBeginTime) {
        this.validityBeginTime = validityBeginTime;
    }

    public Date getValidityEndTime() {
        return validityEndTime;
    }

    public void setValidityEndTime(Date validityEndTime) {
        this.validityEndTime = validityEndTime;
    }

    public Integer getStatus() {
        return status;
    }

    public void setStatus(Integer status) {
        this.status = status;
    }
}