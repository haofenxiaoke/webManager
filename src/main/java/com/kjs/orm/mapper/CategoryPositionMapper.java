package com.kjs.orm.mapper;

import com.kjs.common.bean.annotation.CleanCache;
import com.kjs.orm.core.BaseMapper;
import com.kjs.orm.model.CategoryPosition;
import org.apache.ibatis.annotations.Param;

import java.util.List;

@CleanCache(key="com.kjs.orm.mapper.CategoryPositionMapper")
public interface CategoryPositionMapper extends BaseMapper<CategoryPosition,Long> {

    Long selectMaxId();

    int checkCateUnique(CategoryPosition cate);

    int deleteById(CategoryPosition cate);

    List<CategoryPosition> getPositionByDirectionId(int directionId);

    List<CategoryPosition> getAll();

    int countCheckDel(@Param("directionId")Integer directionId);

	List<CategoryPosition> findPositionById(@Param("directionId")String directionId);

}