package com.kjs.orm.mapper;

import com.kjs.orm.core.BaseMapper;
import com.kjs.orm.model.UserStu;
import org.apache.ibatis.annotations.Param;

public interface UserStuMapper extends BaseMapper<UserStu,Long> {

    UserStu findByUserid(@Param("userid") String userid);

}