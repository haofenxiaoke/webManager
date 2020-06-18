package com.kjs.orm.model;

import java.util.Date;

import org.apache.ibatis.type.Alias;

import com.kjs.common.bean.BaseEntity;

@SuppressWarnings("serial")
@Alias("Article")
public class Article extends BaseEntity{
//	private Integer id; /*id*/
	private String	title;     /* 标题 */
	private Integer positionId;
	private String coverUrl;
	private Date createTime;
	private Date saveTime;
	private String body;
	private Integer viewsNumber;
	private String authorName;
	private Integer deleted;
	private Integer directionId;
	
	
	
	
	
public Integer getDirectionId() {
		return directionId;
	}
	public void setDirectionId(Integer directionId) {
		this.directionId = directionId;
	}
	//	public Integer getId() {
//		return id;
//	}
//	public Article setId(Integer id) {
//		this.id = id;
//		return this;
//	}
	public String getTitle() {
		return title;
	}
	public Article setTitle(String title) {
		this.title = title;
		return this;
	}
	public Integer getPositionId() {
		return positionId;
	}
	public Article setPositionId(Integer positionId) {
		this.positionId = positionId;
		return this;
	}
	public String getCoverUrl() {
		return coverUrl;
	}
	public Article setCoverUrl(String coverUrl) {
		this.coverUrl = coverUrl;
		return this;
	}
	public Date getCreateTime() {
		return createTime;
	}
	public Article setCreateTime(Date createTime) {
		this.createTime = createTime;
		return this;
	}
	public Date getSaveTime() {
		return saveTime;
	}
	public Article setSaveTime(Date saveTime) {
		this.saveTime = saveTime;
		return this;
	}
	public String getBody() {
		return body;
	}
	public Article setBody(String body) {
		
		this.body = body;
		return this;
	}
	public Integer getViewsNumber() {
		return viewsNumber;
	}
	public Article setViewsNumber(Integer viewsNumber) {
		this.viewsNumber = viewsNumber;
		return this;
	}
	public String getAuthorName() {
		return authorName;
	}
	public Article setAuthorName(String authorName) {
		this.authorName = authorName;
		return this;
	}
	public Integer getDeleted() {
		return deleted;
	}
	public void setDeleted(Integer deleted) {
		this.deleted = deleted;
	}
	@Override
	public String toString() {
		return "Article [title=" + title + ", positionId=" + positionId + ", coverUrl=" + coverUrl + ", createTime="
				+ createTime + ", saveTime=" + saveTime + ", body=" + body + ", viewsNumber=" + viewsNumber
				+ ", authorName=" + authorName + ", deleted=" + deleted + ", directionId=" + directionId + "]";
	}
	
	
	
	
	

}
