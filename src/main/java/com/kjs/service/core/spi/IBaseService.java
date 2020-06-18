package com.kjs.service.core.spi;

import com.kjs.common.bean.DataTablePageModel;
import com.kjs.common.bean.PageModel;

import java.io.Serializable;
import java.util.List;

/**
 * Created by wangsongpeng on 2015/11/4.
 */
public interface IBaseService<T extends Serializable,PK extends Serializable> {

    T findById(PK id);

    void save(T t);

    void update(T t);

    void delete(PK id);

    void deleteByIds(PK[] ids);

    PK count();

    PK count(T t);

    PK count(PageModel pageModel);

    List<T> page(PageModel pageModel);

    <T> List<T> search(T var1);

    /**
     * Build model by search.
     * 通过查询表单构建jquery table 所需要的Model
     *
     * @param search the search
     * @author 李恒名
     * @date 2016年6月1日 17:44:35
     */
    DataTablePageModel buildModelBySearch(DataTablePageModel search);
}
