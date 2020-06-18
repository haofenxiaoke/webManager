package com.kjs.web.serach.kjs.teacher;

import com.kjs.common.bean.DataTablePageModel;
import org.apache.ibatis.type.Alias;

/**
 * 老师管理DataTable搜索实体
 * Created by on 2016/9/14.
 */
@SuppressWarnings("serial")
@Alias("TeacherManagerSerach")
public class TeacherManagerSerachBean extends DataTablePageModel {
    private String name; /*老师姓名*/
    private String num; /*老师工号*/

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getNum() {
        return num;
    }

    public void setNum(String num) {
        this.num = num;
    }
}
