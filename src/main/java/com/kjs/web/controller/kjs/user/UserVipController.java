package com.kjs.web.controller.kjs.user;

import com.kjs.common.bean.ResponseJsonModel;
import com.kjs.common.bean.annotation.AdminLogAnn;
import com.kjs.common.bean.annotation.PermissionAnn;
import com.kjs.common.bean.enums.OperLevel;
import com.kjs.common.bean.enums.OperType;
import com.kjs.common.utils.RequestParamUtils;
import com.kjs.orm.model.VipInfo;
import com.kjs.service.kjs.user.spi.IVipInfoService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.List;
import java.util.Map;

/**
 * 分类方向管理控制器
 * Created by wangsongpeng on 2016/2/25.
 */
@Controller
@RequestMapping("/vip")
public class UserVipController {
    private final static Logger logger = LoggerFactory.getLogger(UserVipController.class);
    @Resource
    private IVipInfoService vipInfoService;

    /**
     * 跳转到管理页面
     * @return
     */
    @PermissionAnn(menuCode = "vip",msg = "你没有进入会员定价管理页面的权限!")
    @RequestMapping(value = "/manager")
    public String forwardManager(Model model){
        return "user/user_vip";
    }

    /**
     * 列表
     * @return
     */
    @PermissionAnn(menuCode = "vip",operCode = "find",msg = "你没有会员定价页面的查询权限!")
    @ResponseBody
    @RequestMapping(value = "/list",method = RequestMethod.POST)
    public ResponseJsonModel serachVipInfo(){
        List<VipInfo> viplist =  this.vipInfoService.queryAll();
        ResponseJsonModel arm = new ResponseJsonModel();
        arm.setResult(viplist);
        return arm;
    }
    /**
     *  新增
     * @param
     * @return
     */
    @AdminLogAnn(operType = OperType.SYSTEM,operLevel = OperLevel.NORM,operDescribe = "新增/修改会员信息")
    @PermissionAnn(menuCode = "vip",operCode = "save",msg = "你没有新增/修改会员信息的权限!")
    @ResponseBody
    @RequestMapping(value = "/save",method = RequestMethod.POST)
    public ResponseJsonModel saveEmp(HttpServletRequest request,HttpServletResponse response)throws Exception{
        Map paramMap = RequestParamUtils.getParamValues(request);
        Map<String,VipInfo> map = this.vipInfoService.switchDataToObject(paramMap);
        this.vipInfoService.saveEmp(map);
        logger.warn("新增/修改vip会员信息:" + map);
        return new ResponseJsonModel();
    }

    @RequestMapping("/info/list")
    @ResponseBody
    public ResponseJsonModel list(){
        ResponseJsonModel model = new ResponseJsonModel();
        model.setResult(this.vipInfoService.queryAll());
        return model;
    }

}
