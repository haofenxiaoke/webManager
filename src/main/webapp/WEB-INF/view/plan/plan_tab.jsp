<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" contentType="text/html; UTF-8" %>
<%@include file="/WEB-INF/view/include/taglib.jsp" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <title>${pname}管理系统-定制计划</title>
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
          <h4 class="panel-title">定制计划</h4>
        </div>
        <!-- tab页面start-->
        <ul id="myTab" class="nav nav-tabs">
          <li class="active"><a href="#tab_1" data-type="1" data-toggle="tab">有计划</a></li>
          <li><a href="#tab_2" data-type="2" data-toggle="tab">无计划</a></li>
        </ul>
        <div id="myTabContent" class="tab-content">
          <div class="panel-body">
            <form class="form-inline" role="form">
              <div class="form-group m-r-10">
                <select id="directionId" class="form-control">
                  <option value="-1">--选择${cate1}--</option>
                </select>
              </div>
              <c:if test="${pid == 'kjs'}">
                <div class="form-group m-r-10">
                  <select id="industryId" class="form-control">
                    <option value="-1">--选择${cate2}--</option>
                  </select>
                </div>
              </c:if>
              <div class="form-group m-r-10">
                <select id="positionId" class="form-control">
                  <option value="-1">--选择${cate3}--</option>
                </select>
              </div>
              <shiro:hasPermission name="plan:find:0">
                <button type="button" class="btn btn-sm btn-info m-r-5" id="find">搜索</button>
              </shiro:hasPermission>
            </form>
          </div>
          <div class="panel-body">
            <table id="table-1" class="table table-striped table-bordered" width="100%">
              <thead>
              <tr>
                <th></th>
                <th>${cate1}</th>
                <c:if test="${pid == 'kjs'}">
                  <th>${cate2}</th>
                </c:if>
                <th>${cate3}</th>
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
<script src="${pageContext.request.contextPath}/resources/assets/plugins/DataTables/media/js/jquery.dataTables.js"></script>
<script src="${pageContext.request.contextPath}/resources/assets/plugins/DataTables/media/js/dataTables.bootstrap.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/assets/plugins/DataTables/extensions/Select/js/dataTables.select.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/assets/plugins/bootstrap-daterangepicker/moment.js"></script>
<script src="${pageContext.request.contextPath}/resources/assets/plugins/bootstrap-daterangepicker/daterangepicker.js"></script>
<script src="${pageContext.request.contextPath}/resources/common/switch/js/bootstrap-switch.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/common/utils/js/tool.date.js"></script>
<script src="${pageContext.request.contextPath}/resources/base/plan/plan.js"></script>
<script>
  var planTable ;
  var planType = $('#myTab a:first').attr("data-type");//默认的类型
  //Tab页切换
  $(function(){
    //初始化 默认第1项
    $('#myTab a:first').tab('show');
    loadDataGrid();
    $('a[data-toggle="tab"]').on('show.bs.tab', function (e) {
      $("form input").val("");
      planType = $(this).attr("data-type");
      planTable.ajax.reload();
    });
    $("#find").click(function(){
      planTable.ajax.reload();
    });

    //初始化方向分类下拉框
    var directionObj = $('#directionId');
    initCateSelect(directionObj,'plan','find');
    //c
    directionObj.change(function() {
      <c:if test="${pid == 'kjs'}">
          initIndustrySelect($('#industryId'),$(this).val());
      </c:if>
      initPositionSelect($('#positionId'),$(this).val());
    });
  });


  //加载列表
  function loadDataGrid(){
    planTable =  $("#table-1").DataTable({
      bDestroy: true,
      searching:false,
      processing: true,
      serverSide: true,
      ordering:false, //排序
      paging:true,
      ajax:{
        "url":"/plan/list",
        "type": "POST",
        "dataType":"json",
        "data":function(d){
          //查询 赋值传参
          d.planType = planType;
          d.directionId=$("#directionId").val() ==-1?"":$("#directionId").val();
          <c:if test="${pid == 'kjs'}">
            d.industryId=$("#industryId").val() ==-1?"":$("#industryId").val();
          </c:if>
          d.positionId=$("#positionId").val() ==-1?"":$("#positionId").val();;
        }
      },
      columns: [
        { "data":"id","visible":false},//visible 隐藏或显示
        { "data": "directionDesc"},
        <c:if test="${pid == 'kjs'}">
           { "data": "industryDesc"},
        </c:if>
       /* { "data": "positionDesc"},*/
        { "render":function(data,type,row,meta){
          if(row.positionDesc==null || row.positionDesc==''){
            return '';
          }else{
            return row.positionDesc;
          }
        }},
        { "data": null,"render":function(data,type,row,meta){
          if(null!=data){
            var btn = "" ;
            if(planType == 1){
              <shiro:hasPermission name="plan:update:0">
              btn+='<button class="btn btn-sm btn-warning m-r-5 m-b-5" onclick="forwardPage('+row.id+');"  data-toggle="modal"   href="#plan-update-alert"    type="button">修改</button>';
              btn+='<button onclick="removePlan('+row.id+');" class="btn btn-sm btn-danger m-r-5 m-b-5" type="button">删除</button>';
              </shiro:hasPermission>
            }else{
              <shiro:hasPermission name="plan:save:0">
              btn+='<button class="btn btn-sm btn-info m-r-5 m-b-5" onclick="forwardPage('+row.id+');"  data-toggle="modal"   href="#plan-create-alert"    type="button">新增</button>';
              </shiro:hasPermission>
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
  }



  /**
   * 初始化下拉菜单
   * @param select 下拉元素 类型必须为jquery对象
   * @param selValue  方向ID
   */
  function initIndustrySelect(select,selValue){
    var url = '/industry/industryList';
    var datas = {"directionId":selValue};
    $.ajax({
      url:url,
      type:"post",
      dataType:"json",
      cache: false,
      data :datas,
      success: function (datas){
        if(datas.code == HttpUtil.success_code){
          select.empty();
          var options = '<option value="-1">--选择${cate2}--</option>';
          $.each(datas.result,function (index,industry) {
            options+='<option value="'+industry.id+'">'+industry.categoryDesc+'</option>';
          })
          select.append(options);
        }else{
          BootstrapDialog.alert(data.msg);
        }
      }
    });
  }
  /**
   * 初始化下拉菜单
   * @param select 下拉元素 类型必须为jquery对象
   * @param selValue  方向ID
   */
  function initPositionSelect(select,selValue){
    var url = '/position/positionList';
    var datas = {"directionId":selValue};
    $.ajax({
      url:url,
      type:"post",
      dataType:"json",
      cache: false,
      data :datas,
      success: function (datas){
        if(datas.code == HttpUtil.success_code){
          select.empty();
          var options = '<option value="-1">--选择${cate3}--</option>';
          $.each(datas.result,function (index,position) {
            options+='<option value="'+position.id+'">'+position.categoryDesc+'</option>';
          })
          select.append(options);
        }else{
          BootstrapDialog.alert(data.msg);
        }
      }
    });
  }
</script>
</body>
</html>