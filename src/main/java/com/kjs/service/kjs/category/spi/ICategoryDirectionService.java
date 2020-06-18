package com.kjs.service.kjs.category.spi;

import com.kjs.common.dto.auth.CateTreeDto;
import com.kjs.orm.model.CategoryDirection;
import com.kjs.orm.model.CategoryIndustry;
import com.kjs.orm.model.CategoryPosition;
import com.kjs.orm.model.Course;
import com.kjs.service.core.spi.IBaseService;
import com.kjs.web.serach.kjs.category.CategorySerachBean;

import java.util.List;
import java.util.Map;

/**
 * Service Interface:CategoryDirection
 * @author duia_builder
 * @date 2016-5-20
 */
public interface ICategoryDirectionService extends IBaseService<CategoryDirection,Long> {
    CateTreeDto findAllCateTreeByAuth(Long roleId, Long menuId, Long operId);

    List<CategoryDirection> findAllCates();

    void findCategoryPage(CategorySerachBean serachBean);//根据条件获取用户的数据(分页)

    Boolean checkCateUnique(CategoryDirection cate);
    Boolean checkDelUnique(Integer directionId);
    void deleteById(CategoryDirection cate);
    void orderBy(Map paramMap);

    /**
     * 获得用户某资源下对应操作 所拥有的分类
     * @param userId  用户id
     * @param operationCode 操作码
     * @param operationCode 操作码
     * @return 分类列表
     * @author 李恒名
     * @date 2016-6-6 18:27:15
     */
    List<CategoryDirection> findByUserIdAndResourceCodeAndOperationCode( Long userId,String resourceCode,String operationCode);

    /**
     * 获得用户某资源下对应操作 所拥有的分类的id数组
     * @param userId  用户id
     * @param operationCode 操作码
     * @param operationCode 操作码
     * @return 分类列表
     * @author 李恒名
     * @date 2016-6-6 18:27:15
     */
    Long[] findCateIdsByUserIdAndResourceCodeAndOperationCode(Long userId,String resourceCode, String operationCode);

    void saveCustomizePlan(CategoryDirection direction,CategoryIndustry industry,CategoryPosition position);

	Object find4HomePage();

	
}