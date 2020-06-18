package com.kjs.service.kjs.system.spi;

import com.kjs.orm.model.SysMessage;
import com.kjs.service.core.spi.IBaseService;

/**
 * The interface Sys message service.
 */
public interface ISysMessageService extends IBaseService<SysMessage,Long> {

    /**
     * Send. 单发
     * @param message the message
     * @param addresseeIds the addresseeId 收件人的id
     * @author 李恒名
     * @date 2016年6月15日 17:49:28
     */
    public void send(SysMessage message,Long addresseeId);
    /**
     * Send. 根据消息发送对象类型 发送
     * @param message the message
     * @author 李恒名
     * @date 2016年6月15日 17:49:28
     */
    public void send(SysMessage message);
}