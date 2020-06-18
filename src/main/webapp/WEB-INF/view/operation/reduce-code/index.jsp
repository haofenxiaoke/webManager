<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" contentType="text/html; UTF-8" %>
<%@include file="/WEB-INF/view/include/taglib.jsp" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>${pname}管理系统-优惠码生成管理</title>
    <link href="${pageContext.request.contextPath}/resources/assets/plugins/bootstrap-daterangepicker/daterangepicker-bs3.css"
          rel="stylesheet"/>
    <link href="${pageContext.request.contextPath}/resources/assets/plugins/bootstrap-datetimepicker/css/datetimepicker.css"
          rel="stylesheet"/>
    <link href="${path}/resources/assets/plugins/bootstrapValidator/css/bootstrapValidator.css" rel="stylesheet">
    <link href="${path}/resources/assets/plugins/bootstrap-wizard/css/bwizard.min.css" rel="stylesheet"/>
    <style>
        .datetimepicker-minutes {
        height: 340px;
        overflow: auto;
        width: 170px;
        }
        .nav-pills>li.active>a, .nav-pills>li.active>a:focus, .nav-pills>li.active>a:hover {
            background: #c1ccd1;
        }
    </style>
</head>

<body>

<div class="panel panel-inverse">
    <div class="panel-heading">
        <h4 class="panel-title">优惠码生成管理</h4>
    </div>
        <div >
            <!-- Nav tabs -->
            <ul id="tabs" class="nav nav-tabs " role="tablist">
                <li><a href="#voucher-grant">生成优惠码</a></li>
                <li><a href="#voucher-grant-history">优惠码生成记录</a></li>
            </ul>
            <div class="tab-content">
                <div role="tabpanel" class="tab-pane " id="voucher-grant">
                           <div class="tab-content">
                               <div class="tab-pane active" id="tab1">
                                   <form id="search-form" class="form-inline">
                                       <div class="form-group ">
                                           <div class="input-group">
                                               <input class="form-control" id="voucher-name" placeholder="请输入优惠码名字">
                                           </div>
                                       </div>
                                       <div class="form-group">
                                           <div class="input-group">
                                               <input readonly="readonly" class="form-control" id="voucher-create-date"
                                                      placeholder="创建时间">
                                           </div>
                                       </div>
                                       <shiro:hasPermission name="voucher-grant:search">
                                           <button type="button" class="btn btn-sm btn-primary" id="search">搜索</button>
                                       </shiro:hasPermission>
                                   </form>
                                   <hr>
                                   <table id="feedback-table" class="table table-striped table-bordered" width="100%">
                                       <thead>
                                       <tr>
                                           <th></th>
                                           <th>选择</th>
                                           <th>优惠码名字</th>
                                           <th>金额</th>
                                           <th>有效期</th>
                                           <th>使用规则</th>
                                           <th>创建人</th>
                                           <th>创建时间</th>
                                       </tr>
                                       </thead>
                                   </table>
                                   <form class="form-inline" style="float: right">
                                       <div class="form-group">
                                           <label for="count">生成优惠码的数量<span style="color: red;">*</span></label>
                                           <input type="number" class="form-control" id="count" value="1" placeholder="不能超过100">
                                       </div>
                                       <button type="button" class="btn btn-primary " id="generate-btn" >确认生成</button>
                                   </form>
                               </div>
                           </div>
                </div>
                <div role="tabpanel" class="tab-pane " id="voucher-grant-history">
                    <form id="search-form-2" class="form-inline">
                        <div class="form-group ">
                            <div class="input-group">
                                <input class="form-control" id="voucher-name-2" placeholder="请输入优惠码名字">
                            </div>
                        </div>
                        <div class="form-group ">
                            <div class="input-group">
                               <select class="form-control" id="used-select">
                                   <option value="" selected>使用状态</option>
                                   <option value="0" >未使用</option>
                                   <option value="1" >已使用</option>
                               </select>
                            </div>
                        </div>
                        <div class="form-group ">
                            <div class="input-group">
                                <input readonly="readonly" class="form-control" id="voucher-create-date-2"
                                       placeholder="生成时间">
                            </div>
                        </div>
                        <div class="form-group ">
                            <div class="input-group">
                                <input class="form-control" id="stu-username" placeholder="请输入学员账号">
                            </div>
                        </div>
                        <div class="form-group ">
                            <div class="input-group">
                                <input class="form-control" id="grant-username" placeholder="请输入创建人账号">
                            </div>
                        </div>
                        <shiro:hasPermission name="voucher-grant:search">
                            <button type="button" class="btn btn-sm btn-primary" id="search-2">搜索</button>
                            <button type="button" class="btn btn-sm btn-message" id="reset-search" onclick="$('#search-form-2')[0].reset();">重置</button>
                        </shiro:hasPermission>
                        <a class="btn btn-sm btn-primary" id="batch-export-btn" download="批量导出.csv" href="#">批量导出</a>
                    </form>
                    <hr>
                    <table id="voucher-table-2" class="table table-striped table-bordered" width="100%">
                        <thead>
                        <tr>
                            <th></th>
                            <th>优惠码名字</th>
                            <th>金额</th>
                            <th>使用规则</th>
                            <th>码号</th>
                            <th>学员</th>
                            <th>使用状态</th>
                            <th>创建人</th>
                            <th>生成时间</th>
                        </tr>
                        </thead>
                    </table>
                </div>
            </div>
    </div>
</div>

<!-- Modal -->
<div class="modal fade bs-example-modal-sm" id="code-generate-success-modal" tabindex="-1" role="dialog">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="row" ></h4>
            </div>
            <div class="modal-body" style="text-align: center">
                <div class="row">
                    <img src="/resources/images/08cac75a-e0e9-4044-880c-127a3587227c.png">
                </div>
                <div class="row">
                    <h3>发放成功</h3>
                <div class="row" style="font-size: 15px;margin: 18px 0px;">
                    <p style="color:#E4E4E4 ">—————————————— <span style="color: #666">猜你需要</span> ——————————————</p>
                </div>
                <a class="btn btn-primary" id="export-btn" download="猜你需要.csv" href="#">批量导出</a>
            </div>
        </div>
    </div>
</div>
<script src="${pageContext.request.contextPath}/resources/assets/plugins/DataTables/media/js/jquery.dataTables.js"></script>
<script src="${pageContext.request.contextPath}/resources/assets/plugins/DataTables/media/js/dataTables.bootstrap.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/assets/plugins/bootstrap-daterangepicker/moment.js"></script>
<script src="${pageContext.request.contextPath}/resources/assets/plugins/bootstrap-daterangepicker/daterangepicker.js"></script>
<script src="${pageContext.request.contextPath}/resources/assets/plugins/bootstrap-datetimepicker/js/bootstrap-datetimepicker.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/assets/plugins/bootstrap-datetimepicker/js/locales/bootstrap-datetimepicker.zh-CN.js" charset="UTF-8"></script>
<script src="${pageContext.request.contextPath}/resources/common/utils/js/tool.date.js"></script>
<script src="${pageContext.request.contextPath}/resources/assets/plugins/bootstrapValidator/js/bootstrapValidator.js"></script>
<script src="${pageContext.request.contextPath}/resources/assets/js/jquery.bootstrap.wizard.js"></script>
<script src="${pageContext.request.contextPath}/resources/base/operation/reduce-code.js"></script>
<script>
    $(function () {
        page.init();
    });
</script>
</body>
</html>