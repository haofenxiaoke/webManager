<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" contentType="text/html; UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <title>讲义预览</title>
  <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/common/FlexPaper/css/flexpaper.css"/>
  <script src="${pageContext.request.contextPath}/resources/assets/plugins/jquery/jquery-1.9.1.min.js"></script>
  <script type="text/javascript" src="${pageContext.request.contextPath}/resources/common/FlexPaper/js/jquery.extensions.min.js"></script>
  <script type="text/javascript" src="${pageContext.request.contextPath}/resources/common/FlexPaper/js/flexpaper.js"></script>
  <script type="text/javascript" src="${pageContext.request.contextPath}/resources/common/FlexPaper/js/flexpaper_handlers.js"></script>
  <script type="text/javascript" src="${pageContext.request.contextPath}/resources/base/course/course_preview.js"></script>
  <style type="text/css" media="screen">
    html, body{ height:100%;}
    body { margin:0; padding:0; overflow:auto; }
  </style>
</head>
<body>
  <input type="hidden" id="swf-url" name="swf-url" value="${swfUrl}">
  <input type="hidden" id="pdf-url" name="pdf-url" value="${pdfUrl}">
  <!-- 预览资料 start -->
  <div id="documentViewer" class="flexpaper_viewer" style="z-index: 1;width:100%;height:100%;margin:0px auto;"></div>
  <!-- 预览资料 end -->
</body>
</html>
