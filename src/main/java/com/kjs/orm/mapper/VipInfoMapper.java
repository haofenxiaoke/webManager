package com.kjs.orm.mapper;

import com.kjs.orm.core.BaseMapper;
import com.kjs.orm.model.VipInfo;

import java.util.List;

public interface VipInfoMapper extends BaseMapper<VipInfo,Long> {
    List<VipInfo> queryAll();
}