package com.kjs.service.core;
/**
 * Created by wangsongpeng on 2015/11/4.
 */
import com.kjs.common.bean.DataTablePageModel;
import com.kjs.common.bean.PageModel;
import com.kjs.orm.core.BaseMapper;
import com.kjs.orm.model.Course;
import com.kjs.service.core.spi.IBaseService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;

import java.io.Serializable;
import java.util.List;

public abstract class BaseService<T extends Serializable,PK extends  Serializable> implements IBaseService<T,PK>{
    Logger logger = LoggerFactory.getLogger(BaseService.class);
    @Autowired
    protected BaseMapper<T, PK> iBaseDao;

    @Override
    public T findById(PK id) {
        return iBaseDao.findById(id);
    }

    @Override
    public void save(T t) {
        this.iBaseDao.save(t);
    }

    @Override
    public void update(T t) {
        this.iBaseDao.update(t);
    }

    @Override
    public void delete(PK id) {
       this.iBaseDao.delete(id);
    }

    @Override
    public void deleteByIds(PK[] ids) {
       this.iBaseDao.deleteByIds(ids);
    }

    @Override
    public PK count() {
        return this.iBaseDao.count();
    }

    @Override
    public PK count(T t) {
        return this.iBaseDao.count(t);
    }

    @Override
    public PK count(PageModel pageModel){
        return this.iBaseDao.count(pageModel);
    }

    @Override
    public List<T> page(PageModel pageModel) {
        return this.iBaseDao.page(pageModel);
    }

    @Override
    public <T1> List<T1> search(T1 var1) {
        return this.iBaseDao.search(var1);
    }

    public DataTablePageModel buildModelBySearch(DataTablePageModel search) {
        List<T> data = this.iBaseDao.page(search);
        if(!data.isEmpty()){
            PK count = this.iBaseDao.count(search);
            search.setRecordsTotal((Long) count);
            search.setRecordsFiltered((Long) count);
            search.setData(data);
        }
        return search;
    }

	
}
