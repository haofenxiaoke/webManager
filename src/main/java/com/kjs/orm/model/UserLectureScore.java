package com.kjs.orm.model;

import java.util.Date;
import org.codehaus.jackson.map.annotate.JsonSerialize;
import com.kjs.common.utils.ShortDateSerializer;

import com.kjs.common.bean.BaseEntity;
import org.apache.ibatis.type.Alias;

/**
* POJO:UserLectureScore
*
* @author kjs_builder
* @date 2016-12-15
*/
@SuppressWarnings("serial")
@Alias("UserLectureScore")
public class UserLectureScore extends BaseEntity {

    
    private Integer	lectureId;		 /* 章节id */ 
    private Integer	clarity;		 /* 视频清晰 */ 
    private Integer	wittySpeech;		 /* 演讲风趣 */ 
    private Integer	isFluency;		 /* 是否流畅1流畅0不流畅 */ 
    private String	suggest;		 /* 建议 */ 
    private Integer	userId;		 /* 用户ID */ 
    private Date	createTime;		 /* 创建时间 */ 
    private String	ipAddress;		 /* ip地址 */ 
    private String	gid;		 /* gid */ 

// getter && setter
    
public Integer getLectureId() {
return lectureId;
}

public UserLectureScore setLectureId(Integer lectureId) {
    this.lectureId = lectureId;
    return this;
}

    
public Integer getClarity() {
return clarity;
}

public UserLectureScore setClarity(Integer clarity) {
    this.clarity = clarity;
    return this;
}

    
public Integer getWittySpeech() {
return wittySpeech;
}

public UserLectureScore setWittySpeech(Integer wittySpeech) {
    this.wittySpeech = wittySpeech;
    return this;
}

    
public Integer getIsFluency() {
return isFluency;
}

public UserLectureScore setIsFluency(Integer isFluency) {
    this.isFluency = isFluency;
    return this;
}

    
public String getSuggest() {
return suggest;
}

public UserLectureScore setSuggest(String suggest) {
    this.suggest = suggest;
    return this;
}

    
public Integer getUserId() {
return userId;
}

public UserLectureScore setUserId(Integer userId) {
    this.userId = userId;
    return this;
}

    @JsonSerialize(using = ShortDateSerializer.class)
public Date getCreateTime() {
return createTime;
}

public UserLectureScore setCreateTime(Date createTime) {
    this.createTime = createTime;
    return this;
}

    
public String getIpAddress() {
return ipAddress;
}

public UserLectureScore setIpAddress(String ipAddress) {
    this.ipAddress = ipAddress;
    return this;
}

    
public String getGid() {
return gid;
}

public UserLectureScore setGid(String gid) {
    this.gid = gid;
    return this;
}

@Override
public String toString() {
    return "UserLectureScore [" + "id=" + getId() + ", lectureId=" + lectureId + ", clarity=" + clarity + ", wittySpeech=" + wittySpeech + ", isFluency=" + isFluency + ", suggest=" + suggest + ", userId=" + userId + ", createTime=" + createTime + ", ipAddress=" + ipAddress + ", gid=" + gid +  "]";
    }
}
