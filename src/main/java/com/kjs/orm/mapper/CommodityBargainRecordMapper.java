package com.kjs.orm.mapper;

import com.kjs.common.dto.excel.CommodityExcelDTO;
import com.kjs.orm.core.BaseMapper;
import com.kjs.orm.model.CommodityBargainRecord;
import com.kjs.orm.model.CourseTicket;
import com.kjs.web.serach.kjs.commodity.CommodityBargainRecordConditionBean;

import java.util.List;

public interface CommodityBargainRecordMapper extends BaseMapper<CommodityBargainRecord,Long> {

    List<CommodityExcelDTO> findByCondition(CommodityBargainRecordConditionBean conditionBean);
}