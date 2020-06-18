package com.kjs.service.kjs.user.spi;

import com.kjs.orm.model.VipInfo;
import com.kjs.service.core.spi.IBaseService;

import java.util.List;
import java.util.Map;

/**
 * Service Interface:VipInfo
 * @author duia_builder
 * @date 2016-5-23
 */
public interface IVipInfoService extends IBaseService<VipInfo,Long> {
	List<VipInfo> queryAll();
	Map switchDataToObject(Map paramMap);
	void saveEmp(Map<String,VipInfo> map);
}