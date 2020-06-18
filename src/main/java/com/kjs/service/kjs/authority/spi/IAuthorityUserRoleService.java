package com.kjs.service.kjs.authority.spi;

import com.kjs.orm.model.AuthorityUserRole;
import com.kjs.service.core.spi.IBaseService;

/**
 * Service Interface:AuthorityUserRole
 * @author duia_builder
 * @date 2016-1-20
 */
public interface IAuthorityUserRoleService extends IBaseService<AuthorityUserRole,Long> {
    void deleteRoleUser(AuthorityUserRole ur);/*删除角色下的用户*/
}