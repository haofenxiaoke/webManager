package com.kjs.service.kjs.home;

import com.kjs.common.utils.SortUtils;
import com.kjs.common.utils.StringUtil;
import com.kjs.orm.mapper.HomeSetMapper;
import com.kjs.orm.mapper.SysDictMapper;
import com.kjs.orm.model.HomeSet;
import com.kjs.orm.model.SysDict;
import com.kjs.service.core.BaseService;
import com.kjs.service.kjs.home.spi.IHomeSetService;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.CollectionUtils;

import javax.annotation.Resource;
import java.util.Date;
import java.util.List;
import java.util.Map;

/**
 * Service Implementation:HomeSet
 * @author duia_builder
 * @date 2016-5-23
 */
@Service
public class HomeSetService extends BaseService<HomeSet,Long> implements IHomeSetService {
    @Resource
    private HomeSetMapper homeSetDao;
    @Resource
    private SysDictMapper sysDictDao;

    @Override
    public List<Map> queryAllSets() {
        HomeSet homeSet = new HomeSet();
        List<Map> setList = this.homeSetDao.searchInfo(homeSet);
        if(!CollectionUtils.isEmpty(setList)){
            SortUtils.sortTheList(setList,"order_num",SortUtils.SORT_ORDER_ASC);
        }
        return setList;
    }

    @Override
    public HomeSet getSetByType(Integer type,List<HomeSet> setList) {
        HomeSet homeSet = new HomeSet();
        if(!CollectionUtils.isEmpty(setList))
        {
            for(HomeSet set:setList){
                if(type == set.getDirectionId()){
                    homeSet = set;
                }
            }
        }
        return homeSet;
    }

    @Override
    public List<Map> searchCoursesWithHomeSet() {
        return this.homeSetDao.searchCoursesWithHomeSet();
    }

    @Override
    public List<HomeSet> findHomeSet() {
        return homeSetDao.findHomeSet();
    }

    @Override
    public void updateHomeSet(Integer preCourseId,Integer courseId) {
        List<HomeSet> homeSetList=findHomeSet();

        for(HomeSet homeSet:homeSetList){

            boolean isUpdate=false;
            if(homeSet.getModule1()!=null&&homeSet.getModule1().intValue()==preCourseId){
                homeSet.setModule1(courseId);
                isUpdate=true;
            }else if(homeSet.getModule2()!=null&&homeSet.getModule2().intValue()==preCourseId){
                homeSet.setModule2(courseId);
                isUpdate=true;
            }else if (homeSet.getModule3()!=null&&homeSet.getModule3().intValue()==preCourseId){
                homeSet.setModule3(courseId);
                isUpdate=true;
            } else if (homeSet.getModule4()!=null&&homeSet.getModule4().intValue()==preCourseId){
                homeSet.setModule4(courseId);
                isUpdate=true;
            }else if (homeSet.getModule5()!=null&&homeSet.getModule5().intValue()==preCourseId){
                homeSet.setModule5(courseId);
                isUpdate=true;
            }else if(homeSet.getModule6()!=null&&homeSet.getModule6().intValue()==preCourseId){
                homeSet.setModule6(courseId);
                isUpdate=true;
            }else if (homeSet.getModule7()!=null&&homeSet.getModule7()==preCourseId){
                homeSet.setModule7(courseId);
                isUpdate=true;
            }else if(homeSet.getModule8()!=null&&homeSet.getModule8().intValue()==preCourseId){
                homeSet.setModule8(courseId);
                isUpdate=true;
            }
            if(isUpdate){
                homeSetDao.update(homeSet);
            }
        }

    }

    @Override
    public void saveHotEmp(Map paramMap) {
        sysDictDao.deleteObj(1);
        if(paramMap!=null && paramMap.size()>0){
            Map<String, String> map = SortUtils.sortMapByKey(paramMap);

            for(int i=1;i<=6;i++){
                SysDict dict = new SysDict();
                String content = StringUtil.isEmpty(map.get("hot" + i))?"":map.get("hot"+i);
                dict.setType(1);
                dict.setState(true);
                dict.setCreateTime(new Date());
                dict.setContent(content);
                sysDictDao.save(dict);
            }

        }
    }
}
