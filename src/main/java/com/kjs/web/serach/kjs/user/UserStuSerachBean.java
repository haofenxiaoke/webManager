package com.kjs.web.serach.kjs.user;

import com.kjs.common.bean.DataTablePageModel;
import com.kjs.common.utils.DateUtils;
import org.apache.commons.lang.StringUtils;
import org.apache.ibatis.type.Alias;

import java.util.Date;

/**
 * 前台用户DataTable搜索实体
 * Created by wangsongpeng on 2016/1/18.
 */
@SuppressWarnings("serial")
@Alias("UserStuSerach")
public class UserStuSerachBean extends DataTablePageModel {

    private String userid; /*学员id*/
    private Integer stuid;
    private String	username;		 /* 昵称 */
    private String registTime;		 /* 注册时间 */
    private String	lastPayDatetime;		 /* 最后一次付费日期 */
    private Integer deleted;		 /* 删除标识1删除0使用 */
    private Date startDatetime; /*sql使用的开始时间*/
    private Date endDatetime; /*sql使用的结束时间*/
    private Date startPayDatetime; /*sql使用的开始时间*/
    private Date endPayDatetime; /*sql使用的结束时间*/
    private Date currentTime; /*sql使用的结束时间*/

    public String getUserid() {
        return userid;
    }

    public void setUserid(String userid) {
        this.userid = userid;
    }

    public Integer getStuid() {
        return stuid;
    }

    public void setStuid(Integer stuid) {
        this.stuid = stuid;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getRegistTime() {
        return registTime;
    }

    public void setRegistTime(String registTime) {
        this.registTime = registTime;
        if(StringUtils.isNotBlank(registTime)){
            String date[] =   registTime.split("/");
            this.startDatetime =  DateUtils.getFirstDateOfDay(DateUtils.stringtoDate(date[0]));
            this.endDatetime=  DateUtils.getLastDateOfDay(DateUtils.stringtoDate(date[1]));
        }
    }

    public String getLastPayDatetime() {
        return lastPayDatetime;
    }

    public void setLastPayDatetime(String lastPayDatetime) {
        this.lastPayDatetime = lastPayDatetime;
        if(StringUtils.isNotBlank(lastPayDatetime)){
            String date[] =   lastPayDatetime.split("/");
            this.startPayDatetime =  DateUtils.getFirstDateOfDay(DateUtils.stringtoDate(date[0]));
            this.endPayDatetime=  DateUtils.getLastDateOfDay(DateUtils.stringtoDate(date[1]));
        }
    }

    public Integer getDeleted() {
        return deleted;
    }

    public void setDeleted(Integer deleted) {
        this.deleted = deleted;
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

    public Date getStartPayDatetime() {
        return startPayDatetime;
    }

    public void setStartPayDatetime(Date startPayDatetime) {
        this.startPayDatetime = startPayDatetime;
    }

    public Date getEndPayDatetime() {
        return endPayDatetime;
    }

    public void setEndPayDatetime(Date endPayDatetime) {
        this.endPayDatetime = endPayDatetime;
    }

    public Date getCurrentTime() {
        return currentTime;
    }

    public void setCurrentTime(Date currentTime) {
        this.currentTime = currentTime;
    }
}
