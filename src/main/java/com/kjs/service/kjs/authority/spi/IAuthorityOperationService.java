package com.kjs.service.kjs.authority.spi;

import com.kjs.common.dto.auth.OperTreeDto;
import com.kjs.orm.model.AuthorityOperation;
import com.kjs.service.core.spi.IBaseService;

/**
 * Service Interface:AuthorityOperation
 * @author duia_builder
 * @date 2016-1-20
 */
public interface IAuthorityOperationService extends IBaseService<AuthorityOperation,Long> {
    OperTreeDto findMenuOperByRoleID(Long menuId, Long roleId);/*查询菜单下的所有操作树,并根据角色权限,对操作设置勾选状态*/
    boolean     checkOperUnique(AuthorityOperation operation);/*验证菜单下操作码的唯一性*/
}