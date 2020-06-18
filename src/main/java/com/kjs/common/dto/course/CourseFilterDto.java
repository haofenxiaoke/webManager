package com.kjs.common.dto.course;

import java.util.List;

import com.kjs.orm.model.CategoryIndustry;
import com.kjs.orm.model.CategoryPosition;

public class CourseFilterDto {

	private boolean isShowMore;
    private List<CategoryPosition> positionList;
    private List<CategoryIndustry> industryList;
	public boolean isShowMore() {
		return isShowMore;
	}
	public void setIsShowMore(boolean isShowMore) {
		this.isShowMore = isShowMore;
	}
	public List<CategoryPosition> getPositionList() {
		return positionList;
	}
	public void setPositionList(List<CategoryPosition> positionList) {
		this.positionList = positionList;
	}
	public List<CategoryIndustry> getIndustryList() {
		return industryList;
	}
	public void setIndustryList(List<CategoryIndustry> industryList) {
		this.industryList = industryList;
	}
    
    

}
