<%@ page language="java" pageEncoding="UTF-8" contentType="text/html; UTF-8" import="com.kjs.common.util.ParamUtil" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<%
    String contextPath = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + contextPath + "/";
%>
<html>
<head>
    <meta http-equiv="X-UA-Compatible" content="IE=8,IE=9,chrome=1">
    <title>
        <sitemesh:write property='title'/>
    </title>
    <script src="${basePath}/resources/common/js/jquery-1.9.1.js"></script>
    <script src="${basePath}/resources/common/layer-v2.3/layer/layer.js"></script>
    <script src="${basePath}/resources/common/js/jquery.cookie.js"></script>
    <script src="${basePath}/resources/common/js/utils.js"></script>
    <link href="${basePath}/resources/common/css/rest.css" rel="stylesheet">
    <sitemesh:write property='head'/>
</head>
<body>
<header>
    <div class="headerBg">
        <div class="head_center">
            <a class="head_logo" >
                <img src="${basePath}/resources/common/images/haofenxiaoke.png" alt="" width="133" height="40"/>
                <span>|</span>
                <span>订单支付</span>
            </a>
            <div class="head_search">
                <div class="head_login">
                    <a href="${basePath}/userCenter">好分小课帐号：<span>${SESSION_USER.displayName}</span></a>
                </div>
            </div>
        </div>
    </div>

</header>
<sitemesh:write property='body'/>
<div class="toolbar">
    <%--<a class="too-ewm"><i class="restIcon"></i><em></em></a>--%>
    <%--<a class="too-xn"><i class="restIcon"></i></a>--%>
    <a class="too-userDc" target="_blank" href="${basePath}/help?m=2"><i class="restIcon"></i></a>
    <a class="too-scrollT" id="top"><i class="restIcon"></i></a>
</div>
<footer>
    <div class="kjs-fotter">
        <div class="kjs-f-con">
            <div class="kjs-f-text clearfloat">
                <img src="${basePath}/resources/common/images/foter-logo.png" class="kjs-f-l" style="width:48px; height:48px;">
                <div class="kjs-f-c">
                    <div class="kjs-f-about">
                        <a href="${basePath}/help?m=5">关于我们</a>|
                        <a href="${basePath}/vip">会员服务</a>|
                        <a href="${basePath}/help?m=3&sm=3">隐私条款</a>|
                        <a href="${basePath}/help?m=3">用户协议</a>|
                        <a href="${basePath}/help">帮助中心</a>|
                        <a href="${basePath}/help??m=4">联系我们</a>|
                        <a href="${basePath}/help?m=2">意见反馈</a>
                    </div>
                    <div class="kjs-f-bq">
                        <span>Copyright@2016</span>
                        <span>北京入行教育科技有限公司版权所有</span>
                        <a href="http://www.miit.gov.cn/" target="_blank" style="margin-right: 20px; color: #ddd;"> 京ICP备16011120号-10</a>
                        <a href="http://www.miit.gov.cn/" target="_blank" style="margin-right: 20px; color: #ddd;"> 京ICP证160803号</a>
                        <img style="margin-top: -3px;" src="/resources/index/images/picWb.png"/>
                        <a target="_blank" href="http://www.beian.gov.cn/portal/registerSystemInfo?recordcode=11030102010060" style="color: #dddddd;"><span>京公网安备11030102010060号</span></a>
                    </div>
                    <div style="color: #ddd;margin: 12px 8px 10px 9px;">
                        <a href="http://xwgdj.beijing.gov.cn/" target="_blank" style="color: #ddd;">出版物经营许可证（批发）新出发京批字第直170038号</a>
                    </div>
                </div>
                <%-- <img src="${basePath}/resources/common/images/foter-ewm.png" class="kjs-f-r">--%>
            </div>
           <%-- <img src="${basePath}/resources/common/images/foter-wa.png" class="kjs-fo-tittle">--%>
            <%--<a class="kjs-fo-tittle" style="top: 0px;" key ="57a7f329efbfb00b583282a1"  logo_size="124x47"  logo_type="realname"  href="http://www.anquan.org" ><script src="//static.anquan.org/static/outer/js/aq_auth.js"></script></a>--%>
        </div>
    </div>
</footer>
<script>Util.rightFloat();</script>
</body>
</html>