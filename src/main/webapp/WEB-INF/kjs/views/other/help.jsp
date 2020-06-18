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
    <title></title>
    <link rel="stylesheet" href="/resources/help/css/help.css" />
    <link rel="stylesheet" href="/resources/help/css/helpRight.css" />
</head>
<body>
<div class="help-all">
    <div class="help-nav">
        <a href="/" style="padding-left: 0px;">首页</a><img class="old" src="/resources/live/images/jiao2.png"/><a href="/help">帮助中心</a>
    </div>
    <div class="help-bottom">
        <div class="help-left">
            <div class="help-tb">
                <img src="/resources/help/images/bzzx_03.png" />
            </div>
            <ul>
                <li id="1" onclick="$('#help-right').load('/resources/help/html/helpRight.html',{},function () {
                  document.title='帮助中心-会计狮';
                })" style=" margin-top: 15px;">帮助中心</li>
                <li id="2" onclick="$('#help-right').load('/resources/help/html/idea.html',{},function () {
                  document.title='意见反馈-会计狮';
                })">意见反馈</li>
                <li id="3" onclick="$('#help-right').load('/resources/help/html/agreement.html',{},function() {
                  document.title='服务协议-会计狮';
                    var sm = Util.getRequestParam('sm');
                    if (sm)
                         $('#sm-' + sm).click();
                    else
                         $('#sm-1').click();
                });">服务协议</li>
                <li id="4" onclick="$('#help-right').load('/resources/help/html/relation.html',{},function () {
                  document.title='联系我们-会计狮';
                })">联系我们</li>
                <li id="5" onclick="$('#help-right').load('/resources/help/html/aboutUS.html',{},function () {
                  document.title='关于我们-会计狮';
                })">关于我们</li>
            </ul>

        </div>
        <div class="help-right" id="help-right">
        </div>
    </div>
</div>

<script type="text/javascript" src="/resources/help/js/help.js" ></script>


<script language="javascript" type="text/javascript">
    NTKF_PARAM = {
        siteid: "kf_9751",              //企业id
        settingid: "kf_9751_1431594125839",           //应答客服组id，在客户端生成代码界面创建
        uid: "${SESSION_USER.id!=''?SESSION_USER.id:''}",                //用户id，登录用户必填，游客为空字符串
        uname: "${SESSION_USER.displayName!=''?SESSION_USER.displayName:''}",             //用户名，登录用户必填，游客为空字符串
        isvip: "0",            //是否为vip用户，登录用户可选，游客为"0"
        userlevel: ""   //网站用户级别，登录用户可选，游客不填
    }
</script>
<script type="text/javascript" src="http://dl.ntalker.com/js/xn6/ntkfstat.js?siteid=kf_9751" charset="utf-8"></script>
<script>
    var consultDate;
</script>
</body>
</html>
