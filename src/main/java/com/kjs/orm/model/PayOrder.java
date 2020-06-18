package com.kjs.orm.model;


import com.kjs.common.bean.BaseEntity;
import org.apache.commons.lang.StringUtils;
import org.apache.ibatis.type.Alias;

import java.util.Date;

/**
 * POJO:PayOrder
 *
 * @author duia_builder
 * @date 2016-5-23
 */
@SuppressWarnings("serial")
@Alias("PayOrder")
public class PayOrder extends BaseEntity {
    public static final String PAY_STATUS_NOPAY = "0";//未支付
    public static final String PAY_STATUS_PAID = "1";//已支付

    public static final String REFUND_STATUS_REFUNDING = "1";
    public static final String REFUND_STATUS_FINISH = "2";

    private Long userId;		 /* 用户ID */
    private String payNum;		 /* 订单号 */
    private Integer programId;		 /* 商品表id */
    private String programName;		 /* 商品名称 */
    private Double realpayPrice;		 /* 支付价格 */
    private Double costPrice;		 /* 订单价格 */
    private Date orderTime;		 /* 下单时间 */
    private Date payTime;		 /* 支付时间 */
    private String payStatus;		 /* 支付状态  0未支付 1已支付*/
    private String payType;		 /* 支付类型 */
    private String bankType;		 /* 银行类型 */
    private String orderNum;		 /* 银行交易号 */
    private String sourceChannel;		 /* 订单来源渠道 */
    private String auditStatus;		 //退款审核状态，0审核不通过，1退款中，2完成
    private Double backPrice;		 /* 退款金额 */
    private String backType;		 /* 退款类型 */
    private Date backTime;		 /* 退款时间 */
    private String sourceGid;		 /* 订单来源Cookie gid */
    private String ip;		 /* ip地址 */
    private String sourceInfo;		 /* 订单来源信息，关键字/URL */
    private String reduceType;		 /* 优惠减免类型，1：优惠券 */
    private String voucherNum;		 /* 优惠券编号 */
    private String remark;		 /* 备注 */
    private Date createTime;		 /* 创建时间 */
    private Integer deleted;		 /* 删除标记 */
    private String firstIntoUrl;  /* 首次进入网址 */

    //DTO字段
    private String username;//购买账号,连表查询所用
    private String statusDesc; //订单状态描述
    private String payTypeDesc;//支付类型描述

    public String getPayTypeDesc() {
        payTypeDesc = buildPayTypeDesc(payType);
        return payTypeDesc;
    }

    public static String buildPayTypeDesc(String payType) {
        String payTypeDesc;
        if ("1".equals(payType)) {
            payTypeDesc = "支付宝";
        } else if ("2".equals(payType)) {
            payTypeDesc = "微信支付";
        } else if ("3".equals(payType)) {
            payTypeDesc = "财付通";
        } else if ("4".equals(payType)) {
            payTypeDesc = "银联";
        } else if ("5".equals(payType)) {
            payTypeDesc = "券/码全额支付";
        } else {
            payTypeDesc = "未知类型";
        }
        return payTypeDesc;
    }

    public void setPayTypeDesc(String payTypeDesc) {
        this.payTypeDesc = payTypeDesc;
    }

    public Long getUserId() {
        return userId;
    }

    public PayOrder setUserId(Long userId) {
        this.userId = userId;
        return this;
    }


    public String getPayNum() {
        return payNum;
    }

    public PayOrder setPayNum(String payNum) {
        this.payNum = payNum;
        return this;
    }


    public Integer getProgramId() {
        return programId;
    }

    public PayOrder setProgramId(Integer programId) {
        this.programId = programId;
        return this;
    }


    public String getProgramName() {
        return programName;
    }

    public PayOrder setProgramName(String programName) {
        this.programName = programName;
        return this;
    }


    public Double getRealpayPrice() {
        return realpayPrice;
    }

    public PayOrder setRealpayPrice(Double realpayPrice) {
        this.realpayPrice = realpayPrice;
        return this;
    }


    public Double getCostPrice() {
        return costPrice;
    }

    public PayOrder setCostPrice(Double costPrice) {
        this.costPrice = costPrice;
        return this;
    }


    public Date getOrderTime() {
        return orderTime;
    }

    public PayOrder setOrderTime(Date orderTime) {
        this.orderTime = orderTime;
        return this;
    }


    public Date getPayTime() {
        return payTime;
    }

    public PayOrder setPayTime(Date payTime) {
        this.payTime = payTime;
        return this;
    }


    public String getPayStatus() {
        return payStatus;
    }

