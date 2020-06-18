package com.kjs.common.dto;

import java.util.Date;

/**
 * Created by 杨天峰 on 2017/3/29.
 */
public class LiveWatchNumDTO {
    private String titleName;
    private Integer number;
    private Date date;
    private String dateString;
    private Integer liveId;
    public LiveWatchNumDTO() {
        this.number=0;
    }

    public Integer getLiveId() {
        return liveId;
    }

    public void setLiveId(Integer liveId) {
        this.liveId = liveId;
    }

    public String getDateString() {
        return dateString;
    }

    public void setDateString(String dateString) {
        this.dateString = dateString;
    }

    public Date getDate() {
        return date;
    }


    public void setDate(Date date) {
        this.date = date;
    }

    public String getTitleName() {
        return titleName;
    }

    public void setTitleName(String titleName) {
        this.titleName = titleName;
    }

    public Integer getNumber() {
        return number;
    }

    public void setNumber(Integer number) {
        this.number = number;
    }
}
