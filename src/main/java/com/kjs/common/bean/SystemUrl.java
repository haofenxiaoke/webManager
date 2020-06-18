package com.kjs.common.bean;

import java.util.List;

/**
 * Created by wangsongpeng on 2015/9/29.
 */
public class SystemUrl {

    private String loginUrl; /*登录URL*/
    private List<String> passUrl; /*放过的URL*/

    public String getLoginUrl() {
        return loginUrl;
    }

    public void setLoginUrl(String loginUrl) {
        this.loginUrl = loginUrl;
    }

    public List<String> getPassUrl() {
        return passUrl;
    }

    public void setPassUrl(List<String> passUrl) {
        this.passUrl = passUrl;
    }
}
