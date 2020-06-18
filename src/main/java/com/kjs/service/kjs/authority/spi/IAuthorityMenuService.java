package com.kjs.service.kjs.authority.spi;

import com.kjs.common.dto.auth.MenuDto;
import com.kjs.common.dto.auth.MenuTreeDto;
import com.kjs.orm.model.AuthorityMenu;
import com.kjs.service.core.spi.IBaseService;

import java.util.List;

/**
 * Service Interface:AuthorityMenu
 * @author duia_builder
 * @date 2016-1-20
 */
public interface IAuthorityMenuService extends IBaseService<AuthorityMenu,Long> {
    List<MenuDto>  findUserAuthMenu();  /*查询出用户的权限菜单*/
    MenuTreeDto findAllAuthMenu();     /*查询出所有菜单*/
    MenuTreeDto findAllMenuByRoles(long roleId);  /*查询出所有菜单,并对当前角色下的菜单设置勾选状态*/
    AuthorityMenu findAuthMenuById(long id); /*根据菜单Id查询当前菜单实体*/
    boolean   checkMenuUnique(AuthorityMenu menu);/*验证菜单的唯一性*/
}