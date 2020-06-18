<%--
  Created by IntelliJ IDEA.
  User: lihengming
  Date: 2016/6/20
  Time: 14:53
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path;
%>
<!DOCTYPE html>
<html>
<head>
    <base href="${basePath}">
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=8,IE=9,chrome=1">
    <title></title>
    <link rel="stylesheet" href="/resources/help/css/help.css" />
    <link rel="stylesheet" href="/resources/help/css/helpRight.css" />
    <meta http-equiv="X-UA-Compatible" content="IE=8,IE=9,chrome=1">
</head>
<body>
<div class="help-all">
    <div class="help-nav">
        <a href="/" style="padding-left: 0px;">首页</a> > <a href="/help">帮助中心</a>
    </div>
    <div class="help-bottom content-m-top">
        <div class="help-left">
            <div class="help-tb">
                <img src="/resources/help/images/bzzx_03.png" />
            </div>
            <ul>
                <li id="1" onclick="$('#help-right').load('/resources-sjn/help/html/helpRight.html',{},function () {
                  document.title='帮助中心-设计牛';
                })" style=" margin-top: 15px;">帮助中心</li>
                <li id="2" onclick="$('#help-right').load('/resources-sjn/help/html/idea.html',{},function () {
                  document.title='意见反馈-设计牛';
                })">意见反馈</li>
                <li id="3" onclick="$('#help-right').load('/resources-sjn/help/html/agreement.html',{},function() {
                  document.title='服务协议-设计牛';
                    var sm = Util.getRequestParam('sm');
                    if (sm)
                         $('#sm-' + sm).click();
                    else
                         $('#sm-1').click();
                });">服务协议</li>
                <li id="4" onclick="$('#help-right').load('/resources-sjn/help/html/relation.html',{},function () {
                  document.title='联系我们-设计牛';
                })">联系我们</li>
                <li id="5" onclick="$('#help-right').load('/resources-sjn/help/html/aboutUS.html',{},function () {
                  document.title='关于我们-设计牛';
                })">关于我们</li>
            </ul>

        </div>
        <div class="help-right" id="help-right">
        </div>
    </div>
</div>

<script type="text/javascript" src="/resources-sjn/help/js/help.js" ></script>
</body>
</html>
