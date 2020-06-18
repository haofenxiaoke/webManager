<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" contentType="text/html; UTF-8" %>
<%@include file="/WEB-INF/view/include/taglib.jsp" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>${pname}管理系统-直播管理</title>
    <link href="${pageContext.request.contextPath}/resources/assets/plugins/bootstrap-daterangepicker/daterangepicker-bs3.css" rel="stylesheet"/>
    <link href="${pageContext.request.contextPath}/resources/assets/plugins/bootstrap-datetimepicker/css/datetimepicker.css" rel="stylesheet"/>
    <link href="${path}/resources/assets/plugins/bootstrapValidator/css/bootstrapValidator.css" rel="stylesheet">
    <link href="${path}/resources/assets/plugins/jquery-file-upload/css/jquery.fileupload.css" rel="stylesheet">
    <style>
        .datetimepicker-minutes{height: 340px;  overflow: auto; width: 170px;}
    </style>
</head>

<body>

<div class="panel panel-inverse">
    <div class="panel-heading">
        <h4 class="panel-title">${titleName}</h4>
    </div>
    <div>
        <div class="container-fluid">
            <div class="row">
                <!-- Nav tabs -->
                <ul id="tabs" class="nav nav-tabs" role="tablist">
                    <li><a href="#live-info" data-type="unoverdue" data-toggle="tab">未过期</a></li>
                    <li><a href="#live-info" data-type="overdue" data-toggle="tab">已过期</a></li>
                </ul>
                <!-- Tab panes -->
                <div class="tab-content">
                    <div role="tabpanel" class="tab-pane " id="live-info">
                        <form id="search-form" class="form-inline">
                            <div class="form-group ">
                                <input type="hidden" id="liveType" name="liveType" value="${liveType}">
                            </div>
                            <div class="form-group ">
                                <select class="form-control" id="cate-select-find">
                                    <option value="">选择学院</option>
                                </select>
                            </div>
                            <div class="form-group ">
                                <div class="input-group">
                                    <input readonly="readonly" class="form-control" id="open-course-date" placeholder="选择开课日期">
                                </div>
                            </div>
                            <div class="form-group ">
                                <input type="text" class="form-control" id="courseName" placeholder="请输入课程名"/>
                            </div>
                            <c:if test="${liveType==0}">
                                <shiro:hasPermission name="live:find">
                                    <button type="button" class="btn btn-sm btn-primary" id="search">搜索</button>
                                </shiro:hasPermission>
                                <shiro:hasPermission name="live:save">
                                    <button type="button" id="createCourse" class="btn btn-sm btn-info pull-right"  >创建${titleName} </button>
                                </shiro:hasPermission>
                            </c:if>
                            <c:if test="${liveType==1}">
                                <shiro:hasPermission name="liveOpen:find">
                                    <button type="button" class="btn btn-sm btn-primary" id="search">搜索</button>
                                </shiro:hasPermission>
                                <shiro:hasPermission name="liveOpen:save">
                                    <button type="button" id="createCourse" class="btn btn-sm btn-info pull-right"  >创建${titleName} </button>
                                </shiro:hasPermission>
                            </c:if>
                        </form>
                        <hr/>
                            <table id="live-table" class="table table-striped table-bordered" width="100%">
                                <thead>
                                <tr>
                                    <th></th>
                                    <th>课程名称</th>
                                    <th>学院</th>
                                    <th>日期</th>
                                    <th>是否有录播ID</th>
                                    <th>时间</th>
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

