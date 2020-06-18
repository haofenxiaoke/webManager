<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" contentType="text/html; UTF-8" %>
<%@include file="/WEB-INF/view/include/taglib.jsp" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>${pname}管理系统-操作日志</title>
    <link href="${pageContext.request.contextPath}/resources/assets/plugins/DataTables/media/css/dataTables.bootstrap.min.css" rel="stylesheet" />
    <link href="${pageContext.request.contextPath}/resources/assets/plugins/DataTables/extensions/Select/css/select.bootstrap.min.css" rel="stylesheet" />
    <link href="${pageContext.request.contextPath}/resources/assets/plugins/bootstrap-daterangepicker/daterangepicker-bs3.css" rel="stylesheet" />
</head>
<body>
<div>
    <div class="row">
        <div class="col-md-10" style="width:100%;">
            <div class="panel panel-inverse">
                <div class="panel-heading">
                    <div class="panel-heading-btn">
                        <a href="javascript:;" class="btn btn-xs btn-icon btn-circle btn-default"
                           data-click="panel-expand"><i class="fa fa-expand"></i></a>
                        <a href="javascript:;" class="btn btn-xs btn-icon btn-circle btn-warning"
                           data-click="panel-collapse"><i class="fa fa-minus"></i></a>
                    </div>
                    <h4 class="panel-title">操作日志列表</h4>
                </div>
                <div class="panel-body">
                    <form class="form-inline">
                        <div class="form-group m-r-10">
                            <input type="text" class="form-control"  id="userName"
                                   placeholder="操作人员姓名"/>
                        </div>
                        <div class="form-group m-r-10">
                            <select id="operType" class="form-control" data-map=${operTypeMapString}>

                                <option value="">操作类型</option>
                                <c:forEach items="${operTypelList}" var="t">
                                    <option name="operType" value="${t.value}">${t.name}</option>
                                </c:forEach>
                            </select>
                        </div>
                        <div class="form-group m-r-10">
                            <select id="operLevel" class="form-control">
                                <option value="">操作级别</option>
                                <c:forEach items="${operLevelList}" var="l">
                                    <option name="operLeave" value="${l.value}">${l.name}</option>
                                </c:forEach>
                            </select>
                        </div>
                        <div class="form-group  m-r-10">
                            <div class="input-group">
                                <input readonly="readonly" class="form-control"  id="operTime"
                                       placeholder="操作时间">
									<%--<span class="input-group-btn">
									   <button id="showCreateBtn" class="btn btn-default" type="button"><i
                                               class="fa fa-calendar"></i></button>
									</span>--%>
                            </div>
                        </div>
                        <shiro:hasPermission name="adminLog:find:0">
                            <button type="button" class="btn btn-sm btn-info m-r-5" id="find">查询</button>
                        </shiro:hasPermission>
                    </form>
                </div>
                <div class="panel-body">
                    <table id="adminLog-table" class="table table-striped table-bordered " width="100%">
                        <thead>
                        <tr>
                            <th>序号</th>
                            <th>员工编号</th>
                            <th>姓名</th>
                            <th>调用方法</th>
                            <th>操作类型</th>
                            <th>操作描述</th>
                            <th>传递参数</th>
                            <th>操作等级</th>
                            <th>操作时间</th>
                        </tr>
                        </thead>
                    </table>
                </div>
            </div>
        </div>
    </div>
</div>
<script src="${pageContext.request.contextPath}/resources/assets/plugins/DataTables/media/js/jquery.dataTables.js"></script>
<script src="${pageContext.request.contextPath}/resources/assets/plugins/DataTables/media/js/dataTables.bootstrap.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/assets/plugins/DataTables/extensions/Select/js/dataTables.select.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/assets/plugins/bootstrap-daterangepicker/moment.js"></script>
<script src="${pageContext.request.contextPath}/resources/assets/plugins/bootstrap-daterangepicker/daterangepicker.js"></script>
<script src="${pageContext.request.contextPath}/resources/common/utils/js/tool.date.js"></script>

<script src="${pageContext.request.contextPath}/resources/base/system/adminlog_list.js"></script>
<script>
    $(document).ready(function () {
        operTypeMap = ($("#operType").data("map"));
        <shiro:hasPermission name="adminLog:find:0">
        adminLogTable = $('#adminLog-table').DataTable({
            select: true, //是否选中
            autoWidth: true,
            deferRender: true,
            responsive: true,
            searching: false, //是否开启搜索
            pagingType: "full_numbers",//分页类型 full_numbers显示所有分页信息
            processing: false, //是否显示处理状态
            serverSide: true, //是否开启服务器模式
            ordering: false, //排序
            aLengthMenu: [10, 20, 50, 100], //下拉框每页显示数量
            ajax: {
                "url": "/adminLog/search",
                "type": "POST",
                "dataType": "json",
                "data": function (d) {
                    d.userName = $("#userName").val();
                    d.operType = $("#operType").val();
                    d.operLevel = $("#operLevel").val();
                    d.operTime = $("#operTime").val();
                }
            },
            columns: [
                {"data": null},
                {"data": "userId", "visible": false},//visible 隐藏或显示
                {"data": "userName"},
                {
                    "data": "operName", "render": function (data, type, row, meta) {
                //替换显示内容
                    var cont = data.substring(0, 30)+"...";
                    return "<span data-name='operName' data-cont='"+cont+"'><span class='glyphicon glyphicon-plus'>展开</span>"+cont + "<span>";
                }
                },
                {"data": "operTypeDto"},
                {"data": "operDescribe"},
                {
                    "data": "operParam", "render": function (data, type, row, meta) {
                    //替换显示内容
                    var cont = data.substring(0, 30)+"...";
                    return "<span data-name='operParam' data-cont='"+cont+"'><span class='glyphicon glyphicon-plus'>展开</span>"+cont + "<span>";
                }
                },
                {"data": "operLevelDto"},
                {"data": "operTime"},
            ],
            columnDefs: [
                {className: "dt-body-center", "targets": "_all"},
                {
                    "targets": [8],
                    "render": function (data, type, row, meta) {
                        return TimeObjectUtil.formatterDateTime(new Date(data))
                    }
                }
            ],
            language: {
                lengthMenu: "每页 _MENU_ 条记录",//下拉框文字
                info: "第 _PAGE_ 页 ( 总共 _PAGES_ 页 ,共 _TOTAL_ 项)",//左下角显示文字
                infoEmpty: "",//当查询没有数据时左下角显示文字
                sEmptyTable: "没有数据..",//当查询没有数据时表格中间显示文字
                paginate: {                          //分页
                    first: "首页",
                    last: "尾页",
                    next: "下一页",
                    previous: "上一页"
                }
            },
            //设置第一列为自增列
            drawCallback: function (settings) {
                findObj.attr('disabled',false);
                n = this.api().page.info().start;
                this.api().column(0).nodes().each(function (cell, i) {
                    cell.innerHTML = ++n;
                })
            }
        });
        </shiro:hasPermission>
    });
</script>
</body>
</html>