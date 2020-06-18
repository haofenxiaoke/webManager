<%@ page language="java" import="java.util.*" pageEncoding="utf-8" contentType="text/html; utf-8" %>
<%@include file="/WEB-INF/view/include/taglib.jsp" %>
<!DOCTYPE html>
<%--[if IE 8]> <html lang="en" class="ie8"> <![endif]--%>
<%--[if !IE]><%--%>
<html lang="en">
<%--<![endif]--%>
    <head>
        <meta charset="utf-8">
        <title><sitemesh:write property='title'/></title>
        <meta content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no" name="viewport" />
        <meta name="keywords" content="${pname}网管理系统"/>
        <meta name="description" content="${pname}网管理系统"/>
        <%-- ================== BEGIN BASE CSS STYLE ================== --%>
        <link href="${pageContext.request.contextPath}/resources/assets/plugins/jquery-ui/themes/base/minified/jquery-ui.min.css" rel="stylesheet" />
        <link href="${pageContext.request.contextPath}/resources/assets/plugins/bootstrap/css/bootstrap.min.css" rel="stylesheet" />
        <link href="${pageContext.request.contextPath}/resources/assets/plugins/font-awesome/css/font-awesome.min.css" rel="stylesheet" />
        <link href="${pageContext.request.contextPath}/resources/assets/css/animate.min.css" rel="stylesheet" />
        <link href="${pageContext.request.contextPath}/resources/assets/css/style.min.css" rel="stylesheet" />
        <link href="${pageContext.request.contextPath}/resources/assets/css/style-responsive.min.css" rel="stylesheet" />
        <link href="${pageContext.request.contextPath}/resources/assets/css/theme/default.css" rel="stylesheet" id="theme" />
        <link href="${pageContext.request.contextPath}/resources/assets/plugins/bootstrap-datepicker/css/datepicker.css" rel="stylesheet" />
        <link href="${pageContext.request.contextPath}/resources/assets/plugins/bootstrap-datepicker/css/datepicker3.css" rel="stylesheet" />
        <link href="${pageContext.request.contextPath}/resources/assets/plugins/gritter/css/jquery.gritter.css" rel="stylesheet" />
        <link href="${pageContext.request.contextPath}/resources/common/dialog/css/jquery.toastmessage.css" rel="stylesheet" />
        <link href="${pageContext.request.contextPath}/resources/common/dialog/css/bootstrap-dialog.css" rel="stylesheet" />

        <script src="${pageContext.request.contextPath}/resources/assets/plugins/jquery/jquery-1.9.1.min.js"></script>
        <script src="${pageContext.request.contextPath}/resources/assets/plugins/jquery/jquery-migrate-1.1.0.min.js"></script>
        <script src="${pageContext.request.contextPath}/resources/assets/plugins/pace/pace.min.js"></script>
        <script src="${pageContext.request.contextPath}/resources/assets/plugins/jquery-ui/ui/minified/jquery-ui.min.js"></script>
        <script src="${pageContext.request.contextPath}/resources/assets/plugins/bootstrap/js/bootstrap.min.js"></script>
        <script src="${pageContext.request.contextPath}/resources/assets/plugins/slimscroll/jquery.slimscroll.min.js"></script>
        <script src="${pageContext.request.contextPath}/resources/assets/plugins/jquery-cookie/jquery.cookie.js"></script>
        <script src="${pageContext.request.contextPath}/resources/assets/plugins/gritter/js/jquery.gritter.js"></script>
        <script src="${pageContext.request.contextPath}/resources/assets/plugins/bootstrap-datepicker/js/bootstrap-datepicker.js"></script>
        <script src="${pageContext.request.contextPath}/resources/assets/js/apps.min.js"></script>
        <script src="${pageContext.request.contextPath}/resources/common/utils/js/utils.js"></script>
        <script src="${pageContext.request.contextPath}/resources/common/dialog/js/jquery.toastmessage.js"></script>
        <script src="${pageContext.request.contextPath}/resources/common/dialog/js/bootstrap-dialog.js"></script>
        <sitemesh:write property='head' />
        <style>body{color: #333}</style>
        <link rel="shortcut icon" href="/resources/images/favicon_${pid}.ico" >
    </head>
    <body class="index">
    <%-- 页面隐藏域 --%>
    <input id="path" type="hidden" value="${pageContext.request.contextPath}">
    <%-- begin #page-loader --%>
    <div id="page-loader" class="fade in"><span class="spinner"></span></div>
    <%-- end #page-loader --%>

    <%-- begin #page-container --%>
    <div id="page-container" class="fade page-sidebar-fixed page-header-fixed">
        <%-- begin #header --%>
        <div id="header" class="header navbar navbar-default navbar-fixed-top">
            <%-- 页面头部 --%>
            <jsp:include page="head.jsp"/>
        </div>
        <%-- end #header --%>
        <%-- begin #sidebar --%>
        <div id="sidebar" class="sidebar">
            <%-- 页面左侧边栏 --%>
            <jsp:include page="left.jsp"/>
        </div>
        <div class="sidebar-bg"></div>
        <%-- end #sidebar --%>
        <%-- begin #content --%>
        <div id="content" class="content">
            <%--页面内容使用sitemesh拦截自己的页面body部分,写入这个DIV,最后返回给浏览器--%>
            <sitemesh:write property="body"/>
        </div>
        <%-- end #content --%>
        <%-- 主题 --%>
            <%--  <jsp:include page="theme.jsp"/>--%>
          <%-- begin #footer --%>
        <div id="footer" class="footer">
            <%-- 页面底部 --%>
        </div>
        <%-- end #footer --%>

        <%-- 向上滚动按钮 --%>
        <a href="javascript:;" class="btn btn-icon btn-circle btn-success btn-scroll-to-top fade" data-click="scroll-top">
            <i class="fa fa-angle-up"></i>
        </a>
        <%-- end 向上滚动按钮 --%>
    </div>
    <script>
        $(document).ready(function() {
            App.init();
        })
    </script>
    </body>
</html>