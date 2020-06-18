package com.kjs.common.permission;

import org.apache.commons.lang.StringUtils;

/*
 * 权限对象
 * Created by wangsongpeng on 2016/2/17.
 */
public class Permission {

    private String menuCode;
    private String operCode;
    private String CategoryCode;


    public Permission() {

    }

    public Permission(String menuCode, String operCode, String categoryCode) {
        this.menuCode = menuCode;
        this.operCode = operCode;
        CategoryCode = categoryCode;
    }

    public String getMenuCode() {
        return menuCode;
    }

    public void setMenuCode(String menuCode) {
        this.menuCode = menuCode;
    }

    public String getOperCode() {
        return operCode;
    }

    public void setOperCode(String operCode) {
        this.operCode = operCode;
    }

    public String getCategoryCode() {
        return CategoryCode;
    }

    public void setCategoryCode(String categoryCode) {
        CategoryCode = categoryCode;
    }

    public String toCode(){
        if(StringUtils.isBlank(this.getMenuCode())||StringUtils.isBlank(this.getOperCode())
                ||StringUtils.isBlank(this.getCategoryCode())){
            return null;
        }
        return this.getMenuCode()+":"+this.getOperCode()+":"+this.getCategoryCode();
    }
}
