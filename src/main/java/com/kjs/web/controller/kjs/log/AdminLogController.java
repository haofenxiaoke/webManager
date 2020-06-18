package com.kjs.web.controller.kjs.log;

import com.kjs.common.bean.DataTablePageModel;
import com.kjs.common.bean.annotation.PermissionAnn;
import com.kjs.common.bean.enums.OperLevel;
import com.kjs.common.bean.enums.OperType;
import com.kjs.service.kjs.log.spi.IAdminLogService;
import com.kjs.web.serach.kjs.log.AdminLogSerachBean;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import java.util.ArrayList;
import java.util.List;

/**
 * 日志控制器
 * Created by qiaolu on 2016/3/25.
 */
@Controller
@RequestMapping(value = "/adminLog")
public class AdminLogController {
    @Resource
    private IAdminLogService adminLogService;

    /**
     * 跳转到日志列表页面
     *
     * @return
     */
    @PermissionAnn(menuCode = "adminLog",msg = "你没有进入操作日志列表页面的权限!")
    @RequestMapping(value = "/list")
    public String forwardLogListManager(Model model) {
        List operTypelList = new ArrayList();
        for (OperType operType : OperType.values()) {
            operTypelList.add(operType);
        }

        List operLevelList = new ArrayList();
        for (OperLevel operLevel : OperLevel.values()) {
            operLevelList.add(operLevel);
        }
        model.addAttribute("operTypelList", operTypelList);
        model.addAttribute("operLevelList", operLevelList);
        return "log/adminlog_list";
    }

    /**
     * 查询日志列表
     *
     * @param adminLogSerachBean
     * @return
     */
    @PermissionAnn(menuCode = "adminLog", operCode = "find", msg = "你没有操作日志的查询权限!")
    @ResponseBody
    @RequestMapping(value = "/search", method = RequestMethod.POST)
    public DataTablePageModel searchEmpInfo(AdminLogSerachBean adminLogSerachBean) {
        adminLogService.findAdminLogPage(adminLogSerachBean);
        return adminLogSerachBean;
    }
}
