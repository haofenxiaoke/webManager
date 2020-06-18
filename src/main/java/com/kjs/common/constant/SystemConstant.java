package com.kjs.common.constant;

/**
 * 系统常量
 * Created by wangsongpeng on 2016/3/25.
 */
public class SystemConstant {
    public static final int PASSWORD_BIT = 8;//密码位数
    public static final String LOGIN_COOKIE_KEY = "LCK";//登录cookie的key
    public static final String SHIRO_COOKIE_SESSION_KEY="SID";//shiro cookie session id
    public static final int COOKIE_ONEDAY = 24*60*60;//cookie一天的生命周期
    public static final int DEFAULT_COOKIE_AGE = -1;//默认的会话cookie
    public static final String USER_MENU = "user_menu";//用户菜单key
    public static final String CATE_INDUSTRY_CODE="HY";//课程分类 行业类型
    public static final String CATE_POSITION_CODE="ZW";//课程分类 行业类型
    public static final String CATE_INDUSTRY_NAME = "行业";//
    public static final String CATE_POSITION_NAME = "职位";//
    public static final String OPER_TYPE_ADD = "add";//操作类型
    public static final String OPER_TYPE_EDIT = "edit";//操作类型
    public static final String USER_QUESTION_REDIS_HASH_NAME="user.question";//用户是否有新的回复信息(last_question_time记录最后一次点击时间  unReadQuestionClass:是否有未读回答)
    public static final String BROADCAST_BUY_REDIS_LIST_KEY="broadcast.buy";//会员广播当日购买订单，存放List 的 Redis Key
    public static final String BROADCAST_BUY_REDIS_COUNT_KEY="broadcast.buy.count";//会员广播订单数统计的 Redis Key
    public static final String CONSULT_CONFIG = "consult";//用户菜单key
    public static final String LIVE_BOOKING_USER_KEY="live.booking.";//直播预约用户存放List 的 Redis Key
    public static final String videoConfigOption="video.config.option";
}
