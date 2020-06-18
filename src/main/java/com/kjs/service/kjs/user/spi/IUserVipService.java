package com.kjs.service.kjs.user.spi;

import com.kjs.orm.model.UserVip;
import com.kjs.service.core.spi.IBaseService;
import com.kjs.web.serach.kjs.user.UserManagerSerachBean;

/**
 * Service Interface:UserVip
 * @author duia_builder
 * @date 2016-5-23
 */
public interface IUserVipService extends IBaseService<UserVip,Long> {
    void findPage(UserManagerSerachBean serachBean);
}