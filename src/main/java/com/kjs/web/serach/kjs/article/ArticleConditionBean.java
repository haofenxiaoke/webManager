package com.kjs.web.serach.kjs.article;

import java.util.Date;

import com.kjs.common.bean.DataTablePageModel;

public class ArticleConditionBean extends DataTablePageModel {
	private Integer id;

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	private String title; /* 标题 */

	private String createTime;/* 课程创建时间 */

	private Integer positionId;

	private Integer directionId;

	public Integer getDirectionId() {
		return directionId;
	}

	public void setDirectionId(Integer directionId) {
		this.directionId = directionId;
	}

	private String coverUrl;

	private String body;

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getCreateTime() {
		return createTime;
	}

	public void setCreateTime(String createTime) {
		this.createTime = createTime;
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

	public String getBody() {
		return body;
	}

	public void setBody(String body) {
		this.body = body;
	}

	@Override
	public String toString() {
		return "ArticleConditionBean [id=" + id + ", title=" + title + ", createTime=" + createTime + ", positionId="
				+ positionId + ", directionId=" + directionId + ", coverUrl=" + coverUrl + ", body=" + body + "]";
	}

}
