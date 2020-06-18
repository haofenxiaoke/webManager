package com.kjs.service.kjs.user;

import com.kjs.common.utils.SortUtils;
import com.kjs.orm.mapper.UserStuMapper;
import com.kjs.orm.mapper.UserVipMapper;
import com.kjs.orm.model.UserStu;
import com.kjs.orm.model.UserVip;
import com.kjs.service.core.BaseService;
import com.kjs.service.kjs.user.spi.IUserStuService;
import com.kjs.web.serach.kjs.user.UserStuSerachBean;
import org.springframework.stereotype.Service;
import org.springframework.util.CollectionUtils;

import javax.annotation.Resource;
import java.util.*;


/**
 * Service Implementation:UserStu
 * @author duia_builder
 * @date 2016-5-23
 */
@Service
public class UserStuService extends BaseService<UserStu,Long> implements IUserStuService {
    @Resource
    private UserVipMapper userVipMapper;
    @Resource
    private UserStuMapper userStuMapper;
    @Override
    public void findCategoryPage(UserStuSerachBean serachBean) {
        List<UserStu> stu = this.iBaseDao.page(serachBean);
        if(!CollectionUtils.isEmpty(stu))
        {
            long count = this.iBaseDao.count(serachBean);
            serachBean.setRecordsTotal(count);
            serachBean.setRecordsFiltered(count);
            serachBean.setData(stu);
        }
    }

    @Override
    public UserStu findDetail(Long id) {
        UserStu userStu = this.findById(id);
        List<UserVip> vips = userVipMapper.findByUserId(id);
        if (!vips.isEmpty() && vips.get(0).getEndDate().after(new Date())) {
            userStu.setIsVIP(true);
            userStu.setVipExpireTime(vips.get(0).getEndDate());
        }
        return userStu;

    }
    @Override
    public Boolean isVIP(Long id) {
        List<UserVip> vips = userVipMapper.findByUserId(id);
        if (!vips.isEmpty() && vips.get(0).getEndDate().after(new Date())) {
            return true;
        }
        return false;
    }

    @Override
    public UserStu findByUserid(String userid) {
       return userStuMapper.findByUserid(userid);
    }

    public List<UserStu> replaceLastPayDate(List<UserStu> userStu){

        //查询最后的支付时间
        List<UserStu> userStuList = new ArrayList<>();
        List<UserVip> vips = userVipMapper.findLastPayDate();

        if(!CollectionUtils.isEmpty(vips))
        {
            Map<Long,Date> vipMap = new HashMap<>();
            for(UserVip vip:vips){
                vipMap.put(vip.getUserId().longValue(),vip.getAddTime());
            }
            for(UserStu stu:userStu){

                if(vipMap.containsKey(stu.getId())){
                    stu.setLastPayDatetime(vipMap.get(stu.getId()));
                }
                userStuList.add(stu);
            }
        }else {
            userStuList = userStu;
        }
        return userStuList;
    }

    @Override
    public List<UserStu> exportCsvAnswers(UserStuSerachBean serachBean) {
        List<UserStu> stu = this.iBaseDao.page(serachBean);
        return stu;
    }
}
