package com.kjs.web.serach.kjs.authority;
import com.kjs.common.bean.DataTablePageModel;
import com.kjs.common.utils.DateUtils;
import org.apache.commons.lang.StringUtils;
import org.apache.ibatis.type.Alias;

import java.util.Date;

/**
 * 员工管理DataTable搜索实体
 * Created by wangsongpeng on 2016/1/18.
 */
@SuppressWarnings("serial")
@Alias("AuthorityUserSerach")
public class AuthorityUserSerachBean extends DataTablePageModel {

    private String  mobile;	 /* 员工的手机号 */
    private String	email;		 /* 员工的电子邮箱 */
    private String	num;		 /* 员工工号 */
    private int     userStatus;  /*员工状态*/
    private String createDatetime;		 /* 员工创建时间 */

    private Date startDatetime; /*sql使用的开始时间*/
    private Date endDatetime; /*sql使用的结束时间*/

    public String getMobile() {
        return mobile;
    }

    public void setMobile(String mobile) {
        this.mobile = mobile;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getNum() {
        return num;
    }

    public void setNum(String num) {
        this.num = num;
    }

    public String getCreateDatetime() {
        return createDatetime;
    }

    public void setCreateDatetime(String createDatetime) {
        this.createDatetime = createDatetime;
        if(StringUtils.isNotBlank(createDatetime)){
            String date[] =   createDatetime.split("/");
            this.startDatetime =  DateUtils.getFirstDateOfDay(DateUtils.stringtoDate(date[0]));
            this.endDatetime=  DateUtils.getLastDateOfDay(DateUtils.stringtoDate(date[1]));
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

    public int getUserStatus() {
        return userStatus;
    }

    public void setUserStatus(int userStatus) {
        this.userStatus = userStatus;
    }
}
