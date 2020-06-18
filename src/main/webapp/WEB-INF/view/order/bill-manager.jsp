<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" contentType="text/html; UTF-8" %>
<%@include file="/WEB-INF/view/include/taglib.jsp" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>${pname}财务管理-对账管理</title>
    <link href="${pageContext.request.contextPath}/resources/assets/plugins/bootstrap-daterangepicker/daterangepicker-bs3.css"
          rel="stylesheet"/>
    <link href="${path}/resources/assets/plugins/bootstrapValidator/css/bootstrapValidator.css" rel="stylesheet">
    <style>
        dd{word-break: break-all;}
    </style>
</head>

<body>
<div class="panel panel-inverse">
    <div class="panel-heading">
        <h4 class="panel-title">财务对账</h4>
    </div>

    <div class="panel-body">
        <form id="search-form" class="form-inline">
            <div class="form-group ">
                <input type="text" class="form-control" id="order-num" placeholder="请输入订单编号"/>
            </div>
            <div class="form-group ">
                <select id="pay-type" name="pay-type" class="form-control" style="width: 200px;">
                    <option selected value="">--请选择支付渠道--</option>
                    <option value="1" >支付宝</option>
                    <option value="2">微信支付</option>
                    <option value="3">财付通(含网银)</option>
                </select>
            </div>
            <div class="form-group ">
                <div class="input-group">
                    <input readonly="readonly" class="form-control" id="pay-date"
                           placeholder="选择支付日期">
                </div>
            </div>
            <shiro:hasPermission name="bill-manager:search:0">
                <button type="button" class="btn btn-sm btn-primary" id="search">搜索</button>
            </shiro:hasPermission>
        </form>
        <br/>
        <table id="order-table1" class="table table-striped table-bordered" width="100%">
            <thead>
            <tr style="background-color:#a0a0a0;"><td colspan="4"><h5><strong id="data-collect"></strong></h5></td></tr>
            <tr>
                <th>支付渠道</th>
                <th>总订单数</th>
                <th>总支付金额</th>
            </tr>
            </thead>
        </table>
        <br/>
        <table id="order-table" class="table table-striped table-bordered" width="100%">
            <thead>
            <tr>
                <th></th>
                <th>订单编号</th>
                <th>会员套餐</th>
                <th>支付渠道</th>
                <th>支付日期</th>
                <th>订单金额</th>
                <th>实付金额</th>
                <th>状态</th>
                <th>操作</th>
            </tr>
            </thead>
        </table>
    </div>
</div>
</div>


<!-- Modal -->
<div class="modal fade bs-example-modal-lg" id="order-look-modal" tabindex="-1" role="dialog">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div>
                <ul id="detailTab" class="nav nav-tabs nav-tabs-inverse nav-justified nav-justified-mobile">
                    <li class="active"><a href="#detail-1" data-type="1" data-toggle="tab">订单详情</a></li>
                    <li><a href="#detail-2" data-type="2" data-toggle="tab">退款详情</a></li>
                </ul>
                <div id="detailTabContent" class="tab-content">
                    <div class="tab-pane fade in active" id="detail-1">
                        <dl class="dl-horizontal" style="font-size: 15px;" id="detail-1-dl">
                        </dl>
                    </div>
                    <div id="detail-2" class="tab-pane fade in">
                        <dl class="dl-horizontal" style="font-size: 15px;" id="detail-2-dl">
                        </dl>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<div id="button-1">
    <shiro:hasPermission name="bill-manager:find">
        <button type="button" class="btn btn-sm btn-primary" id="deleteLive" onclick="page.look('#id')">查看</button>
    </shiro:hasPermission>
</div>
<script src="${pageContext.request.contextPath}/resources/assets/plugins/DataTables/media/js/jquery.dataTables.js"></script>
<script src="${pageContext.request.contextPath}/resources/assets/plugins/DataTables/media/js/dataTables.bootstrap.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/assets/plugins/bootstrap-daterangepicker/moment.js"></script>
<script src="${pageContext.request.contextPath}/resources/assets/plugins/bootstrap-daterangepicker/daterangepicker.js"></script>
<script src="${pageContext.request.contextPath}/resources/common/utils/js/tool.date.js"></script>
<script src="${pageContext.request.contextPath}/resources/assets/plugins/bootstrapValidator/js/bootstrapValidator.js"></script>
<script src="${pageContext.request.contextPath}/resources/script/china_area.js"></script>
<script src="${pageContext.request.contextPath}/resources/base/order/bill-manager.js"></script>
<script>
    $(function () {
        page.init();
    })
</script>
</body>
</html>