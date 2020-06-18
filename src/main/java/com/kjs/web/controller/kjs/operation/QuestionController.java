package com.kjs.web.controller.kjs.operation;

import com.kjs.common.bean.DataTablePageModel;
import com.kjs.common.bean.ResponseJsonModel;
import com.kjs.common.bean.annotation.AdminLogAnn;
import com.kjs.common.bean.annotation.PermissionAnn;
import com.kjs.common.bean.enums.OperLevel;
import com.kjs.common.bean.enums.OperType;
import com.kjs.common.dto.user.ExportCsvForAnswerDto;
import com.kjs.common.utils.ShiroUtils;
import com.kjs.orm.model.CourseQuestion;
import com.kjs.orm.model.CourseQuestionReply;
import com.kjs.service.kjs.course.spi.ICourseQuestionReplyService;
import com.kjs.service.kjs.course.spi.ICourseQuestionService;
import com.kjs.web.serach.kjs.operation.QuestionSearchBean;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import java.io.IOException;
import java.util.Date;
import java.util.List;
import java.util.Map;

/**
 * Created by 李恒 on 2016/6/19.
 * 老师答疑控制器
 */
@Controller
@RequestMapping("/question")
public class QuestionController{

    @Resource
    private ICourseQuestionService questionService;
    @Resource
    private ICourseQuestionReplyService replyService;

    /**
     * 老师答疑页
     * @return  view
     * @author 李恒名
     * @date 2016年6月19日
     */
    @PermissionAnn(menuCode = "question",msg = "你没有进入老师答疑页面的权限!")
    @RequestMapping("/index")
    public String index() {
        return "operation/question/index" ;
    }

    /**
     * 答疑列表接口
     * @return  model
     * @author 李恒名
     * @date 2016年6月19日
     */
    @AdminLogAnn(operType = OperType.QUESTION,operLevel = OperLevel.NORM,operDescribe = "查询答疑列表")
    @RequestMapping("/list")
    @ResponseBody
    public DataTablePageModel list(QuestionSearchBean search) {
        return questionService.buildModelBySearch(search);
    }

    /**
     * 答疑详情接口
     * @return  model
     * @author 李恒名
     * @date 2016年6月14日
     */
    @AdminLogAnn(operType = OperType.QUESTION,operLevel = OperLevel.NORM,operDescribe = "答疑详情")
    @RequestMapping("/detail")
    @ResponseBody
    public ResponseJsonModel detail(Long id) {
        CourseQuestion question = questionService.detail(id);
        ResponseJsonModel model = new ResponseJsonModel();
        model.setResult(question);
        return model;
    }

    /**
     * 回答接口
     * @return  model
     * @author 李恒名
     * @date 2016年6月14日
     */
    @AdminLogAnn(operType = OperType.QUESTION,operLevel = OperLevel.NORM,operDescribe = "回答")
    @PermissionAnn(menuCode = "question",operCode = "reply" ,msg = "你没有老师答疑回复的权限!")
    @RequestMapping("/reply")
    @ResponseBody
    public ResponseJsonModel reply(CourseQuestionReply reply) throws IOException {
        reply.setReplyTime(new Date());
        reply.setReplyUserid(ShiroUtils.getSessionUser().getId());
        reply.setDeleted(0);
        replyService.reply(reply);
        ResponseJsonModel model = new ResponseJsonModel();
        return model;
    }

    /**
     * 删除答疑接口
     * @return  model
     * @author 李恒名
     * @date 2016年6月14日
     */
    @AdminLogAnn(operType = OperType.QUESTION,operLevel = OperLevel.NORM,operDescribe = "删除")
    @RequestMapping("/delete")
    @ResponseBody
    public ResponseJsonModel delete(Long id) {
        questionService.deleteByIds(new Long[]{id});
        ResponseJsonModel model = new ResponseJsonModel();
        return model;
    }

    /**
     * 问题计数接口(当日新增问题数、未回答问题数)
     * @return  model
     * @author 李恒名
     * @date 2016年6月14日
     */
    @AdminLogAnn(operType = OperType.QUESTION,operLevel = OperLevel.NORM,operDescribe = "问题统计")
    @RequestMapping("/count")
    @ResponseBody
    public ResponseJsonModel count(Long id) {
        Map<String, Long> countInfo = questionService.findCountInfo();
        ResponseJsonModel model = new ResponseJsonModel();
        model.setResult(countInfo);
        return model;
    }

    /**
     * 老师答疑导出csv
     * @return
     */
    @AdminLogAnn(operType = OperType.QUESTION,operLevel = OperLevel.NORM,operDescribe = "老师答疑导出csv")
    @PermissionAnn(menuCode = "question",operCode = "export",msg = "你没有老师答疑导出csv的权限!")
    @ResponseBody
    @RequestMapping(value = "/export/csv/answers",method = RequestMethod.POST)
    public ResponseJsonModel exportCsvAnswers(QuestionSearchBean search){
        ResponseJsonModel responseJsonModel = new ResponseJsonModel();
        List<ExportCsvForAnswerDto> exportDatas = questionService.exportCsvAnswers(search);
        responseJsonModel.setResult(exportDatas);
        return responseJsonModel;
    }
}
