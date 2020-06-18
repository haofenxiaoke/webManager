<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" contentType="text/html; UTF-8" %>
<%@include file="/WEB-INF/view/include/taglib.jsp" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <title>${pname}管理系统-标签管理</title>
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
          <h4 class="panel-title">标签管理</h4>
        </div>
        <div class="panel-body">
          <table id="tag-table" class="table table-striped table-bordered" width="100%">
            <thead>
            <tr>
              <th></th>
              <th>方向</th>
              <th>标签</th>
              <th>操作</th>
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
<script src="${pageContext.request.contextPath}/resources/assets/plugins/bootstrap-datetimepicker/js/bootstrap-datetimepicker.min.js"></script>
<script  src="${pageContext.request.contextPath}/resources/assets/plugins/bootstrap-datetimepicker/js/locales/bootstrap-datetimepicker.zh-CN.js" charset="UTF-8"></script>
<script src="${pageContext.request.contextPath}/resources/common/switch/js/bootstrap-switch.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/common/utils/js/tool.date.js"></script>
<script src="${pageContext.request.contextPath}/resources/base/sysTag/tag.js"></script>
<script>
  var tagTable ;
  $(document).ready(function() {
    <shiro:hasPermission name="tag:find:0">
      tagTable =  $('#tag-table').DataTable({
        bDestroy: true,
        searching:false,
        processing: true,
        serverSide: true,
        ordering:false, //排序
        paging:true,
      ajax:{
        "url":"/tag/cate/list",
        "type": "POST",
        "dataType":"json",
        "data":function(d){
          //
        }
      },
      columns: [
        { "data": "id","visible":false},
        { "data": "tagdesc"},
        { "data": "tagNum", "render":function(data,type,row,meta){
            return data == null?0+"个":data+"个";
          }
        },
        { "data": null,"render":function(data,type,row,meta){
          if(null!=data){
            var btn = "" ;
            <shiro:hasPermission name="tag:find:0">
            btn+='<button class="btn btn-sm btn-primary  m-r-5 m-b-5" data-toggle="modal"  onclick="forwardTab('+row.id+');" href="#tag-tab-alert"  type="button">查看</button>';
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
  });
</script>
</body>
</html>