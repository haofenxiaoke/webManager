package com.kjs.web.serach.kjs.operation;

/**
 * Created by 李恒名 on 2016/8/31.
 */
public class VoucherGrantSearchBean extends VoucherSearchBean {
    private String stuUsername;
    private String grantUsername;
    private Integer used;

    public String getStuUsername() {
        return stuUsername;
    }

    public void setStuUsername(String stuUsername) {
        this.stuUsername = stuUsername;
    }

    public String getGrantUsername() {
        return grantUsername;
    }

    public void setGrantUsername(String grantUsername) {
        this.grantUsername = grantUsername;
    }

    public Integer getUsed() {
        return used;
    }

    public void setUsed(Integer used) {
        this.used = used;
    }
}
