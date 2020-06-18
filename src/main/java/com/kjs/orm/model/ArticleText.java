package com.kjs.orm.model;

import java.util.Date;

import org.apache.ibatis.type.Alias;

import com.kjs.common.bean.BaseEntity;

@SuppressWarnings("serial")
@Alias("ArticleText")
public class ArticleText extends BaseEntity {
	
	
	private Integer	articleId;		 /* 文章主表id */ 
	private String	body;		 /* 文章正文 */ 
	
	private Integer authorName;  /*作者姓名*/
	
	private Date	createTime;		 /* 创建时间 */ 
	private Date	saveTime;		 /* 保存时间 */ 
	private int	deleted;		 /* 删除标识1删除0使用 */
	
	
	
	
	
	
	public Integer getArticleId() {
		return articleId;
	}
	public void setArticleId(Integer articleId) {
		this.articleId = articleId;
	}
	public String getBody() {
		return body;
	}
	public void setBody(String body) {
		this.body = body;
	}
	public Integer getAuthorName() {
		return authorName;
	}
	public void setAuthorName(Integer authorName) {
		this.authorName = authorName;
	}
	
	public int getDeleted() {
		return deleted;
	}
	public void setDeleted(int deleted) {
		this.deleted = deleted;
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
	@Override
	public String toString() {
		return "ArticleText [articleId=" + articleId + ", body=" + body + ", authorName=" + authorName + ", createTime="
				+ createTime + ", saveTime=" + saveTime + ", deleted=" + deleted + "]";
	}

	
	
	
	
	
	
	
}