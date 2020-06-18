package com.kjs.web.controller.kjs.operation;

import com.kjs.common.bean.DataTablePageModel;
import com.kjs.common.bean.ResponseJsonModel;
import com.kjs.common.bean.annotation.AdminLogAnn;
import com.kjs.common.bean.annotation.PermissionAnn;
import com.kjs.common.bean.enums.OperLevel;
import com.kjs.common.bean.enums.OperType;
import com.kjs.orm.model.UserVoucher;
import com.kjs.service.kjs.user.UserVoucherService;
import com.kjs.web.serach.kjs.operation.VoucherGrantSearchBean;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import java.util.List;

/**
 * Created by 李恒名 on 2016/8/26.
 * <p>
 * 优惠码控制器
 */
@Controller
@RequestMapping("/reduce-code")
public class ReduceCodeController {

    @Resource
    private UserVoucherService userVoucherService;

    @PermissionAnn(menuCode = "reduce-code", msg = "你没有进入优惠码生成管理页面的权限!")
    @RequestMapping("/manager")
    public String manager() {
        return "operation/reduce-code/index";
    }


    @AdminLogAnn(operType = OperType.REDUCE_CODE, operLevel = OperLevel.NORM, operDescribe = "生成优惠码")
    @RequestMapping("/generate")
    @ResponseBody
    public ResponseJsonModel generate(Integer voucherTemplateId, Integer voucherCount) {
        List<UserVoucher> reduceCodeList = userVoucherService.generateReduceCode(voucherTemplateId, voucherCount);
        ResponseJsonModel result = new ResponseJsonModel();
        result.setResult(reduceCodeList);
        return result ;
    }

    @AdminLogAnn(operType = OperType.REDUCE_CODE, operLevel = OperLevel.NORM, operDescribe = "查询优惠码生成记录列表")
    @RequestMapping("/list")
    @ResponseBody
    public DataTablePageModel list(VoucherGrantSearchBean search) {
        return userVoucherService.buildModelBySearch(search);
    }

}


