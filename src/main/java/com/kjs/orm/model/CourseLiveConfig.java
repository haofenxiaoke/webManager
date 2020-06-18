package com.kjs.orm.model;

import com.kjs.common.bean.BaseEntity;
import com.kjs.common.utils.ShortDateSerializer;
import org.apache.ibatis.type.Alias;
import org.codehaus.jackson.map.annotate.JsonSerialize;

import java.util.Date;

/**
* POJO:CourseLiveConfig
*
* @author kjs_builder
* @date 2017-3-31
*/
@SuppressWarnings("serial")
@Alias("CourseLiveConfig")
public class CourseLiveConfig extends BaseEntity {

    
    private Integer	orderNum;		 /* 位置 */ 
    private Integer	courseId;		 /* 课程ID */ 
    private Integer	categoryId;		 /* 方向ID */ 
    private String	hrefUrl;		 /* 图片地址 */ 
    private Integer	type;		 /* 0:直播 1：公开课 */ 
    private Date	createTime;		 /* 创建时间 */ 
    private Integer	createUserid;		 /* 创建人id */ 
    private Date	lastUpdateTime;		 /* 最后修改时间 */ 
    private Integer	lastUpdateUserid;		 /* 最后修改人id */
    private  String liveTitle;        /* 直播课程名称 */


// getter && setter
    
public Integer getOrderNum() {
return orderNum;
}

public CourseLiveConfig setOrderNum(Integer orderNum) {
    this.orderNum = orderNum;
    return this;
}

public String getLiveTitle() {
    return liveTitle;
}

public CourseLiveConfig setLiveTitle(String liveTitle) {
    this.liveTitle = liveTitle;
    return this;
}

public Integer getCourseId() {
return courseId;
}

public CourseLiveConfig setCourseId(Integer courseId) {
    this.courseId = courseId;
    return this;
}

    
public Integer getCategoryId() {
return categoryId;
}

public CourseLiveConfig setCategoryId(Integer categoryId) {
    this.categoryId = categoryId;
    return this;
}

    
public String getHrefUrl() {
return hrefUrl;
}

public CourseLiveConfig setHrefUrl(String hrefUrl) {
    this.hrefUrl = hrefUrl;
    return this;
}

    
public Integer getType() {
return type;
}

public CourseLiveConfig setType(Integer type) {
    this.type = type;
    return this;
}

    @JsonSerialize(using = ShortDateSerializer.class)
public Date getCreateTime() {
return createTime;
}

public CourseLiveConfig setCreateTime(Date createTime) {
    this.createTime = createTime;
    return this;
}

    
public Integer getCreateUserid() {
return createUserid;
}

public CourseLiveConfig setCreateUserid(Integer createUserid) {
    this.createUserid = createUserid;
    return this;
}

    @JsonSerialize(using = ShortDateSerializer.class)
public Date getLastUpdateTime() {
return lastUpdateTime;
}

public CourseLiveConfig setLastUpdateTime(Date lastUpdateTime) {
    this.lastUpdateTime = lastUpdateTime;
    return this;
}

    
public Integer getLastUpdateUserid() {
return lastUpdateUserid;
}

public CourseLiveConfig setLastUpdateUserid(Integer lastUpdateUserid) {
    this.lastUpdateUserid = lastUpdateUserid;
    return this;
}

@Override
public String toString() {
    return "CourseLiveConfig [" + "id=" + getId() + ", orderNum=" + orderNum + ", courseId=" + courseId + ", categoryId=" + categoryId + ", hrefUrl=" + hrefUrl + ", type=" + type + ", createTime=" + createTime + ", createUserid=" + createUserid + ", lastUpdateTime=" + lastUpdateTime + ", lastUpdateUserid=" + lastUpdateUserid +  "]";
    }
}
