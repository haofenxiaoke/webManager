package com.kjs.orm.mapper;

import com.kjs.orm.core.BaseMapper;
import com.kjs.orm.model.UserVoucher;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface UserVoucherMapper extends BaseMapper<UserVoucher,Long> {
    void batchSave(List<UserVoucher> userVoucherList);
    UserVoucher findDetailById(Long id);
    List<UserVoucher> findByUserIdAndPrice(@Param("id") Long id,@Param("price") Integer price);
}