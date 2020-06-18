package com.kjs.orm.model;

import com.kjs.common.bean.BaseEntity;
import com.kjs.common.utils.ShortDateSerializer;
import org.apache.ibatis.type.Alias;
import org.codehaus.jackson.map.annotate.JsonSerialize;

import java.util.Date;

/**
* POJO:ConsultConfig
*
* @author kjs_builder
* @date 2017-3-29
*/
@SuppressWarnings("serial")
@Alias("ConsultConfig")
public class ConsultConfig extends BaseEntity {

    
    private Boolean	isSwitch;		 /* 0关闭1打开 */ 
    private Integer	type;		 /* 1左侧售前小能2右侧售前导航小能3右侧售后QQ群 */ 
    private String	consultUrl;		 /* 咨询地址（小能、QQ链接等） */ 
    private String	imgUrl;		 /* 小能图片 */ 
    private String	pageSwitch;		 /* 页面开关 */ 
    private Integer	userId;		 /* 操作人id */ 
    private Date	ctime;		 /* 操作时间 */ 
    private Date	utime;		 /* 更新时间 */ 

// getter && setter
    
public Boolean getIsSwitch() {
return isSwitch;
}

public ConsultConfig setIsSwitch(Boolean isSwitch) {
    this.isSwitch = isSwitch;
    return this;
}

    
public Integer getType() {
return type;
}

public ConsultConfig setType(Integer type) {
    this.type = type;
    return this;
}

    
public String getConsultUrl() {
return consultUrl;
}

public ConsultConfig setConsultUrl(String consultUrl) {
    this.consultUrl = consultUrl;
    return this;
}

    
public String getImgUrl() {
return imgUrl;
}

public ConsultConfig setImgUrl(String imgUrl) {
    this.imgUrl = imgUrl;
    return this;
}

    
public String getPageSwitch() {
return pageSwitch;
}

public ConsultConfig setPageSwitch(String pageSwitch) {
    this.pageSwitch = pageSwitch;
    return this;
}

    
public Integer getUserId() {
return userId;
}

public ConsultConfig setUserId(Integer userId) {
    this.userId = userId;
    return this;
}

    @JsonSerialize(using = ShortDateSerializer.class)
public Date getCtime() {
return ctime;
}

public ConsultConfig setCtime(Date ctime) {
    this.ctime = ctime;
    return this;
}

    @JsonSerialize(using = ShortDateSerializer.class)
public Date getUtime() {
return utime;
}

public ConsultConfig setUtime(Date utime) {
    this.utime = utime;
    return this;
}

@Override
public String toString() {
    return "ConsultConfig [" + "id=" + getId() + ", isSwitch=" + isSwitch + ", type=" + type + ", consultUrl=" + consultUrl + ", imgUrl=" + imgUrl + ", pageSwitch=" + pageSwitch + ", userId=" + userId + ", ctime=" + ctime + ", utime=" + utime +  "]";
    }
}
