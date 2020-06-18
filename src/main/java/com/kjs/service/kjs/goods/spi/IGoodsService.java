package com.kjs.service.kjs.goods.spi;

import java.util.List;

import com.kjs.common.dto.goods.GoodsTest;
import com.kjs.orm.model.Goods;
import com.kjs.service.core.spi.IBaseService;
import com.kjs.web.serach.kjs.goods.GoodsConditionBean;

public interface IGoodsService extends IBaseService<Goods,Long>{

	public void savegoodsBase(Goods goods);

	public void findGoodsList(GoodsConditionBean goodsConditionBean);

	public List<GoodsConditionBean> findGoodsList(GoodsTest goodsTest);

	public void deleteGoods(Integer id, Integer deleted);

	public Goods scanGoods(Integer id);

	public void updateGoodsBase(Goods goods);

	public int addRemain(Integer id, Integer newRemain);

//	public void saveGoodsSon(List<Integer> idList);

}
