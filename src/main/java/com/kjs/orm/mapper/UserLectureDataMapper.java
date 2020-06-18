package com.kjs.orm.mapper;

import com.kjs.orm.core.BaseMapper;
import com.kjs.orm.model.UserLectureData;
import com.kjs.web.serach.kjs.user.UserManagerSerachBean;

import java.util.List;
import java.util.Map;

public interface UserLectureDataMapper extends BaseMapper<UserLectureData,Long> {
    void findPage(UserManagerSerachBean serachBean);

    List<Map> pageInfo(UserManagerSerachBean serachBean);

    Long countInfo(UserManagerSerachBean serachBean);

}