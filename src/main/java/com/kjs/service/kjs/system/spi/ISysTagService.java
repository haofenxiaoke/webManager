package com.kjs.service.kjs.system.spi;

import com.kjs.orm.model.SysTag;
import com.kjs.service.core.spi.IBaseService;
import com.kjs.web.serach.kjs.system.SysTagSerachBean;

import java.util.List;

/**
 * Service Interface:SysTag
 * @author duia_builder
 * @date 2016-5-23
 */
public interface ISysTagService extends IBaseService<SysTag,Long> {
    /**
     * 获取所有标签列表
     * @return
     */
    public List<SysTag> getTagList(Integer directionId);

    /**
     * 筛选出所有属于课程优势的标签
     * @return
     */
    public  List<SysTag> queryAllAdvantages(Integer type,Integer directionId);
    /**
     * 根据课程Id从标签表中筛选出课程优势标签
     * @param courseId
     * @return
     */
    public List<SysTag> getTagListByCourseId(int courseId);
    /**
     * 根据课程Id从标签表中筛选出课程优势标签
     * @param courseId
     * @return
     */
    public List<SysTag> getSuitableListByCourseId(int courseId);


    void findPage(SysTagSerachBean serachBean);//根据条件获取数据(分页)
    void findCatePage(SysTagSerachBean serachBean);//根据条件获取数据(分页)
    Boolean checkTagUnique(SysTag tag);
    void deleteById(SysTag tag);
    void searchSuitableVideo(SysTagSerachBean serachBean);
    void searchAdvantageVideo(SysTagSerachBean serachBean);
    void searchPlans(SysTagSerachBean serachBean);

    /**
     * 筛选出所有属于计划的标签
     * @return
     */
    public List<SysTag> queryAllPlans(Integer type,Integer directionId);
}