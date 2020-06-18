package com.kjs.service.kjs.user.spi;

import com.kjs.orm.model.UserStu;
import com.kjs.service.core.spi.IBaseService;
import com.kjs.web.serach.kjs.user.UserStuSerachBean;

import java.util.List;
import java.util.Map;

/**
 * Service Interface:UserStu
 * @author duia_builder
 * @date 2016-5-23
 */
public interface IUserStuService extends IBaseService<UserStu,Long> {
    void findCategoryPage(UserStuSerachBean serachBean);

    UserStu findDetail(Long id);

    Boolean isVIP(Long id);

    UserStu findByUserid(String userid);

    List<UserStu> exportCsvAnswers(UserStuSerachBean serachBean);
}