package com.kjs.orm.model;

import com.kjs.common.bean.BaseEntity;
import com.kjs.common.utils.ShortDateSerializer;
import org.apache.ibatis.type.Alias;
import org.codehaus.jackson.map.annotate.JsonSerialize;

import java.util.Date;

/**
 * POJO:UserStu
 * 
 * @author duia_builder
 * @date 2016-5-23
 */
@SuppressWarnings("serial")
@Alias("UserStu")
public class UserStu extends BaseEntity {
	
	private String userid;    /* 用户id */
	private String	username;		 /* 昵称 */ 
	private String	password;		 /* 密码 */ 
	private String	mobile;		 /* 手机号码 */ 
	private String	email;		 /* 邮箱 */ 
	private String	sex;		 /* 性别 */ 
	private String	job;		 /* 用户职位 */ 
	private String	imgurl;		 /* 用户头像 */ 
	private String	userAddress;		 /* 用户所在城市 */ 
	private String	userProvince;		 /* 所在省份 */ 
	private String	profession;		 /* 职业 */ 
	private String	courseBasis;		 /* 课程基础 */ 
	private String	qqNum;		 /* qq号码 */
	private String	education;		 /* 最高学历 */ 
	private Date	registTime;		 /* 注册时间 */ 
	private String	loginType;		 /* 注册类型 */ 
	private String	authCode;		 /* 邮箱验证码 */ 
	private String	phoneIdCode;		 /* 手机验证码 */ 
	private Date	authSendtime;		 /* 验证码发送时间 */ 
	private Long	onlineTime;		 /* 在线时长 */
	private Integer	userQuestionNum;		 /* 用户提问次数 */ 
	private Integer	courseScore;		 /* 用户课程评分 */ 
	private Integer	lectureScore;		 /* 用户章节评分 */ 
	private Date	lastPayDatetime;		 /* 最后一次付费日期 */ 
	private Date	lastLoginDatetime;		 /* 最后一次登录时间 */ 
	private Integer	lastModifyUserId;		 /* 最后一次修改该用户信息的用户 */ 
	private Date	lastModifyDatetime;		 /* 最后一次修改该用户信息的时间 */ 
	private String	lastModifyUserEmail;		 /* 最后一次修改该用户信息的用户email */ 
	private Boolean	deleted;		 /* 删除标识1删除0使用 */
	private Boolean  isAnswer;//答疑权限
	private Integer registerType; /* 注册类型，0：Web端；1:安卓；2：IOS */

	private Boolean isVIP;//是否VIP
	private Date  vipExpireTime;//VIP到期时间
	// getter && setter
	// 在setter方法最后加上"return this;"并把返回参数改为UserStu可以实现连缀设置属性

	public String getUserid() {
		return userid;
	}

	public void setUserid(String userid) {
		this.userid = userid;
	}

	public String getUsername() {
		return username;
	}

	public UserStu setUsername(String username) {
		this.username = username;
		return this;
	}
	
	
	public String getPassword() {
		return password;
	}

	public UserStu setPassword(String password) {
		this.password = password;
		return this;
	}
	
	
	public String getMobile() {
		return mobile;
	}

	public UserStu setMobile(String mobile) {
		this.mobile = mobile;
		return this;
	}
	
	
	public String getEmail() {
		return email;
	}

	public UserStu setEmail(String email) {
		this.email = email;
		return this;
	}
	
	
	public String getSex() {
		return sex;
	}

	public UserStu setSex(String sex) {
		this.sex = sex;
		return this;
	}
	
	
	public String getJob() {
		return job;
	}

	public UserStu setJob(String job) {
		this.job = job;
		return this;
	}
	
	
	public String getImgurl() {
		return imgurl;
	}

	public UserStu setImgurl(String imgurl) {
		this.imgurl = imgurl;
		return this;
	}
	
	
	public String getUserAddress() {
		return userAddress;
	}

	public UserStu setUserAddress(String userAddress) {
		this.userAddress = userAddress;
		return this;
	}
	
	
	public String getUserProvince() {
		return userProvince;
	}

	public UserStu setUserProvince(String userProvince) {
		this.userProvince = userProvince;
		return this;
	}
	
	
	public String getProfession() {
		return profession;
	}

	public UserStu setProfession(String profession) {
		this.profession = profession;
		return this;
	}
	
	
	public String getCourseBasis() {
		return courseBasis;
	}

