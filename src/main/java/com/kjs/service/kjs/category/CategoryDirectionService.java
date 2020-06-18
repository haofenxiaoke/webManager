package com.kjs.service.kjs.category;

import static com.kjs.common.bean.Constants.PRODUCT_ID_会计狮;

import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.Date;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.util.CollectionUtils;

import com.kjs.common.bean.ParamUtil;
import com.kjs.common.constant.SystemConstant;
import com.kjs.common.dto.auth.CateTreeDto;
import com.kjs.common.utils.RequestParamUtils;
import com.kjs.common.utils.ShiroUtils;
import com.kjs.common.utils.SortUtils;
import com.kjs.orm.mapper.AuthorityPermissionMapper;
import com.kjs.orm.mapper.CategoryDirectionMapper;
import com.kjs.orm.mapper.CategoryIndustryMapper;
import com.kjs.orm.mapper.CategoryPositionMapper;
import com.kjs.orm.mapper.CourseLiveMapper;
import com.kjs.orm.mapper.CourseMapper;
import com.kjs.orm.mapper.SetCustomizePlanMapper;
import com.kjs.orm.model.CategoryDirection;
import com.kjs.orm.model.CategoryIndustry;
import com.kjs.orm.model.CategoryPosition;
import com.kjs.orm.model.SetCustomizePlan;
import com.kjs.service.core.BaseService;
import com.kjs.service.kjs.category.spi.ICategoryDirectionService;
import com.kjs.web.serach.kjs.category.CategorySerachBean;


/**
 * Service Implementation:CategoryDirection
 * @author duia_builder
 * @date 2016-5-20
 */
@Service
public class CategoryDirectionService extends BaseService<CategoryDirection,Long> implements ICategoryDirectionService {
    @Resource
    private CategoryDirectionMapper categoryDirectionDao;
    @Resource
    private CategoryIndustryMapper categoryIndustryDao;
    @Resource
    private CategoryPositionMapper categoryPositionDao;
    @Resource
    private CourseMapper courseDao;
    @Resource
    private CourseLiveMapper courseLiveDao;
    @Resource
    private SetCustomizePlanMapper setCustomizePlanDao;
    @Resource
    private AuthorityPermissionMapper authorityPermissionDao;
    @Resource
    private ICategoryDirectionService categoryDirectionService;

    @Override
    public void findCategoryPage(CategorySerachBean serachBean) {
        Long userId = ShiroUtils.getSessionUser().getId();
        serachBean.setUserid(userId.intValue());
        List<Map> direction = this.categoryDirectionDao.pageInfo(serachBean);
        if(!CollectionUtils.isEmpty(direction))
        {
            SortUtils.sortTheList(direction,"order_num",SortUtils.SORT_ORDER_ASC);
            long count = this.categoryDirectionDao.countInfo(serachBean);
            serachBean.setRecordsTotal(count);
            serachBean.setRecordsFiltered(count);
            serachBean.setData(direction);
        }
    }

    @Override
    public void deleteById(CategoryDirection cate) {
        categoryDirectionDao.deleteById(cate);
    }

    @Override
    public Boolean checkCateUnique(CategoryDirection cate) {
        return this.categoryDirectionDao.checkCateUnique(cate) == 0?true:false;
    }

    @Override
    public void orderBy(Map paramMap) {
        if(paramMap!=null && paramMap.size()>0){
            Long firstid = RequestParamUtils.switchToLong(paramMap.get("firstid"));
            Integer firstnum = RequestParamUtils.switchToInteger(paramMap.get("firstnum"));
            Long lastid = RequestParamUtils.switchToLong(paramMap.get("lastid"));
            Integer lastnum = RequestParamUtils.switchToInteger(paramMap.get("lastnum"));
            CategoryDirection cate = new CategoryDirection();
            cate.setId(firstid);
            cate.setOrderNum(firstnum);
            this.categoryDirectionDao.update(cate);
            cate.setId(lastid);
            cate.setOrderNum(lastnum);
            this.categoryDirectionDao.update(cate);
        }
    }

