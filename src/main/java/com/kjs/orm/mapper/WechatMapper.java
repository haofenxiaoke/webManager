package com.kjs.orm.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.kjs.common.bean.annotation.CleanCache;
import com.kjs.common.dto.wechat.WechatDataDto;
import com.kjs.common.dto.wechat.WechatDto;
import com.kjs.common.dto.wechat.WechatTypeDto;
import com.kjs.orm.core.BaseMapper;
import com.kjs.orm.model.Wechat;

@CleanCache(key="com.kjs.orm.mapper.WechatMapper")
public interface WechatMapper extends BaseMapper<Wechat,Long>{

	void saveWechatBase(WechatDto wechatBaseDto);

	WechatDto scanWechat(Integer id);

	void updateWechat(WechatDto wechatBaseDto);

	void deleteWechat(Integer id);

	List<WechatDto> findGoodsList();

	List<WechatDataDto> findList(@Param("startTime")String startTime, 
			@Param("endTime")String endTime,
			@Param("dimesion") String dimesion, 
			@Param("type")Integer type);

}
