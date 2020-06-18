package com.kjs.service.kjs.system;

import com.kjs.common.utils.ShiroUtils;
import com.kjs.common.utils.StringUtil;
import com.kjs.orm.model.AuthorityUsers;
import com.kjs.orm.model.SysFeedback;
import com.kjs.orm.model.SysMessage;
import com.kjs.service.core.BaseService;
import com.kjs.service.kjs.system.spi.ISysFeedbackService;
import com.kjs.service.kjs.system.spi.ISysMessageService;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.util.Date;


@Service
@Transactional
public class SysFeedbackService extends BaseService<SysFeedback,Long> implements ISysFeedbackService {
    @Resource
    private ISysMessageService messageService;
    @Override
    public void reply(Long id, String content) {


        SysFeedback feedback = this.iBaseDao.findById(id);

        AuthorityUsers sessionUser = ShiroUtils.getSessionUser();

        //更新意见
        feedback.setFeedbackReply(content);
        feedback.setFeedbackReplyUserid(sessionUser.getId());
        feedback.setFlowerName(sessionUser.getFlowerName());
        feedback.setFeedbackReplyTime(new Date());
        feedback.setReplyStatus(SysFeedback.REPLY_STATUS_REPLIED);

        this.iBaseDao.update(feedback);

        //发送系统消息
        SysMessage message = new SysMessage();
        message.setTitle("您的意见反馈已被回复,快点击我查看吧!");
        message.setContent(feedback.getFeedbackReply());
        message.setType(0);
        message.setSendObject(SysMessage.SEND_OBJECT_PERSON);

        Boolean flag = StringUtil.isEmpty(feedback.getUserId()) || (feedback.getUserId() == -1l);
        if(!flag){
            messageService.send(message,feedback.getUserId());
        }
    }
}
