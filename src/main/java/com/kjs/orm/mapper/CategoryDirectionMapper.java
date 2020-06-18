package com.kjs.orm.mapper;

import com.kjs.common.bean.annotation.CleanCache;
import com.kjs.common.dto.auth.CateTreeDto;
import com.kjs.orm.core.BaseMapper;
import com.kjs.orm.model.CategoryDirection;
import com.kjs.web.serach.kjs.category.CategorySerachBean;
import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Map;
import java.util.Set;

@CleanCache(key="com.kjs.orm.mapper.CategoryDirectionMapper")
public interface CategoryDirectionMapper extends BaseMapper<CategoryDirection,Long> {
    CateTreeDto findAllCateTreeByAuth(Long roleId, Long menuId, Long operId);

    List<CategoryDirection> getAllCates(@Param("derectionIds") Long[] derectionIds,@Param("userId")String userId);

    int checkCateUnique(CategoryDirection cate);

    int deleteById(CategoryDirection cate);

    /**获取用户位于某资源下所拥有的分类Id列表
     * @param userId 用户ID
     * @param resId 资源ID
     * @return 分类列表
     * @Autor 李恒名
     * @Date 2016年5月31日 16:43:25
     */
    Set<String> findByUserIdAndResourceId(@Param("userId") Long userId, @Param("resId") Long resId);

    Set<String> findByUserIdAndOperationCode(@Param("userId") Long userId,  @Param("operationCode") String operationCode);

    Set<String> findByUserIdAndResourceCodeAndOperationCode(@Param("userId") Long userId, @Param("resourceCode")String resourceCode, @Param("operationCode") String operationCode);

    List<CategoryDirection> findByIds(Long... ids);

    List<Map> pageInfo(CategorySerachBean serachBean);

    Long countInfo(CategorySerachBean serachBean);

    List<CategoryDirection> findAllCates();
    
    
    
    /**
     * 通过表关联查询出主页菜单所需的关联数据
     * 查询所有方向，并将其下的行业，职位封装为List。
     * @author  李恒名
     * @return the list
     */
	List<CategoryDirection> select4HomeMenuByKJS();

}