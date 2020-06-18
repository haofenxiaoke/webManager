package com.kjs.common.dto;

/**
 * Created by 李恒名 on 2016/11/28.
 */
public class FinanceStatisticsDTO {
    private String payType;
    private Double sum;
    private Long count;
    private String payTypeDesc;

    public String getPayType() {
        return payType;
    }

    public void setPayType(String payType) {
        this.payType = payType;
    }

    public Double getSum() {
        return sum;
    }

    public void setSum(Double sum) {
        this.sum = sum;
    }

    public Long getCount() {
        return count;
    }

    public void setCount(Long count) {
        this.count = count;
    }

    public String getPayTypeDesc() {
        if ("1".equals(payType)) {
            payTypeDesc = "支付宝";
        } else if ("2".equals(payType)) {
            payTypeDesc = "微信支付";
        } else if ("3".equals(payType)) {
            payTypeDesc = "财付通(含网银)";
        } else if ("4".equals(payType)) {
            payTypeDesc = "财付通(含网银)";
        }  else {
            payTypeDesc = "未知类型";
        }
        return payTypeDesc;
    }

    public void setPayTypeDesc(String payTypeDesc) {
        this.payTypeDesc = payTypeDesc;
    }
}
