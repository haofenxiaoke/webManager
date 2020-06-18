package com.kjs.orm.model;

import com.kjs.common.bean.BaseEntity;
import com.kjs.common.utils.ShortDateSerializer;
import org.apache.ibatis.type.Alias;
import org.codehaus.jackson.map.annotate.JsonSerialize;

import java.util.Date;

/**
* POJO:Teacher
*
* @author kjs_builder
* @date 2016-9-14
*/
@SuppressWarnings("serial")
@Alias("Teacher")
public class Teacher extends BaseEntity {

    
    private String	name;		 /* 老师名称 */ 
    private String	flowerName;		 /* 花名 */ 
    private String	num;		 /* 工号 */ 
    private String	sex;		 /* 性别 */ 
    private String	imgUrl;		 /* 照片 */ 
    private String	introduction;		 /* 介绍 */ 
    private Integer	userLock;		 /* 账号是否锁定(0:锁定1:正常) */
    private Integer	teacherUserId;		 /* 老师绑定用户ID */ 
    private Integer	userId;		 /* 创建人 */ 
    private Date	ctime;		 /* 创建时间 */ 
    private Date	utime;		 /* 更新时间 */ 

// getter && setter
    
public String getName() {
return name;
}

public Teacher setName(String name) {
    this.name = name;
    return this;
}

    
public String getFlowerName() {
return flowerName;
}

public Teacher setFlowerName(String flowerName) {
    this.flowerName = flowerName;
    return this;
}

    
public String getNum() {
return num;
}

public Teacher setNum(String num) {
    this.num = num;
    return this;
}

    
public String getSex() {
return sex;
}

public Teacher setSex(String sex) {
    this.sex = sex;
    return this;
}

    
public String getImgUrl() {
return imgUrl;
}

public Teacher setImgUrl(String imgUrl) {
    this.imgUrl = imgUrl;
    return this;
}

    
public String getIntroduction() {
return introduction;
}

public Teacher setIntroduction(String introduction) {
    this.introduction = introduction;
    return this;
}

    
public Integer getUserLock() {
return userLock;
}

public Teacher setUserLock(Integer userLock) {
    this.userLock = userLock;
    return this;
}

    
public Integer getTeacherUserId() {
return teacherUserId;
}

public Teacher setTeacherUserId(Integer teacherUserId) {
    this.teacherUserId = teacherUserId;
    return this;
}

    
public Integer getUserId() {
return userId;
}

public Teacher setUserId(Integer userId) {
    this.userId = userId;
    return this;
}

    @JsonSerialize(using = ShortDateSerializer.class)
public Date getCtime() {
return ctime;
}

public Teacher setCtime(Date ctime) {
    this.ctime = ctime;
    return this;
}

    @JsonSerialize(using = ShortDateSerializer.class)
public Date getUtime() {
return utime;
}

public Teacher setUtime(Date utime) {
    this.utime = utime;
    return this;
}

@Override
public String toString() {
    return "Teacher [" + "id=" + getId() + ", name=" + name + ", flowerName=" + flowerName + ", num=" + num + ", sex=" + sex + ", imgUrl=" + imgUrl + ", introduction=" + introduction + ", userLock=" + userLock + ", teacherUserId=" + teacherUserId + ", userId=" + userId + ", ctime=" + ctime + ", utime=" + utime +  "]";
    }
}
