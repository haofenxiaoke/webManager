package com.kjs.common.dto.excel;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.google.gson.JsonObject;
import com.kjs.common.bean.annotation.ExcelBean;
import com.kjs.common.bean.annotation.ExcelColumn;
import com.kjs.common.utils.excel.BaseExcel;
import org.springframework.format.annotation.DateTimeFormat;

import java.text.SimpleDateFormat;
import java.util.Date;

/**
 * @author: liuhuan
 * @Description: 商品excel导出数据对象
 * @date: 2019/8/8
 */
@ExcelBean(sheetName = "商品砍价发券记录")
public class CommodityExcelDTO implements BaseExcel {

    SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy/MM/dd");
    /**
     * 兑换用户id
     */
    private Integer exchangeUserId;

    private Integer directionId;

    private Integer industryId;

    @ExcelColumn(name = "序号")
    private Integer num;

    @ExcelColumn(name = "商品")
    private String commodityName;
    /**
     * 方向
     */
    @ExcelColumn(name = "方向")
    private String directionName;
    /**
     * 行业
     */
    @ExcelColumn(name = "行业")
    private String industryName;

    private Integer status;

    @ExcelColumn(name = "砍价状态")
    private String statusString;

    @ExcelColumn(name = "砍价时间")
    private Date bargainBeginTime;

    private Integer courseTicketId;

    @ExcelColumn(name = "课程券号")
    private String code;

    @ExcelColumn(name = "发放时间")
    private Date bargainSuccessTime;

    @ExcelColumn(name = "砍价人")
    private String bargainer;

    private String bargainHelpers;

    @ExcelColumn(name = "助力砍价人1")
    private String bargainHelperOne;

    @ExcelColumn(name = "助力砍价人2")
    private String bargainHelperTwo;

    /**
     * 兑换状态
     */
    private Integer ticketStatus;

    @ExcelColumn(name = "兑换状态")
    private String ticketStatusString;
    /**
     * 兑换人手机号
     */
    @ExcelColumn(name = "兑换人")
    private String exchangeUserPhone;

    /**
     * 券有效起始时间
     */
    private Date validityBeginTime;
    /**
     * 券有效结束时间
     */
    private Date validityEndTime;

    @ExcelColumn(name = "有效时间")
    private String validityTime;

    public Integer getExchangeUserId() {
        return exchangeUserId;
    }

    public void setExchangeUserId(Integer exchangeUserId) {
        this.exchangeUserId = exchangeUserId;
    }

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

    public Integer getNum() {
        return num;
    }

    public void setNum(Integer num) {
        this.num = num;
    }

    public String getCommodityName() {
        return commodityName;
    }

    public void setCommodityName(String commodityName) {
        this.commodityName = commodityName;
    }

    public Integer getCourseTicketId() {
        return courseTicketId;
    }

    public void setCourseTicketId(Integer courseTicketId) {
        this.courseTicketId = courseTicketId;
    }

    public String getBargainer() {
        return bargainer;
    }

    public void setBargainer(String bargainer) {
        this.bargainer = bargainer;
    }

    public String getBargainHelpers() {
        return bargainHelpers;
    }

    public void setBargainHelpers(String bargainHelpers) {
        this.bargainHelpers = bargainHelpers;
    }

    public String getBargainHelperOne() {
        return bargainHelperOne;
    }

    public void setBargainHelperOne(String bargainHelperOne) {
        this.bargainHelperOne = bargainHelperOne;
    }

    public String getBargainHelperTwo() {
        return bargainHelperTwo;
    }

    public void setBargainHelperTwo(String bargainHelperTwo) {
        this.bargainHelperTwo = bargainHelperTwo;
    }

    public Date getBargainBeginTime() {
        return bargainBeginTime;
    }

    public void setBargainBeginTime(Date bargainBeginTime) {
        this.bargainBeginTime = bargainBeginTime;
    }

    public Date getBargainSuccessTime() {
        return bargainSuccessTime;
    }

    public void setBargainSuccessTime(Date bargainSuccessTime) {
        this.bargainSuccessTime = bargainSuccessTime;
    }

    public Integer getStatus() {
        return status;
    }

    public void setStatus(Integer status) {
        this.status = status;
    }

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


    public String getValidityTime() {
        return validityTime;
    }

    public void setValidityTime(String validityTime) {
        this.validityTime = validityTime;
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

    /**
     * @Author liuhuan
     * @Description 初始化兑换时间
     * @Date  2019/08/08
     * @Param []
     * @return void
     **/
    public void initValidityTime() {
        if(null != this.validityBeginTime && null != this.validityEndTime){
            this.validityTime = dateFormat.format(validityBeginTime)+"-"+dateFormat.format(validityEndTime);
        }
    }

    /**
     * @Author liuhuan
     * @Description 初始化助砍人1
     * @Date  2019/08/08
     * @Param []
     * @return void
     **/
    public void initBargainHelperOne() {
        JSONArray objects = JSON.parseArray(this.bargainHelpers);
        if(null != objects && objects.size() >= 2){
            JSONObject object = (JSONObject) objects.get(1);
            this.bargainHelperOne = object.getString("mobile");
        }
    }

    /**
     * @Author liuhuan
     * @Description 初始化助砍人2
     * @Date  2019/08/08
     * @Param []
     * @return void
     **/
    public void initBargainHelperTwo() {
        JSONArray objects = JSON.parseArray(this.bargainHelpers);
        if(null != objects && objects.size() >= 3){
            JSONObject object = (JSONObject) objects.get(2);
            this.bargainHelperTwo = object.getString("mobile");
        }
    }

    /**
     * @Author liuhuan
     * @Description 初始化兑换状态
     * @Date  2019/08/08
     * @Param []
     * @return void
     **/
    public void initTicketStatus() {
        if(null == this.ticketStatus){
            return;
        }
        if(0 == this.ticketStatus){
            this.ticketStatusString = "已兑换";
        }
        if(1 == this.ticketStatus) {
            this.ticketStatusString = "未兑换";
        }
    }

    /**
     * @Author liuhuan
     * @Description 初始化砍价状态
     * @Date  2019/08/08
     * @Param []
     * @return void
     **/
    public void initStatus() {
        if(null == this.status){
            return;
        }
        if(0 == this.status){
            this.statusString = "进行中";
        }
        if(1 == this.status) {
            this.statusString = "已完成";
        }
        if(2 == this.status) {
            this.statusString = "已过期";
        }
    }

    /**
     * @Author liuhuan
     * @Description 初始化方法
     * @Date  2019/08/08
     * @Param []
     * @return void
     **/
    public void init(){
        initValidityTime();
        initBargainHelperOne();
        initBargainHelperTwo();
        initTicketStatus();
        initStatus();
    }
}
