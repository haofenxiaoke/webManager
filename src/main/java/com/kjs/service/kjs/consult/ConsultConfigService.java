package com.kjs.service.kjs.consult;

import com.google.common.collect.Maps;
import com.kjs.common.constant.SystemConstant;
import com.kjs.orm.mapper.ConsultConfigMapper;
import com.kjs.orm.model.ConsultConfig;
import com.kjs.service.core.BaseService;
import com.kjs.service.kjs.consult.spi.IConsultConfigService;
import org.springframework.stereotype.Service;
import org.springframework.util.CollectionUtils;

import javax.annotation.Resource;
import java.util.List;
import java.util.Map;

/**
 * Service Implementation:ConsultConfig
 * @author kjs_builder
 * @date 2017-3-29
 */
@Service
public class ConsultConfigService extends BaseService<ConsultConfig,Long> implements IConsultConfigService {
    @Resource
    private ConsultConfigMapper mapper;

    public List<ConsultConfig> queryAll(){
        return mapper.queryAll();
    };
}
