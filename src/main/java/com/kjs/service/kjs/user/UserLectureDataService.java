package com.kjs.service.kjs.user;

import com.kjs.orm.mapper.UserLectureDataMapper;
import com.kjs.orm.model.UserLectureData;
import com.kjs.service.core.BaseService;
import com.kjs.service.kjs.user.spi.IUserLectureDataService;
import com.kjs.web.serach.kjs.user.UserManagerSerachBean;
import org.springframework.stereotype.Service;
import org.springframework.util.CollectionUtils;

import javax.annotation.Resource;
import java.util.List;
import java.util.Map;


/**
 * Service Implementation:UserLectureData
 * @author duia_builder
 * @date 2016-6-7
 */
@Service
public class UserLectureDataService extends BaseService<UserLectureData,Long> implements IUserLectureDataService {
    @Resource
    private UserLectureDataMapper userLectureDataDao;
    @Override
    public void findPage(UserManagerSerachBean serachBean) {
        List<Map> list = this.userLectureDataDao.pageInfo(serachBean);
        if(!CollectionUtils.isEmpty(list))
        {
            long count = this.userLectureDataDao.countInfo(serachBean);
            serachBean.setRecordsTotal(count);
            serachBean.setRecordsFiltered(count);
            serachBean.setData(list);
        }
    }
}