    public PayOrder setPayStatus(String payStatus) {
        this.payStatus = payStatus;
        return this;
    }


    public String getPayType() {
        return payType;
    }

    public PayOrder setPayType(String payType) {
        this.payType = payType;
        return this;
    }


    public String getBankType() {
        return bankType;
    }

    public PayOrder setBankType(String bankType) {
        this.bankType = bankType;
        return this;
    }


    public String getOrderNum() {
        return orderNum;
    }

    public PayOrder setOrderNum(String orderNum) {
        this.orderNum = orderNum;
        return this;
    }

    public String getAuditStatus() {
        return auditStatus;
    }

    public PayOrder setAuditStatus(String auditStatus) {
        this.auditStatus = auditStatus;
        return this;
    }


    public Double getBackPrice() {
        return backPrice;
    }

    public PayOrder setBackPrice(Double backPrice) {
        this.backPrice = backPrice;
        return this;
    }


    public String getBackType() {
        return backType;
    }

    public PayOrder setBackType(String backType) {
        this.backType = backType;
        return this;
    }


    public String getSourceGid() {
        return sourceGid;
    }

    public void setSourceGid(String sourceGid) {
        this.sourceGid = sourceGid;
    }

    public String getIp() {
        return ip;
    }

    public PayOrder setIp(String ip) {
        this.ip = ip;
        return this;
    }




    public String getRemark() {
        return remark;
    }

    public PayOrder setRemark(String remark) {
        this.remark = remark;
        return this;
    }


    public Date getCreateTime() {
        return createTime;
    }

    public PayOrder setCreateTime(Date createTime) {
        this.createTime = createTime;
        return this;
    }


    public Integer getDeleted() {
        return deleted;
    }

    public PayOrder setDeleted(Integer deleted) {
        this.deleted = deleted;
        return this;
    }

    public String getFirstIntoUrl() {
        return firstIntoUrl;
    }

    public void setFirstIntoUrl(String firstIntoUrl) {
        this.firstIntoUrl = firstIntoUrl;
    }

    public Date getBackTime() {
        return backTime;
    }

    public PayOrder setBackTime(Date backTime) {
        this.backTime = backTime;
        return this;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }


    public String getStatusDesc() {

        if (StringUtils.equals(PAY_STATUS_NOPAY, this.getPayStatus())) {
            statusDesc = "未支付";
        } else if (StringUtils.equals(PAY_STATUS_PAID, this.getPayStatus())) {
            statusDesc = "已支付";
        } else {
            statusDesc = "未知状态";
        }
        return statusDesc;
    }


    public String getSourceChannel() {
        return sourceChannel;
    }

    public void setSourceChannel(String sourceChannel) {
        this.sourceChannel = sourceChannel;
    }

    public String getSourceInfo() {
        return sourceInfo;
    }

    public void setSourceInfo(String sourceInfo) {
        this.sourceInfo = sourceInfo;
    }

    public String getReduceType() {
        return reduceType;
    }

    public void setReduceType(String reduceType) {
        this.reduceType = reduceType;
    }

    public String getVoucherNum() {
        return voucherNum;
    }

    public void setVoucherNum(String voucherNum) {
        this.voucherNum = voucherNum;
    }

    @Override
    public String toString() {
        return "PayOrder{" +
                "userId=" + userId +
                ", payNum='" + payNum + '\'' +
                ", programId=" + programId +
                ", programName='" + programName + '\'' +
                ", realpayPrice=" + realpayPrice +
                ", costPrice=" + costPrice +
                ", orderTime=" + orderTime +
                ", payTime=" + payTime +
                ", payStatus='" + payStatus + '\'' +
                ", payType='" + payType + '\'' +
                ", bankType='" + bankType + '\'' +
                ", orderNum='" + orderNum + '\'' +
                ", sourceChannel='" + sourceChannel + '\'' +
                ", auditStatus='" + auditStatus + '\'' +
                ", backPrice=" + backPrice +
                ", backType='" + backType + '\'' +
                ", backTime=" + backTime +
                ", sourceGid='" + sourceGid + '\'' +
                ", ip='" + ip + '\'' +
                ", sourceInfo='" + sourceInfo + '\'' +
                ", reduceType='" + reduceType + '\'' +
                ", voucherNum='" + voucherNum + '\'' +
                ", remark='" + remark + '\'' +
                ", createTime=" + createTime +
                ", deleted=" + deleted +
                ", firstIntoUrl='" + firstIntoUrl + '\'' +
                ", username='" + username + '\'' +
                ", statusDesc='" + statusDesc + '\'' +
                ", payTypeDesc='" + payTypeDesc + '\'' +
                '}';
    }
}
