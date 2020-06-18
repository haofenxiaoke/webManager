package com.kjs.web.controller.kjs.authority;

import com.kjs.common.bean.ResponseJsonModel;
import com.kjs.common.bean.annotation.AdminLogAnn;
import com.kjs.common.bean.annotation.PermissionAnn;
import com.kjs.common.bean.enums.OperLevel;
import com.kjs.common.bean.enums.OperType;
import com.kjs.common.dto.auth.CateTreeDto;
import com.kjs.common.dto.auth.MenuTreeDto;
import com.kjs.common.dto.auth.OperTreeDto;
import com.kjs.common.dto.auth.RoleTreeDto;
import com.kjs.service.kjs.authority.spi.IAuthorityMenuService;
import com.kjs.service.kjs.authority.spi.IAuthorityOperationService;
import com.kjs.service.kjs.authority.spi.IAuthorityPermissionService;
import com.kjs.service.kjs.authority.spi.IAuthorityRolesService;
import com.kjs.service.kjs.category.spi.ICategoryDirectionService;
import com.kjs.web.serach.kjs.authority.AuthorityPermissionSerachBean;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;

/**
 * 权限管理控制器
 * Created by wangsongpeng on 2016/2/25.
 */
@Controller
@RequestMapping("/per")
public class AuthorityPermissionController {
    @Resource
    private IAuthorityRolesService authorityRolesService;
    @Resource
    private IAuthorityMenuService  authorityMenuService;
    @Resource
    private IAuthorityOperationService authorityOperationService;
    @Resource
    private ICategoryDirectionService categoryDirectionService;
    @Resource
    private IAuthorityPermissionService authorityPermissionService;

    /**
     * 跳转到角色管理页面
     * @return
     */
    @PermissionAnn(menuCode = "per",msg = "你没有进入角色授权页面的权限!")
    @RequestMapping(value = "/manager")
    public String forwardRoleManager(Model model){
        return "authority/authority_per";
    }

    /**
     * 根据条件查询所有角色信息(Ztree).
     * @return
     */
    @PermissionAnn(menuCode = "per",operCode = "find",msg = "你没有角色授权页面的查询权限!")
    @ResponseBody
    @RequestMapping(value = "/role/list",method = RequestMethod.POST)
    public RoleTreeDto serachRoleInfo(){
        return this.authorityRolesService.findAllEnableRoles();
    }

    /**
     * 根据条件查询所有菜单信息(Ztree).
     * @return
     */
    @PermissionAnn(menuCode = "per",operCode = "find",msg = "你没有角色授权页面的查询权限!")
    @ResponseBody
    @RequestMapping(value = "/menu/list",method = RequestMethod.POST)
    public MenuTreeDto serachMenuInfo(Long roleId) {
        return this.authorityMenuService.findAllMenuByRoles(roleId);
    }

    /**
     * 根据条件查询所有操作信息(Ztree).
     * @return
     */
    @PermissionAnn(menuCode = "per",operCode = "find",msg = "你没有角色授权页面的查询权限!")
    @ResponseBody
    @RequestMapping(value = "/oper/list",method = RequestMethod.POST)
    public OperTreeDto serachOperInfo(Long roleId, Long menuId){
        return this.authorityOperationService.findMenuOperByRoleID(menuId, roleId);
    }
    /**
     * 根据条件查询所有分类信息(Ztree).
     * @return
     */
    @PermissionAnn(menuCode = "per",operCode = "find",msg = "你没有角色授权页面的查询权限!")
    @ResponseBody
    @RequestMapping(value = "/cate/list",method = RequestMethod.POST)
    public CateTreeDto serachSkuInfo(Long roleId, Long menuId, Long operId){
        return this.categoryDirectionService.findAllCateTreeByAuth(roleId,menuId,operId);
    }
    /**
     * 对角色进行授权
     * @return
     */
    @AdminLogAnn(operType = OperType.AUTH,operLevel = OperLevel.MAX,operDescribe = "角色授权")
    @PermissionAnn(menuCode = "per",operCode = "roleAuth",msg = "你没有角色授权的权限!")
    @ResponseBody
    @RequestMapping(value = "/role/auth",method = RequestMethod.POST)
    public ResponseJsonModel roleAuth(AuthorityPermissionSerachBean serachBean){
        this.authorityPermissionService.saveRoleAuth(serachBean);
        return new ResponseJsonModel();
    }

}
