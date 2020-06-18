package com.kjs.orm.model;

import com.kjs.common.bean.BaseEntity;
import org.apache.ibatis.type.Alias;

import java.util.Date;

/**
 * POJO:AuthorityUsers
 * 
 * @author duia_builder
 * @date 2016-1-20
 */
@SuppressWarnings("serial")
@Alias("AuthorityUsers")
public class AuthorityUsers extends BaseEntity {
	
	
	private String	username;		 /* 员工真实姓名或者花名 */ 
	private String	password;		 /* md5密码 */ 
	private String	mobile;		 /* 员工的手机号 */ 
	private String	email;		 /* 员工的电子邮箱 */ 
	private String	sex;		 /* 性别 */ 
	private String	job;		 /* 员工职位 */ 
	private String	num;		 /* 员工工号 */
	private String flowerName;
	private int	userLock = 1;		 /* 账号是否锁定(0:锁定1:正常) */
	private int	userStatus = 1;		 /* 员工状态(0:离职1:在职) */
	private String	bigImg;		 /* 员工头像(大图) */ 
	private String	smallImg;		 /* 员工头像(小图) */
	private int     administrator=0;  /*是否是超级管理员1是0不是*/
	private Date	createDatetime;		 /* 员工创建时间 */ 
	private Long	lastModifyUserId;		 /* 最后一次修改该员工信息的用户 */
	private String  lastModifyUserEmail;    /* 最后一次修改该员工信息的用户Email */
	private Date	lastModifyDatetime;		 /* 最后一次修改该员工信息的时间 */ 
	private Date	lastLoginDatetime;		 /* 最后一次登录时间 */
	private int wechatStatus;
	private String wechatDi;
	private String wechatUrl;
	private Date wechatShowTime;

	@Override
	public String toString() {
		return "AuthorityUsers [username=" + username + ", password=" + password + ", mobile=" + mobile + ", email="
				+ email + ", sex=" + sex + ", job=" + job + ", num=" + num + ", flowerName=" + flowerName
				+ ", userLock=" + userLock + ", userStatus=" + userStatus + ", bigImg=" + bigImg + ", smallImg="
				+ smallImg + ", administrator=" + administrator + ", createDatetime=" + createDatetime
				+ ", lastModifyUserId=" + lastModifyUserId + ", lastModifyUserEmail=" + lastModifyUserEmail
				+ ", lastModifyDatetime=" + lastModifyDatetime + ", lastLoginDatetime=" + lastLoginDatetime
				+ ", wechatStatus=" + wechatStatus + ", wechatDi=" + wechatDi + ", wechatUrl=" + wechatUrl
				+ ", wechatShowTime=" + wechatShowTime + "]";
	}

	public int getWechatStatus() {
		return wechatStatus;
	}

	public void setWechatStatus(int wechatStatus) {
		this.wechatStatus = wechatStatus;
	}

	public String getWechatDi() {
		return wechatDi;
	}

	public void setWechatDi(String wechatDi) {
		this.wechatDi = wechatDi;
	}

	public String getWechatUrl() {
		return wechatUrl;
	}

	public void setWechatUrl(String wechatUrl) {
		this.wechatUrl = wechatUrl;
	}

	public Date getWechatShowTime() {
		return wechatShowTime;
	}

	public void setWechatShowTime(Date wechatShowTime) {
		this.wechatShowTime = wechatShowTime;
	}

	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getMobile() {
		return mobile;
	}

	public void setMobile(String mobile) {
		this.mobile = mobile;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getSex() {
		return sex;
	}

	public void setSex(String sex) {
		this.sex = sex;
	}

	public String getJob() {
		return job;
	}

	public void setJob(String job) {
		this.job = job;
	}

	public String getNum() {
		return num;
	}

	public void setNum(String num) {
		this.num = num;
	}

	public String getFlowerName() {
		return flowerName;
	}

	public void setFlowerName(String flowerName) {
		this.flowerName = flowerName;
	}

	public int getUserLock() {
		return userLock;
	}

	public void setUserLock(int userLock) {
		this.userLock = userLock;
	}

	public int getUserStatus() {
		return userStatus;
	}

	public void setUserStatus(int userStatus) {
		this.userStatus = userStatus;
	}

	public String getBigImg() {
		return bigImg;
	}

	public void setBigImg(String bigImg) {
		this.bigImg = bigImg;
	}

	public String getSmallImg() {
		return smallImg;
	}

	public void setSmallImg(String smallImg) {
		this.smallImg = smallImg;
	}

	public Date getCreateDatetime() {
		return createDatetime;
	}

	public void setCreateDatetime(Date createDatetime) {
		this.createDatetime = createDatetime;
	}

	public Long getLastModifyUserId() {
		return lastModifyUserId;
	}

	public void setLastModifyUserId(Long lastModifyUserId) {
		this.lastModifyUserId = lastModifyUserId;
	}

	public Date getLastModifyDatetime() {
		return lastModifyDatetime;
	}

	public void setLastModifyDatetime(Date lastModifyDatetime) {
		this.lastModifyDatetime = lastModifyDatetime;
	}

	public Date getLastLoginDatetime() {
		return lastLoginDatetime;
	}

	public void setLastLoginDatetime(Date lastLoginDatetime) {
		this.lastLoginDatetime = lastLoginDatetime;
	}

	public int getAdministrator() {
		return administrator;
	}

	public void setAdministrator(int administrator) {
		this.administrator = administrator;
	}

	public String getLastModifyUserEmail() {
		return lastModifyUserEmail;
	}

	public void setLastModifyUserEmail(String lastModifyUserEmail) {
		this.lastModifyUserEmail = lastModifyUserEmail;
	}
}
