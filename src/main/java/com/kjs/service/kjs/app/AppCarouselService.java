package com.kjs.service.kjs.app;

import com.kjs.orm.mapper.AppCarouselMapper;
import com.kjs.orm.model.AppCarousel;
import com.kjs.service.core.BaseService;
import com.kjs.service.kjs.app.spi.IAppCarouselService;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.collections.CollectionUtils;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;

/**
 * Created by Administrator on 2016/12/29 0029.
 */
@Service
public class AppCarouselService extends BaseService<AppCarousel,Long> implements IAppCarouselService {
    @Resource
    private AppCarouselMapper appCarouselMapper;
    public Map findAll(){
        Map appCarouselMap=new HashMap();
        List<AppCarousel> appCarousels=appCarouselMapper.queryAll();
        if(!CollectionUtils.isEmpty(appCarousels)){
            for(AppCarousel appCarousel:appCarousels){
                appCarouselMap.put("carouselId"+appCarousel.getOrderNum(),appCarousel.getId());
                appCarouselMap.put("carouselUrl"+appCarousel.getOrderNum(),appCarousel.getPathUrl());
                appCarouselMap.put("hrefUrl"+appCarousel.getOrderNum(),appCarousel.getHrefUrl());
                appCarouselMap.put("type"+appCarousel.getOrderNum(),appCarousel.getType());
            }
        }
        return  appCarouselMap;
    }

}
