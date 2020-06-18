package com.kjs.common.dto.course;

import java.util.Date;

public class ArticleBaseDto {
	
	private Integer id; /*id*/
	private String	title;     /* 标题 */
	private Integer positionId;
	private String coverUrl;
	private Date createTime;
	private Date saveTime;
	private String body;
	private Integer viewsNumber; 
	private String authorName;

	private Integer	deleted;		 /* 删除标识1删除0使用 */
	
	private Integer directionId;
	
	public Integer getDirectionId() {
		return directionId;
	}
	public void setDirectionId(Integer directionId) {
		this.directionId = directionId;
	}
	public String getBody() {
		return body;
	}
	public void setBody(String body) {
		this.body = body;
	}
	public Integer getViewsNumber() {
		return viewsNumber;
	}
	public void setViewsNumber(Integer viewsNumber) {
		this.viewsNumber = viewsNumber;
	}
	
	
	


	
	public Integer getDeleted() {
		return deleted;
	}
	public void setDeleted(Integer deleted) {
		this.deleted = deleted;
	}
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public Integer getPositionId() {
		return positionId;
	}
	public void setPositionId(Integer positionId) {
		this.positionId = positionId;
	}
	public String getCoverUrl() {
		return coverUrl;
	}
	public void setCoverUrl(String coverUrl) {
		this.coverUrl = coverUrl;
	}
	public Date getCreateTime() {
		return createTime;
	}
	public void setCreateTime(Date createTime) {
		this.createTime = createTime;
	}
	public Date getSaveTime() {
		return saveTime;
	}
	public void setSaveTime(Date saveTime) {
		this.saveTime = saveTime;
	}
	public String getAuthorName() {
		return authorName;
	}
	public void setAuthorName(String authorName) {
		this.authorName = authorName;
	}
	@Override
	public String toString() {
		return "ArticleBaseDto [id=" + id + ", title=" + title + ", positionId=" + positionId + ", coverUrl=" + coverUrl
				+ ", createTime=" + createTime + ", saveTime=" + saveTime + ", body=" + body + ", viewsNumber="
				+ viewsNumber + ", authorName=" + authorName + ", deleted=" + deleted + ", directionId=" + directionId
				+ "]";
	}
	
	
	
	
	
	
	


}
