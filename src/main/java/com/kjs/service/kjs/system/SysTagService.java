package com.kjs.service.kjs.system;

import com.kjs.common.utils.SortUtils;
import com.kjs.orm.mapper.SysTagMapper;
import com.kjs.orm.model.SysTag;
import com.kjs.service.core.BaseService;
import com.kjs.service.kjs.system.spi.ISysTagService;
import com.kjs.web.serach.kjs.system.SysTagSerachBean;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.CollectionUtils;

import javax.annotation.Resource;
import java.util.*;

/**
 * Service Implementation:SysTag
 * @author duia_builder
 * @date 2016-5-23
 */
@Transactional(rollbackFor=Exception.class)
@Service
public class SysTagService extends BaseService<SysTag,Long> implements ISysTagService {
    @Resource
    private SysTagMapper sysTagDao;

    @Override
    public List<SysTag> queryAllAdvantages(Integer type,Integer directionId) {
        return sysTagDao.queryAllAdvantages(type,directionId);
    }

    @Override
    public void findPage(SysTagSerachBean serachBean) {
        List<Map> sysTagList = this.sysTagDao.pageInfo(serachBean);
        if(!CollectionUtils.isEmpty(sysTagList))
        {
            SortUtils.sortTheList(sysTagList, "createTime", SortUtils.SORT_ORDER_DESC);
            long count = this.sysTagDao.countInfo(serachBean);
            serachBean.setRecordsTotal(count);
            serachBean.setRecordsFiltered(count);
            serachBean.setData(sysTagList);
        }
    }



    @Override
    public void findCatePage(SysTagSerachBean serachBean) {
        List<Map> sysTagList = this.sysTagDao.pageCateInfo(serachBean);
        if(!CollectionUtils.isEmpty(sysTagList))
        {
            long count = this.sysTagDao.countCateInfo(serachBean);
            serachBean.setRecordsTotal(count);
            serachBean.setRecordsFiltered(count);
            serachBean.setData(sysTagList);
        }
    }
    @Override
    public Boolean checkTagUnique(SysTag tag) {
        return this.sysTagDao.checkTagUnique(tag) == 0?true:false;
    }
    @Override
    public void deleteById(SysTag tag) {
        this.sysTagDao.deleteById(tag);
    }

    public List<SysTag> getTagList(Integer directionId) {

        return sysTagDao.queryAllAdvantages(2,directionId);
    }

    @Override
    public List<SysTag> getTagListByCourseId(int courseId) {
        return sysTagDao.getTagListByCourseId(courseId);
    }

    @Override
    public List<SysTag> getSuitableListByCourseId(int courseId) {
        return sysTagDao.getSuitableListByCourseId(courseId);
    }

    @Override
    public void searchSuitableVideo(SysTagSerachBean serachBean) {
        List<Map> suitlist = this.sysTagDao.searchSuitableVideo(serachBean);
        if(!CollectionUtils.isEmpty(suitlist))
        {
            SortUtils.sortTheList(suitlist, "createTime", SortUtils.SORT_ORDER_ASC);
            long count = this.sysTagDao.countSuitableInfo(serachBean);
            serachBean.setRecordsTotal(count);
            serachBean.setRecordsFiltered(count);
            serachBean.setData(suitlist);
        }
    }

    @Override
    public void searchAdvantageVideo(SysTagSerachBean serachBean) {
        List<Map> list = this.sysTagDao.searchAdvantageVideo(serachBean);
        if(!CollectionUtils.isEmpty(list))
        {
            SortUtils.sortTheList(list, "createTime", SortUtils.SORT_ORDER_ASC);
            long count = this.sysTagDao.countAdvantageInfo(serachBean);
            serachBean.setRecordsTotal(count);
            serachBean.setRecordsFiltered(count);
            serachBean.setData(list);
        }
    }

    @Override
    public void searchPlans(SysTagSerachBean serachBean) {
        List<Map> list = this.sysTagDao.searchPlans(serachBean);
        if(!CollectionUtils.isEmpty(list))
        {
            SortUtils.sortTheList(list, "createTime", SortUtils.SORT_ORDER_ASC);
            long count = this.sysTagDao.countPlansInfo(serachBean);
            serachBean.setRecordsTotal(count);
            serachBean.setRecordsFiltered(count);
            serachBean.setData(list);
        }
    }

    @Override
    public List<SysTag> queryAllPlans(Integer type,Integer directionId) {
        return this.sysTagDao.queryAllAdvantages(type,directionId);
    }

}
