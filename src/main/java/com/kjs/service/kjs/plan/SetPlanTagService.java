package com.kjs.service.kjs.plan;

import com.kjs.common.utils.SortUtils;
import com.kjs.orm.mapper.SetPlanTagMapper;
import com.kjs.orm.model.SetPlanTag;
import com.kjs.service.core.BaseService;
import com.kjs.service.kjs.plan.spi.ISetPlanTagService;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.CollectionUtils;

import javax.annotation.Resource;
import java.util.*;

/**
 * Service Implementation:SetPlanTag
 * @author duia_builder
 * @date 2016-6-15
 */
@Service
public class SetPlanTagService extends BaseService<SetPlanTag,Long> implements ISetPlanTagService {
    @Resource
    private SetPlanTagMapper setPlanTagDao;
    @Override
    public Map searchTagsByPlanId(Integer planId) {
        Map tagMap = new HashMap();
        List<SetPlanTag> tags = this.setPlanTagDao.searchTagsByPlanId(planId);
        if(!CollectionUtils.isEmpty(tags))
        {
            SortUtils.sortTheList(tags, "orderNum", SortUtils.SORT_ORDER_ASC);
            for(SetPlanTag tag:tags){
                tagMap.put("planTag"+tag.getOrderNum(),tag.getPlanTagId());
                tagMap.put("tagId"+tag.getOrderNum(),tag.getId());
            }
        }
        return tagMap;
    }

    @Override
    public void deleteObj(Integer planId) {
        this.setPlanTagDao.deleteObj(planId);
    }
}
