package com.kjs.web.controller.kjs.order;

import com.kjs.common.bean.DataTablePageModel;
import com.kjs.common.bean.ResponseJsonModel;
import com.kjs.common.bean.annotation.AdminLogAnn;
import com.kjs.common.bean.annotation.PermissionAnn;
import com.kjs.common.bean.enums.OperLevel;
import com.kjs.common.bean.enums.OperType;
import com.kjs.common.dto.RefundDetailDto;
import com.kjs.orm.model.PayOrder;
import com.kjs.orm.model.RefundDetail;
import com.kjs.service.kjs.pay.IRefundDetailService;
import com.kjs.service.kjs.pay.spi.IPayOrderService;
import com.kjs.web.serach.kjs.order.PayOrderSearchBean;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import java.util.List;

/**
 * Created by 李恒名 on 2016/6/12.
 */
@Controller
@RequestMapping("/order")
public class OrderController {

    @Resource
    IPayOrderService orderService;
    @Resource
    IRefundDetailService refundService;

    /**
     * 订单管理页
     *
     * @return view
     * @author 李恒名
     * @date 2016年6月12日
     */
    @PermissionAnn(menuCode = "order", msg = "你没有进入订单管理页面的权限!")
    @RequestMapping("/manager")
    public String manager() {
        return "order/order-manager";
    }

    @PermissionAnn(menuCode = "order-create", msg = "你没有进入订单创建页面的权限!")
    @RequestMapping("/create")
    public String create() {
        return "order/order-create";
    }

    /**
     * 订单列表接口
     *
     * @return model
     * @author 李恒名
     * @date 2016年6月12日
     */
    @AdminLogAnn(operType = OperType.ORDER, operLevel = OperLevel.NORM, operDescribe = "查询订单列表")
    @RequestMapping("/list")
    @ResponseBody
    public DataTablePageModel list(PayOrderSearchBean search) {
        return orderService.buildModelBySearch(search);
    }

    /**
     * 订单详情接口
     *
     * @return model
     * @author 李恒名
     * @date 2016年6月12日
     */
    @AdminLogAnn(operType = OperType.ORDER, operLevel = OperLevel.NORM, operDescribe = "查询订单详情")
    @RequestMapping("/detail")
    @ResponseBody
    public ResponseJsonModel detail(Long id) {
        ResponseJsonModel model = new ResponseJsonModel();
        PayOrder order = orderService.findById(id);
        model.setResult(order);
        return model;
    }

    /**
     * 退款信息接口
     *
     * @return model
     * @author 李恒名
     * @date 2016年6月12日
     */
    @AdminLogAnn(operType = OperType.ORDER, operLevel = OperLevel.NORM, operDescribe = "查询退款详情")
    @RequestMapping("/refund/info")
    @ResponseBody
    public ResponseJsonModel refundInfo(Long id) {
        ResponseJsonModel model = new ResponseJsonModel();
        PayOrder order = orderService.findRefundInfoById(id);
        model.setResult(order);
        return model;
    }

    /**
     * 退款接口
     *
     * @return model
     * @author 李恒名
     * @date 2016年6月12日
     */
    @AdminLogAnn(operType = OperType.ORDER, operLevel = OperLevel.NORM, operDescribe = "退款")
    @RequestMapping("/refund")
    @ResponseBody
    public ResponseJsonModel refund(RefundDetail refundDetail) {
        orderService.refund(refundDetail);
        ResponseJsonModel model = new ResponseJsonModel();
        return model;
    }


    /**
     * 后天添加订单接口
     *
     * @return model
     * @author 李恒名
     * @date 2016年9月5日
     */
    @AdminLogAnn(operType = OperType.ORDER, operLevel = OperLevel.NORM, operDescribe = "创建订单")
    @RequestMapping("/add")
    @ResponseBody
    public ResponseJsonModel add(Long vipId, String uid, Long userVoucherId, HttpServletRequest request) {
        orderService.create(vipId, uid, userVoucherId, request);
        return new ResponseJsonModel();
    }


    /**
     * 退款审核页
     *
     * @return view
     * @author 李恒名
     * @date 2016年11月23日
     */
    @PermissionAnn(menuCode = "refund-audit", msg = "你没有进入退款审核页面的权限!")
    @RequestMapping("/refund/audit")
    public String refundAudit() {
        return "order/refund-audit";
    }


    /**
     * 退款审批列表接口
     *
     * @return model
     * @author 李恒名
     * @date 2016年11月23日
     */
    @AdminLogAnn(operType = OperType.ORDER, operLevel = OperLevel.NORM, operDescribe = "查询退款审批列表")
    @RequestMapping("/refund/audit/list")
    @ResponseBody
    public DataTablePageModel refundAuditList(PayOrderSearchBean search) {
        return refundService.buildModelBySearch(search);
    }


