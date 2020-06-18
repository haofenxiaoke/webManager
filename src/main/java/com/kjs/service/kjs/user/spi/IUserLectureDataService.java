package com.kjs.service.kjs.user.spi;

import com.kjs.orm.model.UserLectureData;
import com.kjs.service.core.spi.IBaseService;
import com.kjs.web.serach.kjs.user.UserManagerSerachBean;

/**
 * Service Interface:UserLectureData
 * @author duia_builder
 * @date 2016-6-7
 */
public interface IUserLectureDataService extends IBaseService<UserLectureData,Long> {
    void findPage(UserManagerSerachBean serachBean);
}