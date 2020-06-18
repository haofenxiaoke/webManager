<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" contentType="text/html; UTF-8" %>
<%@include file="/WEB-INF/view/include/taglib.jsp" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>${pname}管理系统-意见反馈</title>
    <link href="${pageContext.request.contextPath}/resources/assets/plugins/bootstrap-daterangepicker/daterangepicker-bs3.css" rel="stylesheet"/>
    <link href="${path}/resources/assets/plugins/bootstrapValidator/css/bootstrapValidator.css" rel="stylesheet">
    <style>
        .word-break {word-break: break-all}
    </style>
</head>

<body>
<div class="panel panel-inverse">
    <div class="panel-heading">
        <h4 class="panel-title">意见反馈</h4>
    </div>
    <div class="panel-body">
        <div class="container-fluid">
            <form  id="search-form" class="form-inline">
                <div class="form-group ">
                    <select id="reply-status" class="form-control">
                        <option value="">所有状态</option>
                        <option value="1">已回复</option>
                        <option value="0">未回复</option>
                    </select>
                </div>
                <div class="form-group ">
                    <div class="input-group">
                        <input readonly="readonly" class="form-control" id="feedback-date"
                               placeholder="反馈日期">
                        <%--<span class="input-group-btn">
                           <button id="showCreateBtn" class="btn btn-default" type="button">
                               <i class="fa fa-calendar"></i>
                           </button>
                        </span>--%>
                    </div>
                </div>
                <shiro:hasPermission name="feedback:find">
                    <button type="button" class="btn btn-sm btn-primary" id="search">搜索</button>
                </shiro:hasPermission>
            </form>
            <hr>
            <table id="feedback-table" class="table table-striped table-bordered" width="100%">
                <thead>
                <tr>
                    <th></th>
                    <th>学员账号</th>
                    <th>昵称</th>
                    <th>内容</th>
                    <th>状态</th>
                    <th>反馈日期</th>
                    <th>联系方式</th>
                    <th>操作</th>
                </tr>
                </thead>
            </table>
        </div>
    </div>
</div>
<!-- Modal -->
<div class="modal fade bs-example-modal-lg" id="feedback-reply-modal" tabindex="-1" role="dialog">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" >意见回复</h4>
            </div>
            <div class="modal-body">
                <form id="feedback-reply-form" class="form-horizontal">
                    <div class="form-group ">
                        <div class="col-md-12">
                               <textarea  id="reply-content" name="replyContent" class="form-control " rows="6"></textarea>
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" id="feedback-reply-btn" class="btn btn-primary" >回复</button>
            </div>
        </div>
    </div>
</div>
<div class="modal fade bs-example-modal-lg" id="feedback-look-modal" tabindex="-1" role="dialog">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" >反馈查看</h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal" id="order-refund-form">
                    <div class="form-group">
                        <label  class="col-md-2 control-label">回复人</label>
                        <div class="col-md-4">
                            <input type="text" class="form-control" id="reply-person" readonly>
                        </div>
                    </div>
                    <div class="form-group">
                        <label  class="col-md-2 control-label">回复日期</label>
                        <div class="col-md-4">
                            <input type="text" class="form-control" id="reply-date" readonly>
                        </div>
                    </div>
                    <div class="form-group">
                        <label  class="col-md-2 control-label">回复内容</label>
                        <div class="col-md-9">
                            <textarea   id="reply-content-2" class="form-control" readonly  rows="6" ></textarea>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>


<div id="button-1" style="display: none">
    <shiro:hasPermission name="feedback:find">
        <button type="button" class="btn btn-sm btn-primary" id="look-btn" onclick="page.look('#id')">查看</button>
    </shiro:hasPermission>
</div>
<div id="button-2" style="display: none">
    <shiro:hasPermission name="feedback:reply">
        <button type="button" class="btn btn-sm btn-primary " id="reply-btn" onclick="page.reply('#id')">回复</button>
    </shiro:hasPermission>
</div>
<div id="button-3" style="display: none">
    <shiro:hasPermission name="feedback:delete">
        <button type="button" class="btn btn-sm btn-danger " id="delete-btn" onclick="page.delete('#id')">删除</button>
    </shiro:hasPermission>
</div>

<script src="${pageContext.request.contextPath}/resources/assets/plugins/DataTables/media/js/jquery.dataTables.js"></script>
<script src="${pageContext.request.contextPath}/resources/assets/plugins/DataTables/media/js/dataTables.bootstrap.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/assets/plugins/bootstrap-daterangepicker/moment.js"></script>
<script src="${pageContext.request.contextPath}/resources/assets/plugins/bootstrap-daterangepicker/daterangepicker.js"></script>
<script src="${pageContext.request.contextPath}/resources/common/utils/js/tool.date.js"></script>
<script src="${pageContext.request.contextPath}/resources/assets/plugins/bootstrapValidator/js/bootstrapValidator.js"></script>
<script src="${pageContext.request.contextPath}/resources/base/operation/feedback.js"></script>
<script>
    $(function () {
        page.init();
    })
</script>
</body>
</html>