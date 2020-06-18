package com.kjs.common.bean.annotation;

import com.kjs.common.constant.PermissionConstant;

import java.lang.annotation.*;

/**
 * 权限注解
 * Created by wangsongpeng on 2016/3/2.
 */
@Target(ElementType.METHOD)
@Retention(RetentionPolicy.RUNTIME)
@Documented
public @interface PermissionAnn {
    String menuCode(); /*菜单权限码*/
    String operCode() default PermissionConstant.DEFAULT_OPER; /*操作权限码*/
    String category()   default PermissionConstant.DEFAULT_CATEID; /*分类*/
    String[] categorys() default {};/*category分类集合值*/
    String msg() default "没有权限!";/*没有权限时提示消息*/
}

