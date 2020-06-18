package com.kjs.service.kjs.pay;

import com.kjs.common.dto.RefundDetailDto;
import com.kjs.orm.model.RefundDetail;
import com.kjs.service.core.spi.IBaseService;

import java.util.List;

/**
 * 订单退款服务
 *
 * @author 李恒名
 * @date 2016-11-23
 */
public interface IRefundDetailService extends IBaseService<RefundDetail, Long> {

    List<RefundDetailDto> findDetailListByOrderId(Long id);

    /**
     * 退款，教务主管审批
     *
     * @param id      退款详情ID
     * @param opinion 意见
     * @param pass    是否统一
     */
    void refundAuditByTeacherManager(Long id, String opinion, Boolean pass);

    /**
     * 退款，财务审批
     *
     * @param id      退款详情ID
     * @param opinion 意见
     * @param pass    是否统一
     */
    void refundAuditByFinance(Long id, String opinion, Boolean pass , boolean isSecond);

    List<RefundDetailDto> findByOrderId(Long id);
}