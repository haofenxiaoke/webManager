package com.kjs.orm.model;

import com.kjs.common.bean.BaseEntity;
import com.kjs.common.utils.ShortDateSerializer;
import org.apache.ibatis.type.Alias;
import org.codehaus.jackson.map.annotate.JsonSerialize;

import java.util.Date;

/**
 * POJO:CourseText
 * 
 * @author duia_builder
 * @date 2016-5-23
 */
@SuppressWarnings("serial")
@Alias("CourseText")
public class CourseText extends BaseEntity {
	
	
	private Integer	courseId;		 /* 课程主表id */ 
	private String	summary;		 /* 课程简介 */ 
	private String	jobDuty;		 /* 岗位职责 */
	private Integer teacherId;  /*老师id*/
	private String teacherBrief;  /*老师简介*/
	private Date	createDate;		 /* 创建时间 */ 
	private Date	updateDate;		 /* 更新时间 */ 
	private int	deleted;		 /* 删除标识1删除0使用 */

	// getter && setter
	// 在setter方法最后加上"return this;"并把返回参数改为CourseText可以实现连缀设置属性
	
	public Integer getCourseId() {
		return courseId;
	}

	public CourseText setCourseId(Integer courseId) {
		this.courseId = courseId;
		return this;
	}
	
	
	public String getSummary() {
		return summary;
	}

	public CourseText setSummary(String summary) {
		this.summary = summary;
		return this;
	}
	
	
	public String getJobDuty() {
		return jobDuty;
	}

	public CourseText setJobDuty(String jobDuty) {
		this.jobDuty = jobDuty;
		return this;
	}
	
	@JsonSerialize(using = ShortDateSerializer.class)
	public Date getCreateDate() {
		return createDate;
	}

	public CourseText setCreateDate(Date createDate) {
		this.createDate = createDate;
		return this;
	}
	
	@JsonSerialize(using = ShortDateSerializer.class)
	public Date getUpdateDate() {
		return updateDate;
	}

	public CourseText setUpdateDate(Date updateDate) {
		this.updateDate = updateDate;
		return this;
	}
	
	
	public int getDeleted() {
		return deleted;
	}

	public CourseText setDeleted(int deleted) {
		this.deleted = deleted;
		return this;
	}

	public Integer getTeacherId() {
		return teacherId;
	}

	public void setTeacherId(Integer teacherId) {
		this.teacherId = teacherId;
	}

	public String getTeacherBrief() {
		return teacherBrief;
	}

	public void setTeacherBrief(String teacherBrief) {
		this.teacherBrief = teacherBrief;
	}

	@Override
	public String toString() {
		return "CourseText{" +
				"courseId=" + courseId +
				", summary='" + summary + '\'' +
				", jobDuty='" + jobDuty + '\'' +
				", teacherId=" + teacherId +
				", teacherBrief='" + teacherBrief + '\'' +
				", createDate=" + createDate +
				", updateDate=" + updateDate +
				", deleted=" + deleted +
				'}';
	}
}
