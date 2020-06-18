package com.kjs.common.dto;

import org.apache.commons.lang.StringUtils;

import java.util.Date;

/**
 * Created by 李恒名 on 2016/12/24.
 */
public class TrackDTO {
    private String title;//停留页面
    private long remain;//停留时长，单位毫秒
    private Date visit;//访问时间
    private String url;//网址
    private String firstEntryUrl;//首次进入网址


    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public long getRemain() {
        return remain;
    }

    public void setRemain(long remain) {
        this.remain = remain;
    }

    public Date getVisit() {
        return visit;
    }

    public void setVisit(Date visit) {
        this.visit = visit;
    }

    public String getUrl() {
        return url;
    }

    public void setUrl(String url) {
        this.url = url;
    }

    public String getFirstEntryUrl() {
        return firstEntryUrl;
    }

    public void setFirstEntryUrl(String firstEntryUrl) {
        this.firstEntryUrl = firstEntryUrl;
    }

    @Override
    public String toString() {
        return "TrackDTO{" +
                "title='" + title + '\'' +
                ", remain=" + remain +
                ", visit=" + visit +
                ", url='" + url + '\'' +
                '}';
    }

    public static void main(String[] args) {
        String url = "http://www.kuaijishizi.com/plan?directionId=70&industryId=49&positionId=51";
        if(StringUtils.contains(url,"positionId=")){
             url = url.substring(url.lastIndexOf("=") + 1);
            System.out.println(url);
        }

    }
}
