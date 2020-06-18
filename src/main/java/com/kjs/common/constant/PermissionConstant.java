package com.kjs.common.constant;
/**
 * 权限静态常量
 * Created by wangsongpeng on 2016/3/14.
 */
public class PermissionConstant {
    public static final String DEFAULT_OPER = "view";//默认的操作码
    public static final Long DEFAULT_OPERID = 0L;//默认的操作ID
    public static final String DEFAULT_OPER_NAME = "浏览";//默认的操作名称
    public static final String DEFAULT_OPER_DESC = "菜单的默认操作";//默认的操作描述
    public static final String DEFAULT_CATEID = "0";//默认的cate分类值
    public static final String DEFAULT_CATE_NAME = "默认课程分类";//默认的cate分类名称
    public static final String CONVERT_CATE_REG = ".*(find|view).*";//将匹配该正则的操作码分类转换为* ， user:find:0 -> user:find:*

}
