package com.kjs.common.dto.commodity;

import com.kjs.orm.model.CommodityBargainRecord;

import java.util.Date;

/**
 * @author: liuhuan
 * @Description: 商品砍价记录数据对象
 * @date: 2019/8/6
 */
public class CommodityBargainRecordDTO extends CommodityBargainRecord {

    /**
     * 兑换状态
     */
    private Integer ticketStatus;
    /**
     * 兑换人手机号
     */
    private String exchangeUserPhone;
    /**
     * 兑换用户id
     */
    private Integer exchangeUserId;
    /**
     * 券有效起始时间
     */
    private Date validityBeginTime;
    /**
     * 券有效结束时间
     */
    private Date validityEndTime;
    /**
     * 方向
     */
    private String directionName;
    /**
     * 行业
     */
    private String industryName;

    /**
     * 课程券号
     */
    private String code;


    public Integer getTicketStatus() {
        return ticketStatus;
    }

    public void setTicketStatus(Integer ticketStatus) {
        this.ticketStatus = ticketStatus;
    }

    public String getExchangeUserPhone() {
        return exchangeUserPhone;
    }

    public void setExchangeUserPhone(String exchangeUserPhone) {
        this.exchangeUserPhone = exchangeUserPhone;
    }

    public Integer getExchangeUserId() {
        return exchangeUserId;
    }

    public void setExchangeUserId(Integer exchangeUserId) {
        this.exchangeUserId = exchangeUserId;
    }

    public Date getValidityBeginTime() {
        return validityBeginTime;
    }

    public void setValidityBeginTime(Date validityBeginTime) {
        this.validityBeginTime = validityBeginTime;
    }

    public Date getValidityEndTime() {
        return validityEndTime;
    }

    public void setValidityEndTime(Date validityEndTime) {
        this.validityEndTime = validityEndTime;
    }

    public String getDirectionName() {
        return directionName;
    }

    public void setDirectionName(String directionName) {
        this.directionName = directionName;
    }

    public String getIndustryName() {
        return industryName;
    }

    public void setIndustryName(String industryName) {
        this.industryName = industryName;
    }

    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
    }

    @Override
    public String toString() {
        return "CommodityBargainRecordDTO{" +
                "ticketStatus=" + ticketStatus +
                ", exchangeUserPhone='" + exchangeUserPhone + '\'' +
                ", exchangeUserId=" + exchangeUserId +
                ", validityBeginTime=" + validityBeginTime +
                ", validityEndTime=" + validityEndTime +
                ", directionName='" + directionName + '\'' +
                ", industryName='" + industryName + '\'' +
                ", code='" + code + '\'' +
                ", id=" + id +
                '}';
    }
}