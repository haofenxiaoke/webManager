package com.kjs.orm.mapper;

import com.kjs.common.bean.annotation.CleanCache;
import com.kjs.common.dto.LiveWatchNumDTO;
import com.kjs.orm.core.BaseMapper;
import com.kjs.orm.model.CourseLive;
import org.apache.ibatis.annotations.Param;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
@CleanCache(key="com.kjs.orm.mapper.CourseLiveMapper")
public interface CourseLiveMapper extends BaseMapper<CourseLive,Long> {

    public List<CourseLive> queryAll();

    int countCheckDel(@Param("categoryId") Integer directionId);

    List<String> findCourseLiveTitleByIds(@Param("ids") List<Integer> ids);

    List<CourseLive> initScheduled();

    List<LiveWatchNumDTO> findLiveWatchNumByDates(@Param("betweenTimes") ArrayList<Date> betweenTimes,@Param("ids")  List<Integer> ids);

    List<LiveWatchNumDTO> findLiveTitlesByLiveIds(@Param("ids")List<Integer> ids);

}
