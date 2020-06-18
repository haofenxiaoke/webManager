<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" contentType="text/html; UTF-8" %>
<%@include file="/WEB-INF/view/include/taglib.jsp" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>${pname}管理系统-定制计划-课程排序</title>
    <link href="${pageContext.request.contextPath}/resources/assets/plugins/DataTables/media/css/dataTables.bootstrap.min.css"
          rel="stylesheet"/>
    <link href="${pageContext.request.contextPath}/resources/assets/plugins/DataTables/extensions/Select/css/select.bootstrap.min.css"
          rel="stylesheet"/>
    <link href="${path}/resources/assets/plugins/bootstrapValidator/css/bootstrapValidator.css" rel="stylesheet">
</head>
<body>
<div>
    <div class="row">
        <div class="col-md-10" style="width:100%;">
            <div class="panel panel-inverse">
                <div class="panel-heading">
                    <div class="panel-heading-btn">
                    </div>
                    <div class="panel-title">定制计划管理 - ${plan.planDescribe}</div>
                </div>
                <!-- form表单 -->
                <div class="panel-body">
                    <nav class="navbar navbar-default" role="navigation">
                        <div class="navbar-header" style="width:34%;background: lightseagreen;">
                            <a class="navbar-brand" href="#">
                                <button type="button" class="btn btn-default btn-xs m-r-5">1</button>
                                计划基本信息</a>
                        </div>
                        <div class="navbar-header" style="width:33%;background: lightseagreen;">
                            <a class="navbar-brand" href="#">
                                <button type="button" class="btn btn-default btn-xs m-r-5">2</button>
                                选择课程</a>
                        </div>
                        <div class="navbar-header" style="width:33%;background: lightseagreen;">
                            <a class="navbar-brand" href="#">
                                <button type="button" class="btn btn-default btn-xs m-r-5">3</button>
                                课程排序</a>
                        </div>
                    </nav>
                    <table id="table-1" class="table table-striped table-bordered" width="100%">
                        <thead>
                        <tr>
                            <th></th>
                            <th>阶段</th>
                            <th>课程名称</th>
                            <th>操作</th>
                        </tr>
                        </thead>
                    </table>
                    <label class="col-md-1">
                        <button type="button" class="btn btn-sm btn-info btn-block" id="save-top"
                                onclick="javascript:history.back(-1);" >上一步
                        </button>
                    </label>
                    <label class="col-md-1">
                        <button type="button" class="btn btn-sm btn-info btn-block" id="save-success">完成</button>
                    </label>
                </div>
                <!-- form表单 -->
            </div>
        </div>
    </div>
</div>
<script src="${pageContext.request.contextPath}/resources/assets/plugins/DataTables/media/js/jquery.dataTables.js"></script>
<script src="${pageContext.request.contextPath}/resources/assets/plugins/DataTables/media/js/dataTables.bootstrap.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/assets/plugins/DataTables/extensions/Select/js/dataTables.select.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/common/utils/js/tool.date.js"></script>
<script src="${pageContext.request.contextPath}/resources/assets/plugins/bootstrapValidator/js/bootstrapValidator.js"></script>
<script src="${pageContext.request.contextPath}/resources/base/plan/plan.js"></script>
<script>
    var planTable;
    $(document).ready(function () {
        <shiro:hasPermission name="plan:find:0">
        planTable = $("#table-1").DataTable({
            bDestroy: true,
            searching: false,
            processing: true,
            serverSide: true,
            ordering: false, //排序
            paging: false,
            autoFill: true,
            autoFill: {
                update: false
            },
            ajax: {
                "url": "/plan/relation/list",
                "type": "POST",
                "dataType": "json",
                "data": function (d) {
                    //查询 赋值传参
                    d.planId = ${plan.id};
                }
            },
            columns: [
                {"data": "id", "visible": false},//visible 隐藏或显示
                {
                    "data": "stageName", "render": function (data, type, row, meta) {
                    var i = parseInt(meta.row) +1;
                    numberUpperCase.init('' + i + '');
                    return "第" + numberUpperCase.pri_ary() + "阶段";
                }
                },
                {"data": "courseTitle"},
                {
                    "data": null, "render": function (data, type, row, meta) {
                    if (null != data) {
                        var btn = "";
                        <shiro:hasPermission name="plan:up:0">
                        btn += '<a class="btn btn-sm btn-info m-r-5 m-b-5" data-type="up" type="button">向上</a>';
                        </shiro:hasPermission>
                        <shiro:hasPermission name="plan:down:0">
                        btn += '<a class="btn btn-sm btn-info m-r-5 m-b-5" data-type="down"  type="button">向下</a>';
                        </shiro:hasPermission>
                        return btn;
                    }
                }
                },
            ],
            language: {
                lengthMenu: "每页 _MENU_ 条记录",//下拉框文字
                info: "",//左下角显示文字
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
                n = this.api().page.info().start;
                this.api().column(0).nodes().each(function(cell,i){
                    cell.innerHTML = i;
//                  cell.style.width = "20px";
                })
            }
        });

        </shiro:hasPermission>

        $('#save-success').unbind('click').click(function () {
            var planId = ${plan.id};

            var orders = new Array();
            planTable.column(0).data().each( function (value,index)
            {
                orders.push((index+1)+':'+value);
            });
            var datas = {"planId": planId, "orders": orders.toString()};
            if (planId) {
                $.ajax({
                url: '/plan/stage/updatePlans',
                type: "post",
                dataType: "json",
                cache: false,
                data: datas,
                success: function (datas) {
                    if (datas.code == HttpUtil.success_code) {
                        window.location.href = "/plan/manager";
                    } else {
                        BootstrapDialog.alert(datas.msg);
                    }
                }
            });
            }
        });

        //排序
        $("#table-1").on('click', 'a', function () {
            var order_type = $(this).attr("data-type")
            var tlength = planTable.column(0).data().length;

            //当前行
            var current_row = $(this).parents('tr');
            var dataObj = planTable.row(current_row);
            var current_Data = dataObj.data();

            //替换行
            var last_num,new_data;
            if (order_type == 'up') {
                if (Number(dataObj[0]) == 0) {
                    return;
                }
                last_num = Number(dataObj[0]) - 1;
            } else {
                if(Number(dataObj[0]) == (tlength -1)){
                    return;
                }
                last_num = Number(dataObj[0]) + 1;
            }
            new_data = planTable.row(last_num).data();

            //替换
            planTable.row(last_num).data(current_Data);
            planTable.row(current_row).data(new_data);

        });
    });

</script>
</body>
</html>