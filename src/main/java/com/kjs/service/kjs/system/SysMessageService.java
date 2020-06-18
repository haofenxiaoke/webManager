package com.kjs.service.kjs.system;

import com.kjs.common.utils.ShiroUtils;
import com.kjs.orm.mapper.SysMessageMapper;
import com.kjs.orm.model.AuthorityUsers;
import com.kjs.orm.model.MsgUser;
import com.kjs.orm.model.SysMessage;
import com.kjs.service.core.BaseService;
import com.kjs.service.kjs.system.spi.ISysMessageService;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;

import java.util.Date;


@Service
@Transactional
public class SysMessageService extends BaseService<SysMessage,Long> implements ISysMessageService {

    @Resource
    private SysMessageMapper messageDao;

    private void send(SysMessage message,Long... addresseeIds) {
        AuthorityUsers sessionUser = ShiroUtils.getSessionUser();
        message.setSenderId(sessionUser.getId());
        message.setSenderName(sessionUser.getFlowerName());
        message.setSendtime(new Date());
        if(addresseeIds.length > 0){
            messageDao.save(message);
            for (Long addresseeId : addresseeIds) {
                MsgUser msgUser = new MsgUser();
                msgUser.setAddresseeId(addresseeId);
                msgUser.setMsgId(message.getId());
                msgUser.setIsRead(MsgUser.MSG_STATUS_UNREAD);
                messageDao.saveMsgUser(msgUser);
            }
        }
    }

    @Override
    public void send(SysMessage message,Long addresseeId) {
        send(message, new Long[]{addresseeId});
    }

    @Override
    public void send(SysMessage message) {
        Long[] addresseeIds =  messageDao.findUserIdListBySendObject(message.getSendObject());
        send(message,addresseeIds);
    }
}
