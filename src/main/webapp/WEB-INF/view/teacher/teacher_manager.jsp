<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" contentType="text/html; UTF-8" %>
<%@include file="/WEB-INF/view/include/taglib.jsp" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <title>${pname}管理系统-老师管理</title>
  <link href="${pageContext.request.contextPath}/resources/assets/plugins/DataTables/media/css/dataTables.bootstrap.min.css" rel="stylesheet" />
  <link href="${pageContext.request.contextPath}/resources/assets/plugins/DataTables/extensions/Select/css/select.bootstrap.min.css" rel="stylesheet" />
  <link href="${pageContext.request.contextPath}/resources/assets/plugins/bootstrap-daterangepicker/daterangepicker-bs3.css" rel="stylesheet" />
  <link href="${path}/resources/assets/plugins/bootstrapValidator/css/bootstrapValidator.css" rel="stylesheet">
  <link href="${path}/resources/assets/plugins/jquery-file-upload/css/jquery.fileupload.css" rel="stylesheet">
</head>
<body>
<div>
  <input type="hidden">
  <div class="row">
    <div class="col-md-10" style="width:100%;">
      <div class="panel panel-inverse">
        <div class="panel-heading">
          <h4 class="panel-title">老师管理</h4>
        </div>
        <!-- tab页面start-->
        <ul id="myTab" class="nav nav-tabs">
          <li class="active"><a href="#tab_1" data-type="1" data-toggle="tab">老师管理</a></li>
        </ul>
        <div id="myTabContent" class="tab-content">
          <div class="panel-body">
            <form class="form-inline" role="form">
              <div class="form-group m-r-10">
                <input type="text" class="form-control"  style="width:220px;" id="teacher_name" placeholder="请输入老师姓名" />
              </div>
              <div class="form-group m-r-10">
                <input type="text" class="form-control" style="width:220px;" id="teacher_num" placeholder="请输入老师工号" />
              </div>
              <shiro:hasPermission name="teacher:find">
                <button type="button" class="btn btn-sm btn-info m-r-5" id="find">搜索</button>
              </shiro:hasPermission>
              <shiro:hasPermission name="teacher:save">
                <button type="button" class="btn btn-sm btn-primary m-r-5" id="createTeacher">增加老师</button>
              </shiro:hasPermission>
            </form>
          </div>
          <div class="panel-body">
            <table id="table-1" class="table table-striped table-bordered" width="100%">
              <thead>
              <tr>
                <th></th>
                <th>姓名</th>
                <th>花名</th>
                <th>性别</th>
                <th>工号</th>
                <th>创建人</th>
                <th>创建时间</th>
                <th>操作</th>
              </tr>
              </thead>
            </table>
          </div>
          <!-- tab页面end-->
        </div>
      </div>
    </div>
  </div>
</div>
<%@include file="/WEB-INF/view/teacher/teacher_dialog.jsp" %>
<script src="${pageContext.request.contextPath}/resources/assets/plugins/DataTables/media/js/jquery.dataTables.js"></script>
<script src="${pageContext.request.contextPath}/resources/assets/plugins/DataTables/media/js/dataTables.bootstrap.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/assets/plugins/DataTables/extensions/Select/js/dataTables.select.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/assets/plugins/bootstrap-daterangepicker/moment.js"></script>
<script src="${pageContext.request.contextPath}/resources/assets/plugins/bootstrap-daterangepicker/daterangepicker.js"></script>
<script src="${pageContext.request.contextPath}/resources/common/utils/js/tool.date.js"></script>
<script src="${pageContext.request.contextPath}/resources/assets/plugins/bootstrapValidator/js/bootstrapValidator.js"></script>
<script src="${pageContext.request.contextPath}/resources/assets/plugins/jquery-file-upload/js/jquery.fileupload.all.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/common/layer-v2.3/layer/layer.js"></script>
<script src="${pageContext.request.contextPath}/resources/base/teacher/teacher.js"></script>
<script>
  var teacherTable ;
  var teacherid = $('#myTab a:first').attr("data-type");//默认的类型
  //Tab页切换
  $(function(){
    //初始化 默认第1项
    $('#myTab a:first').tab('show');
    <shiro:hasPermission name="teacher:find">
      loadDataGrid();
      $("#find").click(function(){
        teacherTable.ajax.reload();
      });
    </shiro:hasPermission>
    <shiro:lacksPermission name="teacher:find">
      BootstrapDialog.alert("你没有查询老师管理信息的权限!");
    </shiro:lacksPermission>

    page.init();
  });
  //加载列表
  function loadDataGrid(){
    teacherTable =  $("#table-1").DataTable({
      bDestroy: true,
      searching:false,
      processing: true,
      serverSide: true,
      ordering:false, //排序
      ajax:{
        "url":"/teacher/list",
        "type": "POST",
        "dataType":"json",
        "data":function(d){
          //查询 赋值传参
          d.name=$("#teacher_name").val();
          d.num=$("#teacher_num").val();
        }
      },
      columns: [
        { "data":"id","visible":false},//visible 隐藏或显示
        { "data": "name"},
        { "data": "flower_name"},
        { "data": "sex"},
        { "data": "num"},
        { "data": "username"},
        { "data": "ctime"},
        { "data": null,"render":function(data,type,row,meta){
          if(null!=data){
            var btn = "" ;
            <shiro:hasPermission name="teacher:find">
            btn+='<button class="btn btn-sm btn-primary m-r-5 m-b-5" data-toggle="modal"  onclick="page.view('+row.id+');" href="#stu-tab-alert"  type="button">查看</button>';
            </shiro:hasPermission>
            <shiro:hasPermission name="teacher:update">
            btn+='<button class="btn btn-sm btn-warning m-r-5 m-b-5" data-toggle="modal"  onclick="page.openModal('+row.id+');" href="#stu-tab-alert"  type="button">修改</button>';
            </shiro:hasPermission>
            //1锁定
           /* var lockStr = (data.user_lock == 1)?'>锁定':'checked>解锁';
            btn+='<button onclick="page.lockUser(this);" class="btn btn-sm btn-danger m-r-5 m-b-5" type="button" value="'+row.id+'" status = "'+row.user_lock+'" '+lockStr+'</button>';
           */
            return btn;
          }
        }},
      ],
      columnDefs:[
        {className: "dt-body-center", "targets": "_all"},
        {
          "targets": [6],
          "render":function(data,type,row,meta){
            if(data == null){
              return "";
            }
            return TimeObjectUtil.formatterDateTime(new Date(data))
          }
        }
      ],
      language:{
        lengthMenu: "每页 _MENU_ 条记录",//下拉框文字
        info:"第 _PAGE_ 页 ( 总共 _PAGES_ 页 ,共 _TOTAL_ 项)",//左下角显示文字
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
//          cell.style.width = "20px";
        })
      }
    });
  }
</script>
</body>
</html>