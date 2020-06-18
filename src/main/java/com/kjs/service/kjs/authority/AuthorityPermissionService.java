package com.kjs.service.kjs.authority;

import com.kjs.common.bean.MenuCacheModel;
import com.kjs.common.bean.annotation.AdminLogAnn;
import com.kjs.common.bean.enums.OperLevel;
import com.kjs.common.bean.enums.OperType;
import com.kjs.common.realm.AuthRealm;
import com.kjs.common.utils.ShiroUtils;
import com.kjs.orm.mapper.AuthorityPermissionMapper;
import com.kjs.orm.mapper.AuthorityUserRoleMapper;
import com.kjs.orm.model.AuthorityPermission;
import com.kjs.orm.model.AuthorityUsers;
import com.kjs.service.core.BaseService;
import com.kjs.service.kjs.authority.spi.IAuthorityPermissionService;
import com.kjs.web.serach.kjs.authority.AuthorityPermissionSerachBean;
import org.springframework.beans.factory.InitializingBean;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.CollectionUtils;
import org.springframework.util.StringUtils;

import javax.annotation.Resource;
import java.util.*;

/**
 * Service Implementation:AuthorityPermission
 * @author duia_builder
 * @date 2016-1-20
 */
@Transactional(rollbackFor=Exception.class)
@Service
public class AuthorityPermissionService extends BaseService<AuthorityPermission,Long> implements IAuthorityPermissionService ,InitializingBean {

    public static Set<String> allPermissionIdsCache;
    @Resource
    private AuthorityPermissionMapper authorityPermissionDao;
    @Resource
    private AuthorityUserRoleMapper authorityUserRoleDao;
    @Resource(name = "authRealm")
    private AuthRealm authRealm;
    @Resource
    private MenuCacheModel menuCacheModel;

    /**
     * 根据用户ID获取权限数据
     * @param userId
     * @return
     */
    @Override
    public List<AuthorityPermission> findPermissionByUserID(long userId) {
        return this.authorityPermissionDao.getPermissionByUserID(userId);
    }

    /**
     * 根据请求参数,进行角色授权
     * @param serachBean
     */
    @AdminLogAnn(operType = OperType.AUTH,operLevel = OperLevel.MAX,operDescribe = "对角色进行授权")
    @Override
    public void saveRoleAuth(AuthorityPermissionSerachBean serachBean) {
        Map map = new HashMap();
        map.put("roleId",serachBean.getRoleId());
        if(serachBean.getDelMenuFlag()){
            //删除当前角色对于该菜单的所有权限
            map.put("resourcesId",serachBean.getMenuId());
            this.authorityPermissionDao.delRoleAuth(map);
        }else if(serachBean.getDelOperFlag()){
            //删除当前角色对于菜单下该操作的所有权限
            map.put("resourcesId",serachBean.getMenuId());
            map.put("operationId",serachBean.getOperId());
            this.authorityPermissionDao.delRoleAuth(map);
        }else{
            //进行权限添加,先删除后添加
            map.put("resourcesId",serachBean.getMenuId());
            map.put("operationId",serachBean.getOperId());
            this.authorityPermissionDao.delRoleAuth(map);//删除这个角色下这个菜单下的这个操作数据
            List<AuthorityPermission> ps = new ArrayList<AuthorityPermission>();
            //所有权限
            if(!CollectionUtils.isEmpty(serachBean.getCategoryIds())){
                for(String cateId:serachBean.getCategoryIds()){
                    if(!StringUtils.isEmpty(cateId)&&!cateId.equals("-1")){
                        AuthorityPermission p = new AuthorityPermission();
                        p.setRoleId(serachBean.getRoleId());
                        p.setResourcesId(serachBean.getMenuId());
                        p.setResourceCode(serachBean.getResCode());
                        p.setOperationId(serachBean.getOperId());
                        p.setOperationCode(serachBean.getOperCode());
                        p.setCategoryId(cateId);
                        p.setPermissionCode(p.getCode());
                        p.setLastModifyUserId(ShiroUtils.getSessionUser().getId());
                        p.setLastModifyDatetime(new Date());
                        ps.add(p);
                    }
                }
            }

            if(!CollectionUtils.isEmpty(ps)){
                for(AuthorityPermission per:ps){
                    this.authorityPermissionDao.save(per);
                }
            }
        }
        //获取角色下的用户
        List<AuthorityUsers> us =  authorityUserRoleDao.getUsersByRoleId(serachBean.getRoleId());
        if(!CollectionUtils.isEmpty(us)){
            List<Long> ids = new ArrayList<Long>();
            for(AuthorityUsers u:us){
                ids.add(u.getId());
            }
            this.authRealm.clearAllUserAuthorization();//删除全部用户的权限缓存
            this.menuCacheModel.clearMapMenuByUserId(ids);//删除当前用户集合的菜单缓存
        }
    }

    @Override
    public void afterPropertiesSet() throws Exception {
        allPermissionIdsCache = authorityPermissionDao.findCateIdByAdmin();
    }
    @Override
    public  void updateAllPermissionIdsCache() {
        allPermissionIdsCache = authorityPermissionDao.findCateIdByAdmin();
    }
}
