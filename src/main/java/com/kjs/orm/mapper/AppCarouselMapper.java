package com.kjs.orm.mapper;

import com.kjs.orm.core.BaseMapper;
import com.kjs.orm.model.AppCarousel;
import java.util.List;

/**
 *
 * Created by Administrator on 2016/12/29 0029.
 */
public interface AppCarouselMapper extends BaseMapper<AppCarousel,Long> {
    public List<AppCarousel> queryAll();
}


