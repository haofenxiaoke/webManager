package com.kjs.common.dto.course;

public class CourseSortDto {
	private int id;
	 private int orderIndex;  //课程顺序

	public int getOrderIndex() {
		return orderIndex;
	}

	public void setOrderIndex(int orderIndex) {
		this.orderIndex = orderIndex;
	}

	@Override
	public String toString() {
		return "CourseSort [orderIndex=" + orderIndex + "]";
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}
	
	

}
