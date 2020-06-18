package com.kjs.web.serach.kjs.article;

import java.util.Date;

public class ArticleSearchBean {
	 	private int id;/*课程id*/
	    
	    private String	title;		 /* 标题 */
	    
	    private Date createTime;		 /* 课程发布时间 */
	    
	    private Date saveTime;
	    
	    private Integer viewsNumber;
	    
	    private String authorName;        /*作者*/
	    
	    private Integer  positionId;		 /* 职位id */
	    private String positionName;/*职位名称*/
	    
	    private Integer deleted;
	    
	    private Integer directionId;
		
		public Integer getDirectionId() {
			return directionId;
		}
		public void setDirectionId(Integer directionId) {
			this.directionId = directionId;
		}
		public Integer getDeleted() {
			return deleted;
		}
		public void setDeleted(Integer deleted) {
			this.deleted = deleted;
		}
		public int getId() {
			return id;
		}
		public void setId(int id) {
			this.id = id;
		}
		public String getTitle() {
			return title;
		}
		public void setTitle(String title) {
			this.title = title;
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
		public Integer getViewsNumber() {
			return viewsNumber;
		}
		public void setViewsNumber(Integer viewsNumber) {
			this.viewsNumber = viewsNumber;
		}
		public String getAuthorName() {
			return authorName;
		}
		public void setAuthorName(String authorName) {
			this.authorName = authorName;
		}
		public Integer getPositionId() {
			return positionId;
		}
		public void setPositionId(Integer positionId) {
			this.positionId = positionId;
		}
		public String getPositionName() {
			return positionName;
		}
		public void setPositionName(String positionName) {
			this.positionName = positionName;
		}
		@Override
		public String toString() {
			return "ArticleSearchBean [id=" + id + ", title=" + title + ", createTime=" + createTime + ", saveTime="
					+ saveTime + ", viewsNumber=" + viewsNumber + ", authorName=" + authorName + ", positionId="
					+ positionId + ", positionName=" + positionName + ", deleted=" + deleted + ", directionId="
					+ directionId + "]";
		}
	    
	 

}
