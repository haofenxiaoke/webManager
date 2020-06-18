package com.kjs.orm.mapper;

import com.kjs.common.bean.annotation.CleanCache;
import com.kjs.orm.core.BaseMapper;
import com.kjs.orm.model.HomeSetCarousel;

@CleanCache(key="com.kjs.orm.mapper.HomeSetCarouselMapper")
public interface HomeSetCarouselMapper extends BaseMapper<HomeSetCarousel,Long> {

}