package com.kjs.service.kjs.authority;

import com.kjs.common.bean.MenuCacheModel;
import com.kjs.common.bean.ParamUtil;
import com.kjs.common.bean.annotation.AdminLogAnn;
import com.kjs.common.bean.enums.OperLevel;
import com.kjs.common.bean.enums.OperType;
import com.kjs.common.constant.SessionConstant;
import com.kjs.common.constant.SystemConstant;
import com.kjs.common.dto.login.LoginDto;
import com.kjs.common.utils.CookieUtils;
import com.kjs.common.utils.MD5;
import com.kjs.common.utils.ShiroUtils;
import com.kjs.orm.mapper.AuthorityUserRoleMapper;
import com.kjs.orm.mapper.AuthorityUsersMapper;
import com.kjs.orm.model.AuthorityUserRole;
import com.kjs.orm.model.AuthorityUsers;
import com.kjs.service.core.BaseService;
import com.kjs.service.kjs.authority.spi.IAuthorityUsersService;
import com.kjs.web.serach.kjs.authority.AuthorityUserSerachBean;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.CollectionUtils;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletResponse;
import java.util.Date;
import java.util.List;
import java.util.Map;

/**
 * Service Implementation:AuthorityUsers
 * @author duia_builder
 * @date 2016-1-20
 */
@Transactional(rollbackFor=Exception.class)
@Service("AuthorityUsers")
public class AuthorityUsersService extends BaseService<AuthorityUsers,Long> implements IAuthorityUsersService {
    @Resource
    private AuthorityUsersMapper usersDao;
    @Resource
    private AuthorityUserRoleMapper userRoleDao;
    @Resource
    private MenuCacheModel menuCacheModel;

    private final static Logger logger = LoggerFactory.getLogger(AuthorityUsersService.class);
    /**
     * 根据条件获取用户的数据(分页)
     * @param serachBean 分页数据
     */
    @Override
    public void findUserPage(AuthorityUserSerachBean serachBean) {
        List<AuthorityUsers> users = this.iBaseDao.page(serachBean);
        if(!CollectionUtils.isEmpty(users))
        {
            long count = this.iBaseDao.count(serachBean);
            serachBean.setRecordsTotal(count);
            serachBean.setRecordsFiltered(count);
            serachBean.setData(users);
        }
    }

    /**
     * 根据用户名密码验证登录,并返回响应
     * @param users
     * @return
     */
    @Override
    public LoginDto checkLogin(AuthorityUsers users,HttpServletResponse response,boolean isrem) {
        LoginDto loginDto = new LoginDto(false,"用户名不存在!");
        try{
            List<AuthorityUsers> us = findUsersByEmail(users.getEmail());//获取用户
            if(!CollectionUtils.isEmpty(us)){
                if(us.size()>1){
                    //用户名对应对个账号
                    loginDto.setMessage("账号出现冲突,对应多个用户!");
                }else{
                    AuthorityUsers u = us.get(0);/*获取用户*/
                    if(u.getUserLock() == 0){
                       //账号被锁定
                       loginDto.setMessage("账号被锁定!");
                    }else{
                        String pwd = MD5.getMD5(users.getPassword());
                        if(!u.getPassword().trim().equals(pwd)){
                            loginDto.setMessage("密码错误!");
                        }else{
                            //处理登录成功逻辑
                            loginDto.setSuccess(true);
                            //shiro登录
                            ShiroUtils.login(u.getId(), u.getEmail(), u.getPassword());
                            ShiroUtils.getSession().setAttribute(SessionConstant.LOGIN_USER, u);
                            //修改最后一次登录时间.
                            u.setLastLoginDatetime(new Date());
                            this.usersDao.updateUserLoginDate(u);
                            //设置登录cookie
                            response.addCookie(CookieUtils.createLoginCookie(SystemConstant.LOGIN_COOKIE_KEY,u.getId().toString(),isrem?SystemConstant.COOKIE_ONEDAY:SystemConstant.DEFAULT_COOKIE_AGE));
                           //存放用户菜单到缓存对象中
                            menuCacheModel.reLoadUserMenu(u.getId());
                        }
                    }

                }
            }
        }catch (Exception e){
            logger.error("用户登录出现异常!异常信息",e);
            loginDto.setMessage("系统异常!");
        }
        return loginDto;
    }

    /**
     * 根据邮箱获取用户
     * @param email
     * @return
     */
    @Override
    public List<AuthorityUsers> findUsersByEmail(String email) {
        return this.usersDao.getUsersByEmail(email);
    }

    /**
     * 根据角色ID获取当前角色下的所有用户
     * @param roleId
     * @return
     */
    @Override
    public List<AuthorityUsers> findUsersByRoleId(Long roleId) {
        return this.usersDao.getUsersByRoleId(roleId);
    }

    /**
     * 根据邮箱和角色ID,模糊获取不在当前角色下的用户
     * @param map
     * @return
     */
    @Override
    public List<AuthorityUsers> findUserByEmailAndRoleId(Map map) {
        return this.usersDao.getUserByEmailAndRoleId(map);
    }

    /**
     * 根据用户ID锁定或解锁该用户
     * @param users
     */
    @AdminLogAnn(operType = OperType.SYSTEM,operLevel = OperLevel.MAX,operDescribe = "锁定或解锁用户")
    @Override
    public void LockingUser(AuthorityUsers users) {
         this.usersDao.lockingUser(users);
    }

    /**
     * 验证用户邮箱是否存在
     * @param users
     * @return true不存在 false存在
     */
    @Override
    public boolean checkUserEmailUnique(AuthorityUsers users) {
        return this.usersDao.checkUserEmailUnique(users) == 0?true:false;
    }

    /**
     * 验证用户邮箱是否存在
     * @param users
     * @return true不存在 false存在
     */
    @Override
    public boolean checkUserNumUnique(AuthorityUsers users) {
        return this.usersDao.checkUserNumUnique(users) == 0?true:false;
    }
    /**
     * 根据用户id查找roleId
     * @author 嵇俊达
     * @date 2020.4.26
     */
	@Override
	public List<AuthorityUserRole> RoleIdByUserId(Long userId) {
		return this.userRoleDao.findRoleIdByUserId(userId);
		
	}
	/**
	 * 保存微信信息
	 * @author 嵇俊达
     * @date 2020.4.26
	 */
	@Override
	public void savewechat(AuthorityUsers authorityUsers) {
		this.usersDao.savewechat(authorityUsers);
		
	}
}
