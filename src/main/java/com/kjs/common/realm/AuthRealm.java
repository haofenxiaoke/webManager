package com.kjs.common.realm;
import com.kjs.orm.model.AuthorityPermission;
import com.kjs.orm.model.AuthorityUsers;
import com.kjs.service.kjs.authority.spi.IAuthorityMenuService;
import com.kjs.service.kjs.authority.spi.IAuthorityPermissionService;
import com.kjs.service.kjs.authority.spi.IAuthorityUsersService;
import org.apache.shiro.authc.*;
import org.apache.shiro.authz.AuthorizationInfo;
import org.apache.shiro.authz.SimpleAuthorizationInfo;
import org.apache.shiro.realm.AuthorizingRealm;
import org.apache.shiro.subject.PrincipalCollection;
import org.springframework.util.CollectionUtils;

import javax.annotation.Resource;
import java.util.List;

/**
 * Shiro安全数据源
 * 数据默认被Shiro的缓存管理器缓存
 * Created by wangsongpeng on 2015/9/29.
 */
public class AuthRealm extends AuthorizingRealm {

    @Resource
    private IAuthorityPermissionService permissionService; /*权限业务逻辑对象*/
    @Resource(name = "AuthorityUsers")
    private IAuthorityUsersService authorityUsersService;
    @Resource
    private IAuthorityMenuService authorityMenuService;

    /**
     * 登录成功后
     * shiro调用此方法获取用户的权限数据
     * @param principalCollection
     * @return
     */
    @Override
    protected AuthorizationInfo doGetAuthorizationInfo(PrincipalCollection principalCollection) {
        SimpleAuthorizationInfo authorizationInfo = new SimpleAuthorizationInfo();//创建Shiro权限数据对象
        long userId = Long.valueOf(principalCollection.toString());//获取当前用户ID
        AuthorityUsers users =   this.authorityUsersService.findById(userId);//获取当前用户
        if(users!=null){
            if(users.getAdministrator() == 1){
                //如果是超级管理员,赋予所有权限
                authorizationInfo.addStringPermission("*");
            }else{
                List<AuthorityPermission> permissionList =  this.permissionService.findPermissionByUserID(users.getId());
                if (!CollectionUtils.isEmpty(permissionList)) {
                    for (AuthorityPermission p : permissionList) {
                        String permissionCode = p.getPermissionCode();
                        permissionCode = permissionCode.substring(0, permissionCode.lastIndexOf(":")) + ":*";
                        authorizationInfo.addStringPermission(permissionCode);
                    }
                }
            }
        }
        return authorizationInfo;
    }


    /**
     * shiro登录时
     * 验证用户,并进行用户数据收集
     * @param authenticationToken
     * @return
     * @throws AuthenticationException
     */
    @Override
    protected AuthenticationInfo doGetAuthenticationInfo(AuthenticationToken authenticationToken) throws AuthenticationException {
        UsernamePasswordToken usernamePasswordToken = (UsernamePasswordToken) authenticationToken;
        SimpleAuthenticationInfo info = new SimpleAuthenticationInfo(usernamePasswordToken.getPrincipal(),
                usernamePasswordToken.getCredentials(), usernamePasswordToken.getUsername());
        return info;
    }


    /**
     * 删除全部用户的权限数据
     */
    public void clearAllUserAuthorization(){
        this.getAuthorizationCache().clear();
    }


    public static void main(String[] args) {
       String string = "user:find:1";

        String reg = ".*(find|view).*";

        System.out.println( string.matches(reg));
    }
}
