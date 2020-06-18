package com.kjs.orm.mapper;

import com.kjs.common.bean.DataTablePageModel;
import com.kjs.common.bean.PageModel;
import com.kjs.common.dto.FinanceStatisticsDTO;
import com.kjs.orm.core.BaseMapper;
import com.kjs.orm.model.PayOrder;
import com.kjs.web.serach.kjs.order.PayOrderSearchBean;

import java.util.List;

public interface PayOrderMapper extends BaseMapper<PayOrder,Long> {
    PayOrder findRefundInfoById(Long id);

    List<PayOrder> page4Bill(PageModel<PayOrder> pageModel);

    List<FinanceStatisticsDTO> financeStatistics(PayOrderSearchBean searchBean);

    long count4Bill(DataTablePageModel search);
}