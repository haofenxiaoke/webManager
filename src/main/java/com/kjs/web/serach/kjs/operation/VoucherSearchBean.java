package com.kjs.web.serach.kjs.operation;

import com.kjs.common.bean.DataTablePageModel;
import com.kjs.common.utils.DateUtils;
import org.apache.commons.lang.StringUtils;

import java.util.Date;

/**
 * Created by 李恒名 on 2016/6/15.
 */
public class VoucherSearchBean extends DataTablePageModel {
    private String name;
    private Integer voucherType;
    private Date startCreateDate;
    private Date endCreateDate;

    private String createTimeStr;

    private Integer locked;

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public Integer getVoucherType() {
        return voucherType;
    }

    public void setVoucherType(Integer voucherType) {
        this.voucherType = voucherType;
    }


    public Date getStartCreateDate() {
        return startCreateDate;
    }

    public void setStartCreateDate(Date startCreateDate) {
        this.startCreateDate = startCreateDate;
    }

    public Date getEndCreateDate() {
        return endCreateDate;
    }

    public void setEndCreateDate(Date endCreateDate) {
        this.endCreateDate = endCreateDate;
    }

    public String getCreateTimeStr() {
        return createTimeStr;
    }

    public void setCreateTimeStr(String createTimeStr) {
        this.createTimeStr = createTimeStr;
        if (StringUtils.isNotEmpty(createTimeStr)) {
            String date[] = createTimeStr.split("/");
            this.startCreateDate = DateUtils.getFirstDateOfDay(DateUtils.stringtoDate(date[0]));
            this.endCreateDate = DateUtils.getLastDateOfDay(DateUtils.stringtoDate(date[1]));
        }
    }

    public Integer getLocked() {
        return locked;
    }

    public void setLocked(Integer locked) {
        this.locked = locked;
    }
}
