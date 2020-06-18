package com.kjs.web.serach.kjs.category;
import com.kjs.common.bean.DataTablePageModel;
import com.kjs.common.utils.DateUtils;
import org.apache.commons.lang.StringUtils;
import org.apache.ibatis.type.Alias;

import java.util.Date;

/**
 * 课程分类方向管理DataTable搜索实体
 * Created by wangsongpeng on 2016/1/18.
 */
@SuppressWarnings("serial")
@Alias("CategoryPositionSerach")
public class CategoryPositionSerachBean extends DataTablePageModel {

    private Integer	directionId;		 /* 方向id */
    private String	categoryDesc;		 /* 类别描述 */
    private Integer	userid;		 /* 用户id */
    private Integer	orderNum;		 /* 排序 */
    private String createTime;		 /*创建时间 */
    private Integer deleted;		 /* 删除标识1删除0使用 */
    private Date startDatetime; /*sql使用的开始时间*/
    private Date endDatetime; /*sql使用的结束时间*/

    public Integer getDirectionId() {
        return directionId;
    }

    public void setDirectionId(Integer directionId) {
        this.directionId = directionId;
    }

    public String getCategoryDesc() {
        return categoryDesc;
    }

    public void setCategoryDesc(String categoryDesc) {
        this.categoryDesc = categoryDesc;
    }

    public Integer getUserid() {
        return userid;
    }

    public void setUserid(Integer userid) {
        this.userid = userid;
    }

    public Integer getOrderNum() {
        return orderNum;
    }

    public void setOrderNum(Integer orderNum) {
        this.orderNum = orderNum;
    }

    public Integer getDeleted() {
        return deleted;
    }

    public void setDeleted(Integer deleted) {
        this.deleted = deleted;
    }

    public Date getStartDatetime() {
        return startDatetime;
    }

    public void setStartDatetime(Date startDatetime) {
        this.startDatetime = startDatetime;
    }

    public Date getEndDatetime() {
        return endDatetime;
    }

    public void setEndDatetime(Date endDatetime) {
        this.endDatetime = endDatetime;
    }

    public String getCreateTime() {
        return createTime;
    }

    public void setCreateTime(String createTime) {
        this.createTime = createTime;
        if(StringUtils.isNotBlank(createTime)){
            String date[] =   createTime.split("/");
            this.startDatetime =  DateUtils.getFirstDateOfDay(DateUtils.stringtoDate(date[0]));
            this.endDatetime=  DateUtils.getLastDateOfDay(DateUtils.stringtoDate(date[1]));
        }
    }

}
