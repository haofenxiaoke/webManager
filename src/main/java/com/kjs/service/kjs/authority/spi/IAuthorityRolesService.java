package com.kjs.service.kjs.authority.spi;

import com.kjs.common.dto.auth.RoleTreeDto;
import com.kjs.orm.model.AuthorityRoles;
import com.kjs.service.core.spi.IBaseService;

/**
 * Service Interface:AuthorityRoles
 * @author duia_builder
 * @date 2016-1-20
 */
public interface IAuthorityRolesService extends IBaseService<AuthorityRoles,Long> {
    RoleTreeDto findAllRoles();//查询所有角色
    RoleTreeDto findAllEnableRoles();//查询所有启用角色
    boolean checkRoleUnique(AuthorityRoles roles); /*验证当前角色是否唯一*/
}