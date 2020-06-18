package com.kjs.common.dto.log;

import com.kjs.common.bean.enums.OperLevel;
import com.kjs.common.bean.enums.OperType;
import com.kjs.orm.model.AdminLog;
import org.apache.ibatis.type.Alias;

/**
 * Created by qiaolu on 2016/4/8.
 */
@SuppressWarnings("serial")
@Alias("AdminLogDto")
public class AdminLogDto extends AdminLog {

     private String operLevelDto;//操作级别
    private String operTypeDto;//操作类型

    public String getOperLevelDto() {
        return operLevelDto;
    }

    public void setOperLevelDto(String operLevelDto) {

        for (OperLevel operLevelTemp : OperLevel.values()) {
                if (Integer.parseInt(operLevelDto) == operLevelTemp.getValue()) {
                    this.operLevelDto = operLevelTemp.getName();
                }
        }
    }

    public String getOperTypeDto() {
        return operTypeDto;
    }

    public void setOperTypeDto(String operTypeDto) {

        for (OperType operTypeTemp : OperType.values()) {
            if (operTypeDto.equals(operTypeTemp.getValue().toLowerCase())) {
                this.operTypeDto = operTypeTemp.getName();
            }
        }
    }
}
