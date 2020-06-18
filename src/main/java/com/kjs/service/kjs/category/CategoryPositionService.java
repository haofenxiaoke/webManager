package com.kjs.service.kjs.category;

import com.kjs.common.dto.course.CourseFilterDto;
import com.kjs.common.utils.RequestParamUtils;
import com.kjs.common.utils.SortUtils;
import com.kjs.orm.mapper.*;
import com.kjs.orm.model.CategoryDirection;
import com.kjs.orm.model.CategoryIndustry;
import com.kjs.orm.model.CategoryPosition;
import com.kjs.service.core.BaseService;
import com.kjs.service.kjs.category.spi.ICategoryDirectionService;
import com.kjs.service.kjs.category.spi.ICategoryPositionService;
import com.kjs.web.serach.kjs.category.CategoryPositionSerachBean;
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
 * Service Implementation:CategoryPosition
 * @author duia_builder
 * @date 2016-5-20
 */
@Service
public class CategoryPositionService extends BaseService<CategoryPosition,Long> implements ICategoryPositionService {
    @Resource
    private CategoryPositionMapper categoryPositionDao;
    @Resource
    private CategoryDirectionMapper categoryDirectionDao;
    @Resource
    private CategoryIndustryMapper categoryIndustryDao;
    @Resource
    private SetCustomizePlanMapper setCustomizePlanDao;
    @Resource
    private CourseMapper courseDao;
    @Resource
    private AuthorityPermissionMapper authorityPermissionDao;
    @Resource
    private ICategoryDirectionService categoryDirectionService;

    @Override
    public void deleteById(CategoryPosition cate) {
        categoryPositionDao.deleteById(cate);
        //删除相关的无内容的计划
        setCustomizePlanDao.deletePlanByCate(null,cate.getId().intValue());
    }

    @Override
    public void orderBy(Map paramMap) {
        if(paramMap!=null && paramMap.size()>0){
            Long firstid = RequestParamUtils.switchToLong(paramMap.get("firstid"));
            Integer firstnum = RequestParamUtils.switchToInteger(paramMap.get("firstnum"));
            Long lastid = RequestParamUtils.switchToLong(paramMap.get("lastid"));
            Integer lastnum = RequestParamUtils.switchToInteger(paramMap.get("lastnum"));
            CategoryPosition cate = new CategoryPosition();
            cate.setId(firstid);
            cate.setOrderNum(firstnum);
            this.categoryPositionDao.update(cate);
            cate.setId(lastid);
            cate.setOrderNum(lastnum);
            this.categoryPositionDao.update(cate);
        }
    }

    /**
     * 根据方向ID查询所有职位列表
     * @param directionId
     * @return
     */
    @Override
    public List<CategoryPosition> getPositionByDirectionId(int directionId) {
        return categoryPositionDao.getPositionByDirectionId(directionId);
    }

    @Override
    public void findCategoryPage(CategoryPositionSerachBean serachBean) {
        List<CategoryPosition> position = this.iBaseDao.page(serachBean);
        if(!CollectionUtils.isEmpty(position))
        {
            SortUtils.sortTheList(position, "orderNum", SortUtils.SORT_ORDER_ASC);
            long count = this.iBaseDao.count(serachBean);
            serachBean.setRecordsTotal(count);
            serachBean.setRecordsFiltered(count);
            serachBean.setData(position);
        }
    }

    @Override
    public Boolean checkCateUnique(CategoryPosition cate) {
        return this.categoryPositionDao.checkCateUnique(cate) == 0?true:false;
    }

    /**
     * 保存课程分类职位 同时生成对应得计划匹配组合
     * @param position
     */
    @Override
    public void savePosition(CategoryPosition position) {
        Date now = new Date();
        this.categoryPositionDao.save(position);
        position.setId(this.categoryPositionDao.selectMaxId());
        CategoryDirection direction = this.categoryDirectionDao.findById(position.getDirectionId().longValue());
        List<CategoryIndustry> industries= this.categoryIndustryDao.getIndustryByDirectionId(position.getDirectionId());
        if(!CollectionUtils.isEmpty(industries))
        {
            for(int i=0;i<industries.size();i++){
                categoryDirectionService.saveCustomizePlan(direction, industries.get(i), position);
            }
        }else{
            categoryDirectionService.saveCustomizePlan(direction, new CategoryIndustry(), position);
        }
    }
    @Override
    public Boolean countCheckDelPos(Integer positionId) {
        Boolean flag = false;
        if(this.courseDao.countCheckDelPos(positionId) > 0 || setCustomizePlanDao.countCheckDel(null,positionId)>0){
            flag =true;
        }
        return flag;
    }

	@Override
	public CourseFilterDto find6PositionPage(String directionId, Boolean isMore) {
		 List<CategoryPosition> positions = categoryPositionDao.findPositionById(directionId);

	        //去重复
	        List<String> listTemp= new ArrayList<String>();
	        List<CategoryPosition> positionList = new ArrayList<>();
	                Iterator<CategoryPosition> it=positions.iterator();
	        while(it.hasNext()){
	            CategoryPosition position=it.next();
	            if(!listTemp.contains(position.getCategoryDesc())){
	                listTemp.add(position .getCategoryDesc());
	                positionList.add(position);
	            }
	        }

	        int size = 10;
	        boolean flag = false;
	        if(positionList.size() > size) flag = true;
	        else size = positionList.size();

	        if(positionList!=null && positionList.size()>size && !isMore){
	            positionList = positionList.subList(size,positionList.size());
	        }else{
	            if(!isMore) positionList = new ArrayList<>();
	            else positionList = positionList.subList(0,size);
	        }

	        CourseFilterDto dto = new CourseFilterDto();
	        dto.setPositionList(positionList);
	        dto.setIsShowMore(flag);
	        return dto;
	    
	}
}
