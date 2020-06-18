package com.kjs.orm.model;

import java.util.Date;
import java.util.List;

import org.apache.ibatis.type.Alias;

import com.kjs.common.bean.BaseEntity;

@SuppressWarnings("serial")
@Alias("Goods")
public class Goods extends BaseEntity{
	
	private String name;
	private String coverUrl; //商品封面url
	private Integer directionId; //所属学院
	private Integer positionId; //所属项目
	private Integer type; //商品类型
	private Integer price; 
	private Integer remain; //库存
	private Integer share;
	private Integer count;
	private String rule;
	private String discript;
	private String goodsUrl;
	private String son;
	private Date createTime;
	private int deleted;
	private Integer days;
	
	
	public Integer getDays() {
		return days;
	}
	public void setDays(Integer days) {
		this.days = days;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	
	public String getCoverUrl() {
		return coverUrl;
	}
	public void setCoverUrl(String coverUrl) {
		this.coverUrl = coverUrl;
	}
	public Integer getDirectionId() {
		return directionId;
	}
	public void setDirectionId(Integer directionId) {
		this.directionId = directionId;
	}
	public Integer getPositionId() {
		return positionId;
	}
	public void setPositionId(Integer positionId) {
		this.positionId = positionId;
	}
	public Integer getType() {
		return type;
	}
	public void setType(Integer type) {
		this.type = type;
	}
	public Integer getPrice() {
		return price;
	}
	public void setPrice(Integer price) {
		this.price = price;
	}
	public Integer getRemain() {
		return remain;
	}
	public void setRemain(Integer remain) {
		this.remain = remain;
	}
	public Integer getShare() {
		return share;
	}
	public void setShare(Integer share) {
		this.share = share;
	}
	public Integer getCount() {
		return count;
	}
	public void setCount(Integer count) {
		this.count = count;
	}
	public String getRule() {
		return rule;
	}
	public void setRule(String rule) {
		this.rule = rule;
	}
	public String getDiscript() {
		return discript;
	}
	public void setDiscript(String discript) {
		this.discript = discript;
	}
	public String getGoodsUrl() {
		return goodsUrl;
	}
	public void setGoodsUrl(String goodsUrl) {
		this.goodsUrl = goodsUrl;
	}
	
	
	public String getSon() {
		return son;
	}
	public void setSon(String son) {
		this.son = son;
	}
	public Date getCreateTime() {
		return createTime;
	}
	public void setCreateTime(Date createTime) {
		this.createTime = createTime;
	}
	public int getDeleted() {
		return deleted;
	}
	public void setDeleted(int deleted) {
		this.deleted = deleted;
	}
	@Override
	public String toString() {
		return "Goods [name=" + name + ", coverUrl=" + coverUrl + ", directionId=" + directionId + ", positionId="
				+ positionId + ", type=" + type + ", price=" + price + ", remain=" + remain + ", share=" + share
				+ ", count=" + count + ", rule=" + rule + ", discript=" + discript + ", goodsUrl=" + goodsUrl + ", son="
				+ son + ", createTime=" + createTime + ", deleted=" + deleted + ", days=" + days + "]";
	}
	
	
	
	

}
