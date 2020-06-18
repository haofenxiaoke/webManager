package com.kjs.common.bean.enums;
/**
 * 操作类型
 * Created by wangsongpeng on 2016/3/17.
 */
public enum OperType {
    SYSTEM("系统操作","system"),
    AUTH("授权操作","auth"),
    COM("商品操作","com"),
    COURSE("课程操作","course"),
    STUDENT("学员操作","student"),
    TONGJI("统计操作","tongji"),
    SPREAD("推广操作","spread"),
    ORDER("订单操作","order"),
    FEEDBACK("意见反馈操作","feedback"),
    MSG("系统消息操作","msg"),
    QUESTION("老师答疑操作","question"),
    VOUCHER("优惠券操作","vocher"),
    CONSULT("售前、售后咨询操作","consult"),
    REDUCE_CODE("优惠码操作","reduceCode");


    OperType(String name,String value) {
        this.name = name;
        this.value =value;
    }

    private String name;
    private String value;

    public String getName() {
        return name;
    }

    public String getValue() {
        return value;
    }


}
