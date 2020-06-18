package com.kjs.service.kjs.pay.spi;

import com.kjs.common.dto.RefundDetailDto;
import com.kjs.common.utils.ShiroUtils;
import com.kjs.orm.mapper.PayOrderMapper;
import com.kjs.orm.mapper.RefundDetailMapper;
import com.kjs.orm.mapper.UserVipMapper;
import com.kjs.orm.model.PayOrder;
import com.kjs.orm.model.RefundDetail;
import com.kjs.orm.model.UserVip;
import com.kjs.service.core.BaseService;
import com.kjs.service.kjs.pay.IRefundDetailService;
import org.apache.commons.lang.time.DateUtils;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.util.Date;
import java.util.List;

/**
 * 订单退款服务
 *
 * @author 李恒名
 * @date 2016-11-23
 */
@Service
@Transactional
public class RefundDetailService extends BaseService<RefundDetail, Long> implements IRefundDetailService {

    @Resource
    private PayOrderMapper orderMapper;
    @Resource
    private RefundDetailMapper refundMapper;
    @Resource
    private UserVipMapper userVipMapper;

    @Override
    public List<RefundDetailDto> findDetailListByOrderId(Long id) {
        return refundMapper.findByOrderId(id);
    }

    @Override
    public void refundAuditByTeacherManager(Long id, String opinion, Boolean pass) {
        RefundDetail refundDetail = refundMapper.findById(id);
        PayOrder order = orderMapper.findById(refundDetail.getOrderId().longValue());
        if (pass) {
            List<UserVip> userVips = userVipMapper.findByUserId4Refund(order.getUserId());

            //退款
            UserVip refunded = null;//已退款的套餐记录

            for (UserVip userVip : userVips) {
                if (userVip.getOrderId().equals(refundDetail.getOrderId())) {
                    refunded = userVip;
                    userVips.remove(userVip);
                    userVipMapper.delete(userVip.getId());
                    break;
                }
            }

            //如果还存在其他未到期的叠加套餐，重新计算其他套餐的起始/结束时间
            if (!userVips.isEmpty() && refunded != null) {
                Date apply = refundDetail.getCtime();//申請退款時間
                final Date refundedStartDate = refunded.getStartDate();
                final Date refundedEndDate = refunded.getEndDate();
                Date flag;//重置标记，大于该时间的套餐，起始/结束时间将会被重置，用于解决退款套餐处于中间位置的情况
                Date startDate = null;
                if (refundedStartDate.before(apply)) {//如果退款套餐的开始时间小于当前时间
                    flag = apply;
                    startDate = apply;
                } else {//否则
                    flag = refundedEndDate;
                }
                for (UserVip userVip : userVips) {//重置其他套餐的起始/结束时间
                    if (userVip.getStartDate().after(flag) || userVip.getStartDate().getTime() == flag.getTime()) {
                        userVip.setStartDate(startDate!=null?startDate:refundedStartDate);
                        int months = 0;
                        if (userVip.getVipId() == 1)
                            months = 1;
                        else if (userVip.getVipId() == 2)
                            months = 3;
                        else if (userVip.getVipId() == 3)
                            months = 12;

                        userVip.setEndDate(DateUtils.addMonths(userVip.getStartDate(), months));
                        userVipMapper.update(userVip);
                        startDate = userVip.getEndDate();
                    }
                }

            }
            //其他业务逻辑
            if ("5".equals(order.getPayType())) {//如果为优惠券支付直接退款流程结束
                refundDetail.setRefundStatus(3);
                refundDetail.setFinancePassTime(new Date());
                order.setBackTime(new Date());
                order.setAuditStatus(PayOrder.REFUND_STATUS_FINISH);
            } else {
                refundDetail.setRefundStatus(2);
            }
        } else {
            order.setAuditStatus("0");
            refundDetail.setRefundStatus(0);
        }
        refundDetail.setTeacherManagerName(ShiroUtils.getSessionUser().getUsername());
        refundDetail.setTeacherManagerOpinion(opinion);
        refundDetail.setTeacherManagerPassTime(new Date());
        refundMapper.update(refundDetail);
        orderMapper.update(order);
    }

    @Override
    public void refundAuditByFinance(Long id, String opinion, Boolean pass, boolean isSecond) {
        RefundDetail refundDetail = refundMapper.findById(id);
        PayOrder order = orderMapper.findById(refundDetail.getOrderId().longValue());

        if (pass) {
            if(!isSecond){
                refundDetail.setRefundStatus(3);
                order.setBackTime(new Date());
                order.setAuditStatus(PayOrder.REFUND_STATUS_FINISH);
            }
        } else {
            order.setAuditStatus("0");
            refundDetail.setRefundStatus(0);
        }

        if (isSecond) {
            refundDetail.setFinanceManagerName(ShiroUtils.getSessionUser().getUsername());
            refundDetail.setFinanceManagerOpinion(opinion);
            refundDetail.setFinanceManagerPassTime(new Date());
        } else {
            refundDetail.setFinanceName(ShiroUtils.getSessionUser().getUsername());
            refundDetail.setFinanceOpinion(opinion);
            refundDetail.setFinancePassTime(new Date());
        }

        refundMapper.update(refundDetail);
        orderMapper.update(order);
    }

    @Override
    public List<RefundDetailDto> findByOrderId(Long id) {
        return refundMapper.findByOrderId(id);
    }

}