    @Override
    public Long[] findCateIdsByUserIdAndResourceCodeAndOperationCode(Long userId,String resourceCode, String operationCode){
        Set<String> strIds;
        Long[] ids = new Long[]{};
        Set<Long> set = new HashSet<>();

        //有效的分类
        List<CategoryDirection> directions = categoryDirectionDao.findAllCates();
        Map<Long,CategoryDirection> directionMap = new HashMap<>();
        if(!CollectionUtils.isEmpty(directions)){
            for(CategoryDirection direction:directions){
                set.add(direction.getId());
                directionMap.put(direction.getId(),direction);
            }
        }

        if(userId.equals(1L)){//管理员拥有所有方向的权限
        }else{
            strIds = categoryDirectionDao.findByUserIdAndResourceCodeAndOperationCode(userId, resourceCode, operationCode);
            String reg = "^\\d+$";
            for (String id : strIds) {
                if(!id.matches(reg)){
                    String[] split = id.split("-");
                    if(split.length > 1&& split[1].matches(reg)){
                        if(directionMap.containsKey(Long.valueOf(split[1]))){
                            set.add(Long.valueOf(split[1]));
                        }
                    }
                }else{
                    if(directionMap.containsKey(Long.valueOf(id))){
                        set.add(Long.valueOf(id));
                    }
                }
            }
        }

        ids = set.toArray(new Long[]{});
        return ids;
    }

    @Override
    public List<CategoryDirection> findByUserIdAndResourceCodeAndOperationCode(Long userId,String resourceCode, String operationCode) {
        Long[] ids = findCateIdsByUserIdAndResourceCodeAndOperationCode(userId, resourceCode, operationCode);
        if(userId == 1) ids = null;
        return categoryDirectionDao.findByIds(ids);
    }

    /**
     * @param roleId
     * @param menuId
     * @param operId
     * @return
     */
    @Override
    public CateTreeDto findAllCateTreeByAuth(Long roleId, Long menuId, Long operId) {
        //
        CateTreeDto root = new CateTreeDto("-1L","全部课程分类",true);
        Long userId = ShiroUtils.getSessionUser().getId();
        Long[] derectionIds = categoryDirectionService.findCateIdsByUserIdAndResourceCodeAndOperationCode(userId, "cate", "find");
        List<CategoryDirection> dicts = this.categoryDirectionDao.getAllCates(derectionIds,String.valueOf(userId));//
        List<CategoryIndustry> industrys = this.categoryIndustryDao.getAll();//行业
        List<CategoryPosition> positions = this.categoryPositionDao.getAll();//职位
        if(!CollectionUtils.isEmpty(dicts)){
            Map map = new HashMap();
            map.put("roleId",roleId);
            map.put("menuId",menuId);
            map.put("operId",operId);
            List<String> cateIds = this.authorityPermissionDao.getCateIdByRoleMenuOper(map);
            int k = 0;
            for(CategoryDirection d:dicts){
                CateTreeDto st = new CateTreeDto();
                st.setId(d.getId().toString());
                st.setName(d.getCategoryDesc());
                st.setChecked(cateIds.contains(String.valueOf(d.getId())));//方向选中
                st.setParent(false);
                st.setOpen(false);
                //分类 行业，职位
                CateTreeDto  root1 = new CateTreeDto(SystemConstant.CATE_INDUSTRY_CODE,ParamUtil.CATE_2,true);
                root1.setOpen(false);
                if(industrys !=null){
                    int i = 0;
                    List<CateTreeDto> inlist = new ArrayList<CateTreeDto>();
                    for(CategoryIndustry c:industrys){
                        CateTreeDto cate = new CateTreeDto();
                        cate.setId(SystemConstant.CATE_INDUSTRY_CODE+"-"+d.getId()+"-"+c.getId());
                        cate.setName(c.getCategoryDesc());
                        cate.setChecked(cateIds.contains(SystemConstant.CATE_INDUSTRY_CODE+"-"+d.getId()+"-"+c.getId()));
                        cate.setParent(false);
                        if(d.getId().equals(c.getDirectionId().longValue())){
                            inlist.add(cate);
                        }
                        //行业选中
                        if(cateIds.contains(SystemConstant.CATE_INDUSTRY_CODE + "-" + d.getId() + "-" + c.getId())){
                            i++;
                            k++;
                        }
                    }
                    if(i>0){
                        root1.setChecked(true);
                        i = 0;
                    }
                    root1.setChildren(inlist);
                }
                CateTreeDto  root2 = new CateTreeDto(SystemConstant.CATE_POSITION_CODE,ParamUtil.CATE_3,true);
                root2.setOpen(false);
                if(positions !=null){
                    int j = 0;
                    List<CateTreeDto> poslist = new ArrayList<CateTreeDto>();
                    for(CategoryPosition c:positions){
                        CateTreeDto cate = new CateTreeDto();
                        cate.setId(SystemConstant.CATE_POSITION_CODE+"-"+d.getId()+"-"+c.getId());
                        cate.setName(c.getCategoryDesc());
                        cate.setChecked(cateIds.contains(SystemConstant.CATE_POSITION_CODE+"-"+d.getId()+"-"+c.getId()));
                        cate.setParent(false);
                        if(d.getId().equals(c.getDirectionId().longValue())){
                            poslist.add(cate);
                        }
                        //职位选中
                        if(cateIds.contains(SystemConstant.CATE_POSITION_CODE + "-" + d.getId() + "-" + c.getId())){
                            j++;
                            k++;
                        }
                    }
                    if(j>0){
                        root2.setChecked(true);
                        j = 0;
                    }
                    root2.setChildren(poslist);
                }
                List<CateTreeDto> list = new ArrayList<CateTreeDto>();
                if(d.getId() != 0){
                    if(ParamUtil.CATE_2 != null)
                        list.add(root1);
                    if(ParamUtil.CATE_3 != null)
                        list.add(root2);
                    st.setParent(true);
                    st.setChildren(list);
                }
                //全选选中
                if(k>0){
                    root.setChecked(true);
                    k = 0;
                }
                root.getChildren().add(st);
            }

        }
        return root;
    }

