package com.kjs.service.kjs.commodity.spi;

import com.kjs.common.dto.excel.CommodityExcelDTO;
import com.kjs.orm.core.BaseMapper;
import com.kjs.orm.model.CommodityBargainRecord;
import com.kjs.service.core.BaseService;
import com.kjs.service.core.spi.IBaseService;
import com.kjs.web.serach.kjs.commodity.CommodityBargainRecordConditionBean;

import java.util.List;

/**
 * @author: liuhuan
 * @Description: 商品砍价记录服务
 * @date: 2019/8/6
 */
public interface ICommodityBargainRecordService extends IBaseService<CommodityBargainRecord,Long> {

    List<CommodityExcelDTO> getExcelExportData(CommodityBargainRecordConditionBean conditionBean);

}