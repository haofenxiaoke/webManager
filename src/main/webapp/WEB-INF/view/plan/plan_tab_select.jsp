<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" contentType="text/html; UTF-8" %>
<%@include file="/WEB-INF/view/include/taglib.jsp" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <title>${pname}管理系统-定制计划-选择课程</title>
  <link href="${pageContext.request.contextPath}/resources/assets/plugins/DataTables/media/css/dataTables.bootstrap.min.css" rel="stylesheet" />
  <link href="${pageContext.request.contextPath}/resources/assets/plugins/DataTables/extensions/Select/css/select.bootstrap.min.css" rel="stylesheet" />
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
              <a class="navbar-brand" href="#"><button type="button" class="btn btn-default btn-xs m-r-5">1</button>计划基本信息</a>
            </div>
            <div class="navbar-header" style="width:33%;background: lightseagreen;">
              <a class="navbar-brand" href="#"><button type="button" class="btn btn-default btn-xs m-r-5">2</button>选择课程</a>
            </div>
            <div class="navbar-header" style="width:33%;">
              <a class="navbar-brand" href="#"><button type="button" class="btn btn-default btn-xs m-r-5">3</button>课程排序</a>
            </div>
          </nav>
          <input type="hidden" id="planId" name="planId" value="${plan.id}">
          <input type="hidden" id="directionId" name="directionId" value="${plan.directionId}">
          <input type="hidden" id="industryId" name="industryId" value="${plan.industryId}">
          <input type="hidden" id="positionId" name="directionId" value="${plan.positionId}">
          <table id="table-1" class="table table-striped table-bordered" width="100%">
            <thead>
            <tr>
              <th></th>
              <th>课程名称</th>
              <th>操作</th>
            </tr>
            </thead>
          </table>
          <label class="col-md-1">
            <button type="button" class="btn btn-sm btn-info btn-block" id="save-top" >上一步</button>
          </label>
          <label class="col-md-1">
            <button type="button" class="btn btn-sm btn-info btn-block" id="save-down" >下一步</button>
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
  $(document).ready(function() {
    var planObj = $('#table-1');
    <shiro:hasPermission name="plan:find:0">
    var planTable =  planObj.DataTable({
      bDestroy: true,
      searching:false,
      processing: true,
      serverSide: true,
      ordering:false, //排序
      paging:false,
      ajax:{
        "url":"/plan/course/list",
        "type": "POST",
        "dataType":"json",
        "data":function(d){
          //查询 赋值传参
          d.planId = $("#planId").val() == null?"":$("#planId").val();
          d.directionId=$("#directionId").val() == null?"":$("#directionId").val();
          d.industryId=$("#industryId").val() == null?"":$("#industryId").val();
          d.positionId=$("#positionId").val() == null?"":$("#positionId").val();;
        }
      },
      columns: [
        { "data":null,"visible":false},//visible 隐藏或显示
        { "data": "title"},
        { "data": null,"render":function(data,type,row,meta){
          if(null!=data){
            var btn = '<input type="checkbox" name="check" value="'+row.planCourseId+'">';
            if(row.id && row.id!=null){
              btn = '<input type="checkbox" name="check" value="'+row.planCourseId+'" checked>';
            }
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
//          cell.style.width = "20px";
        })
      }
    });
    </shiro:hasPermission>
    $('#save-top').unbind('click').click(function () {
      window.location.href = "/plan/baseInfo/${plan.id}";
    });
    $('#save-down').unbind('click').click(function () {
      var courseIds = "";
      $("input[name='check']:checked").each(function(){
        courseIds +=$(this).val()+","
      });
      if(courseIds && courseIds.length>0){
        courseIds = courseIds.substring(0,courseIds.length-1);
        var datas = {"planId":${plan.id},"courseIds":courseIds};
        $.ajax({
          url:"/plan/course/save",
          type:"post",
          dataType:"json",
          cache: false,
          data :datas,
          success: function (datas){
            if(datas.code == HttpUtil.success_code){
              window.location.href = "/plan/orderCourse/${plan.id}";
            }
          }
        });
      }else{
        BootstrapDialog.show({
          title: '提示',
          message: '您还没有选择课程！'
        });
        <%--window.location.href = "/plan/orderCourse/${plan.id}";--%>
      }
    });
  });
</script>
</body>
</html>