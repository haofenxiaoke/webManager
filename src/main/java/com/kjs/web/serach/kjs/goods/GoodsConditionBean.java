package com.kjs.web.serach.kjs.goods;

import com.kjs.common.bean.DataTablePageModel;

public class GoodsConditionBean extends DataTablePageModel{
	private Integer id;
	private String coverUrl;
	private String name;
	private Integer positionId;
	private Integer DirectionId;
	private Integer type;
	private Integer price;
	private Integer remain;
	private Integer deleted;
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public String getCoverUrl() {
		return coverUrl;
	}
	public void setCoverUrl(String coverUrl) {
		this.coverUrl = coverUrl;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public Integer getPositionId() {
		return positionId;
	}
	public void setPositionId(Integer positionId) {
		this.positionId = positionId;
	}
	public Integer getDirectionId() {
		return DirectionId;
	}
	public void setDirectionId(Integer directionId) {
		DirectionId = directionId;
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
	public Integer getDeleted() {
		return deleted;
	}
	public void setDeleted(Integer deleted) {
		this.deleted = deleted;
	}
	@Override
	public String toString() {
		return "GoodsConditionBean [id=" + id + ", coverUrl=" + coverUrl + ", name=" + name + ", positionId="
				+ positionId + ", DirectionId=" + DirectionId + ", type=" + type + ", price=" + price + ", remain="
				+ remain + ", deleted=" + deleted + "]";
	}
	

}
