<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" contentType="text/html; UTF-8" %>
<%@include file="/WEB-INF/view/include/taglib.jsp" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>${pname}管理系统-订单管理</title>
    <link href="${pageContext.request.contextPath}/resources/assets/plugins/bootstrap-daterangepicker/daterangepicker-bs3.css"
          rel="stylesheet"/>
    <link href="${path}/resources/assets/plugins/bootstrapValidator/css/bootstrapValidator.css" rel="stylesheet">
    <style>
        .refund-detail-tab {
            display: none
        }

        dd {
            word-break: break-all;
        }
    </style>
</head>

<body>
<input type="hidden" id="pname" value="${pname}">
<div class="panel panel-inverse">
    <div class="panel-heading">
        <h4 class="panel-title">订单管理</h4>
    </div>
    <div>
        <div class="container-fluid">

            <div class="row">
                <!-- Nav tabs -->
                <ul id="tabs" class="nav nav-tabs" role="tablist">
                    <li><a href="#order-list-1" data-status="1" data-toggle="tab">已支付</a></li>
                    <li><a href="#order-list-0" data-status="0" data-toggle="tab">未支付</a></li>
                    <li><a href="#order-list-2" data-status="2" data-toggle="tab">已退款</a></li>
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
                                       placeholder="选择下单日期">
                                <%--<span class="input-group-btn">
                                   <button id="showCreateBtn" class="btn btn-default" type="button">
                                       <i class="fa fa-calendar"></i>
                                   </button>
                                </span>--%>
                            </div>
                        </div>
                        <div class="form-group ">
                            <div class="input-group">
                                <input readonly="readonly" class="form-control" id="pay-date"
                                       placeholder="选择支付日期">
                                <%--<span class="input-group-btn">
                                   <button id="" class="btn btn-default" type="button">
                                       <i class="fa fa-calendar"></i>
                                   </button>
                                </span>--%>
                            </div>
                        </div>
                        <div class="form-group ">
                            <select id="pay-money" class="form-control">
                                <option value="" selected>选择实付金额</option>
                                <option value="0">实付金额为0</option>
                                <option value="1">实付金额不为0</option>
                            </select>
                        </div>
                        <shiro:hasPermission name="order:find:0">
                            <button type="button" class="btn btn-sm btn-primary" id="search">搜索</button>
                        </shiro:hasPermission>
                        <shiro:hasPermission name="order:export:0">
                            <a class="btn btn-sm btn-primary" id="export" onclick="page.export(this);" download="${pname}管理系统-订单管理.csv" href="#">导出数据</a>
                        </shiro:hasPermission>
                    </form>
                    <div role="tabpanel" class="tab-pane " id="order-list-0">
                        <div class="panel panel-default">
                            <div class="panel-heading"></div>
                            <table id="order-table-0" class="table table-striped table-bordered" width="100%">
                                <thead>
                                <tr>
                                    <th></th>
                                    <th>订单编号</th>
                                    <th>购买账号</th>
                                    <th>会员套餐</th>
                                    <th>来源</th>
                                    <th>下单日期</th>
                                    <th>订单金额</th>
                                    <th>操作</th>
                                </tr>
                                </thead>
                            </table>
                        </div>
                    </div>
                    <div role="tabpanel" class="tab-pane " id="order-list-1">
                        <div class="panel panel-default">
                            <div class="panel-heading"></div>
                            <table id="order-table-1" class="table table-striped table-bordered" width="100%">
                                <thead>
                                <tr>
                                    <th></th>
                                    <th>订单编号</th>
                                    <th>购买账号</th>
                                    <th>会员套餐</th>
                                    <th>来源</th>
                                    <th>下单日期</th>
                                    <th>支付日期</th>
                                    <th>订单金额</th>
                                    <th>实付金额</th>
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
                                    <th>购买账号</th>
                                    <th>会员套餐</th>
                                    <th>来源</th>
                                    <th>下单日期</th>
                                    <th>退款日期</th>
                                    <th>退款金额</th>
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
<div class="modal fade bs-example-modal-lg" id="order-look-modal" tabindex="-1" role="dialog">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div>
                <ul id="detailTab" class="nav nav-tabs nav-tabs-inverse nav-justified nav-justified-mobile">
                    <li class="active"><a href="#detail-1" data-type="1" data-toggle="tab">订单详情</a></li>
                    <li class="refund-detail-tab">
                        <a href="#detail-2" data-type="2" data-toggle="tab">退款详情</a>
                    </li>
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

<div class="modal fade bs-example-modal-lg" id="order-look-modal-unpay" tabindex="-1" role="dialog">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span
                        aria-hidden="true">&times;</span></button>
                <h4 class="modal-title">订单详情</h4>
            </div>
            <div class="modal-body">
                <dl class="dl-horizontal" style="font-size: 15px;" id="detail-unpay">
                </dl>
            </div>
        </div>
    </div>
