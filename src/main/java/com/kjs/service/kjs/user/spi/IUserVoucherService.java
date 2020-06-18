package com.kjs.service.kjs.user.spi;

import com.kjs.service.core.spi.IBaseService;
import com.kjs.orm.model.UserVoucher;

import java.util.List;

/**
 * Service Interface:UserVoucher
 * @author kjs_builder
 * @date 2016-8-25
 */
public interface IUserVoucherService extends IBaseService<UserVoucher,Long> {
    void grant(Integer voucherId,Integer voucherCount,String ids);

    /**
     * 通过模板生成优惠码
     * @param voucherId 模板ID
     * @param count 要生成优惠码的个数
     */
    List<UserVoucher> generateReduceCode(Integer voucherId, Integer count);
    UserVoucher detail(Long id);
    List<UserVoucher> findByUserIdAndPrice(Long id,Integer price);
}