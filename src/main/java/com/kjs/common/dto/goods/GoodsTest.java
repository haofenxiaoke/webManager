package com.kjs.common.dto.goods;

public class GoodsTest {
	private Integer positionId;
	private Integer directionId;
	private Integer deleted;
	public Integer getPositionId() {
		return positionId;
	}
	public void setPositionId(Integer positionId) {
		this.positionId = positionId;
	}
	
	public Integer getDirectionId() {
		return directionId;
	}
	public void setDirectionId(Integer directionId) {
		this.directionId = directionId;
	}
	public Integer getDeleted() {
		return deleted;
	}
	public void setDeleted(Integer deleted) {
		this.deleted = deleted;
	}
	@Override
	public String toString() {
		return "GoodsTest [positionId=" + positionId + ", dierctionId=" + directionId + ", deleted=" + deleted + "]";
	}
	
	

}
