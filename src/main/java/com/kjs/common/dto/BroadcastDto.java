package com.kjs.common.dto;

import java.util.Date;

/**
 * Created by 李恒名 on 2016/9/9.
 */
public class BroadcastDto {
    private String city;
    private String mobile;
    private Integer price;
    private Date buyDate;

    public String getCity() {
        return city;
    }

    public void setCity(String city) {
        this.city = city;
    }
    public Integer getPrice() {
        return price;
    }

    public void setPrice(Integer price) {
        this.price = price;
    }

    public Date getBuyDate() {
        return buyDate;
    }

    public void setBuyDate(Date buyDate) {
        this.buyDate = buyDate;
    }

    public String getMobile() {
        return mobile;
    }

    public void setMobile(String mobile) {
        this.mobile = mobile;
    }

    @Override
    public String toString() {
        return "BroadcastDto{" +
                "city='" + city + '\'' +
                ", mobile='" + mobile + '\'' +
                ", price=" + price +
                ", buyDate=" + buyDate +
                '}';
    }

    public BroadcastDto(){}
    public BroadcastDto(String city, String mobile, Integer price, Date buyDate) {
        this.city = city;
        this.mobile = mobile;
        this.price = price;
        this.buyDate = buyDate;
    }
}
