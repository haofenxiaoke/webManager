package com.kjs.orm.model;

import com.kjs.common.bean.BaseEntity;
import com.kjs.common.utils.ShortDateSerializer;
import org.apache.ibatis.type.Alias;
import org.codehaus.jackson.map.annotate.JsonSerialize;

import java.util.Date;

/**
 * POJO:Voucher
 *
 * @author kjs_builder
 * @date 2016-8-25
 */
@SuppressWarnings("serial")
@Alias("Voucher")
public class Voucher extends BaseEntity {


    private String name;		 /* 优惠券名称 */
    private Integer price;		 /* 优惠券金额 */
    private Integer deadline;    /* 截止日期(单位 -> 天)*/
    private Integer type;		 /* 优惠券类型 1代金券 2优惠码 */
    private Integer locked;		 /* 是否锁定，1锁定0未锁定 */
    private String regulation;/* 使用规则，数据格式：30,90,360；代表可供购买月，季，年会员使用 */
    private String description;		 /* 描述 */
    private Long userId;   /* 优惠券创建者ID*/
    private Date ctime;		 /* 创建时间 */
    private Date mtime;		 /* 修改时间 */

    private String createUserName;

    public String getCreateUserName() {
        return createUserName;
    }

    public void setCreateUserName(String createUserName) {
        this.createUserName = createUserName;
    }

    public String getName() {
        return name;
    }

    public Voucher setName(String name) {
        this.name = name;
        return this;
    }


    public Integer getPrice() {
        return price;
    }

    public Voucher setPrice(Integer price) {
        this.price = price;
        return this;
    }

    public Integer getDeadline() {
        return deadline;
    }

    public void setDeadline(Integer deadline) {
        this.deadline = deadline;
    }

    public Integer getType() {
        return type;
    }

    public Voucher setType(Integer type) {
        this.type = type;
        return this;
    }


    public Integer getLocked() {
        return locked;
    }

    public Voucher setLocked(Integer locked) {
        this.locked = locked;
        return this;
    }


    public String getDescription() {
        return description;
    }

    public Voucher setDescription(String description) {
        this.description = description;
        return this;
    }

    @JsonSerialize(using = ShortDateSerializer.class)
    public Date getCtime() {
        return ctime;
    }

    public Voucher setCtime(Date ctime) {
        this.ctime = ctime;
        return this;
    }

    @JsonSerialize(using = ShortDateSerializer.class)
    public Date getMtime() {
        return mtime;
    }

    public Voucher setMtime(Date mtime) {
        this.mtime = mtime;
        return this;
    }

    public Long getUserId() {
        return userId;
    }

    public Voucher setUserId(Long userId) {
        this.userId = userId;
        return this;
    }

    public String getRegulation() {
        return regulation;
    }

    public void setRegulation(String regulation) {
        this.regulation = regulation;
    }

    @Override
    public String toString() {
        return "Voucher{" +
                "name='" + name + '\'' +
                ", price=" + price +
                ", deadline=" + deadline +
                ", type=" + type +
                ", locked=" + locked +
                ", regulation='" + regulation + '\'' +
                ", description='" + description + '\'' +
                ", userId=" + userId +
                ", ctime=" + ctime +
                ", mtime=" + mtime +
                ", createUserName='" + createUserName + '\'' +
                '}';
    }
}
