package com.kjs.service.kjs.system.spi;

import com.kjs.orm.model.SysDict;
import com.kjs.service.core.spi.IBaseService;

import java.util.Map;

/**
 * Service Interface:SysDict
 * @author duia_builder
 * @date 2016-5-23
 */
public interface ISysDictService extends IBaseService<SysDict,Long> {

    Map queryAllDicts();

    void deleteObj(Integer type);
	
}