package com.kjs.web.controller.kjs.operation;

import com.kjs.common.bean.DataTablePageModel;
import com.kjs.common.bean.ResponseJsonModel;
import com.kjs.common.bean.annotation.AdminLogAnn;
import com.kjs.common.bean.annotation.PermissionAnn;
import com.kjs.common.bean.enums.OperLevel;
import com.kjs.common.bean.enums.OperType;
import com.kjs.service.kjs.user.UserVoucherService;
import com.kjs.service.kjs.user.spi.IUserStuService;
import com.kjs.web.serach.kjs.operation.FeedbackSearchBean;
import com.kjs.web.serach.kjs.operation.VoucherGrantSearchBean;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;

/**
 * Created by 李恒名 on 2016/8/26.
 * <p>
 * 优惠券控制器
 */
@Controller
@RequestMapping("/voucher-grant")
public class VoucherGrantController {

    @Resource
    private IUserStuService userStuService;

    @Resource
    private UserVoucherService userVoucherService;

    @PermissionAnn(menuCode = "voucher-grant", msg = "你没有进入优惠券发放管理页面的权限!")
    @RequestMapping("/manager")
    public String manager(FeedbackSearchBean search) {
        return "operation/voucher-grant/index";
    }

    @RequestMapping("/query/stu")
    @ResponseBody
    public ResponseJsonModel stu(String userid) {
        ResponseJsonModel model = new ResponseJsonModel();
        model.setResult(userStuService.findByUserid(userid));
        return model;
    }

    @AdminLogAnn(operType = OperType.VOUCHER, operLevel = OperLevel.NORM, operDescribe = "发放优惠券")
    @RequestMapping("/grant")
    @ResponseBody
    public ResponseJsonModel grant(Integer voucherId, Integer voucherCount, String ids) {
        userVoucherService.grant(voucherId, voucherCount, ids);
        return new ResponseJsonModel();
    }
    @AdminLogAnn(operType = OperType.VOUCHER, operLevel = OperLevel.NORM, operDescribe = "查看优惠券发放详情")
    @RequestMapping("/detail")
    @ResponseBody
    public ResponseJsonModel detail(Long id) {
        ResponseJsonModel model = new ResponseJsonModel();
        model.setResult(userVoucherService.detail(id));
        return model;
    }

    @AdminLogAnn(operType = OperType.VOUCHER, operLevel = OperLevel.NORM, operDescribe = "查询优惠券发放记录列表")
    @RequestMapping("/list")
    @ResponseBody
    public DataTablePageModel list(VoucherGrantSearchBean search) {
        return userVoucherService.buildModelBySearch(search);
    }

    @RequestMapping("/list/stu")
    @ResponseBody
    public ResponseJsonModel listByStuId(Long id,Integer price) {
        ResponseJsonModel model = new ResponseJsonModel();
        model.setResult(userVoucherService.findByUserIdAndPrice(id,price));
        return model;
    }

}


