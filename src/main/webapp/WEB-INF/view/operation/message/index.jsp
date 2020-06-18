<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" contentType="text/html; UTF-8" %>
<%@include file="/WEB-INF/view/include/taglib.jsp" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>${pname}管理系统-系统消息</title>
    <link href="${pageContext.request.contextPath}/resources/assets/plugins/bootstrap-daterangepicker/daterangepicker-bs3.css" rel="stylesheet"/>
    <link href="${path}/resources/assets/plugins/bootstrapValidator/css/bootstrapValidator.css" rel="stylesheet">
</head>

<body>
<div class="panel panel-inverse">
    <div class="panel-heading">
        <h4 class="panel-title">系统消息</h4>
    </div>
    <div class="panel-body">
        <div class="container-fluid">

            <form  id="search-form" class="form-inline">
                <div class="form-group ">
                    <select id="send-object" class="form-control">
                        <option value="">所有学员</option>
                        <option value="1">付费学员</option>
                        <option value="0">免费学员</option>
                    </select>
                </div>
                <div class="form-group ">
                    <div class="input-group">
                        <input readonly="readonly" class="form-control" id="send-date"
                               placeholder="发送时间">
                        <%--<span class="input-group-btn">
                           <button id="showCreateBtn" class="btn btn-default" type="button">
                               <i class="fa fa-calendar"></i>
                           </button>
                        </span>--%>
                    </div>
                </div>
                <shiro:hasPermission name="message:find">
                    <button type="button" class="btn btn-sm btn-primary" id="search">搜索</button>
                </shiro:hasPermission>
                <shiro:hasPermission name="message:send">
                    <button type="button" id="send-modal-bth" class="btn btn-sm btn-primary col-md-offset pull-right"  >发送消息</button>
                </shiro:hasPermission>
            </form>
            <hr>
            <table id="feedback-table" class="table table-striped table-bordered" width="100%">
                <thead>
                <tr>
                    <th></th>
                    <th>标题</th>
                    <th>发送对象</th>
                    <th>发送日期</th>
                    <th>发送人</th>
                    <th>操作</th>
                </tr>
                </thead>
            </table>
        </div>
    </div>
</div>



<!-- Modal -->
<div class="modal fade bs-example-modal-lg" id="send-msg-modal" tabindex="-1" role="dialog">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" >发送消息</h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal" id="send-msg-form">
                    <div class="form-group">
                        <label  class="col-md-2 control-label">发送对象</label>
                        <div class="col-md-4">
                           <select class="form-control" id="send-object-select">
                                <option value="1">付费学员</option>
                                <option value="0">免费学员</option>
                           </select>
                        </div>
                    </div>
                    <div class="form-group">
                        <label  class="col-md-2 control-label">标题</label>
                        <div class="col-md-9">
                            <input type="text" class="form-control" id="msg-title" name="msgTitle" >
                        </div>
                    </div>
                    <div class="form-group">
                        <label  class="col-md-2 control-label">内容</label>
                        <div class="col-md-9">
                            <textarea   id="msg-content" class="form-control"   rows="6" name="msgContent"></textarea>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" id="send-btn" class="btn btn-primary" >发送</button>
                        <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>
<div class="modal fade bs-example-modal-lg" id="look-msg-modal" tabindex="-1" role="dialog">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" >查看消息</h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal" >
                    <div class="form-group">
                        <label  class="col-md-2 control-label">发送对象</label>
                        <div class="col-md-4">
                               <input type="text" class="form-control" id="send-object-look" readonly>
                        </div>
                    </div>
                    <div class="form-group">
                        <label  class="col-md-2 control-label">标题</label>
                        <div class="col-md-9">
                            <input type="text" class="form-control" id="msg-title-look" readonly>
                        </div>
                    </div>
                    <div class="form-group">
                        <label  class="col-md-2 control-label">内容</label>
                        <div class="col-md-9">
                            <textarea   id="msg-content-look" class="form-control"   rows="6" readonly></textarea>
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
    <shiro:hasPermission name="message:find">
        <button type="button" class="btn btn-sm btn-primary" id="look-btn" onclick="page.look('#id')">查看</button>
    </shiro:hasPermission>
</div>
<div id="button-2" style="display: none">
    <shiro:hasPermission name="message:delete">
        <button type="button" class="btn btn-sm btn-danger " id="delete-btn" onclick="page.delete('#id')">删除</button>
    </shiro:hasPermission>
</div>

<script src="${pageContext.request.contextPath}/resources/assets/plugins/DataTables/media/js/jquery.dataTables.js"></script>
<script src="${pageContext.request.contextPath}/resources/assets/plugins/DataTables/media/js/dataTables.bootstrap.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/assets/plugins/bootstrap-daterangepicker/moment.js"></script>
<script src="${pageContext.request.contextPath}/resources/assets/plugins/bootstrap-daterangepicker/daterangepicker.js"></script>
<script src="${pageContext.request.contextPath}/resources/common/utils/js/tool.date.js"></script>
<script src="${pageContext.request.contextPath}/resources/assets/plugins/bootstrapValidator/js/bootstrapValidator.js"></script>
<script src="${pageContext.request.contextPath}/resources/base/operation/message.js"></script>
<script>
    $(function () {
        page.init();
    })
</script>
</body>
</html>