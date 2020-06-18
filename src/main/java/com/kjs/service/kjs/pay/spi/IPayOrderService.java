package com.kjs.service.kjs.pay.spi;

import com.kjs.common.bean.DataTablePageModel;
import com.kjs.common.dto.TrackDTO;
import com.kjs.orm.model.PayOrder;
import com.kjs.orm.model.RefundDetail;
import com.kjs.service.core.spi.IBaseService;
import com.kjs.web.serach.kjs.order.PayOrderSearchBean;

import javax.servlet.http.HttpServletRequest;
import java.util.List;

/**
 * @author 李恒名
 * @date 2016-6-12
 */
public interface IPayOrderService extends IBaseService<PayOrder, Long> {

    PayOrder findRefundInfoById(Long id);

    //退款
    void refund(RefundDetail order);

    void create(Long vipId, String uid, Long userVoucherId, HttpServletRequest request);

    DataTablePageModel buildModelBySearch4Bill(DataTablePageModel search);

    DataTablePageModel buildModelBySearch4financeStatistics(PayOrderSearchBean search);

    /**
     * @param id  orderId
     * @param type 轨迹类型，1支付前的，2创建订单前的
     * @return
     */
    List<TrackDTO> findTrackById(Long id, int type);
}