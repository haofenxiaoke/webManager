<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" contentType="text/html; UTF-8" %>
<%@include file="/WEB-INF/view/include/taglib.jsp" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>${pname}管理系统-退款审核</title>
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
        <h4 class="panel-title">退款审核</h4>
    </div>
    <div>
        <div class="container-fluid">

            <div class="row">
                <!-- Nav tabs -->
                <ul id="tabs" class="nav nav-tabs" role="tablist">
                    <li><a href="#order-list-1" data-status="1" data-toggle="tab">待审批</a></li>
                    <li><a href="#order-list-2" data-status="2" data-toggle="tab">待退款</a></li>
                    <li><a href="#order-list-3" data-status="3" data-toggle="tab">已退款</a></li>
                </ul>
                <!-- Tab panes -->
                <div class="tab-content">
                    <form id="search-form" class="form-inline">
                        <div class="form-group ">
                            <input type="text" class="form-control" id="order-num" placeholder="请输入订单编号"/>
                        </div>
                        <div class="form-group ">
                            <input type="text" class="form-control" id="username" placeholder="请输入购买账号"/>
                        </div>
                        <div class="form-group ">
                            <div class="input-group">
                                <input readonly="readonly" class="form-control" id="order-date"
                                       placeholder="选择申请日期">
                            </div>
                        </div>
                        <shiro:hasPermission name="refund-audit:search:0">
                            <button type="button" class="btn btn-sm btn-primary" id="search">搜索</button>
                        </shiro:hasPermission>
                    </form>
                    <div role="tabpanel" class="tab-pane " id="order-list-1">
                        <div class="panel panel-default">
                            <div class="panel-heading"></div>
                            <table id="order-table-1" class="table table-striped table-bordered" width="100%">
                                <thead>
                                <tr>
                                    <th></th>
                                    <th>订单编号</th>
                                    <th>会员套餐</th>
                                    <th>退款金额</th>
                                    <th>申请人</th>
                                    <th>申请时间</th>
                                    <th>购买账号</th>
                                    <th>操作</th>
                                </tr>
                                </thead>
                            </table>
                        </div>
                    </div>
                    <div role="tabpanel" class="tab-pane " id="order-list-2">
                        <div class="panel panel-default">
                            <div class="panel-heading"></div>
                            <table id="order-table-2" class="table table-striped table-bordered" width="100%">
                                <thead>
                                <tr>
                                    <th></th>
                                    <th>订单编号</th>
                                    <th>会员套餐</th>
                                    <th>退款金额</th>
                                    <th>申请人</th>
                                    <th>审批时间</th>
                                    <th>购买账号</th>
                                    <th>操作</th>
                                </tr>
                                </thead>
                            </table>
                        </div>
                    </div>
                    <div role="tabpanel" class="tab-pane " id="order-list-3">
                        <div class="panel panel-default">
                            <div class="panel-heading"></div>
                            <table id="order-table-3" class="table table-striped table-bordered" width="100%">
                                <thead>
                                <tr>
                                    <th></th>
                                    <th>订单编号</th>
                                    <th>会员套餐</th>
                                    <th>退款金额</th>
                                    <th>申请人</th>
                                    <th>退款时间</th>
                                    <th>购买账号</th>
                                    <th>操作</th>
                                </tr>
                                </thead>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
</div>


<!-- Modal -->
<div class="modal fade bs-example-modal-lg" id="refund-look-modal" tabindex="-1" role="dialog">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span
                        aria-hidden="true">&times;</span></button>
                <h4 class="modal-title">退款详情</h4>
            </div>
            <div class="modal-body">
                <dl class="dl-horizontal" style="font-size: 15px;" id="refund-detail-dl">
                </dl>
                <div class="modal-footer" id="pass-btns" style="display: none">
                    <button type="button" id="pass-btn" class="btn btn-success">通过</button>
                    <button type="button" id="no-pass-btn" class="btn btn-danger">不通过</button>
                </div>
            </div>
        </div>
    </div>
</div>
<div id="button-1">
    <shiro:hasPermission name="refund-audit:find">
        <button type="button" class="btn btn-sm btn-primary" id="deleteLive" onclick="page.look('#orderId')">查看</button>
    </shiro:hasPermission>
</div>
<div id="button-2">
    <shiro:hasPermission name="refund-audit:audit">
        <button type="button" class="btn btn-sm btn-danger " id="modify" onclick="page.audit('#orderId','#id')">审批</button>
    </shiro:hasPermission>
</div>
<script src="${pageContext.request.contextPath}/resources/assets/plugins/DataTables/media/js/jquery.dataTables.js"></script>
<script src="${pageContext.request.contextPath}/resources/assets/plugins/DataTables/media/js/dataTables.bootstrap.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/assets/plugins/bootstrap-daterangepicker/moment.js"></script>
<script src="${pageContext.request.contextPath}/resources/assets/plugins/bootstrap-daterangepicker/daterangepicker.js"></script>
<script src="${pageContext.request.contextPath}/resources/common/utils/js/tool.date.js"></script>
<script src="${pageContext.request.contextPath}/resources/assets/plugins/bootstrapValidator/js/bootstrapValidator.js"></script>
<script src="${pageContext.request.contextPath}/resources/script/china_area.js"></script>
<script src="${pageContext.request.contextPath}/resources/base/order/refund-audit.js"></script>
<script>
    $(function () {
        page.init();
    })
</script>
</body>
</html>