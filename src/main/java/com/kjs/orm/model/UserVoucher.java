package com.kjs.orm.model;

import com.kjs.common.bean.BaseEntity;
import com.kjs.common.utils.ShortDateSerializer;
import org.apache.ibatis.type.Alias;
import org.codehaus.jackson.map.annotate.JsonSerialize;

import java.util.Date;

/**
 * POJO:UserVoucher
 *
 * @author kjs_builder
 * @date 2016-8-25
 */
@SuppressWarnings("serial")
@Alias("UserVoucher")
public class UserVoucher extends BaseEntity {

    private Date expireDate;       //失效日期
    private Integer grantUserId;		 /* 发券用户ID */
    private Integer userId;		 /* 用户ID */
    private Integer used;		 /* 是否已使用 0未使用（默认） 1已使用*/
    private String voucherNum;		 /* 优惠券编号 */
    private Date ctime;		 /* 创建时间 */
    private Date mtime;		 /* 修改时间 */

    private Integer price;
    private String voucherName;
    private Integer type;
    private String regulation;
    //DTO字段
    private String stuUsername;
    private String stuNickname;
    private String grantUsername;



    public Integer getUserId() {
        return userId;
    }

    public UserVoucher setUserId(Integer userId) {
        this.userId = userId;
        return this;
    }


    public String getVoucherNum() {
        return voucherNum;
    }

    public UserVoucher setVoucherNum(String voucherNum) {
        this.voucherNum = voucherNum;
        return this;
    }

    @JsonSerialize(using = ShortDateSerializer.class)
    public Date getCtime() {
        return ctime;
    }

    public UserVoucher setCtime(Date ctime) {
        this.ctime = ctime;
        return this;
    }

    @JsonSerialize(using = ShortDateSerializer.class)
    public Date getMtime() {
        return mtime;
    }

    public UserVoucher setMtime(Date mtime) {
        this.mtime = mtime;
        return this;
    }

    public Integer getUsed() {
        return used;
    }

    public void setUsed(Integer used) {
        this.used = used;
    }


    public Date getExpireDate() {
        return expireDate;
    }

    public void setExpireDate(Date expireDate) {
        this.expireDate = expireDate;
    }


    public String getVoucherName() {
        return voucherName;
    }

    public void setVoucherName(String voucherName) {
        this.voucherName = voucherName;
    }


    public Integer getPrice() {
        return price;
    }

    public void setPrice(Integer price) {
        this.price = price;
    }

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

    public Integer getGrantUserId() {
        return grantUserId;
    }

    public void setGrantUserId(Integer grantUserId) {
        this.grantUserId = grantUserId;
    }

    public String getStuNickname() {
        return stuNickname;
    }

    public void setStuNickname(String stuNickname) {
        this.stuNickname = stuNickname;
    }

    public String getRegulation() {
        return regulation;
    }

    public void setRegulation(String regulation) {
        this.regulation = regulation;
    }

    public Integer getType() {
        return type;
    }

    public void setType(Integer type) {
        this.type = type;
    }

    @Override
    public String toString() {
        return "UserVoucher{" +
                ", expireDate=" + expireDate +
                ", grantUserId=" + grantUserId +
                ", userId=" + userId +
                ", used=" + used +
                ", voucherNum='" + voucherNum + '\'' +
                ", ctime=" + ctime +
                ", mtime=" + mtime +
                ", voucherName='" + voucherName + '\'' +
                ", type=" + type +
                ", price=" + price +
                ", stuUsername='" + stuUsername + '\'' +
                ", stuNickname='" + stuNickname + '\'' +
                ", grantUsername='" + grantUsername + '\'' +
                ", regulation='" + regulation + '\'' +
                '}';
    }
}
