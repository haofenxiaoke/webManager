package com.kjs.service.kjs.home.spi;

import com.kjs.orm.model.HomeSetCarousel;
import com.kjs.service.core.spi.IBaseService;

import java.util.Map;

/**
 * Service Interface:HomeSetCarousel
 * @author duia_builder
 * @date 2016-5-23
 */
public interface IHomeSetCarouselService extends IBaseService<HomeSetCarousel,Long> {

    Map queryAllCarousels();

}