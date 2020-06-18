package com.kjs.orm.mapper;

import com.kjs.orm.core.BaseMapper;
import com.kjs.orm.model.AuthorityMenu;

import java.util.List;

public interface AuthorityMenuMapper extends BaseMapper<AuthorityMenu,Long> {
    /**
     * 获取父菜单
     * @param
     * @return
     */
   List<AuthorityMenu> getParentMenus();

    /**
     * 获取子菜单
     * @param
     * @return
     */
    List<AuthorityMenu> getSubMenus();

    /**
     * 验证菜单的唯一性
     * @param menu
     * @return
     */
    Integer checkMenuUnique(AuthorityMenu menu);
	
}