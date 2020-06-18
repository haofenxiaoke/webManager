package com.kjs.service.kjs.course.spi;

import com.kjs.orm.model.CourseLive;
import com.kjs.service.core.spi.IBaseService;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;

/**
 * Service Interface:CourseLive
 *
 * @author duia_builder
 * @date 2016 -5-23
 */
public interface ICourseLiveService extends IBaseService<CourseLive,Long> {


  /*  *//**
     * Build model by search.
     * 通过查询表单构建jquery table 所需要的Model
     *
     * @param search the search
     * @author 李恒名
     * @date 2016年6月1日 17:44:35
     *//*
    public void buildModelBySearch(CourseLiveSearchBean search);
*/
    /**
     * Logic delete.
     * @param id the id
     * @author 李恒名
     * @date 2016年6月1日 17:44:35
     */
    public void logicDelete(Long id);

    Map findLiveWatchNumByDate(ArrayList<Date> betweenTimes, List<Integer> ids);

    /**
     * 直播预约发送短信，创建定时任务
     * @param liveTime
     * @param liveId
     */
    void createLiveBookingTask(Date liveTime, Long liveId);

    /**
     * 直播预约发送短信，取消定时任务
     * @param liveId
     * @return
     */
    Boolean removeLiveBookingTask(final Long liveId);

    /**
     * 直播预约发送短信，更新定时任务
     * @param oldLiveTime
     * @param liveTime
     * @param liveId
     */
    void updateLiveBookingTask(Date oldLiveTime, Date liveTime, Long liveId);
}
