package com.kjs.common.dto;

import java.util.List;

/**
 * Created by 杨天峰 on 2017/3/29.
 */
public class WatchNumByDateDTO {
    private String liveTitle;
    private List<Integer> numList;
    private Integer id;
    public WatchNumByDateDTO() {
    }

    public List<Integer> getNumList() {
        return numList;
    }

    public void setNumList(List<Integer> numList) {
        this.numList = numList;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getLiveTitle() {
        return liveTitle;
    }

    public void setLiveTitle(String liveTitle) {
        this.liveTitle = liveTitle;
    }

}

