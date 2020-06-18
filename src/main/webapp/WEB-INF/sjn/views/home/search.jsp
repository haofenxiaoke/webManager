<%--
  Created by IntelliJ IDEA.
  User: admin
  Date: 2016/7/13
  Time: 10:21
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path;
%>
<html lang="en">
<head>
    <title>${word}-课程搜索-设计牛</title>
    <link rel="stylesheet" href="${basePath}/resources/course/css/gap.css" />
    <link href="${basePath}/resources/index/css/kjs-index.css" rel="stylesheet">
    <link href="${basePath}/resources-sjn/index/css/search.css" rel="stylesheet">
    <script src="${basePath}/resources/index/js/search.js"></script>
    <script>
        var word = '${word}';
        var isLogin = false;
        <shiro:user>isLogin =true;</shiro:user>
        var isVIP = '${SESSION_USER.isVIP}';
    </script>
</head>
<body>
<div class="kjsCrWid">
    <div class="nav" style="margin: 30px 0 10px 0;">
        <div class="kjsPx fl">
            <div class="kjsSearchRes">
                共找到<span>&nbsp;${pageInfo.total}&nbsp;</span>节关于"${word}"的课程
            </div>
        </div>
        <div class="nav-right"><a id="made-plan">免费定制 >></a></div>
        <p class="nav-rightleft">免费定制学习方案，薪资平均增长36%</p>
    </div>

    <c:if test="${pageInfo.total == 0}">
        <div class="content">
            <img src="${basePath}/resources/login/images/jg.png">
            <p>哇奥，没有找到您搜索<span>"${word}"</span>内容</p>
            <div class="search">
                <div class="sousuo">
                    <input id="search-word-div" type="text"  value="${word}" style="color:#999;" onfocus="if(this.value=='${word}'){this.value=''}" onblur="if(this.value==''){this.value='${word}'}"/>
                    </div>
                <div class="ssbtn" id="search-btn-div">
                </div>
            </div>
            </div>
        </div>
    </c:if>
    <div class="kjsCrouse">
        <ul class="clearfloat" id="course-list">
            <c:forEach items="${pageInfo.list}" var="course">
                <li>
                    <div class="kjsCimg"><a href="${basePath}/course/detail/${course.id}"><img src="${course.coverUrl}"> </a><%--${course.coverUrl}--%>
                    </div>
                    <div class="kjsCTwo">
                        <div class="clearfloat">
                            <shiro:guest>
                                <p class="fl kjsSttext">会员免费</p>
                                <div class="HoverRight">
                                    <a href="${basePath}/course/play/${course.id}" style="display:inline-block; ">
                                        <p class="kjs_index_txt_sj">
                                            <span class="dbX">试听</span></p>
                                        <div class="qieh"></div>
                                    </a>
                                </div>

                            </shiro:guest>
                            <shiro:user>
                                <c:choose>
                                    <c:when test="${SESSION_USER.isVIP}">
                                        <div class="HoverRight">
                                            <a href="${basePath}/course/play/${course.id}" style="display:inline-block; ">
                                                <p class="kjs_index_txt_sj">
                                                    <span class="dbX">听课</span></p>
                                                <div class="qieh"></div>
                                            </a>
                                        </div>
                                    </c:when>
                                    <c:otherwise>
                                        <p class="fl kjsSttext">会员免费</p>
                                        <div class="HoverRight">
                                            <a href="${basePath}/course/play/${course.id}" style="display:inline-block; ">
                                                <p class="kjs_index_txt_sj">
                                                    <span class="dbX">试听</span></p>
                                                <div class="qieh"></div>
                                            </a>
                                        </div>
                                    </c:otherwise>
                                </c:choose>
                            </shiro:user>
                        </div>
                        <div class="kjsStar">
                            <div>学员:${course.courseStuNum}人</div>
                            <div class="kjsPf clearfloat">
                                <c:forEach begin="1" end="${course.score}">
                                    <a class="restIcon kjsXxcur"></a>
                                </c:forEach>
                                <c:if test="${course.score < 5}">
                                    <c:forEach begin="1" end="${5-course.score}">
                                        <a class="restIcon"></a>
                                    </c:forEach>
                                </c:if>
                            </div>
                        </div>
                    </div>
                </li>
            </c:forEach>
        </ul>
    </div>
</div>
</body>
</html>