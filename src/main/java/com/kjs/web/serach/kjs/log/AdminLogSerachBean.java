package com.kjs.web.serach.kjs.log;

import com.kjs.common.bean.DataTablePageModel;
import com.kjs.common.utils.DateUtils;
import org.apache.commons.lang.StringUtils;
import org.apache.ibatis.type.Alias;

import java.util.Date;

/**
 * Created by qiaolu on 2016/3/25.
 */
@SuppressWarnings("serial")
@Alias("AdminLogSerach")
public class AdminLogSerachBean extends DataTablePageModel {
    private String userName;
    private String operType;
    private Integer operLevel;
    private String operTime;
    private Date startDatetime; /*sql使用的开始时间*/
    private Date endDatetime; /*sql使用的结束时间*/

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public String getOperType() {
        return operType;
    }

    public void setOperType(String operType) {
        this.operType = operType;
    }

    public Integer getOperLevel() {
        return operLevel;
    }

    public void setOperLevel(Integer operLevel) {
        this.operLevel = operLevel;
    }

    public String getOperTime() {
        return operTime;
    }

    public void setOperTime(String operTime) {
        this.operTime = operTime;
        if (StringUtils.isNotBlank(operTime)) {
            String date[] = operTime.split("/");
            this.startDatetime = DateUtils.getFirstDateOfDay(DateUtils.stringtoDate(date[0]));
            this.endDatetime = DateUtils.getLastDateOfDay(DateUtils.stringtoDate(date[1]));
        }
    }

    public Date getStartDatetime() {
        return startDatetime;
    }

    public void setStartDatetime(Date startDatetime) {
        this.startDatetime = startDatetime;
    }

    public Date getEndDatetime() {
        return endDatetime;
    }

    public void setEndDatetime(Date endDatetime) {
        this.endDatetime = endDatetime;
    }
}