</div>
<div class="modal fade bs-example-modal-lg" id="order-refund-modal" tabindex="-1" role="dialog">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span
                        aria-hidden="true">&times;</span></button>
                <h4 class="modal-title">申请退款</h4>
            </div>
            <div class="modal-body">

                <form class="form-horizontal" id="order-refund-form">
                    <div class="form-group">
                        <label class="col-md-3 control-label">订单编号</label>
                        <div class="col-md-6">
                            <input type="text" class="form-control" id="refund-order-num" readonly>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-md-3 control-label">支付流水号</label>
                        <div class="col-md-6">
                            <input type="text" class="form-control" id="pay-num" readonly>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-md-3 control-label">会员套餐</label>
                        <div class="col-md-4">
                            <input type="text" class="form-control" id="vip-name" readonly>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-md-3 control-label">订单金额</label>
                        <div class="col-md-4">
                            <input type="text" class="form-control" id="order-price" readonly>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-md-3 control-label">实付金额</label>
                        <div class="col-md-4">
                            <input type="text" class="form-control" id="pay-price" readonly>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-md-3 control-label">支付方式</label>
                        <div class="col-md-4">
                            <input type="text" class="form-control" id="pay-type" readonly>
                        </div>
                    </div>
                    <hr/>
                    <div id="refund-detail">
                        <div class="form-group">
                            <label class="col-md-3 control-label">退款金额<span style="color: red">*</span></label>
                            <div class="col-md-4">
                                <input type="text" class="form-control" name="refundMoney">
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-md-3 control-label">银行名称<span style="color: red">*</span></label>
                            <div class="col-md-4">
                                <input type="text" class="form-control" name="bankName">
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-md-3 control-label">银行账户姓名<span style="color: red">*</span></label>
                            <div class="col-md-4">
                                <input type="text" class="form-control" name="bankAccountName">
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-md-3 control-label">银行卡号<span style="color: red">*</span></label>
                            <div class="col-md-4">
                                <input type="text" class="form-control" name="bankCardNum">
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-md-3 control-label">地址<span style="color: red">*</span></label>
                            <div class="col-md-3">
                                <select id="province" name="province">
                                    <option>省</option>
                                </select>
                            </div>
                            <div class="col-md-3">
                                <select id="city" name="city">
                                    <option>市</option>
                                </select>
                            </div>
                        </div>
                        <div class="form-group">
                            <div class="col-md-3"></div>
                            <div class="col-md-6">
                                    <textarea class="form-control" name="address"
                                              rows="2"></textarea>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-md-3 control-label">支行名称<span style="color: red">*</span></label>
                            <div class="col-md-4">
                                <input type="text" class="form-control" name="openAccountBankName">
                            </div>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-md-3 control-label">退款备注</label>
                        <div class="col-md-6">
                            <textarea class="form-control" id="back-remark" name="description" rows="5"
                                      maxlength="200"></textarea>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" id="refund-button" class="btn btn-primary">确认退款</button>
                        <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>

<div class="modal fade bs-example-modal-lg" id="order-track-modal" tabindex="-1" role="dialog">
    <div class="modal-dialog modal-lg" role="document">
        <div class="modal-content" style="width: 1100px">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span
                        aria-hidden="true">&times;</span></button>
                <h4 class="modal-title">购买轨迹</h4>
            </div>
            <div class="modal-body" id="track-modal-body" style="max-height:600px;overflow: auto;">
            </div>
        </div>
    </div>
</div>

<div id="button-1">
    <shiro:hasPermission name="order:find">
        <button type="button" class="btn btn-sm btn-primary" id="deleteLive" onclick="page.look('#id')">查看</button>
    </shiro:hasPermission>
</div>
<div id="button-2">
    <shiro:hasPermission name="order:refund">
        <button type="button" class="btn btn-sm btn-danger " id="modify" onclick="page.refund('#id')">申请退款</button>
    </shiro:hasPermission>
</div>
<div id="button-3">
    <shiro:hasPermission name="order:track">
        <button type="button" class="btn btn-sm btn-info " id="track" onclick="page.track('#id','#sourceChannel','#sourceInfo','#type')">购买轨迹</button>
    </shiro:hasPermission>
</div>
<script src="${pageContext.request.contextPath}/resources/assets/plugins/DataTables/media/js/jquery.dataTables.js"></script>
<script src="${pageContext.request.contextPath}/resources/assets/plugins/DataTables/media/js/dataTables.bootstrap.min.js"></script>

<script src="${pageContext.request.contextPath}/resources/assets/plugins/bootstrap-daterangepicker/moment.js"></script>
<script src="${pageContext.request.contextPath}/resources/assets/plugins/bootstrap-daterangepicker/daterangepicker.js"></script>
<script src="${pageContext.request.contextPath}/resources/common/utils/js/tool.date.js"></script>
<script src="${pageContext.request.contextPath}/resources/assets/plugins/bootstrapValidator/js/bootstrapValidator.js"></script>
<script src="${pageContext.request.contextPath}/resources/script/china_area.js"></script>
<script src="${pageContext.request.contextPath}/resources/common/layer-v2.3/layer/layer.js"></script>
<script src="${pageContext.request.contextPath}/resources/base/order/order-manager.js"></script>
<script>
    $(function () {
        page.init();
    })
</script>
</body>
</html>