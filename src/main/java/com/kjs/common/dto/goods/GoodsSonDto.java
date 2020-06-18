package com.kjs.common.dto.goods;

public class GoodsSonDto {
	private String coverUrl;
	private String name;
	private Integer positionId;
	private Integer type;
	private Integer price;
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
	@Override
	public String toString() {
		return "GoodsSonDto [coverUrl=" + coverUrl + ", name=" + name + ", positionId=" + positionId + ", type=" + type
				+ ", price=" + price + "]";
	}
	

}
