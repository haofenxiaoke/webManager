package com.kjs.orm.mapper;

import com.kjs.orm.core.BaseMapper;
import com.kjs.orm.model.ConsultConfig;

import java.util.List;

public interface ConsultConfigMapper extends BaseMapper<ConsultConfig,Long> {

    List<ConsultConfig> queryAll();
}