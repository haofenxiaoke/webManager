package com.kjs.service.kjs.goods;


import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.kjs.common.dto.goods.GoodsTest;
import com.kjs.orm.mapper.GoodsMapper;
import com.kjs.orm.model.Article;
import com.kjs.orm.model.Goods;
import com.kjs.service.core.BaseService;
import com.kjs.service.kjs.goods.spi.IGoodsService;
import com.kjs.web.serach.kjs.goods.GoodsConditionBean;
@Service
public class GoodsService extends BaseService<Goods,Long> implements IGoodsService{
	
	@Resource
    private GoodsMapper goodsDao;

	@Override
	public void savegoodsBase(Goods goods) {
		// TODO Auto-generated method stub
		goodsDao.savegoodsBase(goods);
	}

	@Override
	public void findGoodsList(GoodsConditionBean goodsConditionBean) {
		// TODO Auto-generated method stub
		List<Goods> goods = this.goodsDao.page(goodsConditionBean);        
		goodsConditionBean.setData(goods);		
	}

	@Override
	public List<GoodsConditionBean> findGoodsList(GoodsTest goodsTest) {
		// TODO Auto-generated method stub
		return goodsDao.page(goodsTest);
	}

	@Override
	public void deleteGoods(Integer id,Integer deleted) {
		// TODO Auto-generated method stub
		this.goodsDao.deleteGoods(id,deleted);
	}

	@Override
	public Goods scanGoods(Integer id) {
		// TODO Auto-generated method stub
		return goodsDao.scanGoods(id);
	}

	@Override
	public void updateGoodsBase(Goods goods) {
		// TODO Auto-generated method stub
		goodsDao.updateGoodsBase(goods);

		
	}

	@Override
	public int addRemain(Integer id,Integer newRemain) {
		// TODO Auto-generated method stub
		return goodsDao.addRemain(id,newRemain);
	}

//	@Override
//	public void saveGoodsSon(List<Integer> idList) {
//		for(Integer id :idList){
//			goodsDao.saveGoodsSon();
//		}
		
//	}

}
