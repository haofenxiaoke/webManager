package com.kjs.web.serach.kjs.user;

import com.kjs.common.bean.DataTablePageModel;
import org.apache.ibatis.type.Alias;

/**
 * 前台管理DataTable搜索实体
 * Created by wangsongpeng on 2016/1/18.
 */
@SuppressWarnings("serial")
@Alias("UserManagerSerach")
public class UserManagerSerachBean extends DataTablePageModel {

    private String userId; /*学员主键id*/
    private Integer directionId; /* 分类方向ID */
    private String courseId;		 /* 课程ID */
    private Long[] derectionIds;//方向ID数组

    public String getUserId() {
        return userId;
    }

    public void setUserId(String userId) {
        this.userId = userId;
    }

    public Integer getDirectionId() {
        return directionId;
    }

    public void setDirectionId(Integer directionId) {
        this.directionId = directionId;
    }

    public String getCourseId() {
        return courseId;
    }

    public void setCourseId(String courseId) {
        this.courseId = courseId;
    }

    public Long[] getDerectionIds() {
        return derectionIds;
    }

    public void setDerectionIds(Long[] derectionIds) {
        this.derectionIds = derectionIds;
    }
}
