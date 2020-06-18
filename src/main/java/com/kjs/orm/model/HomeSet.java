package com.kjs.orm.model;

import com.kjs.common.bean.BaseEntity;
import org.apache.ibatis.type.Alias;

import java.util.Date;

/**
 * POJO:HomeSet
 * 
 * @author duia_builder
 * @date 2016-5-23
 */
@SuppressWarnings("serial")
@Alias("HomeSet")
public class HomeSet extends BaseEntity {
	
	
	private Integer	directionId;		 /* 方向ID */
	private String	leftModule;		 /* left */
	private Integer	module1;		 /* module1 */
	private Integer	module2;		 /* module2 */
	private Integer	module3;		 /* module3 */
	private Integer	module4;		 /* module4 */
	private Integer	module5;		 /* module5 */
	private Integer	module6;		 /* module6 */
	private Integer	module7;		 /* module7 */
	private Integer	module8;		 /* module8 */
	private Date	createTime;		 /* 创建时间 */ 
	private Integer	createUserid;		 /* 创建人id */ 
	private Date	lastUpdateTime;		 /* 最后修改时间 */ 
	private Integer	lastUpdateUserid;		 /* 最后修改人id */
	private String  leftHref;	/*广告链接*/
	private Boolean  isEnabled; /* 是否启用 */

	// getter && setter
	// 在setter方法最后加上"return this;"并把返回参数改为HomeSet可以实现连缀设置属性


	public Integer getDirectionId() {
		return directionId;
	}

	public void setDirectionId(Integer directionId) {
		this.directionId = directionId;
	}

	public String getLeftModule() {
		return leftModule;
	}

	public void setLeftModule(String leftModule) {
		this.leftModule = leftModule;
	}

	public Integer getModule1() {
		return module1;
	}

	public void setModule1(Integer module1) {
		this.module1 = module1;
	}

	public Integer getModule2() {
		return module2;
	}

	public void setModule2(Integer module2) {
		this.module2 = module2;
	}

	public Integer getModule3() {
		return module3;
	}

	public void setModule3(Integer module3) {
		this.module3 = module3;
	}

	public Integer getModule4() {
		return module4;
	}

	public void setModule4(Integer module4) {
		this.module4 = module4;
	}

	public Integer getModule5() {
		return module5;
	}

	public void setModule5(Integer module5) {
		this.module5 = module5;
	}

	public Integer getModule6() {
		return module6;
	}

	public void setModule6(Integer module6) {
		this.module6 = module6;
	}

	public Integer getModule7() {
		return module7;
	}

	public void setModule7(Integer module7) {
		this.module7 = module7;
	}

	public Integer getModule8() {
		return module8;
	}

	public void setModule8(Integer module8) {
		this.module8 = module8;
	}

	public Date getCreateTime() {
		return createTime;
	}

	public void setCreateTime(Date createTime) {
		this.createTime = createTime;
	}

	public Integer getCreateUserid() {
		return createUserid;
	}

	public void setCreateUserid(Integer createUserid) {
		this.createUserid = createUserid;
	}

	public Date getLastUpdateTime() {
		return lastUpdateTime;
	}

	public void setLastUpdateTime(Date lastUpdateTime) {
		this.lastUpdateTime = lastUpdateTime;
	}

	public Integer getLastUpdateUserid() {
		return lastUpdateUserid;
	}

	public void setLastUpdateUserid(Integer lastUpdateUserid) {
		this.lastUpdateUserid = lastUpdateUserid;
	}

	public String getLeftHref() {
		return leftHref;
	}

	public void setLeftHref(String leftHref) {
		this.leftHref = leftHref;
	}

	public Boolean getIsEnabled() {
		return isEnabled;
	}

	public void setIsEnabled(Boolean isEnabled) {
		this.isEnabled = isEnabled;
	}

	@Override
	public String toString() {
		return "HomeSet [" + "id=" + getId() + ", directionId=" + directionId + ", leftModule=" + leftModule + ", module1=" + module1 + ", module2=" + module2 + ", module3=" + module3 + ", module4=" + module4 + ", module5=" + module5 + ", module6=" + module6+ ", module7=" + module7+ ", module8=" + module8 + ", createTime=" + createTime + ", createUserid=" + createUserid + ", lastUpdateTime=" + lastUpdateTime + ", lastUpdateUserid=" + lastUpdateUserid +",leftHref="+ leftHref +",isEnabled="+ isEnabled + "]";
	}
}
