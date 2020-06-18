package com.kjs.service.kjs.commodity;

import com.kjs.common.dto.excel.CommodityExcelDTO;
import com.kjs.orm.mapper.CommodityBargainRecordMapper;
import com.kjs.orm.model.CommodityBargainRecord;
import com.kjs.service.core.BaseService;
import com.kjs.service.kjs.commodity.spi.ICommodityBargainRecordService;
import com.kjs.web.serach.kjs.commodity.CommodityBargainRecordConditionBean;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * @author: liuhuan
 * @Description: 商品砍价记录服务层
 * @date: 2019/8/6
 */
@Service
public class CommodityBargainRecordService extends BaseService<CommodityBargainRecord,Long> implements ICommodityBargainRecordService {

    @Autowired
    private CommodityBargainRecordMapper commodityBargainRecordMapper;
    /**
     * @Author liuhuan
     * @Description 根据条件查询出导出数据
     * @Date  2019/08/08
     * @Param [conditionBean]
     * @return java.util.List<com.kjs.common.dto.excel.CommodityExcelDTO>
     **/
    @Override
    public List<CommodityExcelDTO> getExcelExportData(CommodityBargainRecordConditionBean conditionBean) {

        return commodityBargainRecordMapper.findByCondition(conditionBean);
    }
}
