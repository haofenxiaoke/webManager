package com.kjs.orm.model;

import com.kjs.common.bean.BaseEntity;
import com.kjs.common.utils.ShortDateSerializer;
import org.apache.ibatis.type.Alias;
import org.codehaus.jackson.map.annotate.JsonSerialize;

import java.util.Date;

/**
* POJO:UserVisit
*
* @author kjs_builder
* @date 2016-12-24
*/
@SuppressWarnings("serial")
@Alias("UserVisit")
public class UserVisit extends BaseEntity {

    
    private Integer	userId;		 /* 用户id */ 
    private String	refererUrl;		 /* 来源地址 */ 
    private String	currentUrl;		 /* 当前访问地址 */ 
    private Date	visitTime;		 /* 访问时间 */ 
    private Date	stayTime;		 /* 离开时间 */ 
    private String	visitIp;		
    private String	gid;		 /* cookie */ 

// getter && setter
    
public Integer getUserId() {
return userId;
}

public UserVisit setUserId(Integer userId) {
    this.userId = userId;
    return this;
}

    
public String getRefererUrl() {
return refererUrl;
}

public UserVisit setRefererUrl(String refererUrl) {
    this.refererUrl = refererUrl;
    return this;
}

    
public String getCurrentUrl() {
return currentUrl;
}

public UserVisit setCurrentUrl(String currentUrl) {
    this.currentUrl = currentUrl;
    return this;
}

    @JsonSerialize(using = ShortDateSerializer.class)
public Date getVisitTime() {
return visitTime;
}

public UserVisit setVisitTime(Date visitTime) {
    this.visitTime = visitTime;
    return this;
}

    @JsonSerialize(using = ShortDateSerializer.class)
public Date getStayTime() {
return stayTime;
}

public UserVisit setStayTime(Date stayTime) {
    this.stayTime = stayTime;
    return this;
}

    
public String getVisitIp() {
return visitIp;
}

public UserVisit setVisitIp(String visitIp) {
    this.visitIp = visitIp;
    return this;
}

    
public String getGid() {
return gid;
}

public UserVisit setGid(String gid) {
    this.gid = gid;
    return this;
}

@Override
public String toString() {
    return "UserVisit [" + "id=" + getId() + ", userId=" + userId + ", refererUrl=" + refererUrl + ", currentUrl=" + currentUrl + ", visitTime=" + visitTime + ", stayTime=" + stayTime + ", visitIp=" + visitIp + ", gid=" + gid +  "]";
    }
}
