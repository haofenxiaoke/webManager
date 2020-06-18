<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" contentType="text/html; UTF-8" %>
<%@include file="/WEB-INF/view/include/taglib.jsp" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>${pname}管理系统-意见反馈</title>
    <link href="${pageContext.request.contextPath}/resources/assets/plugins/bootstrap-daterangepicker/daterangepicker-bs3.css" rel="stylesheet"/>
    <link href="${path}/resources/assets/plugins/bootstrapValidator/css/bootstrapValidator.css" rel="stylesheet">
    <style>
        .list-group-item-text {word-break: break-all}
    </style>
</head>

<body>
<div class="panel panel-inverse">
    <div class="panel-heading">
        <div class="panel-heading-btn">
        </div>
        <h4 class="panel-title">老师答疑</h4>
    </div>
    <div class="panel-body">
        <div class="container-fluid">
            <div class="row">
                <button class="btn btn-primary" type="button">
                    今日新增 <span class="badge" id="today-add">0</span>
                </button>
                <button class="btn btn-info" type="button">
                    未回答 <span class="badge" id="unreply">0</span>
                </button>

            </div>
            <hr>
            <form  id="search-form" class="form-inline">
                <div class="form-group ">
                    <select id="cate-select" class="form-control">
                        <option value="">--方向--</option>
                    </select>
                    <select id="course-select" class="form-control">
                        <option value="">--课程--</option>
                    </select>
                    <select id="lecture-select" class="form-control">
                        <option value="">--节--</option>
                    </select>
                </div>
                <div class="form-group ">
                    <select id="reply-status" class="form-control">
                        <option value="">--回答状态--</option>
                        <option value="1">已回答</option>
                        <option value="0">未回答</option>
                    </select>
                </div>
                <div class="form-group ">
                    <div class="input-group">
                        <input  class="form-control" placeholder="请输入内容" id="search-content"/>
                    </div>
                </div> <div class="form-group ">
                <div class="input-group">
                    <input readonly="readonly" class="form-control" id="submit-date"
                           placeholder="提问日期">
                        <%--<span class="input-group-btn">
                           <button id="showCreateBtn" class="btn btn-default" type="button">
                               <i class="fa fa-calendar"></i>
                           </button>
                        </span>--%>
                </div>
            </div>
                <shiro:hasPermission name="question:find">
                    <button type="button" class="btn btn-sm btn-primary" id="search">搜索</button>
                    <button type="button" class="btn btn-sm btn-info" id="search-reset">清空条件</button>
                </shiro:hasPermission>
                <shiro:hasPermission name="question:export">
                    <a class="btn btn-sm btn-primary" id="export" onclick="page.export(this);" download="${pname}管理系统-老师答疑.csv" href="#">导出数据</a>
                </shiro:hasPermission>
            </form>
            <hr>
            <table id="question-table" class="table table-striped table-bordered" width="100%">
                <thead>
                <tr>
                    <th></th>
                    <th>学员账号</th>
                    <th>昵称</th>
                    <th>内容</th>
                    <th>课程</th>
                    <th>节</th>
                    <th>提问日期</th>
                    <th>回答状态</th>
                    <th>操作</th>
                </tr>
                </thead>
            </table>
        </div>
    </div>
</div>


<!-- Modal -->
<div class="modal fade bs-example-modal-lg" id="question-reply-modal" tabindex="-1" role="dialog">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" >问答信息</h4>
            </div>
            <div class="modal-body">
                <div class="list-group" id="question-list">
                </div>
                <form id="question-reply-form" class="form-horizontal">
                    <div class="form-group ">
                        <div class="col-md-12">
                               <textarea  id="reply-content" name="replyContent" class="form-control " rows="6"></textarea>
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <shiro:hasPermission name="question:reply">
                    <button type="button" id="question-reply-btn" class="btn btn-primary" >回复</button>
                </shiro:hasPermission>
            </div>
        </div>
    </div>
</div>

<div id="button-1" style="display: none">
    <shiro:hasPermission name="question:find">
        <button type="button" class="btn btn-sm btn-primary" id="look-btn" onclick="page.look('#id')">查看</button>
    </shiro:hasPermission>
</div>
<div id="button-2" style="display: none">
    <shiro:hasPermission name="question:delete">
        <button type="button" class="btn btn-sm btn-danger " id="delete-btn" onclick="page.delete('#id')">删除</button>
    </shiro:hasPermission>
</div>

<script src="${pageContext.request.contextPath}/resources/assets/plugins/DataTables/media/js/jquery.dataTables.js"></script>
<script src="${pageContext.request.contextPath}/resources/assets/plugins/DataTables/media/js/dataTables.bootstrap.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/assets/plugins/bootstrap-daterangepicker/moment.js"></script>
<script src="${pageContext.request.contextPath}/resources/assets/plugins/bootstrap-daterangepicker/daterangepicker.js"></script>
<script src="${pageContext.request.contextPath}/resources/common/utils/js/tool.date.js"></script>
<script src="${pageContext.request.contextPath}/resources/assets/plugins/bootstrapValidator/js/bootstrapValidator.js"></script>
<script src="${pageContext.request.contextPath}/resources/base/operation/question.js"></script>
<script src="${pageContext.request.contextPath}/resources/common/layer-v2.3/layer/layer.js"></script>
<script>
    $(function () {
        page.init();
    })
</script>
</body>
</html>