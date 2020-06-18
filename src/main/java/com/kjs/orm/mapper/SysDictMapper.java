package com.kjs.orm.mapper;

import com.kjs.common.bean.annotation.CleanCache;
import com.kjs.orm.core.BaseMapper;
import com.kjs.orm.model.SysDict;

@CleanCache(key="com.kjs.orm.mapper.SysDictMapper")
public interface SysDictMapper extends BaseMapper<SysDict,Long> {

    void deleteObj(Integer type);

}