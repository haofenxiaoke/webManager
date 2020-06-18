package com.kjs.orm.mapper;

import com.kjs.orm.core.BaseMapper;
import com.kjs.orm.model.UserVisit;

import java.util.List;

public interface UserVisitMapper extends BaseMapper<UserVisit,Long> {

    List<UserVisit> findByGid(String gid);
}