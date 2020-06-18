package com.kjs.service.kjs.user.spi;

import com.kjs.orm.model.UserLecture;
import com.kjs.service.core.spi.IBaseService;
import com.kjs.web.serach.kjs.user.UserManagerSerachBean;

/**
 * Service Interface:UserLecture
 * @author duia_builder
 * @date 2016-5-23
 */
public interface IUserLectureService extends IBaseService<UserLecture,Long> {
    void findPage(UserManagerSerachBean serachBean);
}