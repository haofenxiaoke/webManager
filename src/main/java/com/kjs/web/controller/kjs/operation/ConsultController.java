package com.kjs.web.controller.kjs.operation;

import com.kjs.common.bean.ResponseJsonModel;
import com.kjs.common.bean.annotation.AdminLogAnn;
import com.kjs.common.bean.annotation.PermissionAnn;
import com.kjs.common.bean.enums.OperLevel;
import com.kjs.common.bean.enums.OperType;
import com.kjs.common.utils.ShiroUtils;
import com.kjs.common.utils.StringUtil;
import com.kjs.orm.model.AuthorityUsers;
import com.kjs.orm.model.ConsultConfig;
import com.kjs.service.kjs.consult.ConsultConfigService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.util.CollectionUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import java.util.Date;
import java.util.List;

/**
 * Created by zhenghui on 2017/3/29.
 * 售前、售后咨询配置控制器
 */
@Controller
@RequestMapping("/consult")
public class ConsultController {
    private final static Logger logger = LoggerFactory.getLogger(ConsultController.class);
    @Resource
    private ConsultConfigService consultConfigService;

    /**
     * 跳转到售前、售后咨询管理页面
     * @return
     */
    @PermissionAnn(menuCode = "consult",msg = "你没有进入售前、售后咨询管理页面的权限!")
    @RequestMapping(value = "/manager")
    public String forwardManager(){
        return "consult/index";
    }

    /**
     * 显示售前、售后咨询信息
     */
    @AdminLogAnn(operType = OperType.SYSTEM,operLevel = OperLevel.NORM,operDescribe = "显示售前、售后咨询信息")
    @ResponseBody
    @RequestMapping(value = "/entity",method = RequestMethod.POST)
    public ResponseJsonModel serachEmpEntity(){
        ResponseJsonModel responseJsonModel = new ResponseJsonModel();
        List list = consultConfigService.queryAll();
        if(!CollectionUtils.isEmpty(list)){
            responseJsonModel.setResult(consultConfigService.queryAll());
        }
        return responseJsonModel;
    }

    /**
     * 售前、后咨询信息保存
     * @param
     * @return
     */
    @AdminLogAnn(operType = OperType.CONSULT,operLevel = OperLevel.NORM,operDescribe = "售前、后咨询信息保存")
    @PermissionAnn(menuCode = "consult",operCode = "save",msg = "你没有售前、后咨询信息保存的权限!")
    @ResponseBody
    @RequestMapping(value = "/save",method = RequestMethod.POST)
    public ResponseJsonModel saveEmp(ConsultConfig consultConfig)throws Exception{
        Date now = new Date();
        AuthorityUsers users = ShiroUtils.getSessionUser();

        if(users != null){
            consultConfig.setUserId(users.getId().intValue());
        }

        if(StringUtil.isNotEmpty(consultConfig.getId())){
            consultConfig.setUtime(now);
            consultConfigService.update(consultConfig);
            logger.warn("更新售前、售后信息:" + consultConfig.getId());
        }else{
            consultConfig.setCtime(now);
            consultConfig.setUtime(now);
            consultConfigService.save(consultConfig);
            logger.warn("保存售前、售后信息:" + consultConfig.getId());
        }

        return new ResponseJsonModel();
    }
}
