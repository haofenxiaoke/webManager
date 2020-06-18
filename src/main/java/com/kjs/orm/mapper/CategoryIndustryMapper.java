package com.kjs.orm.mapper;

import com.kjs.common.bean.annotation.CleanCache;
import com.kjs.orm.core.BaseMapper;
import com.kjs.orm.model.CategoryIndustry;
import org.apache.ibatis.annotations.Param;

import java.util.List;

@CleanCache(key="com.kjs.orm.mapper.CategoryIndustryMapper")
public interface CategoryIndustryMapper extends BaseMapper<CategoryIndustry,Long> {

    Long selectMaxId();

    int checkCateUnique(CategoryIndustry cate);

    int deleteById(CategoryIndustry cate);

    List<CategoryIndustry> getAll();

    List<CategoryIndustry> getIndustryByDirectionId(int directionId);

    /**
     * 根据课程id获取课程所选行业标签
     * @param courseId
     * @return
     */
    List<CategoryIndustry> getIndustryByCourseId(int courseId);

    int countCheckDel(@Param("directionId")Integer directionId);

    int countCheckDelInd(CategoryIndustry cate);

	List<CategoryIndustry> findIndustryById(@Param("directionId")String directionId);
}