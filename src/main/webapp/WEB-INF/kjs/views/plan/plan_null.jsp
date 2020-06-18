<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<html lang="zh">
<head>
  <meta charset="UTF-8">
  <title>确认学习计划-好分课堂</title>
  <link rel="stylesheet" href="${basePath}/resources/common/css/rest.css" />
  <link rel="stylesheet" href="${basePath}/resources/course/css/plan.css" />
  <link rel="stylesheet" href="${basePath}/resources/course/css/gap.css" />
  <link rel="stylesheet" href="${basePath}/resources/common/layer-v2.3/layer/skin/layer.css">

  <script type="text/javascript" src="${basePath}/resources/course/js/respond.js" ></script>
  <script src="${basePath}/resources/common/layer-v2.3/layer/layer.js"></script>
</head>
<body>
<input type="hidden" id="is-vip" name="is-vip" value="${userStu.isVIP}">
<input type="hidden" id="user-id" name="user-id" value="${userStu.id}">
<div class="buy-all">
  <div class="Made-nav">
    <a href="${basePath}/" style="padding-left: 0px;">首页</a><img class="old" src="/resources/live/images/jiao2.png"/><a onclick="javascript:history.back(-1);">课程定制</a><img class="old" src="/resources/live/images/jiao2.png"/><a>学习计划</a>
  </div>
  <div class="plan-bottom">
    <div class="content">
      <img src="/resources/login/images/jg.png">
      <p>你选择的职位和行业暂无学习计划...</p>
    </div>
  </div>
</div>
</body>
</html>
