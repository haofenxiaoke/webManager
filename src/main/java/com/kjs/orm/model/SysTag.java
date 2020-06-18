package com.kjs.orm.model;

import com.kjs.common.bean.BaseEntity;
import com.kjs.common.utils.ShortDateSerializer;
import org.apache.ibatis.type.Alias;
import org.codehaus.jackson.map.annotate.JsonSerialize;

import java.util.Date;

/**
 * POJO:SysTag
 * 
 * @author duia_builder
 * @date 2016-5-23
 */
@SuppressWarnings("serial")
@Alias("SysTag")
public class SysTag extends BaseEntity {
	
	
	private Integer	type;		 /* 类型 */ 
	private String	content;		 /* 内容 */ 
	private Integer	courseNum;		 /* 关联视频数 */
	private Integer directionId;	/* 方向ID */
	private Date	createTime;		 /* 创建时间 */
	private Boolean deleted;     /*删除标志位*/

	// getter && setter
	// 在setter方法最后加上"return this;"并把返回参数改为SysTag可以实现连缀设置属性
	
	public Integer getType() {
		return type;
	}

	public SysTag setType(Integer type) {
		this.type = type;
		return this;
	}
	
	
	public String getContent() {
		return content;
	}

	public SysTag setContent(String content) {
		this.content = content;
		return this;
	}

	public Integer getCourseNum() {
		return courseNum;
	}

	public void setCourseNum(Integer courseNum) {
		this.courseNum = courseNum;
	}

	public Integer getDirectionId() {
		return directionId;
	}

	public void setDirectionId(Integer directionId) {
		this.directionId = directionId;
	}

	@JsonSerialize(using = ShortDateSerializer.class)
	public Date getCreateTime() {
		return createTime;
	}

	public SysTag setCreateTime(Date createTime) {
		this.createTime = createTime;
		return this;
	}

	public Boolean getDeleted() {
		return deleted;
	}

	public void setDeleted(Boolean deleted) {
		this.deleted = deleted;
	}

	@Override
	public String toString() {
		return "SysTag [" + "id=" + getId() + ", type=" + type + ", content=" + content + ", courseNum=" + courseNum +", directionId="+directionId+ ", createTime=" + createTime + ", deleted=" + deleted +  "]";
	}
}
