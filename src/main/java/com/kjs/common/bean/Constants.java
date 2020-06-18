package com.kjs.common.bean;

/**
 * Created by 李恒名 on 2016/6/24.
 */
public final class Constants {
    public static final String SESSION_USER_KEY = "SESSION_USER";
    public static final String SESSION_SMS_CAPTCHA_KEY = "SMS_CAPTCHA";
    public static final String SESSION_EMAIL_CAPTCHA_KEY = "EMAIL_CAPTCHA";
    public static final String USER_ONLINE_TIME_REDIS_HASH_NAME = "user.online.time";//在线时间统计
    public static final String UNIQUE_LOGIN_REDIS_HASH_NAME = "user.unique.login";//登录唯一性
    public static final String FIND_PASSWORD_TOKEN = "FIND_PASSWORD_TOKEN";
    public static final String PAY_SUCCESS_VIEW_NAME = "redirect:/userCenter#order";//第三方支付成功后需要跳转的视图名称
    public static final String PAY_FAIL_VIEW_NAME = "redirect:/userCenter#order";//第三方支付失败后需要跳转的视图名称
    public static final String GUEST_COOKIE_KEY = "gid";//游客ID放在Cookie的key
    public static final String DUIA_LOGIN_TOKEN = "POTATO";//对啊登录过来Shiro Login传入的临时密码
    public static final String DUIA_LOGIN_REQUEST_CODE_SESSION_KEY = "DUIA_LOGIN_REQUEST_CODE";//对啊登录请求校验码
    public static final String USER_MSG_REDIS_HASH_NAME ="user.msg";//用户未读消息信息（key：userid，value：map类型 last_msg_time最后一次点击时间；msg_num未读消息数）
    public static final String USER_QUESTION_REDIS_HASH_NAME="user.question";//用户是否有新的回复信息(last_question_time记录最后一次点击时间  unReadQuestionClass:是否有未读回答)
    public static final String BROADCAST_BUY_REDIS_LIST_KEY="broadcast.buy";//会员广播当日购买订单，存放List 的 Redis Key
    public static final String BROADCAST_BUY_REDIS_COUNT_KEY="broadcast.buy.count";//会员广播订单数统计的 Redis Key
    public static final String PRODUCT_ID_会计狮="kjs";
    public static final String PRODUCT_ID_设计牛="sjn";
    public static final String LIVE_RECORD_PRE_HASH_NAME="review.live.";//用户是否有新的回复信息(last_question_time记录最后一次点击时间  unReadQuestionClass:是否有未读回答)
    public static final String LIVE_TIME_MAP_HASH_NAME="live.time.";//用户是否有新的回复信息(last_question_time记录最后一次点击时间  unReadQuestionClass:是否有未读回答)
    public static final String LIVE_BOOKING_USER_KEY="live.booking.";//直播预约用户存放List 的 Redis Key
    public static final String LIVE_BOOKING_TASK_KEY="live.booking.task";//直播预约定时任务存放List 的 Redis Key
    public static final String videoConfigOption="video.config.option";//0;乐视 1：cc视频;
    public static String desKey="1be19ffafb9bd09611abc4c5ad21908d";
}
