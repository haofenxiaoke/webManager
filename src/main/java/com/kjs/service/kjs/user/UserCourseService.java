package com.kjs.service.kjs.user;

import com.kjs.orm.model.UserCourse;
import com.kjs.service.core.BaseService;
import com.kjs.service.kjs.user.spi.IUserCourseService;
import com.kjs.web.serach.kjs.user.UserManagerSerachBean;
import org.springframework.stereotype.Service;
import org.springframework.util.CollectionUtils;

import java.util.List;


/**
 * Service Implementation:UserCourse
 * @author duia_builder
 * @date 2016-5-23
 */
@Service
public class UserCourseService extends BaseService<UserCourse,Long> implements IUserCourseService {
    @Override
    public void findCategoryPage(UserManagerSerachBean serachBean) {
        List<UserCourse> list = this.iBaseDao.page(serachBean);
        if(!CollectionUtils.isEmpty(list))
        {
            long count = this.iBaseDao.count(serachBean);
            serachBean.setRecordsTotal(count);
            serachBean.setRecordsFiltered(count);
            serachBean.setData(list);
        }
    }
}
