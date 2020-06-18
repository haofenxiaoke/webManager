package com.kjs.web.controller.kjs.operation;

import com.kjs.common.bean.DataTablePageModel;
import com.kjs.common.bean.ResponseJsonModel;
import com.kjs.common.bean.annotation.AdminLogAnn;
import com.kjs.common.bean.annotation.PermissionAnn;
import com.kjs.common.bean.enums.OperLevel;
import com.kjs.common.bean.enums.OperType;
import com.kjs.orm.model.SysFeedback;
import com.kjs.service.kjs.system.spi.ISysFeedbackService;
import com.kjs.web.serach.kjs.operation.FeedbackSearchBean;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;

/**
 * Created by 李恒名 on 2016/6/14.
 * 意见反馈控制器
 */
@Controller
@RequestMapping("/suggestion")
public class FeedbackController {

    @Resource
    private ISysFeedbackService feedbackService;

    /**
     * 意见反馈页
     * @return  view
     * @author 李恒名
     * @date 2016年6月14日
     */
    @PermissionAnn(menuCode = "feedback",msg = "你没有进入意见反馈页面的权限!")
    @RequestMapping("/feedback")
    public String index(FeedbackSearchBean search) {
        return "operation/feedback/index" ;
    }

    /**
     * 意见反馈列表接口
     * @return  model
     * @author 李恒名
     * @date 2016年6月14日
     */
    @AdminLogAnn(operType = OperType.FEEDBACK,operLevel = OperLevel.NORM,operDescribe = "查询意见反馈列表")
    @RequestMapping("/list")
    @ResponseBody
    public DataTablePageModel list(FeedbackSearchBean search) {
        return feedbackService.buildModelBySearch(search);
    }

    /**
     * 意见反馈列表接口
     * @return  model
     * @author 李恒名
     * @date 2016年6月14日
     */
    @AdminLogAnn(operType = OperType.FEEDBACK,operLevel = OperLevel.NORM,operDescribe = "查询意见反馈详情")
    @RequestMapping("/detail")
    @ResponseBody

    /**
     * 意见反馈详情接口
     * @return  model
     * @author 李恒名
     * @date 2016年6月14日
     */
    public ResponseJsonModel detail(Long id) {
        SysFeedback feedback = feedbackService.findById(id);
        ResponseJsonModel model = new ResponseJsonModel();
        model.setResult(feedback);
        return model;
    }

    /**
     * 回复意见反馈接口
     * @return  model
     * @author 李恒名
     * @date 2016年6月14日
     */
    @AdminLogAnn(operType = OperType.FEEDBACK,operLevel = OperLevel.NORM,operDescribe = "回复")
    @RequestMapping("/reply")
    @ResponseBody
    public ResponseJsonModel reply(SysFeedback feedback) {
        feedbackService.reply(feedback.getId(),feedback.getFeedbackReply());
        ResponseJsonModel model = new ResponseJsonModel();
        return model;
    }

    /**
     * 删除意见反馈接口
     * @return  model
     * @author 李恒名
     * @date 2016年6月14日
     */
    @AdminLogAnn(operType = OperType.FEEDBACK,operLevel = OperLevel.NORM,operDescribe = "删除")
    @RequestMapping("/delete")
    @ResponseBody
    public ResponseJsonModel delete(Long id) {
        feedbackService.deleteByIds(new Long[]{id});
        ResponseJsonModel model = new ResponseJsonModel();
        return model;
    }
}

