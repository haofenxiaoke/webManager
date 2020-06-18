package com.kjs.orm.mapper;

import com.kjs.common.dto.RefundDetailDto;
import com.kjs.orm.core.BaseMapper;
import com.kjs.orm.model.RefundDetail;

import java.util.List;

public interface RefundDetailMapper extends BaseMapper<RefundDetail,Long> {

    List<RefundDetailDto> findByOrderId(Long id);
}