package com.kjs.web.serach.kjs.commodity;

import com.kjs.common.bean.DataTablePageModel;
import com.kjs.common.utils.DateUtils;
import org.apache.commons.lang.StringUtils;

import java.util.Date;

/**
 * @author: liuhuan
 * @Description: 商品砍价记录条件对象
 * @date: 2019/8/6
 */
public class CommodityBargainRecordConditionBean extends DataTablePageModel {

    /**
     * 方向id
     */
    private Integer directionId;
    /**
     * 行业id
     */
    private Integer industryId;
    /**
     * 发放时间
     */
    private String bargainSuccessTime;
    /**
     * 发放开始时间
     */
    private Date bargainSuccessBeginTime;
    /**
     * 发放结束时间
     */
    private Date bargainSuccessEndTime;
    /**
     * 兑换状态
     */
    private Integer ticketStatus;
    /**
     * 发起人
     */
    private String bargainer;
    /**
     * 兑换人
     */
    private String exchangeUserPhone;
    /**
     * 课程券号
     */
    private String code;
    /**
     * 砍价状态
     */
    private Integer bargainStatus;
    /**
     * 砍价开始时间
     */
    private Date bargainBeginTime;
    /**
     * 砍价结束时间
     */
    private Date bargainEndTime;
    /**
     * 砍价时间
     */
    private String bargainTime;

    public Integer getDirectionId() {
        return directionId;
    }

    public void setDirectionId(Integer directionId) {
        this.directionId = directionId;
    }

    public Integer getIndustryId() {
        return industryId;
    }

    public void setIndustryId(Integer industryId) {
        this.industryId = industryId;
    }

    public Date getBargainSuccessBeginTime() {
        return bargainSuccessBeginTime;
    }

    public void setBargainSuccessBeginTime(Date bargainSuccessBeginTime) {
        this.bargainSuccessBeginTime = bargainSuccessBeginTime;
    }

    public Date getBargainSuccessEndTime() {
        return bargainSuccessEndTime;
    }

    public void setBargainSuccessEndTime(Date bargainSuccessEndTime) {
        this.bargainSuccessEndTime = bargainSuccessEndTime;
    }

    public Integer getTicketStatus() {
        return ticketStatus;
    }

    public void setTicketStatus(Integer ticketStatus) {
        this.ticketStatus = ticketStatus;
    }

    public String getBargainer() {
        return bargainer;
    }

    public void setBargainer(String bargainer) {
        this.bargainer = bargainer;
    }

    public String getExchangeUserPhone() {
        return exchangeUserPhone;
    }

    public void setExchangeUserPhone(String exchangeUserPhone) {
        this.exchangeUserPhone = exchangeUserPhone;
    }

    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
    }

    public Integer getBargainStatus() {
        return bargainStatus;
    }

    public void setBargainStatus(Integer bargainStatus) {
        this.bargainStatus = bargainStatus;
    }

    public Date getBargainBeginTime() {
        return bargainBeginTime;
    }

    public void setBargainBeginTime(Date bargainBeginTime) {
        this.bargainBeginTime = bargainBeginTime;
    }

    public Date getBargainEndTime() {
        return bargainEndTime;
    }

    public void setBargainEndTime(Date bargainEndTime) {
        this.bargainEndTime = bargainEndTime;
    }

    public String getBargainSuccessTime() {
        return bargainSuccessTime;
    }

    public void setBargainSuccessTime(String bargainSuccessTime) {
        this.bargainSuccessTime = bargainSuccessTime;
        if(StringUtils.isNotBlank(bargainSuccessTime)){
            String date[] =   bargainSuccessTime.split("/");
            this.bargainSuccessBeginTime=  DateUtils.getFirstDateOfDay(DateUtils.stringtoDate(date[0]));
            this.bargainSuccessEndTime=  DateUtils.getLastDateOfDay(DateUtils.stringtoDate(date[1]));
        }
    }

    public String getBargainTime() {
        return bargainTime;
    }

    public void setBargainTime(String bargainTime) {
        this.bargainTime = bargainTime;
        if(StringUtils.isNotBlank(bargainTime)){
            String date[] =   bargainTime.split("/");
            this.bargainBeginTime=  DateUtils.getFirstDateOfDay(DateUtils.stringtoDate(date[0]));
            this.bargainEndTime=  DateUtils.getLastDateOfDay(DateUtils.stringtoDate(date[1]));
        }
    }
}
