package com.kjs.common.dto;

import com.kjs.orm.model.PayOrder;
import com.kjs.orm.model.RefundDetail;


/**
 * Created by 李恒名 on 2016/11/23.
 */
public class RefundDetailDto extends RefundDetail {
    private String programName; //商品名
    private Double costPrice;//订单价格
    private Double realpayPrice;//支付价格
    private String payType;//支付类型
    private String payTypeDesc;//支付类型描述
    private String payNum;//支付流水号
    private String refundStatusDesc;//退款状态描述

    public String getPayTypeDesc() {
        payTypeDesc = PayOrder.buildPayTypeDesc(payType);
        return payTypeDesc;
    }

    public String getProgramName() {
        return programName;
    }

    public void setProgramName(String programName) {
        this.programName = programName;
    }


    public Double getCostPrice() {
        return costPrice;
    }

    public void setCostPrice(Double costPrice) {
        this.costPrice = costPrice;
    }

    public Double getRealpayPrice() {
        return realpayPrice;
    }

    public void setRealpayPrice(Double realpayPrice) {
        this.realpayPrice = realpayPrice;
    }

    public String getPayType() {
        return payType;
    }

    public void setPayType(String payType) {
        this.payType = payType;
    }

    public void setPayTypeDesc(String payTypeDesc) {
        this.payTypeDesc = payTypeDesc;
    }

    public String getRefundStatusDesc() {
        Integer refundStatus = getRefundStatus();
        if (refundStatus != null) {
            if (refundStatus == 0) {
                refundStatusDesc = "审批未通过";
            } else if (refundStatus == 1) {
                refundStatusDesc = "待审批";
            } else if (refundStatus == 2) {
                refundStatusDesc = "待退款";
            } else if (refundStatus == 3) {
                refundStatusDesc = "已退款";
            } else {
                refundStatusDesc = "未知状态";
            }

        }
        return refundStatusDesc;
    }

    public String getPayNum() {
        return payNum;
    }

    public void setPayNum(String payNum) {
        this.payNum = payNum;
    }

    public void setRefundStatusDesc(String refundStatusDesc) {
        this.refundStatusDesc = refundStatusDesc;
    }

    @Override
    public String toString() {
        return "RefundDetailDto{" +
                "programName='" + programName + '\'' +
                ", costPrice=" + costPrice +
                ", realpayPrice=" + realpayPrice +
                ", payType='" + payType + '\'' +
                ", payTypeDesc='" + payTypeDesc + '\'' +
                ", payNum='" + payNum + '\'' +
                ", refundStatusDesc='" + refundStatusDesc + '\'' +
                '}';
    }
}
