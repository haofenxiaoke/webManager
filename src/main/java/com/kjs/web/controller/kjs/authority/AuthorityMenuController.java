package com.kjs.web.controller.kjs.authority;

import com.kjs.common.bean.MenuCacheModel;
import com.kjs.common.bean.ResponseJsonModel;
import com.kjs.common.bean.annotation.AdminLogAnn;
import com.kjs.common.bean.annotation.PermissionAnn;
import com.kjs.common.bean.enums.OperLevel;
import com.kjs.common.bean.enums.OperType;
import com.kjs.common.constant.HttpConstant;
import com.kjs.common.constant.PermissionConstant;
import com.kjs.common.dto.auth.MenuTreeDto;
import com.kjs.common.utils.ShiroUtils;
import com.kjs.orm.model.AuthorityMenu;
import com.kjs.orm.model.AuthorityOperation;
import com.kjs.service.kjs.authority.spi.IAuthorityMenuService;
import com.kjs.service.kjs.authority.spi.IAuthorityOperationService;
import com.kjs.service.kjs.authority.spi.IAuthorityPermissionService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import java.util.Date;

/**
 * 菜单管理控制器
 * Created by wangsongpeng on 2016/2/25.
 */
@Controller
@RequestMapping("/menu")
public class AuthorityMenuController {
    @Resource
    private IAuthorityMenuService authorityMenuService;
    @Resource
    private IAuthorityOperationService authorityOperationService;
    @Resource
    private IAuthorityPermissionService authorityPermissionService;
    @Resource
    private MenuCacheModel menuCacheModel;

    /**
     * 跳转到菜单管理页面
     * @return
     */
    @PermissionAnn(menuCode = "menu",msg = "你没有进入菜单管理页面的权限!")
    @RequestMapping(value = "/manager")
    public String forwardMenuManager(Model model){
        return "authority/authority_menu";
    }

    /**
     * 菜单列表
     * @return
     */
    @PermissionAnn(menuCode = "menu",operCode = "find",msg = "你没有菜单管理页面的查询权限!")
    @ResponseBody
    @RequestMapping(value = "/list",method = RequestMethod.POST)
    public MenuTreeDto serachMenuInfo(Model model){
        return this.authorityMenuService.findAllAuthMenu();
    }

    /**
     * 根据菜单ID获取当前菜单数据
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "/entity",method = RequestMethod.POST)
    public AuthorityMenu serachMenuEntity(Model model, int id){
        return this.authorityMenuService.findAuthMenuById(id);
    }

    /**
     * 添加菜单树
     * @param authorityMenu
     */
    @AdminLogAnn(operType = OperType.AUTH,operLevel = OperLevel.NORM,operDescribe = "添加菜单树")
    @ResponseBody
    @RequestMapping(value = "/save",method = RequestMethod.POST)
    public ResponseJsonModel saveMenu(AuthorityMenu authorityMenu){
        ResponseJsonModel arm = new ResponseJsonModel();
        authorityMenu.setLastModifyUserId(ShiroUtils.getSessionUser().getId());
        authorityMenu.setLastModifyDatetime(new Date());
        this.authorityMenuService.save(authorityMenu);
        //如果是2级菜单
        if(authorityMenu.getMenuParentId().intValue() != 0){
            //添加默认操作
            AuthorityOperation operation = new AuthorityOperation();
            operation.setCode(PermissionConstant.DEFAULT_OPER);
            operation.setName(PermissionConstant.DEFAULT_OPER_NAME);
            operation.setMenuId(authorityMenu.getId());
            operation.setDescription(PermissionConstant.DEFAULT_OPER_DESC);
            operation.setLastModifyUserId(ShiroUtils.getSessionUser().getId());
            operation.setLastModifyDatetime(new Date());
            this.authorityOperationService.save(operation);
        }
        arm.setResult(authorityMenu.getId());
        this.menuCacheModel.clearMapMenu();//清空用户菜单缓存
        return arm;
    }

    /**
     * 修改菜单树
     * @param authorityMenu
     */
    @AdminLogAnn(operType = OperType.AUTH,operLevel = OperLevel.NORM,operDescribe = "修改菜单树")
    @PermissionAnn(menuCode = "menu",operCode = "update",msg = "你没有修改菜单的权限!")
    @ResponseBody
    @RequestMapping(value = "/update",method = RequestMethod.POST)
    public ResponseJsonModel updateMenu(AuthorityMenu authorityMenu){
        authorityMenu.setLastModifyUserId(ShiroUtils.getSessionUser().getId());
        authorityMenu.setLastModifyDatetime(new Date());
        this.authorityMenuService.update(authorityMenu);
        this.menuCacheModel.clearMapMenu();//清空用户菜单缓存
        return new ResponseJsonModel();
    }


    /**
     * 添加和修改菜单下的操作
     * @param
     */
    @PermissionAnn(menuCode = "menu",operCode = "operManage",msg = "你没有对菜单进行操作管理的权限!")
    @ResponseBody
    @RequestMapping(value = "/su/oper",method = RequestMethod.POST)
    public ResponseJsonModel saveOrUpdateOper(AuthorityOperation operation){
        operation.setLastModifyUserId(ShiroUtils.getSessionUser().getId());
        operation.setLastModifyDatetime(new Date());
        if(operation.getId()==-1){
            operation.setId(null);
            //新增
            this.authorityOperationService.save(operation);
        }else{
            //修改
            this.authorityOperationService.update(operation);
        }
        authorityPermissionService.updateAllPermissionIdsCache();
        return new ResponseJsonModel();
    }

    /**
     * 验证当前菜单名称,url,code是否唯一
     * @param
     */
    @ResponseBody
    @RequestMapping(value = "/check/menu",method = RequestMethod.POST)
    public ResponseJsonModel checkMenuAttr(AuthorityMenu menu){
        ResponseJsonModel arm = new ResponseJsonModel();
        if(this.authorityMenuService.checkMenuUnique(menu)){
            //唯一
            arm.setCode(HttpConstant.SUCCESS_CODE);
        }else{
            //有重复
            arm.setCode(HttpConstant.ERROR_CODE);
        }
        return arm;
    }


    /**
     * 验证当前菜单下的操作code是否唯一
     * @param
     */
    @ResponseBody
    @RequestMapping(value = "/check/oper",method = RequestMethod.POST)
    public ResponseJsonModel checkOperAttr(AuthorityOperation operation){
        ResponseJsonModel arm = new ResponseJsonModel();
        if(this.authorityOperationService.checkOperUnique(operation)){
            //唯一
            arm.setCode(HttpConstant.SUCCESS_CODE);
        }else{
            //有重复
            arm.setCode(HttpConstant.ERROR_CODE);
        }
        return arm;
    }
}
