package com.kjs.orm.mapper;

import com.kjs.orm.core.BaseMapper;
import com.kjs.orm.model.AuthorityRoles;

import java.util.List;
import java.util.Map;


public interface AuthorityRolesMapper extends BaseMapper<AuthorityRoles,Long> {
	   public  List<AuthorityRoles> getParentRole();//获取所有父角色
	   public  List<AuthorityRoles> getSubRole();//获取所有子角色
	   public  void updateRoleSwitch(Map map);//修改角色的开关状态:启用或者停用
	   public  Integer checkRoleUnique(AuthorityRoles roles); /*验证当前角色是否唯一*/
}