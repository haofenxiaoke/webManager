package com.kjs.orm.model;

import com.kjs.common.bean.BaseEntity;
import com.kjs.common.utils.ShortDateSerializer;
import org.apache.ibatis.type.Alias;
import org.codehaus.jackson.map.annotate.JsonSerialize;

import java.util.Date;

/**
 * POJO:RefundDetail
 *
 * @author kjs_builder
 * @date 2016-11-25
 */
@SuppressWarnings("serial")
@Alias("RefundDetail")
public class RefundDetail extends BaseEntity {


    private Integer	orderId;
    private String	orderNum;		 /* 订单编号 */
    private String	orderUsername;		 /* 下单用户名 */
    private String	proposerName;		 /* 退款申请人姓名 */
    private Double	refundMoney;		 /* 退款金额 */
    private String	bankName;		 /* 银行名称 */
    private String	bankAccountName;		 /* 银行账户名称 */
    private String	bankCardNum;		 /* 银行卡号 */
    private String	address;		 /* 地址 */
    private String	openAccountBankName;		 /* 开户行名称 */
    private String	description;		 /* 备注 */
    private String	teacherManagerName;		 /* 教务审批者名字 */
    private String	teacherManagerOpinion;		 /* 教务主管意见 */
    private Date	teacherManagerPassTime;		 /* 教务主管审批通过时间 */
    private String	financeName;		 /* 财务名字 */
    private String	financeOpinion;		 /* 财务意见 */
    private Date	financePassTime;		 /* 财务审批时间 */
    private String	financeManagerName;		 /* 财务审批者名字 */
    private String	financeManagerOpinion;		 /* 财务主管意见 */
    private Date	financeManagerPassTime;		 /* 财务主管审批通过时间 */
    private Integer	refundStatus;		 /* 退款状态，1待审批2待退款3已退款 */
    private Date	ctime;		 /* 创建时间 */
    private Date	mtime;		 /* 修改时间 */
    private Integer	isDelete;		 /* 1删除0不删除 */

// getter && setter

    public Integer getOrderId() {
        return orderId;
    }

    public RefundDetail setOrderId(Integer orderId) {
        this.orderId = orderId;
        return this;
    }


    public String getOrderNum() {
        return orderNum;
    }

    public RefundDetail setOrderNum(String orderNum) {
        this.orderNum = orderNum;
        return this;
    }


    public String getOrderUsername() {
        return orderUsername;
    }

    public RefundDetail setOrderUsername(String orderUsername) {
        this.orderUsername = orderUsername;
        return this;
    }


    public String getProposerName() {
        return proposerName;
    }

    public RefundDetail setProposerName(String proposerName) {
        this.proposerName = proposerName;
        return this;
    }


    public Double getRefundMoney() {
        return refundMoney;
    }

    public RefundDetail setRefundMoney(Double refundMoney) {
        this.refundMoney = refundMoney;
        return this;
    }


    public String getBankName() {
        return bankName;
    }

    public RefundDetail setBankName(String bankName) {
        this.bankName = bankName;
        return this;
    }


    public String getBankAccountName() {
        return bankAccountName;
    }

    public RefundDetail setBankAccountName(String bankAccountName) {
        this.bankAccountName = bankAccountName;
        return this;
    }


    public String getBankCardNum() {
        return bankCardNum;
    }

    public RefundDetail setBankCardNum(String bankCardNum) {
        this.bankCardNum = bankCardNum;
        return this;
    }


    public String getAddress() {
        return address;
    }

    public RefundDetail setAddress(String address) {
        this.address = address;
        return this;
    }


    public String getOpenAccountBankName() {
        return openAccountBankName;
    }

    public RefundDetail setOpenAccountBankName(String openAccountBankName) {
        this.openAccountBankName = openAccountBankName;
        return this;
    }


    public String getDescription() {
        return description;
    }

    public RefundDetail setDescription(String description) {
        this.description = description;
        return this;
    }


    public String getTeacherManagerName() {
        return teacherManagerName;
    }

