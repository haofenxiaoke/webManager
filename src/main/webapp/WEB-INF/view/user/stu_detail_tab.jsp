<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" contentType="text/html; UTF-8" %>
<%@include file="/WEB-INF/view/include/taglib.jsp" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <title>${pname}管理系统-学员管理</title>
  <link href="${pageContext.request.contextPath}/resources/assets/plugins/DataTables/media/css/dataTables.bootstrap.min.css" rel="stylesheet" />
  <link href="${pageContext.request.contextPath}/resources/assets/plugins/DataTables/extensions/Select/css/select.bootstrap.min.css" rel="stylesheet" />
  <link href="${path}/resources/assets/plugins/bootstrapValidator/css/bootstrapValidator.css" rel="stylesheet">
</head>
<body>
<input type="hidden" id="user-name" value="${userName}"/>
<div>
  <div class="row">
    <div class="col-md-10" style="width:100%;">
      <div class="panel panel-inverse">
        <div class="panel-heading">
          <div class="panel-heading-btn">
            <button type="button" class="btn btn-xs btn-info m-r-5" onclick="javascript:history.back(-1);">返回</button>
          </div>
          <div class="panel-title" id="nick-name">${nickName}</div>
        </div>
        <!-- tab页面start-->
        <ul id="myTab" class="nav nav-tabs">
          <li class="active"><a href="#tab_1"  data-url="/stu/managerDetail/base/${user_id}" data-toggle="tab">基本信息</a></li>
          <li><a href="#tab_2" data-url="/stu/managerDetail/video/${user_id}" data-toggle="tab">视频记录</a></li>
          <li><a href="#tab_3" data-url="/stu/managerDetail/data/${user_id}" data-toggle="tab">资料记录</a></li>
          <li><a href="#tab_4" data-url="/stu/managerDetail/pay/${user_id}" data-toggle="tab">购买记录</a></li>
          <li><a href="#tab_5" data-url="/stu/managerDetail/answer/${user_id}" data-toggle="tab">问答记录</a></li>
          <li><a href="#tab_6" data-url="/stu/managerDetail/safe/${user_id}" data-toggle="tab">安全设置</a></li>
        </ul>
        <div id="myTabContent" class="tab-content">
          <div class="tab-pane fade in active" id="tab_1"></div>
          <div class="tab-pane fade" id="tab_2"></div>
          <div class="tab-pane fade" id="tab_3"></div>
          <div class="tab-pane fade" id="tab_4"></div>
          <div class="tab-pane fade" id="tab_5"></div>
          <div class="tab-pane fade" id="tab_6"></div>
        </div>
        <!-- tab页面end-->
      </div>
    </div>
  </div>
</div>
<script src="${pageContext.request.contextPath}/resources/assets/plugins/DataTables/media/js/jquery.dataTables.js"></script>
<script src="${pageContext.request.contextPath}/resources/assets/plugins/DataTables/media/js/dataTables.bootstrap.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/assets/plugins/DataTables/extensions/Select/js/dataTables.select.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/common/utils/js/tool.date.js"></script>
<script src="${pageContext.request.contextPath}/resources/assets/plugins/bootstrapValidator/js/bootstrapValidator.js"></script>
<script src="${pageContext.request.contextPath}/resources/base/user/stu.js"></script>
<script>
  var tabId = $('#myTab a:first').attr("href");
  var taburl = $('#myTab a:first').attr("data-url");
  //Tab页切换
  $(function(){
    //初始化 默认第1项
    loadUrl();
    $('a[data-toggle="tab"]').on('show.bs.tab', function (e) {
      taburl = $(this).attr("data-url");
      tabId = $(this).attr("href");
      $( tabId).html('<br>' + ' 页面加载中，请稍后...'); // 设置页面加载时
      loadUrl();
    });
  });
  function loadUrl(){
    $(tabId).tab('show');
    $(tabId).load(taburl);
  }

</script>
</body>
</html>