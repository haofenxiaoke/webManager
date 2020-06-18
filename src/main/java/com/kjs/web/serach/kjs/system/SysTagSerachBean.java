package com.kjs.web.serach.kjs.system;
import com.kjs.common.bean.DataTablePageModel;
import org.apache.ibatis.type.Alias;

/**
 * 员工管理DataTable搜索实体
 * Created by wangsongpeng on 2016/1/18.
 */
@SuppressWarnings("serial")
@Alias("SysTagSerach")
public class SysTagSerachBean extends DataTablePageModel {

    private Integer	type;		 /* 类型 */
    private Integer    tagId;      /* 标签ID */
    private Integer	directionId;		 /* 方向id */
    private Boolean deleted;   /* 删除标志位 */
    private Long[] derectionIds;//方向ID数组

    public Integer getType() {
        return type;
    }

    public void setType(Integer type) {
        this.type = type;
    }

    public Integer getTagId() {
        return tagId;
    }

    public void setTagId(Integer tagId) {
        this.tagId = tagId;
    }

    public Integer getDirectionId() {
        return directionId;
    }

    public void setDirectionId(Integer directionId) {
        this.directionId = directionId;
    }

    public Boolean getDeleted() {
        return deleted;
    }

    public void setDeleted(Boolean deleted) {
        this.deleted = deleted;
    }

    public Long[] getDerectionIds() {
        return derectionIds;
    }

    public void setDerectionIds(Long[] derectionIds) {
        this.derectionIds = derectionIds;
    }
}
