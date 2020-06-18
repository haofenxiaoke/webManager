package com.kjs.service.kjs.authority.spi;

import com.kjs.orm.model.AuthorityPermission;
import com.kjs.service.core.spi.IBaseService;
import com.kjs.web.serach.kjs.authority.AuthorityPermissionSerachBean;

import java.util.List;

/**
 * Service Interface:AuthorityPermission
 * @author duia_builder
 * @date 2016-1-20
 */
public interface IAuthorityPermissionService extends IBaseService<AuthorityPermission,Long> {

  List<AuthorityPermission> findPermissionByUserID(long userId);/*根据用户ID获取权限数据*/

  void saveRoleAuth(AuthorityPermissionSerachBean serachBean);/*根据请求参数,进行角色授权*/

  void updateAllPermissionIdsCache();

}