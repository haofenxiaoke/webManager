<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2016/6/2 0002
  Time: 下午 6:06
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" contentType="text/html; UTF-8" %>
<%@include file="/WEB-INF/view/include/taglib.jsp" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <title>${pname}管理系统-课程管理</title>
  <link href="${pageContext.request.contextPath}/resources/assets/plugins/DataTables/media/css/dataTables.bootstrap.min.css" rel="stylesheet" />
  <link href="${pageContext.request.contextPath}/resources/assets/plugins/bootstrap-daterangepicker/daterangepicker-bs3.css" rel="stylesheet"/>
  <link href="${pageContext.request.contextPath}/resources/assets/plugins/DataTables/extensions/Select/css/select.bootstrap.min.css" rel="stylesheet" />
  <link href="${pageContext.request.contextPath}/resources/assets/plugins/bootstrap-datetimepicker/css/datetimepicker.css" rel="stylesheet"/>
  <link href="${pageContext.request.contextPath}/resources/common/switch/css/bootstrap-switch.min.css" rel="stylesheet" />
</head>
<body>
<div>
  <div class="row">
    <div class="col-md-10" style="width:100%;">
      <div class="panel panel-inverse">
        <div class="panel-heading">
          <h4 class="panel-title">课程管理</h4>
        </div>
        <!-- tab页面start-->
        <ul id="myTab" class="nav nav-tabs">
          <li class="active"><a href="#tab_1" data-type="1" data-toggle="tab">已审核</a></li>
          <li><a href="#tab_2" data-type="0" data-toggle="tab">未审核</a></li>
          <li><a href="#tab_3" data-type="2" data-toggle="tab">审核不通过</a></li>
        </ul>
        <div id="myTabContent" class="tab-content">
          <div class="panel-body">
            <form class="form-inline" role="form">
              <div class="form-group m-r-10">
                <select style="width: 160px;height: 34px" name="directionId" id="directionId">
                  <option value="">请选择学院</option>
                </select>
              </div>
              <div class="form-group m-r-10">
                <input type="text" class="form-control" style="width:220px;" id="title" name="title" placeholder="请输入课程名称" />
              </div>
             <%-- <div class="form-group  m-r-10" >
                <div class="input-group colorpicker-component" data-color="rgb(0, 0, 0)" data-color-format="rgb" id="colorpicker-prepend" data-colorpicker-guid="2">
                  <input  readonly="readonly" class="form-control"  id="createDate" data-date-format="yyyy-mm-dd" name="createDate" placeholder="发送日期">
                  <span class="input-group-addon" id="remove-on" style="cursor:pointer;">X</span>
                </div>
              </div>--%>
              <div class="form-group ">
                <div class="input-group">
                  <input readonly="readonly" class="form-control" id="update-course-date"
                         placeholder="更新日期">
                </div>
              </div>
              <shiro:hasPermission name="course:find:0">
                <button type="button" class="btn btn-sm btn-info m-r-5" id="find">搜索</button>
              </shiro:hasPermission>
            </form>
          </div>
          <div class="panel-body">
            <table id="table-1" class="table table-striped table-bordered" width="100%">
              <thead>
              <tr>	
                <th>课程id</th>
                <th>方向id</th>
                <th>学院</th>
                <th>课程名称</th>
                <th>版本</th>
                <th>审核人id</th>
                <th>审核人</th>
                <th>审核时间</th>
                <th>状态</th>
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
<script src="${pageContext.request.contextPath}/resources/assets/plugins/bootstrap-datetimepicker/js/bootstrap-datetimepicker.min.js"></script>
<script  src="${pageContext.request.contextPath}/resources/assets/plugins/bootstrap-datetimepicker/js/locales/bootstrap-datetimepicker.zh-CN.js" charset="UTF-8"></script>
<script src="${pageContext.request.contextPath}/resources/common/switch/js/bootstrap-switch.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/common/utils/js/tool.date.js"></script>
<script src="${pageContext.request.contextPath}/resources/base/course/coursemanage.js"></script>
<script src="${pageContext.request.contextPath}/resources/common/utils/js/utils.js"></script>


