package com.kjs.web.controller.kjs.operation;

import com.kjs.common.bean.DataTablePageModel;
import com.kjs.common.bean.ResponseJsonModel;
import com.kjs.common.bean.annotation.AdminLogAnn;
import com.kjs.common.bean.annotation.PermissionAnn;
import com.kjs.common.bean.enums.OperLevel;
import com.kjs.common.bean.enums.OperType;
import com.kjs.orm.model.SysMessage;
import com.kjs.service.kjs.system.spi.ISysMessageService;
import com.kjs.web.serach.kjs.operation.MessageSearchBean;
import com.kjs.web.serach.kjs.operation.FeedbackSearchBean;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;

/**
 * Created by 李恒 on 2016/6/14.
 * 消息管理控制器
 */
@Controller
@RequestMapping("/message")
public class MessageController {

    @Resource
    private ISysMessageService messageService;

    /**
     * 系统消息页
     * @return  view
     * @author 李恒名
     * @date 2016年6月15日
     */
    @PermissionAnn(menuCode = "message",msg = "你没有进入系统消息页面的权限!")
    @RequestMapping("/index")
    public String index(FeedbackSearchBean search) {
        return "operation/message/index" ;
    }

    /**
     * 消息列表接口
     * @return  model
     * @author 李恒名
     * @date 2016年6月15日
     */
    @AdminLogAnn(operType = OperType.MSG,operLevel = OperLevel.NORM,operDescribe = "查询系统消息列表")
    @RequestMapping("/list")
    @ResponseBody
    public DataTablePageModel list(MessageSearchBean search) {
        return messageService.buildModelBySearch(search);
    }

    /**
     * 消息详情接口
     * @return  model
     * @author 李恒名
     * @date 2016年6月15日
     */
    @AdminLogAnn(operType = OperType.MSG,operLevel = OperLevel.NORM,operDescribe = "查询系统消息详情")
    @RequestMapping("/detail")
    @ResponseBody
    public ResponseJsonModel detail(Long id) {
        SysMessage message = messageService.findById(id);
        ResponseJsonModel model = new ResponseJsonModel();
        model.setResult(message);
        return model;
    }

    /**
     * 删除消息接口
     * @return  model
     * @author 李恒名
     * @date 2016年6月15日
     */
    @AdminLogAnn(operType = OperType.MSG,operLevel = OperLevel.NORM,operDescribe = "删除系统消息")
    @RequestMapping("/delete")
    @ResponseBody
    public ResponseJsonModel delete(Long id) {
        messageService.deleteByIds(new Long[]{id});
        ResponseJsonModel model = new ResponseJsonModel();
        return model;
    }

    /**
     * 发送消息接口
     * @return  model
     * @author 李恒名
     * @date 2016年6月15日
     */
    @AdminLogAnn(operType = OperType.MSG,operLevel = OperLevel.NORM,operDescribe = "发送系统消息")
    @RequestMapping("/send")
    @ResponseBody
    public ResponseJsonModel send(SysMessage message) {
        message.setType(1);
        messageService.send(message);
        ResponseJsonModel model = new ResponseJsonModel();
        return model;
    }
}
