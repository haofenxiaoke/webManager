package com.kjs.orm.model;

import com.kjs.common.bean.BaseEntity;
import com.kjs.common.utils.ShortDateSerializer;
import org.apache.ibatis.type.Alias;
import org.codehaus.jackson.map.annotate.JsonSerialize;

import java.util.Date;

/**
 * POJO:HomeSetCarousel
 * 
 * @author duia_builder
 * @date 2016-5-23
 */
@SuppressWarnings("serial")
@Alias("HomeSetCarousel")
public class HomeSetCarousel extends BaseEntity {
	
	private String	pathUrl;		 /* 图片路径 */
	private Integer orderNum;        /* 位置 */
	private Date	createTime;		 /* 创建时间 */ 
	private Integer	createUserid;		 /* 创建人id */ 
	private Date	lastUpdateTime;		 /* 最后修改时间 */ 
	private Integer	lastUpdateUserid;		 /* 最后修改人id */
	private String hrefUrl; /*轮播链接地址*/
	private String bgcolor; /*轮播图片背景色*/

	// getter && setter
	// 在setter方法最后加上"return this;"并把返回参数改为HomeSetCarousel可以实现连缀设置属性
	
	public String getPathUrl() {
		return pathUrl;
	}

	public HomeSetCarousel setPathUrl(String pathUrl) {
		this.pathUrl = pathUrl;
		return this;
	}

	public Integer getOrderNum() {
		return orderNum;
	}

	public void setOrderNum(Integer orderNum) {
		this.orderNum = orderNum;
	}

	@JsonSerialize(using = ShortDateSerializer.class)
	public Date getCreateTime() {
		return createTime;
	}

	public HomeSetCarousel setCreateTime(Date createTime) {
		this.createTime = createTime;
		return this;
	}
	
	
	public Integer getCreateUserid() {
		return createUserid;
	}

	public HomeSetCarousel setCreateUserid(Integer createUserid) {
		this.createUserid = createUserid;
		return this;
	}
	
	@JsonSerialize(using = ShortDateSerializer.class)
	public Date getLastUpdateTime() {
		return lastUpdateTime;
	}

	public HomeSetCarousel setLastUpdateTime(Date lastUpdateTime) {
		this.lastUpdateTime = lastUpdateTime;
		return this;
	}
	
	
	public Integer getLastUpdateUserid() {
		return lastUpdateUserid;
	}

	public HomeSetCarousel setLastUpdateUserid(Integer lastUpdateUserid) {
		this.lastUpdateUserid = lastUpdateUserid;
		return this;
	}

	public String getHrefUrl() {
		return hrefUrl;
	}

	public void setHrefUrl(String hrefUrl) {
		this.hrefUrl = hrefUrl;
	}

	public String getBgcolor() {
		return bgcolor;
	}

	public void setBgcolor(String bgcolor) {
		this.bgcolor = bgcolor;
	}

	@Override
	public String toString() {
		return "HomeSetCarousel [" + "id=" + getId() + ", pathUrl=" + pathUrl + ", orderNum=" + orderNum + ", createTime=" + createTime + ", createUserid=" + createUserid + ", lastUpdateTime=" + lastUpdateTime + ", lastUpdateUserid=" + lastUpdateUserid+ ", hrefUrl=" + hrefUrl+ ", bgcolor=" + bgcolor +  "]";
	}
}
