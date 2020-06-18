<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" contentType="text/html; UTF-8" %>
<%@include file="/WEB-INF/view/include/taglib.jsp" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>${pname}管理系统-分类管理</title>
    <link href="${pageContext.request.contextPath}/resources/assets/plugins/DataTables/media/css/dataTables.bootstrap.min.css" rel="stylesheet" />
    <link href="${pageContext.request.contextPath}/resources/assets/plugins/DataTables/extensions/Select/css/select.bootstrap.min.css" rel="stylesheet" />
    <link href="${pageContext.request.contextPath}/resources/assets/plugins/bootstrap-daterangepicker/daterangepicker-bs3.css" rel="stylesheet" />
    <link href="${pageContext.request.contextPath}/resources/common/switch/css/bootstrap-switch.min.css" rel="stylesheet" />

</head>
<body>
<div>
    <div class="row">
        <div class="col-md-10" style="width:100%;">
            <div class="panel panel-inverse">
                <div class="panel-heading">
                    <div class="panel-heading-btn">
                    </div>
                    <h4 class="panel-title">分类管理</h4>
                </div>
                <div class="panel-body">
                    <form class="form-inline">
                        <shiro:hasPermission name="cate:save:0">
                            <button type="button" data-toggle="modal" href="#cate-create-alert"  class="btn btn-sm btn-info m-r-5" id="createCate" onclick="addCateDialog('cate');">增加${cate1}</button>
                        </shiro:hasPermission>
                    </form>
                </div>
                <div class="panel-body">
                    <table id="cate-table" class="table table-striped table-bordered" width="100%">
                        <thead>
                        <tr>
                            <th>序号</th>
                            <th>${cate1}</th>
                            <c:if test="${pid=='kjs'}" >
                                <th>${cate2}</th>
                            </c:if>
                            <th>${cate3}</th>
                            <th>操作</th>
                        </tr>
                        </thead>
                    </table>
                </div>
            </div>
        </div>
    </div>
</div>
<%@include file="/WEB-INF/view/category/category_dialog.jsp" %>
<script src="${pageContext.request.contextPath}/resources/assets/plugins/DataTables/media/js/jquery.dataTables.js"></script>
<script src="${pageContext.request.contextPath}/resources/assets/plugins/DataTables/media/js/dataTables.bootstrap.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/assets/plugins/DataTables/extensions/Select/js/dataTables.select.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/assets/plugins/bootstrap-daterangepicker/moment.js"></script>
<script src="${pageContext.request.contextPath}/resources/assets/plugins/bootstrap-daterangepicker/daterangepicker.js"></script>
<script src="${pageContext.request.contextPath}/resources/assets/plugins/bootstrap-datetimepicker/js/bootstrap-datetimepicker.min.js"></script>
<script  src="${pageContext.request.contextPath}/resources/assets/plugins/bootstrap-datetimepicker/js/locales/bootstrap-datetimepicker.zh-CN.js" charset="UTF-8"></script>
<script src="${pageContext.request.contextPath}/resources/common/switch/js/bootstrap-switch.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/common/utils/js/tool.date.js"></script>
<script src="${pageContext.request.contextPath}/resources/base/category/cate.js"></script>
<script>
    var cateTable ;
    var directionId;
    $(document).ready(function() {
        <shiro:hasPermission name="cate:find:0">
        cateTable =  $('#cate-table').DataTable({
            bDestroy: true,
            searching:false,
            processing: true,
            serverSide: true,
            ordering:false, //排序
            paging:false,
            ajax:{
                "url":"/cate/list",
                "type": "POST",
                "dataType":"json",
                "data":function(d){
                	console.log('d',d)
//          d.userStatus=$("#userStatus").val();
                }
            },
            columns: [
                { "data": null},
//        { "data": "id","visible":false},//visible 隐藏或显示
                { "data": "category_desc"},
                <c:if test="${pid=='kjs'}" >
                    { "data": "industryNum"},
                </c:if>
                { "data": "positionNum"},
                { "data": null,"render":function(data,type,row,meta){
                    if(null!=data){
                        var btn = "" ;
                        <shiro:hasPermission name="cate:find:0">
                        btn+='<button class="btn btn-sm btn-primary  m-r-5 m-b-5" data-toggle="modal"  onclick="forwardTab('+row.id+',\''+row.category_desc+'\');" href="#cate-tab-alert"  type="button">查看</button>';
                        </shiro:hasPermission>
                        <shiro:hasPermission name="cate:update:0">
                        btn+='<button class="btn btn-sm btn-warning  m-r-5 m-b-5" onclick="updateCateDialog('+row.id+',\'cate\');"  data-toggle="modal"   href="#cate-update-alert"    type="button">改名</button>';
                        </shiro:hasPermission>
                        <shiro:hasPermission name="cate:delete:0">
                        btn+='<button onclick="deleteCate(\'cate\','+row.id+');" class="btn btn-sm btn-danger m-r-5 m-b-5" type="button">删除</button>';
                        </shiro:hasPermission>
                        <shiro:hasPermission name="cate:up:0">
                        btn+='<a class="btn btn-sm btn-info m-r-5 m-b-5" data-type="up" type="button">向上</a>';
                        </shiro:hasPermission>
                        <shiro:hasPermission name="cate:down:0">
                        btn+='<a class="btn btn-sm btn-info m-r-5 m-b-5" data-type="down"  type="button">向下</a>';
                        </shiro:hasPermission>
                        return btn;
                    }
                }},
            ],
            language:{
                lengthMenu: "每页 _MENU_ 条记录",//下拉框文字
                info:"",//左下角显示文字
                infoEmpty:"",//当查询没有数据时左下角显示文字
                sEmptyTable:"没有数据..",//当查询没有数据时表格中间显示文字
                paginate:{                          //分页
                    first:"首页",
                    last:"尾页",
                    next:"下一页",
                    previous:"上一页"
                }
            },
            //设置第一列为自增列
            drawCallback: function(settings){
                n = this.api().page.info().start;
                this.api().column(0).nodes().each(function(cell,i){
                    cell.innerHTML = ++n;
                })
            }
        });
        </shiro:hasPermission>

        $("#find").click(function(){
            cateTable.ajax.reload();
        });

        $('#cate-table').on('click', 'a', function () {
            var order_type = $(this).attr("data-type")
            var current_row = $(this).parents('tr');
            var dataobj = cateTable.row(current_row);
            var first_id =dataobj.data().id;
            var first_orderNum =dataobj.data().order_num;
          	console.log('cateTable')
            var last_num;
            if(order_type == 'up'){
                if(Number(dataobj[0]) == 0){
                    cateTable.ajax.reload();//刷新
                    return;
                }
                last_num = Number(dataobj[0])-1;
            }else{
                last_num = Number(dataobj[0])+1;
            }
            var data = cateTable.row(last_num).data()

            // alert((order_type == 'up')+"前行："+first_id+"--"+first_orderNum+"--后："+data.id+"--"+data.orderNum);
            var datas = {"firstid": first_id, "firstnum": data.order_num,"lastid": data.id, "lastnum": first_orderNum};
            orderBy(datas,"cate");
        } );

    });
</script>
</body>
</html>