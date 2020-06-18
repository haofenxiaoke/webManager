<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" contentType="text/html; UTF-8" %>
<%@include file="/WEB-INF/view/include/taglib.jsp" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>${pname}管理系统-优惠券发放管理</title>
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
        <h4 class="panel-title">优惠券发放管理</h4>
    </div>
        <div >
            <!-- Nav tabs -->
            <ul id="tabs" class="nav nav-tabs " role="tablist">
                <li><a href="#voucher-grant">发放优惠券</a></li>
                <li><a href="#voucher-grant-history">发放优惠券记录</a></li>
            </ul>
            <div class="tab-content">
                <div role="tabpanel" class="tab-pane " id="voucher-grant">
                       <div id="rootwizard">
                           <ul style=" margin-left: 15px;">
                               <li id="step-1" style="width: 49%;cursor: pointer"> <span  class="label badge-inverse">1</span><a>步骤1：选择优惠券>></a></li>
                               <li id="step-2" style="width: 50%;cursor: pointer"> <span  class="label badge-inverse">2</span><a>步骤2：选择学员>></a></li>
                           </ul>
                           <div class="tab-content">
                               <div class="tab-pane active" id="tab1">
                                   <form id="search-form" class="form-inline">
                                       <div class="form-group ">
                                           <div class="input-group">
                                               <input class="form-control" id="voucher-name" placeholder="请输入券名">
                                           </div>
                                       </div>
                                       <div class="form-group">
                                           <div class="input-group">
                                               <input readonly="readonly" class="form-control" id="voucher-create-date"
                                                      placeholder="创建时间">
                                                <%--<span class="input-group-btn">
                                                   <button id="showCreateBtn" class="btn btn-default" type="button">
                                                       <i class="fa fa-calendar"></i>
                                                   </button>
                                                </span>--%>
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
                                           <th>券名</th>
                                           <th>金额</th>
                                           <th>有效期</th>
                                           <th>使用规则</th>
                                           <th>创建人</th>
                                           <th>创建时间</th>
                                       </tr>
                                       </thead>
                                   </table>

                                   <div class="input-group col-md-offset-9">
                                       <span style="float: left;width: 80px;font-size: 14px;">券的数量</span>
                                       <div id="sub" class="input-group-addon" style="cursor: pointer">－</div>
                                       <input type="text" class="form-control"  style="text-align: center;color:black;" value="0" id="voucher-num" readonly>
                                       <div id="add" class="input-group-addon" style="cursor: pointer">＋</div>
                                       <script>
                                           $('#add').click(function () {
                                               var val = $('#voucher-num').val();
                                               if (val == 4){
                                                   $(this).hide();
                                               }
                                               $('#voucher-num').val(parseInt(val) + 1);
                                           });
                                           $('#sub').click(function () {
                                               var val = $('#voucher-num').val();
                                               if (val > 0)
                                                   $('#voucher-num').val(parseInt(val) - 1);
                                               if (val <= 5 && $('#add').css('display') == 'none' ){
                                                   $('#add').show();
                                               }
                                           });
                                       </script>
                                   </div>
                               </div>
                               <div class="tab-pane container-fluid" id="tab2">
                                   <form class="form-inline">
                                       <div class="form-group">
                                           <label style="font-family: '微软雅黑';" for="username">账号</label>
                                           <input type="text" class="form-control" id="username" placeholder="请输入账号">
                                       </div>
                                       <button type="button" id="add-stu-btn" class="btn btn-primary">确定</button>
                                   </form>
                                   <hr/>
                                   <div class="row">
                                       <p style="margin-left: 10px;">已选学员<span id="selected-count">0</span>人</p>
                                       <div class="col-md-5">
                                           <table  id="stu-table" class="table table-hover table-condensed">
                                               <tr class="">
                                                   <th>昵称</th>
                                                   <th>账号</th>
                                                   <th>操作</th>
                                               </tr>
                                           </table>
                                       </div>
                                   </div>
                               </div>
                               <ul class="pager wizard">
                                   <li style="float:left"> <button id="previous" class="btn btn-primary" disabled>上一步</button></li>
                                   <li style="float:right" > <button id="next" class="btn btn-primary" >下一步</button></li>
                                   <li id="grant-li" style="float:right;display: none" > <button id="grant-btn" class="btn btn-primary" disabled >确认发放</button></li>
                               </ul>
                           </div>
                       </div>
                </div>
                <div role="tabpanel" class="tab-pane " id="voucher-grant-history">
                    <form id="search-form-2" class="form-inline">
                        <div class="form-group ">
                            <div class="input-group">
                                <input class="form-control" id="voucher-name-2" placeholder="请输入券名">
                            </div>
                        </div>
                        <div class="form-group ">
                            <div class="input-group">
                                <input readonly="readonly" class="form-control" id="voucher-create-date-2"
                                       placeholder="创建时间">
                                <%--<span class="input-group-btn">
                                   <button id="showCreateBtn-2" class="btn btn-default" type="button">
                                       <i class="fa fa-calendar"></i>
                                   </button>
                                </span>--%>
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
                                <input class="form-control" id="stu-username" placeholder="请输入学员账号">
                            </div>
                        </div>
                        <div class="form-group ">
                            <div class="input-group">
                                <input class="form-control" id="grant-username" placeholder="请输入发放人账号">
                            </div>
                        </div>
                        <shiro:hasPermission name="voucher-grant:search">
                            <button type="button" class="btn btn-sm btn-primary" id="search-2">搜索</button>
                            <button type="button" class="btn btn-sm btn-message" id="reset-search" onclick="$('#search-form-2')[0].reset();">重置</button>
                        </shiro:hasPermission>
                    </form>
                    <hr>
                    <table id="voucher-table-2" class="table table-striped table-bordered" width="100%">
                        <thead>
                        <tr>
                            <th></th>
                            <th>券名</th>
                            <th>金额</th>
                            <th>使用规则</th>
                            <th>券号</th>
                            <th>学员</th>
                            <th>使用状态</th>
                            <th>发放人</th>
                            <th>发放时间</th>
                            <th>操作</th>
                        </tr>
                        </thead>
                    </table>
                </div>
            </div>
    </div>
</div>

<!-- Modal -->
<div class="modal fade bs-example-modal-lg" id="voucher-grant-detail-modal" tabindex="-1" role="dialog">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" >优惠券发放详情</h4>
            </div>
            <div class="modal-body">
                <dl class="dl-horizontal" style="font-size: 15px;" id="voucher-grant-detail-dl">
                </dl>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-primary" data-dismiss="modal">关闭</button>
            </div>
        </div>
    </div>
</div>

<div id="button-1" style="display: none">
    <shiro:hasPermission name="voucher-grant:detail">
        <button type="button" class="btn btn-sm btn-primary" id="look-btn" onclick="page.detail('#id')">查看详情</button>
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
<script src="${pageContext.request.contextPath}/resources/assets/js/jquery.bootstrap.wizard.js"></script>
<script src="${pageContext.request.contextPath}/resources/base/operation/voucher-grant.js"></script>
<script>
    $(function () {
        page.init();
    });
</script>
</body>
</html>