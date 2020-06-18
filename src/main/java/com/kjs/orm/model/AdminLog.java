package com.kjs.orm.model;
import com.kjs.common.bean.BaseEntity;
import org.apache.ibatis.type.Alias;

import java.util.Date;

/**
 * 后台管理日志类
 * Created by wangsongpeng on 2016/3/17.
 */
@SuppressWarnings("serial")
@Alias("AdminLog")
public class AdminLog extends BaseEntity {
    private long userId;/*用户ID*/
    private String userName;/*用户名*/
    private String operName;/*操作名称*/
    private String operType;/*操作类型*/
    private String operDescribe;/*操作描述*/
    private String operParam;/*操作参数*/
    private int operLevel;/*操作级别*/
    private Date operTime;/*操作时间*/

    public long getUserId() {
        return userId;
    }

    public void setUserId(long userId) {
        this.userId = userId;
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public String getOperName() {
        return operName;
    }

    public void setOperName(String operName) {
        this.operName = operName;
    }

    public String getOperType() {
        return operType;
    }

    public void setOperType(String operType) {
        this.operType = operType;
    }

    public String getOperDescribe() {
        return operDescribe;
    }

    public void setOperDescribe(String operDescribe) {
        this.operDescribe = operDescribe;
    }

    public String getOperParam() {
        return operParam;
    }

    public void setOperParam(String operParam) {
        this.operParam = operParam;
    }

    public int getOperLevel() {
        return operLevel;
    }

    public void setOperLevel(int operLevel) {
        this.operLevel = operLevel;
    }

    public Date getOperTime() {
        return operTime;
    }

    public void setOperTime(Date operTime) {
        this.operTime = operTime;
    }


}
