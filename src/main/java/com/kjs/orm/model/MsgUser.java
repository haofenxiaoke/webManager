package com.kjs.orm.model;

import org.apache.ibatis.type.Alias;

import java.util.Date;

/**
 * 消息与收件人关联表 实体对象
 * Created by 李恒名 on 2016/6/15.
 */
@Alias("MsgUser")
public class MsgUser {

    public static final  Integer MSG_STATUS_UNREAD = 0;
    public static final  Integer MSG_STATUS_READ = 1;

    private Long id;
    private Long msgId;
    private Long addresseeId;
    private Integer isRead;
    private Date readTime;

    @Override
    public String toString() {
        return "MsgUser{" +
                "id=" + id +
                ", msgId=" + msgId +
                ", addresseeId=" + addresseeId +
                ", isRead=" + isRead +
                ", readTime=" + readTime +
                '}';
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public Long getMsgId() {
        return msgId;
    }

    public void setMsgId(Long msgId) {
        this.msgId = msgId;
    }

    public Long getAddresseeId() {
        return addresseeId;
    }

    public void setAddresseeId(Long addresseeId) {
        this.addresseeId = addresseeId;
    }

    public Integer getIsRead() {
        return isRead;
    }

    public void setIsRead(Integer isRead) {
        this.isRead = isRead;
    }

    public Date getReadTime() {
        return readTime;
    }

    public void setReadTime(Date readTime) {
        this.readTime = readTime;
    }
}
