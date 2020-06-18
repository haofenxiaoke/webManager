<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" contentType="text/html; UTF-8" %>
<%@include file="/WEB-INF/view/include/taglib.jsp" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>${pname}管理系统-券/码模板管理</title>
    <link href="${pageContext.request.contextPath}/resources/assets/plugins/bootstrap-daterangepicker/daterangepicker-bs3.css" rel="stylesheet"/>
    <link href="${pageContext.request.contextPath}/resources/assets/plugins/bootstrap-datetimepicker/css/datetimepicker.css" rel="stylesheet"/>
    <link href="${path}/resources/assets/plugins/bootstrapValidator/css/bootstrapValidator.css" rel="stylesheet">
    <style>.datetimepicker-minutes{height: 340px;  overflow: auto; width: 170px;}</style>
</head>

<body>

<div class="panel panel-inverse">
    <div class="panel-heading">
        <h4 class="panel-title">券/码模板管理</h4>
    </div>
    <div>
                <!-- Nav tabs -->
                <ul id="tabs" class="nav nav-tabs" role="tablist">
                      <li><a href="#template-list-voucher" data-type="1" data-toggle="tab">优惠券模板</a></li>
                      <li><a href="#template-list-reduce-code" data-type="2" data-toggle="tab">优惠码模板</a></li>
                </ul>
                <!-- Tab panes -->
                <div class="tab-content">
                    <form  id="search-form" class="form-inline">
                        <div class="form-group ">
                            <div class="input-group">
                                <input class="form-control" id="voucher-name" placeholder="请输入券名">
                            </div>
                        </div>
                        <div class="form-group ">
                            <div class="input-group">
                                <input readonly="readonly" class="form-control" id="voucher-create-date"
                                       placeholder="创建时间">
                            </div>
                        </div>
                        <shiro:hasPermission name="voucher:find">
                            <button type="button" class="btn btn-sm btn-primary" id="search">搜索</button>
                        </shiro:hasPermission>
                        <shiro:hasPermission name="voucher:save">
                            <button type="button" id="create-model-btn" class="btn btn-sm btn-primary pull-right"  >创建优惠券</button>
                        </shiro:hasPermission>
                    </form>
                    <div role="tabpanel" class="tab-pane " id="template-list-voucher">
                        <div class="panel panel-default">

                            <hr>
                            <table id="data-table-1" class="table table-striped table-bordered" width="100%">
                                <thead>
                                <tr>
                                    <th></th>
                                    <th>券名</th>
                                    <th>金额</th>
                                    <th>有效期</th>
                                    <th>使用规则</th>
                                    <th>创建人</th>
                                    <th>创建时间</th>
                                    <th>操作</th>
                                </tr>
                                </thead>
                            </table>
                        </div>
                    </div>
                    <div role="tabpanel" class="tab-pane " id="template-list-reduce-code">
                        <div class="panel panel-default">
                            <hr>
                            <table id="data-table-2" class="table table-striped table-bordered" width="100%">
                                <thead>
                                <tr>
                                    <th></th>
                                    <th>优惠码名字</th>
                                    <th>金额</th>
                                    <th>有效期</th>
                                    <th>使用规则</th>
                                    <th>创建人</th>
                                    <th>创建时间</th>
                                    <th>操作</th>
                                </tr>
                                </thead>
                            </table>
                        </div>
                    </div>
                </div>
    </div>
</div>


<!-- Modal -->
<div class="modal fade bs-example-modal-lg" id="create-voucher-modal" tabindex="-1" role="dialog">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" >创建优惠券</h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal" id="create-voucher-form">
                    <div class="form-group">
                        <label  class="col-md-2 control-label"><span id="name-label">券名</span><span style="color: red">*</span></label>
                        <div class="col-md-4">
                            <input type="text" class="form-control"  name="name" >
                        </div>
                    </div>
                    <div class="form-group">
                        <label  class="col-md-2 control-label">金额<span style="color: red">*</span></label>
                        <div class="col-md-4">
                            <input type="text" class="form-control"  name="price" id="voucher-price">
                        </div>
                    </div>

                    <div class="form-group">
                        <label  class="col-md-2 control-label">有效期<span style="color: red">*</span></label>
                        <div class="col-md-4">
                            <select class="form-control" id="voucher-deadline" name="deadline">
                                <option value="" selected>请选择</option>
                                <option value="1">1天</option>
                                <option value="7">7天</option>
                                <option value="30">1个月</option>
                                <option value="90">3个月</option>
                                <option value="180">6个月</option>
                                <option value="365">1年</option>
                            </select>
                        </div>
                    </div>

                    <div class="form-group">
                        <label  class="col-md-2 control-label">使用规则<span style="color: red">*</span></label>
                        <div class="col-md-9">
                            <label class="checkbox-inline">
                                <input type="checkbox" name="regulation" id="inlineCheckbox30" value="30" disabled  title="请先填写金额"> 可购月会员
                            </label>
                            <label class="checkbox-inline">
                                <input type="checkbox" name="regulation" id="inlineCheckbox90" value="90" disabled title="请先填写金额"> 可购季会员
                            </label>
                            <label class="checkbox-inline">
                                <input type="checkbox" name="regulation" id="inlineCheckbox360" value="360" disabled title="请先填写金额"> 可购年会员
                            </label>
                        </div>
                    </div>

                    <div class="form-group">
                        <label  class="col-md-2 control-label">备注</label>
                        <div class="col-md-9">
                            <textarea id="msg-content" class="form-control"   rows="6" name="description"></textarea>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" id="create-voucher-btn" class="btn btn-primary" >保存</button>
                        <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>
<div id="button-1" style="display: none">
    <shiro:hasPermission name="voucher:update">
        <button type="button" class="btn btn-sm btn-primary" id="look-btn" onclick="page.modifyVoucher('#id')">修改</button>
    </shiro:hasPermission>
</div>
<div id="button-2" style="display: none">
    <shiro:hasPermission name="voucher:lock">
        <button type="button" class="btn btn-sm btn-danger " id="delete-btn" onclick="page.lock('#id',1)">锁定</button>
    </shiro:hasPermission>
</div>
<div id="button-3" style="display: none">
    <shiro:hasPermission name="voucher:lock">
        <button type="button" class="btn btn-sm btn-danger " id="delete-btn" onclick="page.lock('#id',0)">解锁</button>
    </shiro:hasPermission>
</div>

<script src="${pageContext.request.contextPath}/resources/assets/plugins/DataTables/media/js/jquery.dataTables.js"></script>
<script src="${pageContext.request.contextPath}/resources/assets/plugins/DataTables/media/js/dataTables.bootstrap.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/assets/plugins/bootstrap-daterangepicker/moment.js"></script>
<script src="${pageContext.request.contextPath}/resources/assets/plugins/bootstrap-daterangepicker/daterangepicker.js"></script>
<script src="${pageContext.request.contextPath}/resources/assets/plugins/bootstrap-datetimepicker/js/bootstrap-datetimepicker.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/assets/plugins/bootstrap-datetimepicker/js/locales/bootstrap-datetimepicker.zh-CN.js" charset="UTF-8"></script>
<script src="${pageContext.request.contextPath}/resources/common/utils/js/tool.date.js"></script>
<script src="${pageContext.request.contextPath}/resources/assets/plugins/bootstrapValidator/js/bootstrapValidator.js"></script>
<script src="${pageContext.request.contextPath}/resources/base/operation/voucher.js"></script>
<script>
    $(function () {
        page.init();
    })
</script>
</body>
</html>