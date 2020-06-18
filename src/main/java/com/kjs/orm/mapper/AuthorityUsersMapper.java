package com.kjs.orm.mapper;

import com.kjs.orm.core.BaseMapper;
import com.kjs.orm.model.AuthorityUsers;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

public interface AuthorityUsersMapper extends BaseMapper<AuthorityUsers,Long> {
    /**
     * 根据邮箱获取用户
     * @param email
     * @return
     */
    List<AuthorityUsers> getUsersByEmail(String email);

    /**
     * 根据角色ID获取当前角色下的所有用户
     * @param roleId
     * @return
     */
    List<AuthorityUsers> getUsersByRoleId(Long roleId);

    /**
     * 根据邮箱和角色ID模糊获取,不在当前角色下的用户
     * @param map
     * @return
     */
    List<AuthorityUsers> getUserByEmailAndRoleId(Map map);

    /**
     * 修改用户登录时间
     * @param users
     */
    void updateUserLoginDate(AuthorityUsers users);

    /**
     * 根据用户ID锁定或解锁该用户
     * @param users
     */
    void lockingUser(AuthorityUsers users);

    /**
     * 用户邮箱是否存在
     * @param users
     * @return
     */
    int checkUserEmailUnique(AuthorityUsers users);

    /**
     * 用户工号是否存在
     * @param users
     * @return
     */
    int checkUserNumUnique(AuthorityUsers users);

    /**
     * 根据员工号 更新用户
     * @param users
     */
    void updateUserByNum(AuthorityUsers users);

	void savewechat(AuthorityUsers authorityUsers);

	

}