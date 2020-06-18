package com.kjs.web.controller.kjs.operation;

import com.kjs.common.bean.DataTablePageModel;
import com.kjs.common.bean.ResponseJsonModel;
import com.kjs.common.bean.annotation.AdminLogAnn;
import com.kjs.common.bean.annotation.PermissionAnn;
import com.kjs.common.bean.enums.OperLevel;
import com.kjs.common.bean.enums.OperType;
import com.kjs.common.utils.ShiroUtils;
import com.kjs.orm.model.Voucher;
import com.kjs.service.kjs.user.spi.IUserVoucherService;
import com.kjs.service.kjs.voucher.spi.IVoucherService;
import com.kjs.web.serach.kjs.operation.FeedbackSearchBean;
import com.kjs.web.serach.kjs.operation.VoucherSearchBean;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import java.util.Date;

/**
 * Created by 李恒名 on 2016/8/26.
 * <p>
 * 优惠券控制器
 */
@Controller
@RequestMapping("/voucher")
public class VoucherController {


    @Resource
    private IVoucherService voucherService;
    @Resource
    private IUserVoucherService userVoucherService;


    @PermissionAnn(menuCode = "voucher", msg = "你没有进入券模板管理页面的权限!")
    @RequestMapping("/manager")
    public String manager(FeedbackSearchBean search) {
        return "operation/voucher/index";
    }

    @AdminLogAnn(operType = OperType.VOUCHER, operLevel = OperLevel.NORM, operDescribe = "查询优惠券列表")
    @RequestMapping("/list")
    @ResponseBody
    public DataTablePageModel list(VoucherSearchBean search) {
        return voucherService.buildModelBySearch(search);
    }


    @AdminLogAnn(operType = OperType.VOUCHER, operLevel = OperLevel.NORM, operDescribe = "修改优惠券")
    @RequestMapping("/detail")
    @ResponseBody
    public ResponseJsonModel detail(Long id) {
        Voucher voucher = voucherService.findById(id);
        ResponseJsonModel model = new ResponseJsonModel();
        model.setResult(voucher);
        return model;
    }


    @AdminLogAnn(operType = OperType.VOUCHER, operLevel = OperLevel.NORM, operDescribe = "锁定优惠券")
    @RequestMapping("/locked")
    @ResponseBody
    public ResponseJsonModel locked(Voucher voucher) {
        voucherService.update(voucher.setLocked(1));
        return new ResponseJsonModel();
    }
    @AdminLogAnn(operType = OperType.VOUCHER, operLevel = OperLevel.NORM, operDescribe = "解锁优惠券")
    @RequestMapping("/unlock")
    @ResponseBody
    public ResponseJsonModel unlock(Voucher voucher) {
        voucher.setLocked(0);
        voucherService.update(voucher);
        return new ResponseJsonModel();
    }

    @AdminLogAnn(operType = OperType.VOUCHER, operLevel = OperLevel.NORM, operDescribe = "添加优惠券")
    @RequestMapping("/add")
    @ResponseBody
    public ResponseJsonModel add(Voucher voucher) {
        voucher.setCtime(new Date());
        voucher.setUserId(ShiroUtils.getSessionUser().getId());
        voucher.setLocked(0);
        voucherService.save(voucher);
        return new ResponseJsonModel();
    }
    @AdminLogAnn(operType = OperType.VOUCHER, operLevel = OperLevel.NORM, operDescribe = "修改优惠券")
    @RequestMapping("/modify")
    @ResponseBody
    public ResponseJsonModel modify(Voucher voucher) {
        voucherService.update(voucher);
        return new ResponseJsonModel();
    }

}


