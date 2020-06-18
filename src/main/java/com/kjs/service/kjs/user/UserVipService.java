package com.kjs.service.kjs.user;

import com.kjs.orm.mapper.UserVipMapper;
import com.kjs.orm.model.UserVip;
import com.kjs.service.core.BaseService;
import com.kjs.service.kjs.user.spi.IUserVipService;
import com.kjs.web.serach.kjs.user.UserManagerSerachBean;
import org.springframework.stereotype.Service;
import org.springframework.util.CollectionUtils;

import javax.annotation.Resource;
import java.util.List;
import java.util.Map;


/**
 * Service Implementation:UserVip
 * @author duia_builder
 * @date 2016-5-23
 */
@Service
public class UserVipService extends BaseService<UserVip,Long> implements IUserVipService {
    @Resource
    private UserVipMapper userVipDao;
    @Override
    public void findPage(UserManagerSerachBean serachBean) {
        List<Map> list = this.userVipDao.pageInfo(serachBean);
        if(!CollectionUtils.isEmpty(list))
        {
            long count = this.userVipDao.countInfo(serachBean);
            serachBean.setRecordsTotal(count);
            serachBean.setRecordsFiltered(count);
            serachBean.setData(list);
        }
    }
}
