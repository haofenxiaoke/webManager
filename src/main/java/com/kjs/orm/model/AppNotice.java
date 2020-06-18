package com.kjs.orm.model;

import com.kjs.common.bean.BaseEntity;
import org.apache.ibatis.type.Alias;

import java.util.Date;

/**
 * Created by Administrator on 2016/12/26 0026.
 */
@SuppressWarnings("serial")
@Alias( "AppNotice")
public class AppNotice extends BaseEntity {

    private String title;/*标题*/
    private String content;/*通知内容*/
    private Integer type;/*通知类型 0立即发送1定时发送*/
    private String imgurl;/*图片链接地址*/
    private Integer readAmount;/*阅读数*/
    private Date sendTime;/*发送时间*/
    private Date expiryTime;/*失效时间*/
    private Date createTime;/*创建时间*/
    private Date updateTime;/*更新时间*/
    private Integer userId;/*用户id*/


    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public Integer getType() {
        return type;
    }

    public void setType(Integer type) {
        this.type = type;
    }

    public String getImgurl() {
        return imgurl;
    }

    public void setImgurl(String imgurl) {
        this.imgurl = imgurl;
    }

    public Integer getReadAmount() {
        return readAmount;
    }

    public void setReadAmount(Integer readAmount) {
        this.readAmount = readAmount;
    }

    public Date getSendTime() {
        return sendTime;
    }

    public void setSendTime(Date sendTime) {
        this.sendTime = sendTime;
    }

    public Date getExpiryTime() {
        return expiryTime;
    }

    public void setExpiryTime(Date expiryTime) {
        this.expiryTime = expiryTime;
    }

    public Date getCreateTime() {
        return createTime;
    }

    public void setCreateTime(Date createTime) {
        this.createTime = createTime;
    }

    public Date getUpdateTime() {
        return updateTime;
    }

    public void setUpdateTime(Date updateTime) {
        this.updateTime = updateTime;
    }

    public Integer getUserId() {
        return userId;
    }

    public void setUserId(Integer userId) {
        this.userId = userId;
    }

    @Override
    public String toString() {
        return "AppNotice{" +
                "id=" + id +
                ", title='" + title + '\'' +
                ", content='" + content + '\'' +
                ", type=" + type +
                ", imgurl='" + imgurl + '\'' +
                ", readAmount=" + readAmount  +
                ", sendTime=" + sendTime +
                ", expiryTime=" + expiryTime +
                ", createTime=" + createTime +
                ", updateTime=" + updateTime +
                ", userId=" + userId +
                '}';
    }
}