    public RefundDetail setTeacherManagerName(String teacherManagerName) {
        this.teacherManagerName = teacherManagerName;
        return this;
    }


    public String getTeacherManagerOpinion() {
        return teacherManagerOpinion;
    }

    public RefundDetail setTeacherManagerOpinion(String teacherManagerOpinion) {
        this.teacherManagerOpinion = teacherManagerOpinion;
        return this;
    }

    @JsonSerialize(using = ShortDateSerializer.class)
    public Date getTeacherManagerPassTime() {
        return teacherManagerPassTime;
    }

    public RefundDetail setTeacherManagerPassTime(Date teacherManagerPassTime) {
        this.teacherManagerPassTime = teacherManagerPassTime;
        return this;
    }


    public String getFinanceName() {
        return financeName;
    }

    public RefundDetail setFinanceName(String financeName) {
        this.financeName = financeName;
        return this;
    }


    public String getFinanceOpinion() {
        return financeOpinion;
    }

    public RefundDetail setFinanceOpinion(String financeOpinion) {
        this.financeOpinion = financeOpinion;
        return this;
    }

    @JsonSerialize(using = ShortDateSerializer.class)
    public Date getFinancePassTime() {
        return financePassTime;
    }

    public RefundDetail setFinancePassTime(Date financePassTime) {
        this.financePassTime = financePassTime;
        return this;
    }


    public String getFinanceManagerName() {
        return financeManagerName;
    }

    public RefundDetail setFinanceManagerName(String financeManagerName) {
        this.financeManagerName = financeManagerName;
        return this;
    }


    public String getFinanceManagerOpinion() {
        return financeManagerOpinion;
    }

    public RefundDetail setFinanceManagerOpinion(String financeManagerOpinion) {
        this.financeManagerOpinion = financeManagerOpinion;
        return this;
    }

    @JsonSerialize(using = ShortDateSerializer.class)
    public Date getFinanceManagerPassTime() {
        return financeManagerPassTime;
    }

    public RefundDetail setFinanceManagerPassTime(Date financeManagerPassTime) {
        this.financeManagerPassTime = financeManagerPassTime;
        return this;
    }


    public Integer getRefundStatus() {
        return refundStatus;
    }

    public RefundDetail setRefundStatus(Integer refundStatus) {
        this.refundStatus = refundStatus;
        return this;
    }

    @JsonSerialize(using = ShortDateSerializer.class)
    public Date getCtime() {
        return ctime;
    }

    public RefundDetail setCtime(Date ctime) {
        this.ctime = ctime;
        return this;
    }

    @JsonSerialize(using = ShortDateSerializer.class)
    public Date getMtime() {
        return mtime;
    }

    public RefundDetail setMtime(Date mtime) {
        this.mtime = mtime;
        return this;
    }


    public Integer getIsDelete() {
        return isDelete;
    }

    public RefundDetail setIsDelete(Integer isDelete) {
        this.isDelete = isDelete;
        return this;
    }

    @Override
    public String toString() {
        return "RefundDetail [" + "id=" + getId() + ", orderId=" + orderId + ", orderNum=" + orderNum + ", orderUsername=" + orderUsername + ", proposerName=" + proposerName + ", refundMoney=" + refundMoney + ", bankName=" + bankName + ", bankAccountName=" + bankAccountName + ", bankCardNum=" + bankCardNum + ", address=" + address + ", openAccountBankName=" + openAccountBankName + ", description=" + description + ", teacherManagerName=" + teacherManagerName + ", teacherManagerOpinion=" + teacherManagerOpinion + ", teacherManagerPassTime=" + teacherManagerPassTime + ", financeName=" + financeName + ", financeOpinion=" + financeOpinion + ", financePassTime=" + financePassTime + ", financeManagerName=" + financeManagerName + ", financeManagerOpinion=" + financeManagerOpinion + ", financeManagerPassTime=" + financeManagerPassTime + ", refundStatus=" + refundStatus + ", ctime=" + ctime + ", mtime=" + mtime + ", isDelete=" + isDelete +  "]";
    }
}