<!-- Modal -->
<div class="modal fade bs-example-modal-lg" id="course-detail-modal" tabindex="-1" role="dialog">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" >创建直播公开课</h4>
            </div>
            <div class="modal-body">

                <form class="form-horizontal" id="course-detail-form">
                    <div class="form-group">
                        <label  class="col-md-2 control-label">直播ID</label>
                        <div class="col-md-4">
                            <input type="text" class="form-control" id="live-id" name="liveId">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-md-2 control-label">学院</label>
                        <div class="col-md-4">
                            <select class="form-control" id="cate-select-save" name="direction">
                                <option value="">请选择学院</option>
                            </select>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-md-2 control-label">上课日期</label>
                        <div   class="col-md-3"  >
                            <input class="form-control"  type="text" id="course-date" name="courseDate" data-date-format="yyyy-mm-dd" readonly/>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-md-2 control-label">上课时间</label>
                        <div class="col-md-2">
                            <input   type="text" class="form-control" id="course-start-time" name="liveStart" data-date-format="hh:ii"  readonly>
                        </div>
                        <label class="col-md-1 control-label">-</label>
                        <div class="col-md-2">
                            <input type="text" class="form-control" id="course-end-time" name="liveEnd" data-date-format="hh:ii" readonly>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-md-2 control-label">老师姓名</label>
                        <div class="col-md-4">
                            <select class="form-control" id="teacher-name" name="teacherName">
                                <option value="">选择老师</option>
                            </select>
                        </div>
                    </div>

                    <div class="form-group">
                        <label  class="col-md-2 control-label">课程名称</label>
                        <div class="col-md-4">
                            <input type="text" class="form-control" id="course-name" name="courseName">
                        </div>
                    </div>
                    <c:if test="${pid=='kjs'}">
                        <c:if test="${liveType==0}">
                            <div class="form-group">
                                <label class="col-md-2 control-label">直播课类型：</label>
                                <div class="col-md-9">
                                    <input type="radio" name="createType" value="1" >所有会员<input type="radio" name="createType"  value="2" >年会员
                                </div>
                            </div>
                        </c:if>
                    </c:if>
                    <c:if test="${pid=='sjn'}">
                        <div class="form-group">
                            <label  class="col-md-2 control-label">课程图片</label>
                            <div class="col-md-4">
                                <img id="preview-image"  alt="课程图片" class="img-thumbnail"/>
                            </div>
                            <div class="col-md-4">
                           <span class="btn btn-primary btn-sm fileinput-button">
                                <i class="glyphicon glyphicon-plus"></i>
                                <span>上传</span>
                                <input id="imageFile" type="file" name="imageFile">
                            <input type="hidden" id="course-image-path" name="courseImage" value="">
                            </span>
                            </div>
                        </div>
                        <div class="form-group">
                            <label  class="col-md-2 control-label">课程简介</label>
                            <div class="col-md-6">
                                <textarea  class="form-control" id="course-description" name="courseDescription" rows="5" ></textarea>
                            </div>
                        </div>
                    </c:if>
                    <div class="form-group">
                        <label  class="col-md-2 control-label">录播ID</label>
                        <div class="col-md-6">
                            <input type="text"  class="form-control" id="recordingId" name="recordingId" >
                        </div>
                    </div>

                    <div class="modal-footer">
                        <button type="button" id="save-course"  class="btn btn-primary">保存</button>
                        <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>

<div id="buttons">
    <c:if test="${liveType==0}">
        <shiro:hasPermission name="live:delete">
            <button type="button" class="btn btn-sm btn-danger" id="deleteLive" onclick="page.deleteLive('#id')">删除</button>
        </shiro:hasPermission>
        <shiro:hasPermission name="live:update">
            <button type="button" class="btn btn-sm btn-warning " id="modify" onclick="page.openModal('#id')">修改</button>
        </shiro:hasPermission>
    </c:if>
    <c:if test="${liveType==1}">
        <shiro:hasPermission name="liveOpen:delete">
            <button type="button" class="btn btn-sm btn-danger" id="deleteLive" onclick="page.deleteLive('#id')">删除</button>
        </shiro:hasPermission>
        <shiro:hasPermission name="liveOpen:update">
            <button type="button" class="btn btn-sm btn-warning " id="modify" onclick="page.openModal('#id')">修改</button>
        </shiro:hasPermission>
    </c:if>
</div>
<script src="${pageContext.request.contextPath}/resources/assets/plugins/DataTables/media/js/jquery.dataTables.js"></script>
<script src="${pageContext.request.contextPath}/resources/assets/plugins/DataTables/media/js/dataTables.bootstrap.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/assets/plugins/DataTables/extensions/Select/js/dataTables.select.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/assets/plugins/bootstrap-daterangepicker/moment.js"></script>
<script src="${pageContext.request.contextPath}/resources/assets/plugins/bootstrap-daterangepicker/daterangepicker.js"></script>
<script src="${pageContext.request.contextPath}/resources/assets/plugins/bootstrap-datetimepicker/js/bootstrap-datetimepicker.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/assets/plugins/bootstrap-datetimepicker/js/locales/bootstrap-datetimepicker.zh-CN.js" charset="UTF-8"></script>>
<script src="${pageContext.request.contextPath}/resources/common/utils/js/tool.date.js"></script>
<script src="${pageContext.request.contextPath}/resources/assets/plugins/bootstrapValidator/js/bootstrapValidator.js"></script>
<script src="${pageContext.request.contextPath}/resources/assets/plugins/jquery-file-upload/js/jquery.fileupload.all.js"></script>
<script src="${pageContext.request.contextPath}/resources/base/course/course-live.manager.js"></script>
<script>
    var pid  = '${pid}';
    $(function () {
        page.init();
    })
</script>
</body>
</html>