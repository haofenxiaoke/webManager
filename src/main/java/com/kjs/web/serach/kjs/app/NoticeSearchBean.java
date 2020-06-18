package com.kjs.web.serach.kjs.app;

import com.kjs.common.bean.DataTablePageModel;
import com.kjs.common.utils.DateUtils;
import org.apache.commons.lang.StringUtils;
import org.apache.ibatis.type.Alias;

import java.util.Date;

/**
 * Created by Administrator on 2016/12/27 0027.
 */
public class NoticeSearchBean extends DataTablePageModel {
    private Integer id;
    private String title;
    private String content;
    private String imgurl;
    private Integer readAmount;
    private String sendTime;
    private String expiryTime;
    private String createTime;
    private String updateTime;
    private String userId;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

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

    public String getImgurl() {
        return imgurl;
    }

    public void setImgurl(String imgurl) {
        this.imgurl = imgurl;
    }

    public String getExpiryTime() {
        return expiryTime;
    }

    public void setExpiryTime(String expiryTime) {
        this.expiryTime = expiryTime;
    }

    public String getCreateTime() {
        return createTime;
    }

    public void setCreateTime(String createTime) {
        this.createTime = createTime;
    }

    public Integer getReadAmount() {
        return readAmount;
    }

    public void setReadAmount(Integer readAmount) {
        this.readAmount = readAmount;
    }

    public String getUpdateTime() {
        return updateTime;
    }

    public void setUpdateTime(String updateTime) {
        this.updateTime = updateTime;
    }

    public String getUserId() {
        return userId;
    }

    public void setUserId(String userId) {
        this.userId = userId;
    }

    private Date startSendDate;
    private Date endSendDate;

    public Date getStartSendDate() {
        return startSendDate;
    }

    public void setStartSendDate(Date startSendDate) {
        this.startSendDate = startSendDate;
    }

    public Date getEndSendDate() {
        return endSendDate;
    }

    public void setEndSendDate(Date endSendDate) {
        this.endSendDate = endSendDate;
    }

    public String getSendTime() {
        return sendTime;
    }

    public void setSendTime(String sendTime) {
        this.sendTime = sendTime;
        if (StringUtils.isNotEmpty(sendTime)) {
            String date[] = sendTime.split("/");
            this.startSendDate = DateUtils.getFirstDateOfDay(DateUtils.stringtoDate(date[0]));
            this.endSendDate = DateUtils.getLastDateOfDay(DateUtils.stringtoDate(date[1]));
        }
    }

    @Override
    public String toString() {
        return "NoticeSearchBean{" +
                "id=" + id +
                ", title='" + title + '\'' +
                ", content='" + content + '\'' +
                ", imgurl='" + imgurl + '\'' +
                ", sendTime='" + sendTime + '\'' +
                ", expiryTime='" + expiryTime + '\'' +
                ", createTime='" + createTime + '\'' +
                ", userId='" + userId + '\'' +
                ", startSendDate=" + startSendDate +
                ", endSendDate=" + endSendDate +
                '}';
    }
}
