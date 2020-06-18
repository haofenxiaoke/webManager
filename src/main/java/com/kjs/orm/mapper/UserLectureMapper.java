package com.kjs.orm.mapper;

import com.kjs.orm.core.BaseMapper;
import com.kjs.orm.model.UserLecture;
import com.kjs.web.serach.kjs.user.UserManagerSerachBean;

import java.util.List;
import java.util.Map;

public interface UserLectureMapper extends BaseMapper<UserLecture,Long> {
    List<Map> pageInfo(UserManagerSerachBean serachBean);

    Long countInfo(UserManagerSerachBean serachBean);
}