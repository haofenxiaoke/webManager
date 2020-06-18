package com.kjs.service.kjs.authority;

import com.kjs.orm.mapper.AuthorityRolesMapper;
import com.kjs.common.dto.auth.RoleTreeDto;
import com.kjs.orm.model.AuthorityRoles;
import com.kjs.service.core.BaseService;
import com.kjs.service.kjs.authority.spi.IAuthorityRolesService;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.CollectionUtils;

import javax.annotation.Resource;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

/**
 * Service Implementation:AuthorityRoles
 * @author duia_builder
 * @date 2016-1-20
 */
@Transactional(rollbackFor=Exception.class)
@Service
public class AuthorityRolesService extends BaseService<AuthorityRoles,Long> implements IAuthorityRolesService {
    @Resource
    private AuthorityRolesMapper authorityRolesDao;

    /**
     * 查询所有角色
     */
    @Override
    public RoleTreeDto findAllRoles() {
        //角色默认的根级
        RoleTreeDto root = new RoleTreeDto(-1L,"系统角色管理",true);
        root.setOpen(true);
        root.setChildren(this.findRoless());
        return root;
    }

    /**
     * 查询所有启用角色
     * @return
     */
    @Override
    public RoleTreeDto findAllEnableRoles() {
        //角色默认的根级
        RoleTreeDto root = new RoleTreeDto(-1L,"全部角色",true);
        root.setOpen(true);
        List<RoleTreeDto> rts =  this.findRoless();;
        if(!CollectionUtils.isEmpty(rts)){
            for(RoleTreeDto r:rts){
                if(!CollectionUtils.isEmpty(r.getChildren())){
                    Iterator<RoleTreeDto> its = r.getChildren().iterator();
                    while(its.hasNext()){
                        RoleTreeDto rt = its.next();
                        if(rt.getEnable() == 0){
                            its.remove();
                        }
                    }
                }
            }
        }
        root.setChildren(rts);
        return root;
    }

    /**
     * 验证当前角色是否唯一
     * @param roles
     * @return
     */
    @Override
    public boolean checkRoleUnique(AuthorityRoles roles) {
        return this.authorityRolesDao.checkRoleUnique(roles)==0?true:false;
    }


    /**
     * 查询出所有父子角色
     * @return
     */
    private List<RoleTreeDto> findRoless(){
        List<AuthorityRoles> ParentRoles = this.authorityRolesDao.getParentRole();//获取所有父角色
        List<AuthorityRoles> SubRoles = this.authorityRolesDao.getSubRole(); //获取所有子菜单
        List<RoleTreeDto> roleTrees = new ArrayList<RoleTreeDto>();
        //如果不为空
        if(!CollectionUtils.isEmpty(ParentRoles)){
            for(AuthorityRoles pr:ParentRoles){
                RoleTreeDto roles = new RoleTreeDto(pr.getId(),pr.getName(),true);
                for(AuthorityRoles sr:SubRoles){
                    if(sr.getParentId().intValue() == pr.getId().intValue()){
                        roles.getChildren().add(new RoleTreeDto(sr.getId(),sr.getName(),sr.getEnable(),null,true,false));
                    }
                }
                roleTrees.add(roles);//添加到当前用户角色集合中
            }
        }
        return roleTrees;
    }
}