	public UserStu setCourseBasis(String courseBasis) {
		this.courseBasis = courseBasis;
		return this;
	}
	
	
	public String getQqNum() {
		return qqNum;
	}

	public UserStu setQqNum(String qqNum) {
		this.qqNum = qqNum;
		return this;
	}
	
	
	public String getEducation() {
		return education;
	}

	public UserStu setEducation(String education) {
		this.education = education;
		return this;
	}
	
	@JsonSerialize(using = ShortDateSerializer.class)
	public Date getRegistTime() {
		return registTime;
	}

	public UserStu setRegistTime(Date registTime) {
		this.registTime = registTime;
		return this;
	}
	
	
	public String getLoginType() {
		return loginType;
	}

	public UserStu setLoginType(String loginType) {
		this.loginType = loginType;
		return this;
	}
	
	
	public String getAuthCode() {
		return authCode;
	}

	public UserStu setAuthCode(String authCode) {
		this.authCode = authCode;
		return this;
	}
	
	
	public String getPhoneIdCode() {
		return phoneIdCode;
	}

	public UserStu setPhoneIdCode(String phoneIdCode) {
		this.phoneIdCode = phoneIdCode;
		return this;
	}
	
	@JsonSerialize(using = ShortDateSerializer.class)
	public Date getAuthSendtime() {
		return authSendtime;
	}

	public UserStu setAuthSendtime(Date authSendtime) {
		this.authSendtime = authSendtime;
		return this;
	}
	
	
	public Long getOnlineTime() {
		return onlineTime;
	}

	public UserStu setOnlineTime(Long onlineTime) {
		this.onlineTime = onlineTime;
		return this;
	}
	
	
	public Integer getUserQuestionNum() {
		return userQuestionNum;
	}

	public UserStu setUserQuestionNum(Integer userQuestionNum) {
		this.userQuestionNum = userQuestionNum;
		return this;
	}
	
	
	public Integer getCourseScore() {
		return courseScore;
	}

	public UserStu setCourseScore(Integer courseScore) {
		this.courseScore = courseScore;
		return this;
	}
	
	
	public Integer getLectureScore() {
		return lectureScore;
	}

	public UserStu setLectureScore(Integer lectureScore) {
		this.lectureScore = lectureScore;
		return this;
	}
	
	@JsonSerialize(using = ShortDateSerializer.class)
	public Date getLastPayDatetime() {
		return lastPayDatetime;
	}

	public UserStu setLastPayDatetime(Date lastPayDatetime) {
		this.lastPayDatetime = lastPayDatetime;
		return this;
	}
	
	@JsonSerialize(using = ShortDateSerializer.class)
	public Date getLastLoginDatetime() {
		return lastLoginDatetime;
	}

	public UserStu setLastLoginDatetime(Date lastLoginDatetime) {
		this.lastLoginDatetime = lastLoginDatetime;
		return this;
	}
	
	
	public Integer getLastModifyUserId() {
		return lastModifyUserId;
	}

	public UserStu setLastModifyUserId(Integer lastModifyUserId) {
		this.lastModifyUserId = lastModifyUserId;
		return this;
	}
	
	@JsonSerialize(using = ShortDateSerializer.class)
	public Date getLastModifyDatetime() {
		return lastModifyDatetime;
	}

	public UserStu setLastModifyDatetime(Date lastModifyDatetime) {
		this.lastModifyDatetime = lastModifyDatetime;
		return this;
	}
	
	
	public String getLastModifyUserEmail() {
		return lastModifyUserEmail;
	}

	public UserStu setLastModifyUserEmail(String lastModifyUserEmail) {
		this.lastModifyUserEmail = lastModifyUserEmail;
		return this;
	}
	
	
	public Boolean getDeleted() {
		return deleted;
	}

	public UserStu setDeleted(Boolean deleted) {
		this.deleted = deleted;
		return this;
	}

	public Boolean getIsAnswer() {
		return isAnswer;
	}

	public void setIsAnswer(Boolean isAnswer) {
		this.isAnswer = isAnswer;
	}

	public Integer getRegisterType() {
		return registerType;
	}

	public void setRegisterType(Integer registerType) {
		this.registerType = registerType;
	}

	public Boolean getIsVIP() {
		return isVIP;
	}

	public void setIsVIP(Boolean vip) {
		isVIP = vip;
	}

	public Date getVipExpireTime() {
		return vipExpireTime;
	}

	public void setVipExpireTime(Date vipExpireTime) {
		this.vipExpireTime = vipExpireTime;
	}
}
