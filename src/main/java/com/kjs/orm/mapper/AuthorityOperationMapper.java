package com.kjs.orm.mapper;

import com.kjs.orm.core.BaseMapper;
import com.kjs.orm.model.AuthorityOperation;

import java.util.List;

public interface AuthorityOperationMapper extends BaseMapper<AuthorityOperation,Long> {
	List<AuthorityOperation> getAuthOperListByMenuId(long menuId);/*根据菜单ID获取当前菜单下的操作*/
	Integer checkOperUnique(AuthorityOperation operation);/*验证菜单下操作码的唯一性*/
}