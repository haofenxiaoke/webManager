package com.kjs.orm.mapper;

import com.kjs.orm.core.BaseMapper;
import com.kjs.orm.model.MsgUser;
import com.kjs.orm.model.SysMessage;
import org.apache.ibatis.annotations.Param;

public interface SysMessageMapper extends BaseMapper<SysMessage,Long> {
    /**
     * 保存消息收件人关联实体对象
     * @param msgUser
     * @author 李恒名
     * @date 2016年6月15日 16:55:55
     */
    void saveMsgUser(MsgUser msgUser);

    /**
     根据消息发送对象(收费学员、免费学员)来获取这些用户的id列表
     * @param sendObject
     * @author 李恒名
     * @date 2016年6月16日 15:33:48
     */
    Long[] findUserIdListBySendObject(@Param("sendObject") Integer sendObject);
}