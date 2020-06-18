package com.kjs.service.kjs.user;

import com.kjs.common.utils.ShiroUtils;
import com.kjs.orm.mapper.UserVoucherMapper;
import com.kjs.orm.mapper.VoucherMapper;
import com.kjs.orm.model.UserVoucher;
import com.kjs.orm.model.Voucher;
import com.kjs.service.core.BaseService;
import com.kjs.service.kjs.user.spi.IUserVoucherService;
import org.apache.commons.lang3.RandomStringUtils;
import org.springframework.dao.DuplicateKeyException;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

/**
 * Service Implementation:UserVoucher
 *
 * @author kjs_builder
 * @date 2016-8-25
 */
@Service
public class UserVoucherService extends BaseService<UserVoucher, Long> implements IUserVoucherService {

    @Resource
    private UserVoucherMapper userVoucherMapper;
    @Resource
    private VoucherMapper voucherMapper;

    @Override
    public void grant(Integer voucherId, Integer voucherCount, String ids) {

        //构造优惠券失效时间
        Voucher voucher = voucherMapper.findById(Long.valueOf(voucherId));
        Integer day = voucher.getDeadline();
        Calendar calendar = Calendar.getInstance();
        calendar.add(Calendar.DATE, day);
        final Date expireDate = calendar.getTime();

        //发放优惠券
        int suffix = 1;
        int i = 0;
        while (i < voucherCount) {
            List<UserVoucher> userVoucherList = new ArrayList<>(ids.length());
            String[] idArray = ids.split(",");
            for (String id : idArray) {
                UserVoucher userVoucher = new UserVoucher();
                userVoucher.setGrantUserId(ShiroUtils.getSessionUser().getId().intValue());
                userVoucher.setCtime(new Date());
                userVoucher.setUserId(Integer.valueOf(id));
                userVoucher.setUsed(0);
                userVoucher.setVoucherNum(String.valueOf(System.currentTimeMillis()) + String.valueOf(suffix));
                userVoucher.setExpireDate(expireDate);
                userVoucher.setPrice(voucher.getPrice());
                userVoucher.setRegulation(voucher.getRegulation());
                userVoucher.setVoucherName(voucher.getName());
                userVoucher.setType(voucher.getType());
                userVoucherList.add(userVoucher);
                suffix++;
            }
            userVoucherMapper.batchSave(userVoucherList);
            i++;
        }

    }

    @Override
    public List<UserVoucher> generateReduceCode(Integer voucherTemplateId, Integer count) {
        //构造优惠券失效时间
        Voucher voucher = voucherMapper.findById(Long.valueOf(voucherTemplateId));
        Integer day = voucher.getDeadline();
        Calendar calendar = Calendar.getInstance();
        calendar.add(Calendar.DATE, day);
        final Date expireDate = calendar.getTime();

        //发放优惠券
        List<UserVoucher> userVoucherList = new ArrayList<>(count);
        int i = 0;
        while (i < count) {
            UserVoucher userVoucher = new UserVoucher();
            userVoucher.setGrantUserId(ShiroUtils.getSessionUser().getId().intValue());
            userVoucher.setCtime(new Date());
            userVoucher.setUserId(0);
            userVoucher.setUsed(0);
            userVoucher.setVoucherNum(RandomStringUtils.random(12, "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"));
            userVoucher.setExpireDate(expireDate);
            userVoucher.setPrice(voucher.getPrice());
            userVoucher.setRegulation(voucher.getRegulation());
            userVoucher.setVoucherName(voucher.getName());
            userVoucher.setType(voucher.getType());
            saveReduceCode(userVoucher);

            userVoucher.setGrantUsername(ShiroUtils.getSessionUser().getEmail());
            userVoucherList.add(userVoucher);
            i++;
        }
        return userVoucherList;
    }

    private void saveReduceCode(UserVoucher userVoucher) {
        try {
            userVoucherMapper.save(userVoucher);
        } catch (DuplicateKeyException e) {//优惠码生成重复时，重试。
            userVoucher.setVoucherNum(RandomStringUtils.random(12, "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"));
            saveReduceCode(userVoucher);
        }
    }

    @Override
    public UserVoucher detail(Long id) {
        return userVoucherMapper.findDetailById(id);
    }

    @Override
    public List<UserVoucher> findByUserIdAndPrice(Long id, Integer price) {
        return userVoucherMapper.findByUserIdAndPrice(id, price);
    }

}
