package com.kjs.orm.core;
import com.kjs.common.bean.PageModel;

import java.io.Serializable;
import java.util.List;

public interface BaseMapper<T extends Serializable,PK extends Serializable> {

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


}
