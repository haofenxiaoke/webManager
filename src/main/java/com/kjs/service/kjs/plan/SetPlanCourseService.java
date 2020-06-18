package com.kjs.service.kjs.plan;

import com.kjs.common.utils.RequestParamUtils;
import com.kjs.common.utils.SortUtils;
import com.kjs.common.utils.StringUtil;
import com.kjs.orm.mapper.SetPlanCourseMapper;
import com.kjs.orm.model.SetPlanCourse;
import com.kjs.service.core.BaseService;
import com.kjs.service.kjs.plan.spi.ISetPlanCourseService;
import com.kjs.web.controller.kjs.index.IndexController;
import com.kjs.web.serach.kjs.plan.PlanManagerSerachBean;
import org.springframework.jca.cci.core.InteractionCallback;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.CollectionUtils;

import javax.annotation.Resource;
import java.util.*;

/**
 * Service Implementation:SetPlanCourse
 * @author duia_builder
 * @date 2016-5-23
 */
@Service
public class SetPlanCourseService extends BaseService<SetPlanCourse,Long> implements ISetPlanCourseService {
    @Resource
    private SetPlanCourseMapper setPlanCourseDao;

    public void findPage(PlanManagerSerachBean serachBean) {
        List<Map> list = this.setPlanCourseDao.pageInfo(serachBean);
        if(!CollectionUtils.isEmpty(list))
        {
            SortUtils.sortTheList(list, "plan_stage", SortUtils.SORT_ORDER_ASC);
            long count = this.setPlanCourseDao.countInfo(serachBean);
            serachBean.setRecordsTotal(count);
            serachBean.setRecordsFiltered(count);
            serachBean.setData(list);
        }
    }

    @Override
    public void saveCourses(Map paramMap) {
        Integer planId = Integer.valueOf((String)paramMap.get("planId"));
        String arry = String.valueOf(paramMap.get("courseIds"));

        Set<String> courseSet = new HashSet<String>(Arrays.asList(arry.split(",")));

        if(StringUtil.isNotEmpty(arry)){
            SetPlanCourse planCourse = new SetPlanCourse();
            //清空前获取该计划已选课程的阶段顺序
            planCourse.setPlanId(planId);
            List<SetPlanCourse> planCourseList = this.setPlanCourseDao.search(planCourse);
            Map<String,SetPlanCourse> courseMap = new HashMap<>();
            ArrayList<Long> removeList = new ArrayList();
            ArrayList<Integer> addList = new ArrayList();
            if(!CollectionUtils.isEmpty(planCourseList)){
                for(SetPlanCourse course:planCourseList){

                    if(courseSet.contains(course.getPlanCourseId().toString())){
                        addList.add(course.getPlanCourseId());
                    }else{
                        removeList.add(course.getId().longValue());
                    }

                }
            }

            //修改计划课程
            if(!CollectionUtils.isEmpty(removeList)){
                for(Long obj:removeList){
                    Long[]  ids= {obj};
                    setPlanCourseDao.deleteByIds(ids);
                }
            }

            //insert
            if(!CollectionUtils.isEmpty(courseSet)){
                for(String obj:courseSet){
                    Integer cid = Integer.valueOf(obj);
                    if(!addList.contains(cid)){
                        planCourse = new SetPlanCourse();
                        planCourse.setPlanId(RequestParamUtils.switchToInteger(planId));
                        planCourse.setPlanCourseId(cid);
                        planCourse.setCreateTime(new Date());
                        planCourse.setDeleted(false);
                        this.setPlanCourseDao.save(planCourse);
                    }
                }
            }
        }
    }

    @Override
    public void updatePlanCourse(Integer curId, Integer preId) {
        this.setPlanCourseDao.updateByCondition(curId,preId);
    }

    @Override
    public void deleteObj(Integer planId) {
        this.setPlanCourseDao.deleteObj(planId);
    }
}
