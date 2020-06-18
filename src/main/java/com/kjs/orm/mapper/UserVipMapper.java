package com.kjs.orm.mapper;

import com.kjs.orm.core.BaseMapper;
import com.kjs.orm.model.UserVip;
import com.kjs.web.serach.kjs.user.UserManagerSerachBean;

import java.util.List;
import java.util.Map;

public interface UserVipMapper extends BaseMapper<UserVip,Long> {
    List<Map> pageInfo(UserManagerSerachBean serachBean);

    Long countInfo(UserManagerSerachBean serachBean);

    List<UserVip> findByUserId(Long id);

    List<UserVip> findByUserId4Refund(Long id);

    List<UserVip> findLastPayDate();
}