    /**
     * 退款详情接口
     *
     * @return model
     * @author 李恒名
     * @date 2016年11月23日
     */
    @AdminLogAnn(operType = OperType.ORDER, operLevel = OperLevel.NORM, operDescribe = "查询订单退款详情")
    @RequestMapping("/refund/detail")
    @ResponseBody
    public ResponseJsonModel refundDetail(Long id) {
        ResponseJsonModel model = new ResponseJsonModel();
        List<RefundDetailDto> refundDetailList = refundService.findByOrderId(id);
        model.setResult(refundDetailList);
        return model;
    }

    /**
     * 退款审核（教务）接口
     *
     * @return model
     * @author 李恒名
     * @date 2016年11月24日
     */
    @AdminLogAnn(operType = OperType.ORDER, operLevel = OperLevel.NORM, operDescribe = "退款审核(教务)")
    @RequestMapping("/refund/audit/teacher")
    @ResponseBody
    public ResponseJsonModel refundAuditTeacher(Long id, String teacherManagerOpinion, Boolean pass) {
        ResponseJsonModel model = new ResponseJsonModel();
        refundService.refundAuditByTeacherManager(id, teacherManagerOpinion, pass);
        return model;
    }

    /**
     * 退款审核（財務）接口
     *
     * @return model
     * @author 李恒名
     * @date 2016年11月24日
     */
    @AdminLogAnn(operType = OperType.ORDER, operLevel = OperLevel.NORM, operDescribe = "退款审核(财务)")
    @RequestMapping("/refund/audit/finance")
    @ResponseBody
    public ResponseJsonModel financeAuditTeacher(Long id, String financeOpinion, Boolean pass, Boolean isSecond) {
        ResponseJsonModel model = new ResponseJsonModel();
        refundService.refundAuditByFinance(id, financeOpinion, pass, isSecond);
        return model;
    }


    /**
     * 退款管理页(退款审核-财务主管)
     *
     * @return view
     * @author 李恒名
     * @date 2016年11月23日
     */
    @PermissionAnn(menuCode = "refund-manager", msg = "你没有进入退款管理页面的权限!")
    @RequestMapping("/refund/manager")
    public String refundManager() {
        return "order/refund-manager";
    }


    /**
     * 对账管理页
     *
     * @return view
     * @author 李恒名
     * @date 2016年11月23日
     */
    @PermissionAnn(menuCode = "bill-manager", msg = "你没有进入对账管理页面的权限!")
    @RequestMapping("/bill/manager")
    public String billManager() {
        return "order/bill-manager";
    }

    /**
     * 对账管理页
     *
     * @return view
     * @author 李恒名
     * @date 2016年11月23日
     */
    @AdminLogAnn(operType = OperType.ORDER, operLevel = OperLevel.NORM, operDescribe = "查询对账管理列表")
    @RequestMapping("/bill/list")
    @ResponseBody
    public DataTablePageModel billList(PayOrderSearchBean searchBean) {
        return orderService.buildModelBySearch4Bill(searchBean);
    }

    /**
     * 财务统计接口
     */
    @RequestMapping("/bill/statistics")
    @ResponseBody
    public DataTablePageModel billStatistics(PayOrderSearchBean searchBean) {
        return orderService.buildModelBySearch4financeStatistics(searchBean);
    }

    @AdminLogAnn(operType = OperType.ORDER, operLevel = OperLevel.NORM, operDescribe = "订单轨迹列表")
    @RequestMapping("/track/list")
    @ResponseBody
    public ResponseJsonModel trackList(Long id,int type) {
        ResponseJsonModel model = new ResponseJsonModel();
        model.setResult(orderService.findTrackById(id,type));
        return model;
    }

    /**
     * 导出csv
     * @return
     */
    @AdminLogAnn(operType = OperType.SYSTEM,operLevel = OperLevel.NORM,operDescribe = "订单导出导出csv")
    @PermissionAnn(menuCode = "order",operCode = "export",msg = "你没有订单导出csv的权限!")
    @ResponseBody
    @RequestMapping(value = "/export/csv/answers")
    public ResponseJsonModel exportCsvAnswers(PayOrderSearchBean search){
        ResponseJsonModel responseJsonModel =  new ResponseJsonModel();
        responseJsonModel.setResult(orderService.buildModelBySearch(search).getData());
        return responseJsonModel;
    }
}
