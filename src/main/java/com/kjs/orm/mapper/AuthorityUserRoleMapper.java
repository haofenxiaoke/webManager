package com.kjs.orm.mapper;

import com.kjs.orm.core.BaseMapper;
import com.kjs.orm.model.AuthorityUserRole;
import com.kjs.orm.model.AuthorityUsers;

import java.util.List;

public interface AuthorityUserRoleMapper extends BaseMapper<AuthorityUserRole,Long> {
	List<AuthorityUsers> getUsersByRoleId(Long roleId);/*获取当前角色下的所有用户*/

	void  deleteRoleUser(AuthorityUserRole ur);     /*删除角色下的用户*/

	List<AuthorityUserRole> findRoleIdByUserId(Long userId);

}