package com.kjs.service.kjs.user.spi;

import com.kjs.orm.model.UserCourse;
import com.kjs.service.core.spi.IBaseService;
import com.kjs.web.serach.kjs.user.UserManagerSerachBean;

/**
 * Service Interface:UserCourse
 * @author duia_builder
 * @date 2016-5-23
 */
public interface IUserCourseService extends IBaseService<UserCourse,Long> {
    void findCategoryPage(UserManagerSerachBean serachBean);
}