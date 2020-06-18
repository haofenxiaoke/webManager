package com.kjs.orm.model;

import com.kjs.common.bean.BaseEntity;
import com.kjs.common.utils.ShortDateSerializer;
import org.apache.ibatis.type.Alias;
import org.codehaus.jackson.map.annotate.JsonSerialize;

import java.io.Serializable;
import java.util.Date;

/**
 * POJO:SysLog
 * 
 * @author duia_builder
 * @date 2016-1-20
 */
@SuppressWarnings("serial")
@Alias("SysLog")
public class SysLog extends BaseEntity implements Serializable {
	
	
	private Integer	userId;		
	private String	userName;		
	private Date	addTime;		
	private String	info;		
	private Integer	type;		
	private String	reason;		

	// getter && setter
	// 在setter方法后加"return this;"并把返回参数改为SysLog可以实现连缀设置属性
	
	public Integer getUserId() {
		return userId;
	}

	public SysLog setUserId(Integer userId) {
		this.userId = userId;
		return this;
	}
	
	
	public String getUserName() {
		return userName;
	}

	public SysLog setUserName(String userName) {
		this.userName = userName;
		return this;
	}
	
	@JsonSerialize(using = ShortDateSerializer.class)
	public Date getAddTime() {
		return addTime;
	}

	public SysLog setAddTime(Date addTime) {
		this.addTime = addTime;
		return this;
	}
	
	
	public String getInfo() {
		return info;
	}

	public SysLog setInfo(String info) {
		this.info = info;
		return this;
	}
	
	
	public Integer getType() {
		return type;
	}

	public SysLog setType(Integer type) {
		this.type = type;
		return this;
	}
	
	
	public String getReason() {
		return reason;
	}

	public SysLog setReason(String reason) {
		this.reason = reason;
		return this;
	}
	
	@Override
	public String toString() {
		return "SysLog [" + "id=" + getId() + ", userId=" + userId + ", userName=" + userName + ", addTime=" + addTime + ", info=" + info + ", type=" + type + ", reason=" + reason +  "]";
	}
}
