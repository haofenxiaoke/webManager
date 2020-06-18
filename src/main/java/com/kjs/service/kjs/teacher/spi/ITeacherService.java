package com.kjs.service.kjs.teacher.spi;

import com.kjs.orm.model.Teacher;
import com.kjs.service.core.spi.IBaseService;
import com.kjs.web.serach.kjs.teacher.TeacherManagerSerachBean;

import java.util.List;

/**
 * Service Interface:Teacher
 * @author kjs_builder
 * @date 2016-9-14
 */
public interface ITeacherService extends IBaseService<Teacher,Long> {

    /**
     * 根据条件获取用户的数据(分页)
     * @param serachBean
     */
    void findPage(TeacherManagerSerachBean serachBean);
    /**
     * 获取所有未锁定的教师信息
     */
    List<Teacher> findTeacherList();

    void updateEmp(Teacher teacher);
}