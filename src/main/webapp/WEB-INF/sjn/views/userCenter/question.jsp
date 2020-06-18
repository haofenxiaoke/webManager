<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%--
  Created by IntelliJ IDEA.
  User: chaishuxiang
  Date: 2016/7/8 0008
  Time: 上午 10:58
  To change this template use File | Settings | File Templates.
--%>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>我的提问</title>
  <link href="/resources/common/css/rest.css" rel="stylesheet">
  <link href="/resources/userCenter/css/user.css" rel="stylesheet">
  <link href="/resources/userCenter/css/speci.css" rel="stylesheet">
  <link href="/resources-sjn/user/css/index.css" rel="stylesheet">
  <link href="/resources-sjn/user/css/question.css" rel="stylesheet">
  <script src="/resources/userCenter/js/user.js"></script>
  <script src="/resources/userCenter/js/question.js"></script>
  <script src="/resources/userCenter/js/messageClick.js"></script>

</head>
<body>
<input type="hidden" id="userid" value="${user.id}">
<input type="hidden" id="vipid" value="${userVip.vipId}">
<input type="hidden" id="userName" value="${SESSION_USER.displayName}">
  <div class="userRight fr">
    <div class="userR-title">
      <a class="userR-cur">我的提问</a>
    </div>
    <div class="userR-con" id="questionContent">
      <div class="h30"></div>
      <div class="studyZl" id="hasQuestion">
        <dl class="specList clearfloat" id="questions">
        </dl>
      </div>
    </div>
  </div>
</body>
</html>