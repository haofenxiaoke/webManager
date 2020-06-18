package com.kjs.service.kjs.category.spi;

import com.kjs.common.dto.course.CourseFilterDto;
import com.kjs.orm.model.CategoryPosition;
import com.kjs.service.core.spi.IBaseService;
import com.kjs.web.serach.kjs.category.CategoryPositionSerachBean;

import java.util.List;
import java.util.Map;

/**
 * Service Interface:CategoryPosition
 * @author duia_builder
 * @date 2016-5-20
 */
public interface ICategoryPositionService extends IBaseService<CategoryPosition,Long> {
    void findCategoryPage(CategoryPositionSerachBean serachBean);//根据条件获取用户的数据(分页)
    Boolean checkCateUnique(CategoryPosition cate);

    void deleteById(CategoryPosition cate);

    List<CategoryPosition> getPositionByDirectionId(int directionId);//根据方向id获取分类列表

    void orderBy(Map paramMap);
    /**
     * 保存课程分类职位 同时生成对应得计划匹配组合
     * @param position
     */
    void savePosition(CategoryPosition position);

    Boolean countCheckDelPos(Integer positionId);
	CourseFilterDto find6PositionPage(String directionId, Boolean isMore);
}