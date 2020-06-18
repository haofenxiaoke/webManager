package com.kjs.service.kjs.category.spi;

import com.kjs.common.dto.course.CourseFilterDto;
import com.kjs.orm.model.CategoryIndustry;
import com.kjs.service.core.spi.IBaseService;
import com.kjs.web.serach.kjs.category.CategoryIndustrySerachBean;

import java.util.List;
import java.util.Map;

/**
 * Service Interface:CategoryIndustry
 * @author duia_builder
 * @date 2016-5-20
 */
public interface ICategoryIndustryService extends IBaseService<CategoryIndustry,Long> {
    void findCategoryPage(CategoryIndustrySerachBean serachBean);//根据条件获取用户的数据(分页)

    List<CategoryIndustry> getIndustryByDirectionId(int directionId);

    Boolean checkCateUnique(CategoryIndustry cate);

    void deleteById(CategoryIndustry cate);

    void orderBy(Map paramMap);
    /**
     * 根据课程id获取所有该课程已选择的行业标签
     * @param courseId
     * @return
     */
    public List<CategoryIndustry> getIndustryByCourseId(int courseId);
    /**
     * 保存课程分类行业 同时生成对应得计划匹配组合
     * @param industry
     */
    void saveIndustry(CategoryIndustry industry);

	CourseFilterDto find6IndustryPage(String directionId, Boolean isMore);

	

}