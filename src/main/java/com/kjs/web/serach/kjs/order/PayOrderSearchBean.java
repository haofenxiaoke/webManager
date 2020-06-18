package com.kjs.web.serach.kjs.order;

import com.kjs.common.bean.DataTablePageModel;
import com.kjs.common.utils.DateUtils;
import org.apache.commons.lang.StringUtils;

import java.util.Date;

/**
 * Created by 李恒名 on 2016/6/12.
 */
public class PayOrderSearchBean extends DataTablePageModel {
    private String	payNum;
    private String	username;

    private Date startOrderDate;
    private Date endOrderDate;
    private Date startPayDate;
    private Date endPayDate;

    private String payType;//支付类型1支付宝2微信支付3财付通4银联

    private String orderDateStr;
    private String payDateStr;
    private Integer orderStatus;//订单状态，0未支付，1已支付，2已退款

    private String orderNum;
    private Integer refundStatus;		 /* 退款状态，1待审批2待退款3已退款 */

    private Integer isRefundManagerPage;

    private Integer payMoney;//实付金额

    public Integer getRefundStatus() {
        return refundStatus;
    }

    public void setRefundStatus(Integer refundStatus) {
        this.refundStatus = refundStatus;
    }

    public String getPayNum() {
        return payNum;
    }

    public void setPayNum(String payNum) {
        this.payNum = payNum;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }


    public Date getEndOrderDate() {
        return endOrderDate;
    }

    public void setEndOrderDate(Date endOrderDate) {
        this.endOrderDate = endOrderDate;
    }

    public Date getStartOrderDate() {
        return startOrderDate;
    }

    public void setStartOrderDate(Date startOrderDate) {
        this.startOrderDate = startOrderDate;
    }

    public Date getStartPayDate() {
        return startPayDate;
    }

    public void setStartPayDate(Date startPayDate) {
        this.startPayDate = startPayDate;
    }

    public Date getEndPayDate() {
        return endPayDate;
    }

    public void setEndPayDate(Date endPayDate) {
        this.endPayDate = endPayDate;
    }

    public String getOrderDateStr() {
        return orderDateStr;
    }

    public Integer getOrderStatus() {
        return orderStatus;
    }

    public void setOrderStatus(Integer orderStatus) {
        this.orderStatus = orderStatus;
    }

    public void setOrderDateStr(String orderDateStr) {
        this.orderDateStr = orderDateStr;
        if (StringUtils.isNotEmpty(orderDateStr)) {
            String date[] = orderDateStr.split("/");
            this.startOrderDate = DateUtils.getFirstDateOfDay(DateUtils.stringtoDate(date[0]));
            this.endOrderDate = DateUtils.getLastDateOfDay(DateUtils.stringtoDate(date[1]));
        }
    }

    public String getPayDateStr() {
        return payDateStr;
    }

    public void setPayDateStr(String payDateStr) {
        this.payDateStr = payDateStr;
        if (StringUtils.isNotEmpty(payDateStr)) {
            String date[] = payDateStr.split("/");
            this.startPayDate = DateUtils.getFirstDateOfDay(DateUtils.stringtoDate(date[0]));
            this.endPayDate = DateUtils.getLastDateOfDay(DateUtils.stringtoDate(date[1]));
        }
    }

    public String getOrderNum() {
        return orderNum;
    }

    public void setOrderNum(String orderNum) {
        this.orderNum = orderNum;
    }

    public Integer getIsRefundManagerPage() {
        return isRefundManagerPage;
    }

    public void setIsRefundManagerPage(Integer isRefundManagerPage) {
        this.isRefundManagerPage = isRefundManagerPage;
    }

    public String getPayType() {
        return payType;
    }

    public void setPayType(String payType) {
        this.payType = payType;
    }

    public Integer getPayMoney() {
        return payMoney;
    }

    public void setPayMoney(Integer payMoney) {
        this.payMoney = payMoney;
    }
}

