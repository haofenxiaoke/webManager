package com.kjs.web.serach.kjs.operation;

import com.kjs.common.bean.DataTablePageModel;
import com.kjs.common.utils.DateUtils;
import org.apache.commons.lang.StringUtils;

import java.util.Date;

/**
 * Created by 李恒名 on 2016/6/15.
 */
public class MessageSearchBean extends DataTablePageModel {
    private String sendObject;//发送对象
    private String sendDateStr;//查询日期范围
    private Date startSendDate;
    private Date endSendDate;

    public void setSendObject(String sendObject) {
        this.sendObject = sendObject;
    }

    public String getSendObject() {
        return sendObject;
    }

    public String getSendDateStr() {
        return sendDateStr;
    }

    public void setSendDateStr(String sendDateStr) {
        this.sendDateStr = sendDateStr;
        if (StringUtils.isNotEmpty(sendDateStr)) {
            String date[] = sendDateStr.split("/");
            this.startSendDate = DateUtils.getFirstDateOfDay(DateUtils.stringtoDate(date[0]));
            this.endSendDate = DateUtils.getLastDateOfDay(DateUtils.stringtoDate(date[1]));
        }
    }

    public Date getStartSendDate() {
        return startSendDate;
    }

    public void setStartSendDate(Date startSendDate) {
        this.startSendDate = startSendDate;
    }

    public Date getEndSendDate() {
        return endSendDate;
    }

    public void setEndSendDate(Date endSendDate) {
        this.endSendDate = endSendDate;
    }
}
