<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" contentType="text/html; UTF-8" %>
<%@include file="/WEB-INF/view/include/taglib.jsp" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>${pname}管理系统-订单管理</title>
    <link href="${pageContext.request.contextPath}/resources/assets/plugins/bootstrap-daterangepicker/daterangepicker-bs3.css" rel="stylesheet"/>
    <link href="${path}/resources/assets/plugins/bootstrapValidator/css/bootstrapValidator.css" rel="stylesheet">
    <style>
        .row{margin:20px 10px}
    </style>
</head>

<body>
<div class="panel panel-inverse">
    <div class="panel-heading">
        <h4 class="panel-title">订单管理</h4>
    </div>
    <div class="panel-body">
            <div class="row">
                <label class="col-md-1 control-label">选择套餐</label>
                <div class="col-md-2">
                    <select class="form-control"  id="vip-price-select">

                    </select>
                </div>
            </div>
            <div class="row">
                <label class="col-md-1 control-label">选择学员</label>
                <div class="col-md-2">
                    <input type="text" class="form-control"  id="username">
                </div>
                <button class="btn btn-primary" id="select-stu-btn">确定</button>
            </div>

            <div class="row">
                <label class="col-md-1 control-label">使用券支付</label>
                <div class="col-md-10">
                    <table id="stu-table" class="table table-hover table-condensed">
                        <tr class="">
                            <th>选择</th>
                            <th>券名</th>
                            <th>券号</th>
                            <th>金额</th>
                            <th>有效期</th>
                        </tr>
                    </table>
                </div>
            </div>
            <div class="row">
                <label class="col-md-2 col-md-offset-11 control-label">待支付金额：<span id="order-price">0</span>元</label>
            </div>
        <shiro:hasPermission name="order-create:save">
            <button type="button" id="create-order-btn" class="btn btn-primary col-md-1 col-md-offset-11">创建</button>
        </shiro:hasPermission>

    </div>
</div>
</div>


<!-- Modal -->
<div class="modal fade bs-example-modal-lg" id="order-confrim-modal" tabindex="-1" role="dialog">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" >优惠券发放详情</h4>
            </div>
            <div class="modal-body">
                <dl class="dl-horizontal" style="font-size: 15px;" id="order-detail-dl">
                </dl>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal" >取消</button>
                <button type="button" class="btn btn-primary" data-dismiss="modal" id="confirm-create">确定创建</button>
            </div>
        </div>
    </div>
</div>
<script src="${pageContext.request.contextPath}/resources/assets/plugins/DataTables/media/js/jquery.dataTables.js"></script>
<script src="${pageContext.request.contextPath}/resources/assets/plugins/DataTables/media/js/dataTables.bootstrap.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/assets/plugins/bootstrap-daterangepicker/moment.js"></script>
<script src="${pageContext.request.contextPath}/resources/assets/plugins/bootstrap-daterangepicker/daterangepicker.js"></script>
<script src="${pageContext.request.contextPath}/resources/common/utils/js/tool.date.js"></script>
<script src="${pageContext.request.contextPath}/resources/assets/plugins/bootstrapValidator/js/bootstrapValidator.js"></script>
<script src="${pageContext.request.contextPath}/resources/base/order/order-create.js"></script>
<script>
    $(function () {
        page.init();
    })
</script>
</body>
</html>