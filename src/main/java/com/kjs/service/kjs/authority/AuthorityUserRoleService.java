package com.kjs.service.kjs.authority;
import org.springframework.transaction.annotation.Transactional;


import com.kjs.orm.mapper.AuthorityUserRoleMapper;
import com.kjs.orm.model.AuthorityUserRole;
import com.kjs.service.core.BaseService;
import com.kjs.service.kjs.authority.spi.IAuthorityUserRoleService;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;

/**
 * Service Implementation:AuthorityUserRole
 * @author duia_builder
 * @date 2016-1-20
 */
@Transactional(rollbackFor=Exception.class)
@Service
public class AuthorityUserRoleService extends BaseService<AuthorityUserRole,Long> implements IAuthorityUserRoleService {
    @Resource
    private AuthorityUserRoleMapper authorityUserRoleDao;

    /**
     * 删除角色下的用户
     */
    @Override
    public void deleteRoleUser(AuthorityUserRole ur) {
        this.authorityUserRoleDao.deleteRoleUser(ur);
    }
}
