package com.kjs.orm.model;


import com.kjs.common.bean.BaseEntity;
import org.apache.ibatis.type.Alias;

/**
 * POJO:CourseChapter
 * 
 * @author duia_builder
 * @date 2016-5-23
 */
@SuppressWarnings("serial")
@Alias("CourseChapter")
public class CourseChapter extends BaseEntity {
	
	
	private Integer	courseId;		 /* 课程id */ 
	private String	courseName;		 /* 课程名称 */ 
	private String	chapterName;		 /* 章的名称 */ 
	private String	chapterDesc;		 /* 章的描述 */ 
	private Integer	chapterOrder;		 /* 章的顺序 */ 
	private Integer	lectureNum;		 /* 章包含总讲座数 */ 

	// getter && setter
	// 在setter方法最后加上"return this;"并把返回参数改为CourseChapter可以实现连缀设置属性
	
	public Integer getCourseId() {
		return courseId;
	}

	public CourseChapter setCourseId(Integer courseId) {
		this.courseId = courseId;
		return this;
	}
	
	
	public String getCourseName() {
		return courseName;
	}

	public CourseChapter setCourseName(String courseName) {
		this.courseName = courseName;
		return this;
	}
	
	
	public String getChapterName() {
		return chapterName;
	}

	public CourseChapter setChapterName(String chapterName) {
		this.chapterName = chapterName;
		return this;
	}
	
	
	public String getChapterDesc() {
		return chapterDesc;
	}

	public CourseChapter setChapterDesc(String chapterDesc) {
		this.chapterDesc = chapterDesc;
		return this;
	}
	
	
	public Integer getChapterOrder() {
		return chapterOrder;
	}

	public CourseChapter setChapterOrder(Integer chapterOrder) {
		this.chapterOrder = chapterOrder;
		return this;
	}
	
	
	public Integer getLectureNum() {
		return lectureNum;
	}

	public CourseChapter setLectureNum(Integer lectureNum) {
		this.lectureNum = lectureNum;
		return this;
	}
	
	@Override
	public String toString() {
		return "CourseChapter [" + "id=" + getId() + ", courseId=" + courseId + ", courseName=" + courseName + ", chapterName=" + chapterName + ", chapterDesc=" + chapterDesc + ", chapterOrder=" + chapterOrder + ", lectureNum=" + lectureNum +  "]";
	}
}
