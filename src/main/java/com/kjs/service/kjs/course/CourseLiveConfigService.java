package com.kjs.service.kjs.course;

import com.kjs.orm.mapper.CourseLiveConfigMapper;
import com.kjs.orm.model.CourseLive;
import com.kjs.orm.model.CourseLiveConfig;
import com.kjs.service.core.BaseService;
import com.kjs.service.kjs.course.spi.ICourseLiveConfigService;
import org.apache.commons.collections.CollectionUtils;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Service Implementation:CourseLiveConfig
 * @author 杨天峰
 * @date 2017-3-29
 */
@Service
public class CourseLiveConfigService extends BaseService<CourseLiveConfig,Long> implements ICourseLiveConfigService {

    @Resource
    CourseLiveConfigMapper courseLiveConfigMapper;
    @Override
    public Map findAllConfigLive() {
        Map liveCarouselMap=new HashMap();
        List<Integer> courIdList = new ArrayList<Integer>();
        List<String> liveTitleList = new ArrayList<String>();
        List<CourseLiveConfig> courseLiveConfigs=courseLiveConfigMapper.findAllConfigLive();
        if(!CollectionUtils.isEmpty(courseLiveConfigs)){
            for(CourseLiveConfig courseLiveConfig:courseLiveConfigs){
                courIdList.add(courseLiveConfig.getCourseId());
                liveTitleList.add(courseLiveConfig.getLiveTitle());
                liveCarouselMap.put("carouselId"+courseLiveConfig.getOrderNum(),courseLiveConfig.getId());
                liveCarouselMap.put("carouselUrl"+courseLiveConfig.getOrderNum(),courseLiveConfig.getHrefUrl());
                liveCarouselMap.put("type"+courseLiveConfig.getOrderNum(),courseLiveConfig.getType());
                liveCarouselMap.put("categoryId"+courseLiveConfig.getOrderNum(),courseLiveConfig.getCategoryId());
                liveCarouselMap.put("courseId"+courseLiveConfig.getOrderNum(),courseLiveConfig.getCourseId());
                liveCarouselMap.put("liveTitle"+courseLiveConfig.getOrderNum(),courseLiveConfig.getLiveTitle());
            }
            liveCarouselMap.put("courIdList",courIdList);
            liveCarouselMap.put("liveTitleList",liveTitleList);
        }
        return  liveCarouselMap;

    }

    @Override
    public List<CourseLive> findliveListByIdAndType(Integer directionId, Integer type) {
        return courseLiveConfigMapper.findliveListByIdAndType( directionId,type);
    }

    @Override
    public List<Integer> findAllIds() {return courseLiveConfigMapper.findAllIds();}

    @Override
    public List<Integer> findAllCourseIds() {
        return courseLiveConfigMapper.findAllCourseIds();
    }
}
