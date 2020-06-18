package com.kjs.service.kjs.home;

import com.kjs.orm.mapper.HomeSetCarouselMapper;
import com.kjs.orm.model.HomeSetCarousel;
import com.kjs.service.core.BaseService;
import com.kjs.service.kjs.home.spi.IHomeSetCarouselService;
import org.springframework.stereotype.Service;
import org.springframework.util.CollectionUtils;

import javax.annotation.Resource;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Service Implementation:HomeSetCarousel
 * @author duia_builder
 * @date 2016-5-23
 */
@Service
public class HomeSetCarouselService extends BaseService<HomeSetCarousel,Long> implements IHomeSetCarouselService {
    @Resource
    private HomeSetCarouselMapper homeSetCarouselDao;
    @Override
    public Map queryAllCarousels() {
        Map carouselMap = new HashMap();
        HomeSetCarousel homeSetCarousel = new HomeSetCarousel();
        List<HomeSetCarousel> carouselList = this.homeSetCarouselDao.search(homeSetCarousel);
        if(!CollectionUtils.isEmpty(carouselList))
        {
            for(HomeSetCarousel carouse:carouselList){
                carouselMap.put("carouselId"+carouse.getOrderNum(),carouse.getId());
                carouselMap.put("carouselUrl"+carouse.getOrderNum(),carouse.getPathUrl());
                carouselMap.put("hrefUrl"+carouse.getOrderNum(),carouse.getHrefUrl());
                carouselMap.put("bgcolor"+carouse.getOrderNum(),carouse.getBgcolor());
            }
        }
        return carouselMap;
    }
}
