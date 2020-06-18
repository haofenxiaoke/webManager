package com.kjs.service.kjs.authority;

import com.kjs.common.constant.PermissionConstant;
import com.kjs.common.permission.Permission;
import com.kjs.common.utils.ShiroUtils;
import com.kjs.orm.mapper.AuthorityMenuMapper;
import com.kjs.orm.mapper.AuthorityOperationMapper;
import com.kjs.orm.mapper.AuthorityPermissionMapper;
import com.kjs.orm.mapper.CategoryDirectionMapper;
import com.kjs.common.dto.auth.MenuDto;
import com.kjs.common.dto.auth.MenuTreeDto;
import com.kjs.orm.model.AuthorityMenu;
import com.kjs.orm.model.AuthorityOperation;
import com.kjs.service.core.BaseService;
import com.kjs.service.kjs.authority.spi.IAuthorityMenuService;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.CollectionUtils;

import javax.annotation.Resource;
import java.util.*;

/**
 * Service Implementation:AuthorityMenu
 * @author duia_builder
 * @date 2016-1-20
 */
@Transactional(rollbackFor=Exception.class)
@Service
public class AuthorityMenuService extends BaseService<AuthorityMenu,Long> implements IAuthorityMenuService {

    @Resource
    private AuthorityMenuMapper authorityMenuDao;
    @Resource
    private AuthorityOperationMapper authorityOperationDao;
    @Resource
    private AuthorityPermissionMapper authorityPermissionDao;
    @Resource
    private CategoryDirectionMapper categoryDirectionDao;

    /**
     * 查询出当前用户的用户菜单
     * @return
     */
    @Override
    public List<MenuDto> findUserAuthMenu() {
        List<AuthorityMenu> ParentMenus = this.authorityMenuDao.getParentMenus(); //获取所有父菜单
        List<AuthorityMenu> SubMenus = this.authorityMenuDao.getSubMenus(); //获取所有子菜单
        List<MenuDto> allMenuDto = new ArrayList<MenuDto>();//当前用户的菜单
        //如果不为空
        if(!CollectionUtils.isEmpty(ParentMenus)&&!CollectionUtils.isEmpty(SubMenus)){
            Long userId = ShiroUtils.getSessionUser().getId();//获得当前用户的id
            for(AuthorityMenu pm:ParentMenus){
                MenuDto menus = new MenuDto(pm.getId(),pm.getMenuName(),pm.getMenuUrl(),pm.getMenuIcon(),pm.getMenuCode());//创建父菜单
                for(AuthorityMenu sm:SubMenus){
                    if(sm.getMenuParentId().intValue() == pm.getId().intValue()){
                        if(sm.getMenuEnable() == 1){
                            //只有启用的菜单才显示
                            if(ShiroUtils.hasPermission(new Permission(sm.getMenuCode(), PermissionConstant.DEFAULT_OPER, PermissionConstant.DEFAULT_CATEID))){
                                //获得当前用户该菜单的拥有权限的分类ID列表
                                Set<String> cateIds = categoryDirectionDao.findByUserIdAndResourceId(userId, sm.getId());
                                menus.getSubMenu().add(new MenuDto(sm.getId(),sm.getMenuName(),sm.getMenuUrl(),sm.getMenuUrl(),sm.getMenuCode(),cateIds));//创建子菜单
                            }
                        }
                    }
                }
                if(!CollectionUtils.isEmpty(menus.getSubMenu())){
                    menus.setSubIsExist(true);//如果有子菜单,则设置为true
                }
                allMenuDto.add(menus);//添加到当前用户菜单集合中
            }
        }
        return allMenuDto;
    }

    /**
     * 查询所有菜单
     * @return
     */
    public MenuTreeDto findAllAuthMenu(){
        //菜单默认的根级
        MenuTreeDto root = new MenuTreeDto(-1L,"系统菜单管理",true,"all");
        root.setOpen(true);
        root.setChildren(this.findMenus());
        return root;
    }

    /**
     * 根据菜单Id查询当前菜单实体
     * @param id 菜单ID
     * @return
     */
    @Override
    public AuthorityMenu findAuthMenuById(long id) {
        AuthorityMenu menu =   this.findById(id);
        List<AuthorityOperation> opers = this.authorityOperationDao.getAuthOperListByMenuId(id);//获取当前菜单下的操作集合
        if(!CollectionUtils.isEmpty(opers)&&null!=menu){
            menu.setOperationList(opers);
        }
        return menu;
    }

    /**
     * 验证菜单的唯一性
     * @param menu
     * @return
     */
    @Override
    public boolean checkMenuUnique(AuthorityMenu menu) {
        return this.authorityMenuDao.checkMenuUnique(menu)==0?true:false;
    }

    /**
     * 查询出所有启用的菜单,并对当前角色下的菜单设置勾选状态
     * @param roleId
     * @return
     */
    @Override
    public MenuTreeDto findAllMenuByRoles(long roleId) {
        //菜单默认的根级
        MenuTreeDto root = new MenuTreeDto(-1l,"全部菜单",true,"all");
        root.setOpen(true);
        List<MenuTreeDto> mts = this.findMenus();
        if(!CollectionUtils.isEmpty(mts)){
            Map map = new HashMap();
            map.put("roleId",roleId);
            List<Long> menuIds = this.authorityPermissionDao.getMenuIdByRoleId(map);//获取当前角色下的菜单ID
            for(MenuTreeDto m:mts){
                if(!CollectionUtils.isEmpty(m.getChildren())){
                    Iterator<MenuTreeDto> its = m.getChildren().iterator();
                    while(its.hasNext()){
                        MenuTreeDto mt = its.next();
                        if(mt.getEnable() == 0){
                            its.remove();
                            continue;
                        }
                        mt.setChecked(menuIds.contains(mt.getId()));
                    }
                }
            }
        }
        root.setChildren(mts);
        return root;
    }

    /**
     * 查询出所有父子菜单
     * @return
     */
    private List<MenuTreeDto> findMenus(){
        List<AuthorityMenu> ParentMenus = this.authorityMenuDao.getParentMenus(); //获取所有父菜单
        List<AuthorityMenu> SubMenus = this.authorityMenuDao.getSubMenus(); //获取所有子菜单
        List<MenuTreeDto> menuTrees = new ArrayList<>();
        //如果不为空
        if(!CollectionUtils.isEmpty(ParentMenus)){
            for(AuthorityMenu pm:ParentMenus){
                MenuTreeDto menus = new MenuTreeDto(pm.getId(),pm.getMenuName(),true,pm.getMenuCode());//创建父菜单
                menus.setCode(pm.getMenuCode());
                for(AuthorityMenu sm:SubMenus){
                    if(sm.getMenuParentId().intValue() == pm.getId().intValue()){
                        menus.getChildren().add(new MenuTreeDto(sm.getId(),sm.getMenuName(),null,true,false,sm.getMenuEnable(),sm.getMenuCode()));//创建子菜单
                    }
                }
                menuTrees.add(menus);
            }
        }
        return menuTrees;
    }
}
