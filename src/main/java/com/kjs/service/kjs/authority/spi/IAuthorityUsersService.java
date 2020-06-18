package com.kjs.service.kjs.authority.spi;

import com.kjs.common.dto.login.LoginDto;
import com.kjs.orm.model.AuthorityUserRole;
import com.kjs.orm.model.AuthorityUsers;
import com.kjs.service.core.spi.IBaseService;
import com.kjs.web.serach.kjs.authority.AuthorityUserSerachBean;
import com.kjs.web.serach.kjs.authority.AuthorityUserWechatBean;

import javax.servlet.http.HttpServletResponse;
import java.util.List;
import java.util.Map;

/**
 * Service Interface:AuthorityUsers
 * @author duia_builder
 * @date 2016-1-20
 */
public interface IAuthorityUsersService extends IBaseService<AuthorityUsers,Long> {
    void findUserPage(AuthorityUserSerachBean serachBean);//根据条件获取用户的数据(分页)
    LoginDto checkLogin(AuthorityUsers users, HttpServletResponse response, boolean isrem); /*根据用户名密码验证登录,并返回响应*/
    List<AuthorityUsers> findUsersByEmail(String email);/*根据邮箱获取用户*/
    List<AuthorityUsers> findUsersByRoleId(Long roleId);/*根据角色ID获取当前角色下的所有用户*/
    List<AuthorityUsers> findUserByEmailAndRoleId(Map map);/*根据邮箱和角色ID,模糊获取不在当前角色下的用户*/
    void LockingUser(AuthorityUsers users);/*根据用户ID锁定或解锁该用户*/
    boolean checkUserEmailUnique(AuthorityUsers users);/*验证用户邮箱是否存在*/
    boolean checkUserNumUnique(AuthorityUsers users);/*验证用户工号是否存在*/
    
    
    /**
     * 查找roleId
     * @param userId
     * @return
     */
	List<AuthorityUserRole> RoleIdByUserId(Long userId);
	/**
	 * 保存微信信息
	 * @param authorityUsers
	 */
	void savewechat(AuthorityUsers authorityUsers);
	
	
}
