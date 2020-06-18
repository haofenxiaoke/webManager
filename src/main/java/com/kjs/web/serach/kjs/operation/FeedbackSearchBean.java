package com.kjs.web.serach.kjs.operation;

import com.kjs.common.bean.DataTablePageModel;
import com.kjs.common.utils.DateUtils;
import org.apache.commons.lang.StringUtils;

import java.util.Date;

/**
 * Created by 李恒名 on 2016/6/14.
 */
public class FeedbackSearchBean extends DataTablePageModel {

    private String status;//状态
    private String feedbackDateStr;//反馈日期字符串
    private Date startFeedbackDate;//反馈起始查询日期
    private Date endFeedbackDate;//反馈结束查询日期


    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getFeedbackDateStr() {
        return feedbackDateStr;
    }

    public void setFeedbackDateStr(String feedbackDateStr) {
        this.feedbackDateStr = feedbackDateStr;
        if (StringUtils.isNotBlank(feedbackDateStr)) {
            String date[] = feedbackDateStr.split("/");
            this.startFeedbackDate = DateUtils.getFirstDateOfDay(DateUtils.stringtoDate(date[0]));
            this.endFeedbackDate = DateUtils.getLastDateOfDay(DateUtils.stringtoDate(date[1]));
        }
    }

    public Date getStartFeedbackDate() {
        return startFeedbackDate;
    }

    public void setStartFeedbackDate(Date startFeedbackDate) {
        this.startFeedbackDate = startFeedbackDate;
    }

    public Date getEndFeedbackDate() {
        return endFeedbackDate;
    }

    public void setEndFeedbackDate(Date endFeedbackDate) {
        this.endFeedbackDate = endFeedbackDate;
    }
}
