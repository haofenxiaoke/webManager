package com.kjs.service.kjs.category;

import com.kjs.common.dto.course.CourseFilterDto;
import com.kjs.common.utils.RequestParamUtils;
import com.kjs.common.utils.SortUtils;
import com.kjs.orm.mapper.*;
import com.kjs.orm.model.CategoryDirection;
import com.kjs.orm.model.CategoryIndustry;
import com.kjs.orm.model.CategoryPosition;
import com.kjs.orm.model.SetCustomizePlan;
import com.kjs.service.core.BaseService;
import com.kjs.service.kjs.category.spi.ICategoryDirectionService;
import com.kjs.service.kjs.category.spi.ICategoryIndustryService;
import com.kjs.web.serach.kjs.category.CategoryIndustrySerachBean;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.CollectionUtils;

import javax.annotation.Resource;

import java.util.ArrayList;
import java.util.Date;
import java.util.Iterator;
import java.util.List;
import java.util.Map;


/**
 * Service Implementation:CategoryIndustry
 * @author duia_builder
 * @date 2016-5-20
 */
@Service
public class CategoryIndustryService extends BaseService<CategoryIndustry,Long> implements ICategoryIndustryService {
    @Resource
    private CategoryPositionMapper categoryPositionDao;
    @Resource
    private CategoryDirectionMapper categoryDirectionDao;
    @Resource
    private CategoryIndustryMapper categoryIndustryDao;
    @Resource
    private SetCustomizePlanMapper setCustomizePlanDao;
    @Resource
    private CourseIndustryMapper courseIndustryDao;
    @Resource
    private AuthorityPermissionMapper authorityPermissionDao;
    @Resource
    private ICategoryDirectionService categoryDirectionService;

    @Override
    public void deleteById(CategoryIndustry cate) {
        categoryIndustryDao.deleteById(cate);
        //删除相关的无内容的计划
        setCustomizePlanDao.deletePlanByCate(cate.getId().intValue(),null);
    }

    @Override
    public void orderBy(Map paramMap) {
        if(paramMap!=null && paramMap.size()>0){
            Long firstid = RequestParamUtils.switchToLong(paramMap.get("firstid"));
            Integer firstnum = RequestParamUtils.switchToInteger(paramMap.get("firstnum"));
            Long lastid = RequestParamUtils.switchToLong(paramMap.get("lastid"));
            Integer lastnum = RequestParamUtils.switchToInteger(paramMap.get("lastnum"));
            CategoryIndustry cate = new CategoryIndustry();
            cate.setId(firstid);
            cate.setOrderNum(firstnum);
            this.categoryIndustryDao.update(cate);
            cate.setId(lastid);
            cate.setOrderNum(lastnum);
            this.categoryIndustryDao.update(cate);
        }
    }

    @Override
    public void findCategoryPage(CategoryIndustrySerachBean serachBean) {
        List<CategoryIndustry> industry = this.iBaseDao.page(serachBean);
        if(!CollectionUtils.isEmpty(industry))
        {
            SortUtils.sortTheList(industry, "orderNum", SortUtils.SORT_ORDER_ASC);
            long count = this.iBaseDao.count(serachBean);
            serachBean.setRecordsTotal(count);
            serachBean.setRecordsFiltered(count);
            serachBean.setData(industry);
        }
    }

    @Override
    public List<CategoryIndustry> getIndustryByDirectionId(int directionId) {
        return categoryIndustryDao.getIndustryByDirectionId(directionId);
    }

    @Override
    public Boolean checkCateUnique(CategoryIndustry cate) {
        return this.categoryIndustryDao.checkCateUnique(cate) == 0?true:false;
    }

    @Override
    public List<CategoryIndustry> getIndustryByCourseId(int courseId) {
        return categoryIndustryDao.getIndustryByCourseId(courseId);
    }

    /**
     * 保存课程分类行业 同时生成对应得计划匹配组合
     * @param industry
     */
    @Override
    public void saveIndustry(CategoryIndustry industry) {
        Date now = new Date();
        this.categoryIndustryDao.save(industry);

        industry.setId(this.categoryIndustryDao.selectMaxId());
        CategoryDirection direction = this.categoryDirectionDao.findById(industry.getDirectionId().longValue());

        List<CategoryPosition> positions=this.categoryPositionDao.getPositionByDirectionId(industry.getDirectionId());
        if(!CollectionUtils.isEmpty(positions))
        {
            for(int i=0;i<positions.size();i++){
                SetCustomizePlan setCustomizePlan=new SetCustomizePlan();
                categoryDirectionService.saveCustomizePlan(direction,industry,positions.get(i));
            }
        }

    }

	@Override
	public CourseFilterDto find6IndustryPage(String directionId, Boolean isMore) {
		List<CategoryIndustry> industrys = categoryIndustryDao.findIndustryById(directionId);

        //去重复
        List<String> listTemp= new ArrayList<String>();
        List<CategoryIndustry> industryList =  new ArrayList<>();
        Iterator<CategoryIndustry> it=industrys.iterator();
        while(it.hasNext()){
            CategoryIndustry industry=it.next();
            if(!listTemp.contains(industry.getCategoryDesc())){
                listTemp.add(industry.getCategoryDesc());
                industryList.add(industry);
            }
        }

        int size = 10;
        boolean flag = false;
        if(industryList.size() > size) flag = true;
        else size = industryList.size();

        if(industryList!=null && industryList.size()>size && !isMore){
            industryList = industryList.subList(size,industryList.size());
        }else{
            if(!isMore) industryList = new ArrayList<>();
            else industryList = industryList.subList(0,size);
        }

        CourseFilterDto dto = new CourseFilterDto();
        dto.setIndustryList(industryList);
        dto.setIsShowMore(flag);
        return dto;
	}

}
