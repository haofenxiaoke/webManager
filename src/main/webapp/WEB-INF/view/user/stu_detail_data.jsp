<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" contentType="text/html; UTF-8" %>
<%@include file="/WEB-INF/view/include/taglib.jsp" %>
<div>
  <div class="row">
    <div class="col-md-10" style="width:100%;">
      <div class="panel panel-inverse">
        <!-- 列表 -->
        <div class="panel-body">
          <div class="panel-body">
            <form class="form-inline">
              <div class="form-group m-r-10">
                <select id="directionId2" class="form-control">
                  <option value="-1">--方向--</option>
                </select>
              </div>
              <div class="form-group m-r-10">
                <select id="courseId2" class="form-control">
                  <option value="-1">--课程--</option>
                </select>
              </div>
              <shiro:hasPermission name="stu:find:0">
                <button type="button" class="btn btn-sm btn-info m-r-5" id="data_find">搜索</button>
              </shiro:hasPermission>
            </form>
          </div>
          <div class="panel-body">
            <table id="table-data" class="table table-striped table-bordered" width="100%">
              <thead>
              <tr>
                <th></th>
                <th>课程</th>
                <th>节</th>
                <th>资料</th>
                <c:if test="${pid=='kjs'}">
                   <th>观看日期</th>
                </c:if>
                <c:if test="${pid=='sjn'}">
                  <th>下载日期</th>
                </c:if>
              </tr>
              </thead>
            </table>
          </div>
        </div>
        <!-- end -->
      </div>
    </div>
  </div>
</div>
<script>
  //Tab页切换
  //加载列表
  var dataTable ;
  $(document).ready(function() {
    <shiro:hasPermission name="stu:find:0">
    loaddatagrid();
    </shiro:hasPermission>
    $("#data_find").click(function(){
      dataTable.ajax.reload();
    });

    //初始化方向分类下拉框
    var directionObj = $('#directionId2');
    initCateSelect(directionObj,'stu','find');
    directionObj.change(function() {
      initCourseSelect($('#courseId2'),$(this).val());
    });
  });
  function loaddatagrid(){
    dataTable =  $('#table-data').DataTable({
      bDestroy: true,
      searching:false,
      processing: true,
      serverSide: true,
      ordering:false, //排序
      ajax:{
        "url":"/stu/lecture/list",
        "type": "POST",
        "dataType":"json",
        "data":function(d){
          //查询 赋值传参
          d.userId=${user_id};
          d.directionId = $("#directionId2").val() ==-1?"":$("#directionId2").val();
          d.courseId = $("#courseId2").val() == -1?"":$("#courseId2").val();
        }
      },
      columns: [
        { "data": "id",visible:false},//visible 隐藏或显示
        { "data": "courseTitle"},
        { "data": "lectureName"},
        { "data": "fileTitle"},
        { "data": "watch_time"},
      ],
      columnDefs:[
        {className: "dt-body-center", "targets": "_all"},
        {
          "targets": [4],
          "render":function(data,type,row,meta){
            if(data == null){
              return "无登录";
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
        })
      }
    });
  }
</script>