    /**
     * 获取type是item所有cate列表 有序
     * @return
     */
    @Override
    public List<CategoryDirection> findAllCates() {
        Long userId = ShiroUtils.getSessionUser().getId();
        Long[] derectionIds = categoryDirectionService.findCateIdsByUserIdAndResourceCodeAndOperationCode(userId, "cate", "find");
        return this.categoryDirectionDao.getAllCates(derectionIds, String.valueOf(userId));//所有分类
    }

    /**
     *  删除验证
     * @param directionId
     * @return
     */
    @Override
    public Boolean checkDelUnique(Integer directionId) {
        Boolean flag = false;
        if( (ParamUtil.CATE_2 == null?false:this.categoryIndustryDao.countCheckDel(directionId) > 0)
                || (ParamUtil.CATE_3 == null?false:this.categoryPositionDao.countCheckDel(directionId) > 0)
                || this.courseDao.countCheckDel(directionId) > 0 || this.courseLiveDao.countCheckDel(directionId) > 0
                || this.setCustomizePlanDao.countCheckDel(directionId,null) > 0){
            flag =true;
        }
        return flag;
    }

    public void saveCustomizePlan(CategoryDirection direction,CategoryIndustry industry,CategoryPosition position){
        SetCustomizePlan setCustomizePlan=new SetCustomizePlan();
        setCustomizePlan.setDirectionId(direction.getId().intValue());
        setCustomizePlan.setState(false);
        setCustomizePlan.setCreateTime(new Date());

        Integer industryId = null;
        String industryDesc = null;
        if(industry!=null){
            industryId = industry.getId()==null?null:industry.getId().intValue();
            industryDesc = industry.getCategoryDesc()==null?"":industry.getCategoryDesc();
        }

        Integer positionId = null;
        String positionDesc = null;
        if(position!=null){
            positionId = position.getId()==null?null:position.getId().intValue();
            positionDesc = position.getCategoryDesc()==null?null:position.getCategoryDesc();
        }
        setCustomizePlan.setIndustryId(industryId);
        setCustomizePlan.setPlanDescribe(direction.getCategoryDesc() + " " + industryDesc + " " + positionDesc);
        setCustomizePlan.setPositionId(positionId);
        setCustomizePlan.setDeleted(false);
        this.setCustomizePlanDao.savePlanByIds(setCustomizePlan);
    }

	@Override
	public Object find4HomePage() {
		List<CategoryDirection> directions;

        switch (ParamUtil.PRODUCT_ID) {
            case PRODUCT_ID_会计狮: {
                directions = categoryDirectionDao.select4HomeMenuByKJS();
                directions = directions.size() > 7 ? directions.subList(0, 7) : directions;
                for (CategoryDirection direction : directions) {
                    Collections.sort(direction.getIndustries(), new Comparator<CategoryIndustry>() {
                        @Override
                        public int compare(CategoryIndustry o1, CategoryIndustry o2) {
                            return o1.getOrderNum() - o2.getOrderNum();
                        }
                    });

                    Collections.sort(direction.getPositions(), new Comparator<CategoryPosition>() {
                        @Override
                        public int compare(CategoryPosition o1, CategoryPosition o2) {
                            return o1.getOrderNum() - o2.getOrderNum();
                        }
                    });
                }
                break;
            }
           
            default:{
                directions = Collections.emptyList();
            }

        }

        return directions;
	}
}
