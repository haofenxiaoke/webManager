package com.kjs.service.spi.wechat;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.kjs.common.dto.wechat.WechatDataDto;
import com.kjs.common.dto.wechat.WechatDto;
import com.kjs.common.dto.wechat.WechatTypeDto;
import com.kjs.orm.mapper.GoodsMapper;
import com.kjs.orm.mapper.WechatMapper;
import com.kjs.orm.model.Goods;
import com.kjs.service.core.BaseService;
import com.kjs.service.kjs.wechat.spi.IWechatService;

@Service
public class WechatService extends BaseService<Goods,Long> implements IWechatService {
	
	@Resource
    private WechatMapper wechatDao;

	@Override
	public void saveWechatBase(String wechatBase) {
		System.out.println(wechatBase);
//		System.out.println("---------------------------------------------------------------------------------------");
		Gson gson = new GsonBuilder().create();
        WechatDto wechatBaseDto = gson.fromJson(wechatBase, WechatDto.class);    
        wechatBaseDto.setDeleted(0);
        wechatDao.saveWechatBase(wechatBaseDto);
		
	}

	@Override
	public WechatDto scanWechat(Integer id) {
		return wechatDao.scanWechat(id);
	}

	@Override
	public void updateWechat(String wechatBase) {
		Gson gson = new GsonBuilder().create();
        WechatDto wechatBaseDto = gson.fromJson(wechatBase, WechatDto.class);
		wechatDao.updateWechat(wechatBaseDto);
		
	}

	@Override
	public void deleteWechat(Integer id) {
		wechatDao.deleteWechat(id);
		
	}

	@Override
	public List<WechatDto> findGoodsList() {
		return wechatDao.findGoodsList();
	}

	@Override
	public List<WechatDataDto> findList(String startTime, String endTime, String dimesion, Integer type) {
		
		return wechatDao.findList(startTime,endTime ,dimesion,type);
	}

}
