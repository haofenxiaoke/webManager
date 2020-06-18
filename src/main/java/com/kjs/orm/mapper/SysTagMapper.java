package com.kjs.orm.mapper;

import com.kjs.orm.core.BaseMapper;
import com.kjs.orm.model.SysTag;
import com.kjs.web.serach.kjs.system.SysTagSerachBean;
import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Map;

public interface SysTagMapper extends BaseMapper<SysTag,Long> {
    List<Map> pageCateInfo(SysTagSerachBean serachBean);

    Long countCateInfo(SysTagSerachBean serachBean);

    List<Map> pageInfo(SysTagSerachBean serachBean);

    Long countInfo(SysTagSerachBean serachBean);

    int checkTagUnique(SysTag tag);

    int deleteById(SysTag tag);

    List<Map> searchSuitableVideo(SysTagSerachBean serachBean);

    List<Map> searchAdvantageVideo(SysTagSerachBean serachBean);

    List<Map> searchPlans(SysTagSerachBean serachBean);

    Long countSuitableInfo(SysTagSerachBean serachBean);

    Long countAdvantageInfo(SysTagSerachBean serachBean);

    Long countPlansInfo(SysTagSerachBean serachBean);

    /**
     * 筛选出所有属于课程优势的标签
     * @return
     */
    public  List<SysTag> queryAllAdvantages(@Param("type")Integer type,@Param("directionId")Integer directionId);
    /**
     * 根据课程Id从标签表中筛选出课程优势标签
     * @param courseId
     * @return
     */
    public List<SysTag> getTagListByCourseId(int courseId);

    /**
     * 根据课程Id从标签表中筛选出适合对象标签
     * @param courseId
     * @return
     */
    public List<SysTag> getSuitableListByCourseId(int courseId);

    /**
     * 保存课程是 为其所选的课程优势标签加1
     * @param sysTagId
     */
    public void updateSysTagById(int sysTagId);
}