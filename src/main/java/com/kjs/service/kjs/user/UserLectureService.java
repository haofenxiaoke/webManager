package com.kjs.service.kjs.user;

import com.kjs.orm.mapper.UserLectureMapper;
import com.kjs.orm.model.UserLecture;
import com.kjs.service.core.BaseService;
import com.kjs.service.kjs.user.spi.IUserLectureService;
import com.kjs.web.serach.kjs.user.UserManagerSerachBean;
import org.springframework.stereotype.Service;
import org.springframework.util.CollectionUtils;

import javax.annotation.Resource;
import java.util.List;
import java.util.Map;


/**
 * Service Implementation:UserLecture
 * @author duia_builder
 * @date 2016-5-23
 */
@Service
public class UserLectureService extends BaseService<UserLecture,Long> implements IUserLectureService {
    @Resource
    private UserLectureMapper userLectureDao;
    @Override
    public void findPage(UserManagerSerachBean serachBean) {
        List<Map> list = this.userLectureDao.pageInfo(serachBean);
        if(!CollectionUtils.isEmpty(list))
        {
            long count = this.userLectureDao.countInfo(serachBean);
            serachBean.setRecordsTotal(count);
            serachBean.setRecordsFiltered(count);
            serachBean.setData(list);
        }
    }
}
