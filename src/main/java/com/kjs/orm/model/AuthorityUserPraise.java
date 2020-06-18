package com.kjs.orm.model;

import com.kjs.common.bean.BaseEntity;
import com.kjs.common.utils.ShortDateSerializer;
import org.apache.ibatis.type.Alias;
import org.codehaus.jackson.map.annotate.JsonSerialize;

import java.util.Date;

/**
 * POJO:AuthorityUserPraise
 * 
 * @author duia_builder
 * @date 2016-5-23
 */
@SuppressWarnings("serial")
@Alias("AuthorityUserPraise")
public class AuthorityUserPraise extends BaseEntity {
	
	
	private String	praiseContent;		 /* 内容 */ 
	private String	url;		 /* 图片url */ 
	private Date	optime;		 /* 创建时间 */ 
	private Integer	userid;		 /* 用户ID */ 

	// getter && setter
	// 在setter方法最后加上"return this;"并把返回参数改为AuthorityUserPraise可以实现连缀设置属性
	
	public String getPraiseContent() {
		return praiseContent;
	}

	public AuthorityUserPraise setPraiseContent(String praiseContent) {
		this.praiseContent = praiseContent;
		return this;
	}
	
	
	public String getUrl() {
		return url;
	}

	public AuthorityUserPraise setUrl(String url) {
		this.url = url;
		return this;
	}
	
	@JsonSerialize(using = ShortDateSerializer.class)
	public Date getOptime() {
		return optime;
	}

	public AuthorityUserPraise setOptime(Date optime) {
		this.optime = optime;
		return this;
	}
	
	
	public Integer getUserid() {
		return userid;
	}

	public AuthorityUserPraise setUserid(Integer userid) {
		this.userid = userid;
		return this;
	}
	
	@Override
	public String toString() {
		return "AuthorityUserPraise [" + "id=" + getId() + ", praiseContent=" + praiseContent + ", url=" + url + ", optime=" + optime + ", userid=" + userid +  "]";
	}
}
