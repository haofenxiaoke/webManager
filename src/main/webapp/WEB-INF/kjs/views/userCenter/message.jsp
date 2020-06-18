<%--
  Created by IntelliJ IDEA.
  User: chaishuxiang
  Date: 2016/7/6 0006
  Time: 下午 6:42
  To change this template use File | Settings | File Templates.
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="zh">
<head>
  <meta charset="UTF-8">
  <title>消息管理</title>
  <link href="/resources/common/css/rest.css" rel="stylesheet">
  <link href="/resources/userCenter/css/user.css" rel="stylesheet">
  <link href="/resources/userCenter/css/message.css" rel="stylesheet">
  <link href="/resources/common/layer-v2.3/layer/skin/layer.css" rel="stylesheet">
<%--  <script src="/resources/userCenter/js/user.js"></script>--%>
  <script src="/resources/userCenter/js/message.js"></script>
  <script src="/resources/userCenter/js/messageClick.js"></script>
</head>
<body>
<input type="hidden" value="${user.userid}" id="userid">
<input type="hidden" id="vipid" value="${userVip.vipId}">

 <div class="kjs clearfloat mt30" style="min-height: 705px">
  <div class="userRight fr">
    <div class="userR-title">
      <a class="userR-cur" value="0">未读消息</a>
      <a  value="1">已读消息</a>
      <p id="msgNum"></p>
    </div>
    <div class="userR-con">
      <div class="userR-zccount">
        <div style="display:block" >
          <div class="studyZl" id="unRead" >
            <div class="userR-twnone" id="noUnReadMessage">
               <img src="/resources/userCenter/images/noPic.png" width="160">
               <p>没看到消息内容</p>
            </div>
          </div>

        </div>
        <div >
          <div class="studyZl" id="read">
            <div class="userR-twnone" id="noReadMessage">
              <img src="/resources/userCenter/images/noPic.png" width="160">
              <p>没看到消息内容</p>
            </div>
          </div>

        </div>

      </div>
    </div>
  </div>
</div>
</body>
</html>