<script>

/*  $('#createDate').datetimepicker({
    language:  'zh-CN',
    weekStart: 1,
    todayBtn:  1,
    autoclose: 1,
    todayHighlight: 1,
    startView: 2,
    minView: 2,
    forceParse: 0
//    endDate:new Date()

  });*/
  bootstrapDateUtil.show('update-course-date');
  var courseTable ;
  var publishState = $('#myTab a:first').attr("data-type");//默认的类型
  //Tab页切换
  $(function(){
    //初始化 默认第1项
    $('#myTab a:first').tab('show');
    loadDataGrid();
    $('a[data-toggle="tab"]').on('show.bs.tab', function (e) {
      $("form input").val("");
      publishState = $(this).attr("data-type");
      courseTable.ajax.reload();
    });
    $("#find").click(function(){
      courseTable.ajax.reload();
    });

    //清空日期
    $("#remove-on").click(function(){
      $('#createDate').val('');
    });

  });
  //加载列表
  function loadDataGrid(){
    courseTable =  $("#table-1").DataTable({
      select:true, //是否选中
      autoWidth:false,
      deferRender:true,
      bRetrieve:true,
      responsive: true,
      searching:false, //是否开启搜索
      pagingType:"full_numbers",//分页类型 full_numbers显示所有分页信息
      processing:false, //是否显示处理状态
      serverSide:true, //是否开启服务器模式
      ordering:false, //排序
      "bAutoWidth": true, //自动宽度
      aLengthMenu:[10,20,50,100], //下拉框每页显示数量
      //scrollX:true,
      ajax:{
        "url":"/course/list",
        "type": "POST",
        "dataType":"json",
        "data":function(d){
          //查询 赋值传参
          d.publishState=publishState;
          d.directionId=$("#directionId").val();
          d.title=$("#title").val();
          d.updateDate=$("#update-course-date").val();
        }
      },
      columns: [
        { "data":"id","visible":false},//visible 隐藏或显示
        { "data": "directionId" ,"visible":false},
        {"data":"directionName"},
        { "data": "title"},
       /* {
          render: function (data, type, row, meta) {
            if (row.title.length>15)
            {

              return row.title.substring(0,15)+'...';
            }else{
              return row.title;
            }

          }
        },*/
        {
          render: function (data, type, row, meta) {
            if (row.version)
            {
              numberUpperCase.init(row.version.toString());
              return '第'+numberUpperCase.pri_ary()+'版';
            }else{
              return '第一版';
            }

          }
        },
        {"data":"publishUserid","visible":false},
        {"data":"publishUserName"},
        { "data": "publishTime"},
        {
          render: function (data, type, row, meta) {
            if (row.onlineState==0)
            {
              return '已下线';
            }else  if (row.onlineState==1){
              return '在线';
            }
          }
        },
        { "data": null,"render":function(data,type,row,meta){
          if(null!=data){
            var btn = "" ;
            <shiro:hasPermission name="course:find:0">
            if(publishState==1){
              <shiro:hasPermission name="addcourse:find">
              btn+='<button class="btn btn-info m-r-5 m-b-5" data-toggle="modal"  onclick="scanCourse('+row.id+',1);" type=\"button\">查看</button>';/* href="#stu-tab-alert" */1
              </shiro:hasPermission>
              <shiro:hasPermission name="course:exam">
              btn+='<button onclick="cancelExamine(\'course\','+row.id+');" class="btn btn-danger m-r-5 m-b-5" type="button">取消已审核</button>';
              </shiro:hasPermission>
            }
            if(publishState==0){
              <shiro:hasPermission name="course:exam">
              btn+='<button class="btn btn-info m-r-5 m-b-5" data-toggle="modal"  onclick="scanCourse('+row.id+',2);" type=\"button\">审核</button>';
              </shiro:hasPermission>
              <shiro:hasPermission name="course:delete">
              btn+='<button onclick="deleteCourse(\'course\','+row.id+');" class="btn btn-danger m-r-5 m-b-5" type="button">删除</button>';
              </shiro:hasPermission>
            }
            if(publishState==2){
             /* if(row.userid==${sessionScope.login_user.id}){*/   //放开后只有自己的课程才会显示重新提审和删除按钮
                <shiro:hasPermission name="addcourse:save">
                btn+='<button class="btn btn-info m-r-5 m-b-5" data-toggle="modal"  onclick="scanCourse('+row.id+',3);" type=\"button\">重新提审</button>';
                </shiro:hasPermission>
                <shiro:hasPermission name="course:delete">
                btn+='<button onclick="deleteCourse(\'course\','+row.id+');" class="btn btn-danger m-r-5 m-b-5" type="button">删除</button>';
                </shiro:hasPermission>
              //}

            }
            </shiro:hasPermission>
            return btn;
          }
        }},
      ],
      columnDefs:[
        {className: "dt-body-center", "targets": "_all"},
        {
          "targets": [7],
          "render":function(data,type,row,meta){
            if(data == null){
              return "无数据";
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



  /*取消课程审核*/
  <shiro:hasPermission name="course:find:0">
  function cancelExamine(name,id){


    BootstrapDialog.confirm({
      title: '取消课程审核',
      message: '你确定要取消该课程审核吗？',
      type: BootstrapDialog.TYPE_WARNING,
      closable: true,
      btnCancelLabel: '取消',
      btnOKLabel: '确认',
      btnOKClass: 'btn-warning',
      callback: function (yes) {
        if (yes){
          $.ajax({
            url: "/course/cancelCourse",
            type: "post",
            dataType: "json",
            cache: false,
            async: false,
            data: {id:id},
            success: function (datas) {
              courseTable.ajax.reload();
            }
          })
        }
      }
    })
  }
  </shiro:hasPermission>
  /*删除课程*/
  <shiro:hasPermission name="course:find:0">
  function deleteCourse(name,id){

    BootstrapDialog.confirm({
      title: '删除课程',
      message: '你确定要删除该课程吗？',
      type: BootstrapDialog.TYPE_WARNING,
      closable: true,
      btnCancelLabel: '取消',
      btnOKLabel: '确认',
      btnOKClass: 'btn-warning',
      callback: function (yes) {
        if (yes){
          $.ajax({
            url: "/course/deleteCourse",
            type: "post",
            dataType: "json",
            cache: false,
            async: false,
            data: {id:id},
            success: function (datas) {
              BootstrapDialog.alert("删除课程成功");
              courseTable.ajax.reload();
            }
          })
        }
      }
    })
  }
  </shiro:hasPermission>

  /**
   *  课程查看按钮
   */
  <shiro:hasPermission name="course:find:0">
  function scanCourse(id,type){
    location.href='/course/scanCourse/'+id+'/'+type;

  }
  </shiro:hasPermission>

</script>

<script>
  $(document).ready(function() {
    <shiro:hasPermission name="course:find:0">
    //初始化方向分类下拉框
    var directionObj = $('#directionId');
    initCateSelect(directionObj,'course','find');
    </shiro:hasPermission>
  })

  /*  初始化时间控件*/
  /**
   * 初始化下拉菜单
   * @param select 下拉元素 类型必须为jquery对象
   * @param resCode   资源编码
   * @param operCode  操作编码
   */
  function initCateSelect(select,resCode,operCode){
    var url = '/cate/list/' + resCode + '/'+operCode;
    $.get(url).done(function (data) {
      if (data.code == HttpUtil.success_code){
        var options = '';
        $.each(data.result,function (index,cate) {
          options+='<option value="'+cate.id+'">'+cate.categoryDesc+'</option>';
        })
        select.append(options);
      }else{
        BootstrapDialog.alert(data.msg);
      }
    });
  }


</script>
</body>
</html>
