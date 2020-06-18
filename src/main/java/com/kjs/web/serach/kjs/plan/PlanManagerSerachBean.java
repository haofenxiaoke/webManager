package com.kjs.web.serach.kjs.plan;

import com.kjs.common.bean.DataTablePageModel;
import org.apache.ibatis.type.Alias;

/**
 * 计划管理DataTable搜索实体
 * Created by wangsongpeng on 2016/1/18.
 */
@SuppressWarnings("serial")
@Alias("PlanManagerSerach")
public class PlanManagerSerachBean extends DataTablePageModel {

    private Integer directionId; /* 分类方向ID */
    private Integer industryId; /* 分类行业ID */
    private Integer positionId; /* 分类职位ID */
    private Integer planId;   /* 计划ID */
    private Integer planType;   /* 计划显示类型 */
    private Long[] derectionIds;//方向ID数组

    public Integer getDirectionId() {
        return directionId;
    }

    public void setDirectionId(Integer directionId) {
        this.directionId = directionId;
    }

    public Integer getIndustryId() {
        return industryId;
    }

    public void setIndustryId(Integer industryId) {
        this.industryId = industryId;
    }

    public Integer getPositionId() {
        return positionId;
    }

    public void setPositionId(Integer positionId) {
        this.positionId = positionId;
    }

    public Integer getPlanId() {
        return planId;
    }

    public void setPlanId(Integer planId) {
        this.planId = planId;
    }

    public Integer getPlanType() {
        return planType;
    }

    public void setPlanType(Integer planType) {
        this.planType = planType;
    }

    public Long[] getDerectionIds() {
        return derectionIds;
    }

    public void setDerectionIds(Long[] derectionIds) {
        this.derectionIds = derectionIds;
    }
}
