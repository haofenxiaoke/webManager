package com.kjs.orm.model;

import com.kjs.common.bean.BaseEntity;
import org.apache.ibatis.type.Alias;

import java.util.Date;

/**
 * Created by Administrator on 2016/12/29 0029.
 */
@SuppressWarnings("serial")
@Alias( "AppCarousel")
public class AppCarousel extends BaseEntity {
    private Integer orderNum;
    private String pathUrl;
    private Date createTime;
    private Integer createUserid;
    private Date  lastUpdateTime;
    private Integer lastUpdateUserid;
    private String hrefUrl;
    private String bgcolor;
    private Integer type;
    public Integer getOrderNum() {
        return orderNum;
    }

    public void setOrderNum(Integer orderNum) {
        this.orderNum = orderNum;
    }

    public String getPathUrl() {
        return pathUrl;
    }

    public void setPathUrl(String pathUrl) {
        this.pathUrl = pathUrl;
    }

    public Date getCreateTime() {
        return createTime;
    }

    public void setCreateTime(Date createTime) {
        this.createTime = createTime;
    }

    public Integer getCreateUserid() {
        return createUserid;
    }

    public void setCreateUserid(Integer createUserid) {
        this.createUserid = createUserid;
    }

    public Date getLastUpdateTime() {
        return lastUpdateTime;
    }

    public void setLastUpdateTime(Date lastUpdateTime) {
        this.lastUpdateTime = lastUpdateTime;
    }

    public Integer getLastUpdateUserid() {
        return lastUpdateUserid;
    }

    public void setLastUpdateUserid(Integer lastUpdateUserid) {
        this.lastUpdateUserid = lastUpdateUserid;
    }

    public String getHrefUrl() {
        return hrefUrl;
    }

    public void setHrefUrl(String hrefUrl) {
        this.hrefUrl = hrefUrl;
    }

    public String getBgcolor() {
        return bgcolor;
    }

    public void setBgcolor(String bgcolor) {
        this.bgcolor = bgcolor;
    }

    public Integer getType() {
        return type;
    }

    public void setType(Integer type) {
        this.type = type;
    }

    @Override
    public String toString() {
        return "AppCarousel{" +
                "orderNum=" + orderNum +
                ", pathUrl='" + pathUrl + '\'' +
                ", createTime=" + createTime +
                ", createUserid=" + createUserid +
                ", lastUpdateTime=" + lastUpdateTime +
                ", lastUpdateUserid=" + lastUpdateUserid +
                ", hrefUrl='" + hrefUrl + '\'' +
                ", bgcolor='" + bgcolor + '\'' +
                ", type='" + type + '\'' +
                '}';
    }
}
