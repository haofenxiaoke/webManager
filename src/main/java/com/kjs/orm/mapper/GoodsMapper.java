package com.kjs.orm.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.kjs.common.bean.annotation.CleanCache;
import com.kjs.common.dto.goods.GoodsTest;
import com.kjs.orm.core.BaseMapper;
import com.kjs.orm.model.Goods;
import com.kjs.web.serach.kjs.goods.GoodsConditionBean;

@CleanCache(key="com.kjs.orm.mapper.GoodsMapper")
public interface GoodsMapper extends BaseMapper<Goods,Long>{

	

	public void savegoodsBase(Goods goods);

	public List<GoodsConditionBean> page(GoodsTest goodsTest);

	public void deleteGoods(@Param("id")Integer id, @Param("deleted")Integer deleted);

	public Goods scanGoods(Integer id);

	public void updateGoodsBase(Goods goods);

	public int addRemain(@Param("id")Integer id, @Param("newRemain")Integer newRemain);

}
