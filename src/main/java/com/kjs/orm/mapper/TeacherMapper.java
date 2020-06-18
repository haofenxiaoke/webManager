package com.kjs.orm.mapper;

import com.kjs.orm.core.BaseMapper;
import com.kjs.orm.model.Teacher;
import com.kjs.web.serach.kjs.teacher.TeacherManagerSerachBean;

import java.util.List;
import java.util.Map;

public interface TeacherMapper extends BaseMapper<Teacher,Long> {

    List<Map> pageInfo(TeacherManagerSerachBean serachBean);

    Long countInfo(TeacherManagerSerachBean serachBean);

    List<Teacher> findTeacherList();
}