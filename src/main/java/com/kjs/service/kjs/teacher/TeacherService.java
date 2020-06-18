package com.kjs.service.kjs.teacher;

import com.kjs.common.utils.SortUtils;
import com.kjs.orm.mapper.AuthorityUsersMapper;
import com.kjs.orm.mapper.TeacherMapper;
import com.kjs.orm.model.AuthorityUsers;
import com.kjs.orm.model.Teacher;
import com.kjs.service.core.BaseService;
import com.kjs.service.kjs.teacher.spi.ITeacherService;
import com.kjs.web.serach.kjs.teacher.TeacherManagerSerachBean;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.CollectionUtils;

import javax.annotation.Resource;
import java.util.List;
import java.util.Map;

/**
 * Service Implementation:Teacher
 * @author kjs_builder
 * @date 2016-9-14
 */
@Service
public class TeacherService extends BaseService<Teacher,Long> implements ITeacherService {
    @Resource
    private TeacherMapper mapper;
    @Resource
    AuthorityUsersMapper authorityUsersMapper;
    @Override
    public void findPage(TeacherManagerSerachBean serachBean) {
        List<Map> list = this.mapper.pageInfo(serachBean);
        if(!CollectionUtils.isEmpty(list))
        {
            SortUtils.sortTheList(list, "ctime", SortUtils.SORT_ORDER_DESC);
            long count = this.mapper.countInfo(serachBean);
            serachBean.setRecordsTotal(count);
            serachBean.setRecordsFiltered(count);
            serachBean.setData(list);
        }
    }

    @Override
    public List<Teacher> findTeacherList() {
        return mapper.findTeacherList();
    }

    @Override
    public void updateEmp(Teacher teacher) {
        this.mapper.update(teacher);
        //更新用户表花名
        AuthorityUsers user = new AuthorityUsers();
        user.setNum(teacher.getNum());
        user.setSex(teacher.getSex());
        user.setFlowerName(teacher.getFlowerName());
        authorityUsersMapper.updateUserByNum(user);
    }
}
