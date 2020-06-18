<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" contentType="text/html; UTF-8" %>
<%@include file="/WEB-INF/view/include/taglib.jsp" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <title>${pname}管理系统-学员管理</title>
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
          <h4 class="panel-title">学员管理</h4>
        </div>
        <!-- tab页面start-->
        <ul id="myTab" class="nav nav-tabs">
          <li class="active"><a href="#tab_1" data-type="1" data-toggle="tab">付费学员</a></li>
          <li><a href="#tab_2" data-type="2" data-toggle="tab">免费学员</a></li>
        </ul>
        <div id="myTabContent" class="tab-content">
          <div class="panel-body">
            <form class="form-inline" role="form">
              <div class="form-group m-r-10">
                <input type="text" class="form-control"  style="width:220px;" id="user_id" placeholder="请输入账号" />
              </div>
              <div class="form-group m-r-10">
                <input type="text" class="form-control" style="width:220px;" id="user_name" placeholder="请输入昵称" />
              </div>
              <div class="form-group  m-r-10" >
                <div class="input-group">
                  <input readonly="readonly" class="form-control" style="width:220px;" id="regist_Time" placeholder="注册日期">
                      <%--<span class="input-group-btn">
                         <button id="showCreateBtn" class="btn btn-default" type="button"><i class="fa fa-calendar"></i></button>
                      </span>--%>
                </div>
              </div>
              <div class="form-group  m-r-10" >
                <div class="input-group">
                  <input  readonly="readonly" class="form-control" style="width:220px;" id="last_PayDate_time" placeholder="最近一次付费日期">
                     <%-- <span class="input-group-btn">
                         <button id="showCreateBtn2" class="btn btn-default" type="button"><j class="fa fa-calendar"></j></button>
                      </span>--%>
                </div>
              </div>
              <shiro:hasPermission name="stu:search:0">
                <button type="button" class="btn btn-sm btn-info m-r-5" id="find">搜索</button>
              </shiro:hasPermission>
              <shiro:hasPermission name="stu:export:0">
                <a class="btn btn-sm btn-primary" id="export" onclick="exportData(this);" download="${pname}管理系统-学员管理.csv" href="#">导出数据</a>
              </shiro:hasPermission>
            </form>
          </div>
          <div class="panel-body">
            <table id="table-1" class="table table-striped table-bordered" width="100%">
              <thead>
              <tr>
                <th>序号</th>
                <th>账号</th>
                <th>昵称</th>
                <th>注册日期</th>
                <th>最近一次付费日期</th>
                <th>来源渠道</th>
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
<script src="${pageContext.request.contextPath}/resources/common/layer-v2.3/layer/layer.js"></script>
<script src="${pageContext.request.contextPath}/resources/base/user/stu.js"></script>
<script>
  var stuTable ;
  var stuid = $('#myTab a:first').attr("data-type");//默认的类型
  //Tab页切换
  $(function(){
    //初始化 默认第1项
    $('#myTab a:first').tab('show');
    loadDataGrid();
    $('a[data-toggle="tab"]').on('show.bs.tab', function (e) {
      $("form input").val("");
      stuid = $(this).attr("data-type");
      stuTable.ajax.reload();
    });
    $("#find").click(function(){
      stuTable.ajax.reload();
    });

  });
  //加载列表
  function loadDataGrid(){
    stuTable =  $("#table-1").DataTable({
      bDestroy: true,
      searching:false,
      processing: true,
      serverSide: true,
      ordering:false, //排序
      ajax:{
        "url":"/stu/list",
        "type": "POST",
        "dataType":"json",
        "data":function(d){
          //查询 赋值传参
          d.stuid=stuid;
          d.userid=$("#user_id").val();
          d.username=$("#user_name").val();
          d.registTime=$("#regist_Time").val();
          d.lastPayDatetime=$("#last_PayDate_time").val();
          d.currentTime = new Date();
        }
      },
      columns: [
        { "data":"id","visible":false},//visible 隐藏或显示
        { "data": "userid"},
        { "data": "username"},
        { "data": "registTime"},
        { "data": "lastPayDatetime"},
        { "data": "registerType","render":function(data,type,row,meta){
          var dataTypes = {0:"网站",1:"移动端(Android)",2:"移动端(IOS)",3:"微信小程序"};
            return dataTypes[data];
        }},
        { "data": null,"render":function(data,type,row,meta){
          if(null!=data){
            var btn = "" ;
            <shiro:hasPermission name="stu:find:0">
            btn+='<button class="btn btn-sm btn-primary" data-toggle="modal"  onclick="forwardTab('+row.id+',\''+row.userid+'\');" href="#stu-tab-alert"  type="button">查看</button>';
            </shiro:hasPermission>
            return btn;
          }
        }},
      ],
      columnDefs:[
        {className: "dt-body-center", "targets": "_all"},
        {
          "targets": [3,4],
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

  /**
   * 导出数据
   * @param aLink
   */
  function exportData(aLink) {
    layer.msg('数据正在导出中，可能需要等候3秒到1分钟...', {
      icon: 16
      ,time: 5000
      ,shade: [0.8, '#393D49']
    });

    var datas = {};
    datas.stuid=stuid;
    datas.userid=$("#user_id").val();
    datas.username=$("#user_name").val();
    datas.registTime=$("#regist_Time").val();
    datas.lastPayDatetime=$("#last_PayDate_time").val();
    datas.currentTime = new Date();
    datas.length = -1;

    var separator = ',\u200C';
    var htmlText = '账号,昵称,注册日期,最近一次付费日期,性别,QQ号';

    $.ajax({
      url:"/stu/export/csv/answers",
      type:"post",
      dataType:"json",
      cache: false,
      async: false,
      data :datas,
      success: function (data){
        if(data.code == HttpUtil.success_code){
          $.each(data.result, function (index,info) {
            htmlText += '\n\u200C'+info.userid+
                    separator+(info.username ? info.username : '')+
                    separator+moment(info.registTime).format('YYYY-MM-DD HH:mm:ss ')+
                    separator+moment(info.lastPayDatetime).format('YYYY-MM-DD HH:mm:ss ')+
                    separator+(info.sex == 0 ? '男' : '女')+
                    separator+(info.qqNum ? info.qqNum : '') +
                    separator;
          })
        }
      }
    })

    aLink.download = $('#export').attr('download');
    var blob = new Blob(["\ufeff", htmlText],{type: 'text/csv,charset=utf-8'});
    aLink.href = URL.createObjectURL(blob);
  }

  /*日期*/
  //弹出日期
  bootstrapDateUtil.show("regist_Time");
  bootstrapDateUtil.show("last_PayDate_time");

</script>
</body>
</html>