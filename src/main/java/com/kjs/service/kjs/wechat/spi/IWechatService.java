package com.kjs.service.kjs.wechat.spi;

import java.util.List;

import com.kjs.common.dto.wechat.WechatDataDto;
import com.kjs.common.dto.wechat.WechatDto;
import com.kjs.common.dto.wechat.WechatTypeDto;
import com.kjs.orm.model.Goods;
import com.kjs.service.core.spi.IBaseService;

public interface IWechatService extends IBaseService<Goods,Long>{

	void saveWechatBase(String wechatBase);

	WechatDto scanWechat(Integer id);

	void updateWechat(String wechatBase);

	void deleteWechat(Integer id);

	List<WechatDto> findGoodsList();

	List<WechatDataDto> findList(String startTime, String endTime, String dimesion, Integer type);

}
