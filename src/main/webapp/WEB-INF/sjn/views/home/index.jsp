<%--
  Created by IntelliJ IDEA.
  User: lihengming
  Date: 2016/6/20
  Time: 14:53
  To change this template use File | Settings | File Templates.
--%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%--<%@ page contentType="text/html;charset=UTF-8" language="java" %>--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path;
    request.setAttribute("realPath",request.getServerName());
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="description" content="设计牛-互联网设计实训平台,在线提供UI设计培训,UI设计,UI培训,UI,室内设计,室内设计培训,室内设计培训班,平面设计培训,平面设计,平面设计培训,广告设计,PS教程,PS抠图教程,设计牛,摄影技巧名师视频与直播课程,助你成为设计大牛！"/>
    <meta name="page" content="index-page">
    <c:if test="${realPath == 'www.shejiniu.net'}">
        <meta name="keywords"
              content="UI设计培训,UI设计,UI培训,UI,室内设计,室内设计培训,室内设计培训班,平面设计培训,平面设计,平面设计培训班,广告设计,PS教程,PS抠图教程,设计牛,摄影技巧"/>
        <title>设计牛-互联网设计实训平台</title>
    </c:if>
    <link href="${basePath}/resources/common/css/rest.css" rel="stylesheet">
    <link href="${basePath}/resources/index/css/kjs-index.css" rel="stylesheet">
    <link rel="stylesheet" href="${basePath}/resources/login/css/touxiang.css"/>
    <link rel="stylesheet" href="${basePath}/resources/userCenter/css/studyGood.css"/>
    <link rel="stylesheet" href="${basePath}/resources-sjn/index/css/index.css"/>
    <link rel="stylesheet" href="${basePath}/resources-sjn/index/css/login.css"/>
    <link rel="stylesheet" href="${basePath}/resources-sjn/index/css/register.css"/>
    <link rel="stylesheet" href="${basePath}/resources-sjn/index/css/password.css"/>
    <script src="${basePath}/resources/common/js/jquery-1.9.1.js"></script>
    <script src="${basePath}/resources/common/layer-v2.3/layer/layer.js"></script>
    <script src="${basePath}/resources/common/js/jquery.cookie.js"></script>
    <script src="${basePath}/resources-sjn/common/js/utils.js"></script>
    <script src="${basePath}/resources/common/js/jquery-latest.min.js"></script>
    <script src="${basePath}/resources/common/js/unslider.js"></script>

    <script src="${basePath}/resources/common/js/move.js"></script>
    <script src="${basePath}/resources/index/js/jqeryLB.js"></script>
    <style type="text/css">
        #add-app{position: relative;}
        #add-ewm{position: relative;}
        #add-app:hover .addapp-ewm{display: block;}

        #add-ewm:hover .addewm-ewm{display: block;}
        .addewm-ewm{ width: 174px; height: 220px; background: url("/resources-sjn/course/images/wxhG.png") no-repeat; position: absolute; bottom: -220px; left: -35px;z-index: 2; display: none;}
        .addapp-ewm{ width: 174px; height: 220px; background: url("/resources-sjn/index/images/appG.png") no-repeat; position: absolute; bottom: -220px; left: -35px;z-index: 2;display: none;}
        .too-ewm em{background: url("/resources-sjn/index/images/app-ewm.png") no-repeat;}

    </style>
    <script type="text/javascript">

    </script>
</head>
<body class="body" testMobile="${SESSION_USER.mobile}">
<div class="FloatOn1">
    <span class="sb-close" >x</span>
    <div class="FloatOn">
    </div>
</div>
<div class="widthBfB" mast="${practiceUrl}" vip="${SESSION_USER.vipId}">
    <div class="width clearfloat">
        <a class="fl" style="position: relative;" href="${basePath}/"><img src="/resources-sjn/index/images/login.png" style="width: 160px;"/>
            <span class="index-loglog"><img src="/resources-sjn/index/images/index-loG.gif"/> </span>
            <%-- <span style="color:#999;font-size: 12px;font-family:楷体;margin-left: 5px;position: relative;top:10px;" id="logo-text"></span>--%>
        </a>

        <%-- <script>
             var logoT='互联网会计实训平台';
             var leng=logoT.length;
             var now=0;
             var logoText='';
             var timer;
             timer=setInterval(function(){
                  if(now==leng){r
                      setTimeout(function(){
                          now=0;
                          logoText='';
                      },2000)
                  }
                 logoText+=logoT.charAt(now);
                 $('#logo-text').text(logoText);
                 now++;
             },500)

         </script>--%>
        <div class="kjsSearch ">
            <div class="kjsInput">
                <div class="kjsbox">
                    <input style="color:#bbb" data-tag="你希望学习什么？" value="你希望学习什么？"
                           onfocus="if(this.value=='你希望学习什么？'){this.value=''};this.style.color='#333';"
                           onblur="if(this.value==''||this.value=='你希望学习什么？'){this.value='你希望学习什么？';this.style.color='#BBB';}"
                           id="search-word">
                </div>
                <a class="kjsSeaBtn" id="search-btn">搜索</a>
            </div>
            <div class="kjsHot">
                <c:if test="${fn:length(hots) > 0}">
                    热门：
                    <c:forEach items="${hots}" var="hot">
                        <a href="${basePath}/search?word=${hot.content}">${hot.content}</a>
                    </c:forEach>
                </c:if>
            </div>
        </div>
        <div class="kjsRecord">
            <div class="kjsRetext " id="kjsHove">
                <i class="restIcon kjsRicon sjnIcon_time"></i>我的播放记录<i class="restIcon kjsJt"></i>
            </div>
            <div class="kjsRcontent" id="kjsCon">
                <shiro:guest>
                    <p>查看播放记录,请<a onclick="Util.User.indexLogin()">登录</a></p>
                </shiro:guest>
                <shiro:user>
                    <div class="kjsRmessage">
                        <c:choose>
                            <c:when test="${histories!=null && fn:length(histories) > 0}">
                                <c:forEach items="${histories}" var="history">
                                    <a href="${basePath}/course/play/${history.courseId}?isUserPlay=true&lectureId=${history.lectureid}">${history.courseName}-${history.lectureName}</a>
                                </c:forEach>
                            </c:when>
                            <c:otherwise>
                                暂无播放记录！
                            </c:otherwise>
                        </c:choose>
                    </div>

                </shiro:user>
            </div>
        </div>
    </div>
</div>

<div class="kjsNav">
    <div class="kjsNavBg">
        <div class="kjsNavCon">
            <div class="kjsNavCfl fl"><i class="restIcon"></i>全部课程分类</div>
            <div class="kjsNavlist">
                <a href="${basePath}/">首页</a>
                <a href="${basePath}/course">课程</a>
                <a href="${basePath}/live" class="kjsZb">直播<%--<span class="kjsZbNum">20</span>--%></a>
                <a href="${basePath}/stu-evaluate">学员好评</a>
                <a href="${basePath}/vip">开通会员</a>
                <a id="add-app" >下载APP<div class="addapp-ewm"></div></a>
                <a id="add-ewm" >关注微信<div class="addewm-ewm"></div></a>
            </div>
        </div>
    </div>
    <div class="kjsBotPic" style="overflow:hidden;">
        <div class="kjsBotLb" id="kjsJb">
            <c:forEach items="${banners}" var="banner" varStatus="s">
                <c:if test="${s.last}">
                    <input type="hidden" id="defaultBgColor" value="${banner.bgcolor}"/>
                </c:if>
                <a data_bgcolor="${banner.bgcolor}" href="${banner.hrefUrl}" style="background: url('${banner.pathUrl}') no-repeat center;background-size: 100% 100%;filter:progid:DXImageTransform.Microsoft.AlphaImageLoader(src='${banner.pathUrl}',  sizingMethod='scale');" target="_blank"></a>
            </c:forEach>
        </div>
        <ul class="kjsD clearfloat">
            <c:forEach items="${banners}" var="banner" varStatus="status">
                <li<c:if test="${status.last}"> class="cur" </c:if>></li>
            </c:forEach>
        </ul>

        <div class="kjsXzCrouse">
            <div class="kjsBanBtn">
                <a class="kjsBanBtnL"></a>
                <a class="kjsBanBtnR"></a>
            </div>
            <div id="guest-div"
                 <shiro:user>style="display: none;"</shiro:user> class="kjsDl">
                <div class="kjsDlBtn">
                    <a id="login-modal-btn" class="kjsDlbtn1">登录</a>
                    <a id="register-modal-btn" class="kjsDlbtn2">注册</a>
                </div>
                <div class="end-Vip">
                    <span class="left-line"></span>
                    <span class="Vip-title">会员特权</span>
                    <span class="right-line"></span>

                </div>
                <div class="exhibition">
                    <a class="dlXj-num1" data_flag="1">
                        <i></i>
                        <p>看全部课程</p>
                    </a>
                    <a class="dlXj-num2" data_flag="2">
                        <i></i>
                        <p>直播课</p>
                    </a>
                    <a class="dlXj-num3" data_flag="3">
                        <i></i>
                        <p>APP观看</p>
                    </a>
                    <a class="dlXj-num4" data_flag="4">
                        <i></i>
                        <p> 老师答疑</p>
                    </a>

                </div>
                <p class="cost">最低<span>99</span>元/月，畅听所有课程</p>
                <a class="dredge-vip" href="/vip">开通会员</a>
                <%--<div class="kjsDlTx">--%>
                <%--<div class="head-portrait">--%>
                <%--<img src="${basePath}/resources/common/images/photo.jpg">--%>
                <%--</div>--%>
                <%--</div>--%>
                <%--<p>欢迎来到设计牛</p>--%>
                <%--<div class="kjsDlBtn">--%>
                <%--<a id="login-modal-btn" class="kjsDlbtn1">登录</a>--%>
                <%--<a id="register-modal-btn" class="kjsDlbtn2">注册</a>--%>
                <%--</div>--%>
                <%--<div class="kjsDlyd clearfloat">--%>
                <%--<a class="dlXj-num1" data_flag="1">--%>
                <%--<i class="index_transition"></i>--%>
                <%--<p>学习计划</p>--%>
                <%--</a>--%>
                <%--<a class="dlXj-num2" data_flag="2">--%>
                <%--<i class="index_transition"></i>--%>
                <%--<p>学习资料</p>--%>
                <%--</a>--%>
                <%--<a class="dlXj-num3" data_flag="3">--%>
                <%--<i class="index_transition"></i>--%>
                <%--<p>成长记录</p>--%>
                <%--</a>--%>
                <%--<a class="dlXj-num4" data_flag="4">--%>
                <%--<i class="index_transition"></i>--%>
                <%--<p>老师答疑</p>--%>
                <%--</a>--%>
                <%--<div class="kjsJdCon">--%>
                <%--</div>--%>
                <%--</div>--%>
            </div>


            <div class="kjsNav2">
                <div class="sjn2L">

                    <c:forEach items="${directions}" var="dire">
                        <div  <c:if test="${fn:length(dire.positions) > 4}"> class="more"</c:if>>
                            <a href="${basePath}/course?directionId=${dire.id}" class="sjn2_a">
                                <p>${dire.categoryDesc}<c:if test="${fn:length(dire.positions) > 4}"><i class="restIcon kjsJjpic"></i></c:if></p>
                            </a>

                            <ul>
                                <c:forEach items="${dire.positions}" var="position" varStatus="status">
                                    <c:if test="${status.index < 4}">
                                        <a href="${basePath}/course?directionId=${dire.id}&positionId=${position.id}">
                                            <li>
                                                <c:choose>
                                                    <c:when test="${fn:length(position.categoryDesc) > 5}">
                                                        ${fn:substring(position.categoryDesc, 0, 4)}...
                                                    </c:when>
                                                    <c:otherwise>
                                                        ${position.categoryDesc}
                                                    </c:otherwise>
                                                </c:choose>

                                            </li>
                                            <span class="bot_xs">${position.categoryDesc}</span>
                                        </a>
                                    </c:if>
                                </c:forEach>
                            </ul>
                        </div>
                    </c:forEach>

                </div>
                <div class="kjsnav2Con">
                    <c:forEach items="${directions}" var="dire">
                        <div style="display: none;">
                            <div class="Kjszyr fr">
                                <div class="kjsZyTit">
                                    选择类别
                                </div>
                                <div class="kjsZyflr">
                                    <c:forEach items="${dire.positions}" var="position" varStatus="status">
                                        <a href="${basePath}/course?directionId=${dire.id}&positionId=${position.id}"><c:choose><c:when
                                                test="${fn:length(position.categoryDesc) > 5}">${fn:substring(position.categoryDesc, 0, 5)}...</c:when><c:otherwise> ${position.categoryDesc}</c:otherwise></c:choose><span class="bot_xs">${position.categoryDesc}</span></a>
                                    </c:forEach>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </div>

            </div>
            <%--已登录--%>
            <div id="user-div"
                 <shiro:guest>style="display: none;"</shiro:guest> class="record">
                <%--<div class="record-top">--%>
                <%--<div class="head-portrait">--%>
                <%--<a href="${basePath}/userCenter">--%>
                <%--<c:choose>--%>
                <%--<c:when test="${SESSION_USER.imgurl != null && SESSION_USER.imgurl != '' }">--%>
                <%--<img id="head-image" src="${SESSION_USER.imgurl}">--%>
                <%--</c:when>--%>
                <%--<c:otherwise>--%>
                <%--<img id="head-image" src="${basePath}/resources/common/images/photo.jpg">--%>
                <%--</c:otherwise>--%>
                <%--</c:choose>--%>
                <%--</a>--%>
                <%--</div>--%>
                <%--<p id="username">--%>
                <%--HI!<a href="${basePath}/userCenter">--%>
                <%--<c:choose>--%>
                <%--<c:when test="${fn:length(SESSION_USER.displayName)>12 }">--%>
                <%--${ fn:substring(SESSION_USER.displayName,0,13)}...--%>
                <%--</c:when>--%>
                <%--<c:otherwise>--%>
                <%--${SESSION_USER.displayName}--%>
                <%--</c:otherwise>--%>
                <%--</c:choose>--%>
                <%--</a>--%>
                <%--<a id="exit" href="${basePath}/logout">退出</a>--%>
                <%--</p>--%>
                <%--</div>--%>
                <div class="personal-details">
                    <div class="personal-left">
                        <a href="${basePath}/userCenter">
                            <c:choose>
                                <c:when test="${SESSION_USER.imgurl != null && SESSION_USER.imgurl != '' }">
                                    <img id="head-image" src="${SESSION_USER.imgurl}">
                                </c:when>
                                <c:otherwise>
                                    <img id="head-image" src="${basePath}/resources/common/images/photo.jpg">
                                </c:otherwise>
                            </c:choose>
                        </a>
                    </div>
                    <div class="personal-right">
                        <div class="number">
                            <span>
                        HI!&nbsp<a id="number-one" title="${SESSION_USER.displayName}" href="${basePath}/userCenter">
                                ${SESSION_USER.displayName}
                                <%--<c:choose>--%>
                                <%--<c:when test="${fn:length(SESSION_USER.displayName)>6 }">--%>
                                <%--${ fn:substring(SESSION_USER.displayName,0,6)}...--%>
                                <%--</c:when>--%>
                                <%--<c:otherwise>--%>
                                <%--${SESSION_USER.displayName}--%>
                                <%--</c:otherwise>--%>
                                <%--</c:choose>--%>
                            </a>
                                </span>
                            <a id="exit" href="${basePath}/logout">退出</a></div>
                        <div class="deadline">

                            <c:choose>
                                <c:when test="${SESSION_USER.vipId  == 1}">
                                    <span style="background: url('/resources/common/images/indexIcon.png') no-repeat;background-position: 0 -89px;"></span>
                                    <p><fmt:formatDate value="${SESSION_USER.vipExpireTime}" pattern="yyyy-MM-dd" type="date" dateStyle="long" />到期</p>
                                </c:when>
                                <c:when test="${SESSION_USER.vipId  == 2}">
                                    <span style="background: url('/resources/common/images/indexIcon.png') no-repeat;background-position: 0 -109px;"></span>
                                    <p><fmt:formatDate value="${SESSION_USER.vipExpireTime}" pattern="yyyy-MM-dd" type="date" dateStyle="long" />到期</p>
                                </c:when>
                                <c:when test="${SESSION_USER.vipId  == 3}">
                                    <span style="background: url('/resources/common/images/indexIcon.png') no-repeat;background-position: 0 -129px;"></span>

                                    <p><fmt:formatDate value="${SESSION_USER.vipExpireTime}" pattern="yyyy-MM-dd" type="date" dateStyle="long" />到期</p>
                                </c:when>
                                <c:otherwise>
                                    <span style="background: url('/resources/common/images/indexIcon.png') no-repeat;background-position: 0 -69px;"></span>
                                </c:otherwise>
                            </c:choose>

                        </div>
                        <div class="deadline-one"><span></span><p>剩余<small>7</small>天到期</p></div>
                    </div>
                </div>
                <div class="end-Vip">
                    <span class="left-line"></span>
                    <span class="Vip-title">会员特权</span>
                    <span class="right-line"></span>

                </div>
                <div class="exhibition">
                    <a class="dlXj-num1" data_flag="1">
                        <i></i>
                        <p>看全部课程</p>
                    </a>
                    <a class="dlXj-num2" data_flag="2">
                        <i></i>
                        <p>直播课</p>
                    </a>
                    <a class="dlXj-num3" data_flag="3">
                        <i></i>
                        <p>APP观看</p>
                    </a>
                    <a class="dlXj-num4" data_flag="4">
                        <i></i>
                        <p> 老师答疑</p>
                    </a>

                </div>
                <c:choose>
                    <c:when test="${SESSION_USER.vipId  == 1||SESSION_USER.vipId  == 2||SESSION_USER.vipId  == 3}">
                        <p class="cost">会员还有<span id="the-Time">${day}</span>天到期</p>
                        <a class="dredge-vip" href="/vip">立即续费</a>
                    </c:when>
                    <c:otherwise>
                        <p class="cost">最低<span>99</span>元/月，畅听所有课程</p>
                        <a class="dredge-vip" href="/vip">开通会员</a>
                    </c:otherwise>
                </c:choose>
                <%--<div class="record-on">--%>
                <%--<div class="recordOn-left">--%>
                <%--<img src="${basePath}/resources-sjn/index/images/sjn_dl.png">--%>
                <%--</div>--%>
                <%--<div class="recordOn-right">--%>
                <%--<c:choose>--%>
                <%--<c:when test="${histories!=null && fn:length(histories) > 0}">--%>
                <%--<p class="bt">上次学到：</p>--%>
                <%--<a href="${basePath}/course/play/${histories[0].courseId}?isUserPlay=true&lectureId=${histories[0].lectureid}"--%>
                <%--class="nr">${histories[0].courseName}</a>--%>
                <%--<p class="zj">--%>
                <%--学习了<span--%>
                <%--style="color: #5583db;">${histories[0].lectureNum}</span>/${histories[0].courseLectureCount}课程小节--%>
                <%--</p>--%>
                <%--</c:when>--%>
                <%--<c:otherwise>--%>
                <%--<p class="bt">上次学到：</p>--%>
                <%--<p class="zj">还没有学习课程哦！</p>--%>
                <%--</c:otherwise>--%>
                <%--</c:choose>--%>
                <%--</div>--%>
                <%--</div>--%>
                <%--<div class="record-bottom">--%>
                <%--<div class="recordBottom-left">--%>
                <%--<img src="${basePath}/resources-sjn/index/images/sjn_dl1.png">--%>
                <%--</div>--%>
                <%--<div class="recordBottom-right">--%>
                <%--<p class="bt">成长记录：</p>--%>
                <%--<p class="bottom-nr">--%>
                <%--<div class="report"><a href="${basePath}/userCenter?m=3" style="color: white;">查看报告</a></div>--%>
                <%--</p>--%>
                <%--</div>--%>
                <%--</div>--%>
            </div>
        </div>
    </div>
</div>

<!--课程内容-->
<div class="kjsContent" style="display: none;">
    <div class="kjsLikeKc">
        <p>直播课</p>
        <%--   <a><i class="restIcon kjsF5"></i>换一批</a>--%>
    </div>
    <div class="kjsCrouse">
        <ul class="clearfloat" id="love-course-list">
            <c:forEach items="${liveSets}" var="course">
                <li endId="${course.id}" endzt="${course.livingFlag}"　liveId="${course.id}" endtype="${course.liveType}">
                    <div class="kjsCimg"><img
                            src="${course.teacherUrl}" style="cursor: text;"> <%--${course.coverUrl}--%>
                        <c:if test="${course.liveType==0}">
                            <span class="near"></span>
                        </c:if>
                    </div>
                    <div class="kjsCTwo">
                        <div class="clearfloat">
                                <%--<shiro:guest>--%>
                                <%--<p class="fl kjsSttext">会员免费</p>--%>

                                <%--<div class="HoverRight">--%>
                                <%--<a href="${basePath}/course/play/${course.id}" style="display:inline-block; ">--%>
                                <%--<p class="kjs_index_txt_sj">--%>
                                <%--<span class="dbX">试听</span></p>--%>
                                <%--<div class="qieh"></div>--%>
                                <%--</a>--%>
                                <%--</div>--%>
                                <%--</shiro:guest>--%>
                                <%--<shiro:user>--%>
                                <%--<c:choose>--%>
                                <%--<c:when test="${SESSION_USER.isVIP}">--%>
                                <%--<div class="HoverRight">--%>
                                <%--<a href="${basePath}/course/play/${course.id}"--%>
                                <%--style="display:inline-block; ">--%>
                                <%--<p class="kjs_index_txt_sj">--%>
                                <%--<span class="dbX">听课</span></p>--%>
                                <%--<div class="qieh"></div>--%>
                                <%--</a>--%>
                                <%--</div>--%>
                                <%--</c:when>--%>
                                <%--<c:otherwise>--%>
                            <p class="fl kjsSttext mart" style="font-size: 12px!important;" moststart="${course.startTimeLong}" mostend="${course.endTimeLong}"></p>

                            <div class="HoverRight">
                                <a href="${basePath}/course/play/" style="display:inline-block; ">
                                    <p class="kjs_index_txt_sj">
                                        <span class="dbX"></span></p>
                                        <%--<div class="qieh"></div>--%>
                                </a>
                            </div>

                                <%--</c:otherwise>--%>
                                <%--</c:choose>--%>
                                <%--</shiro:user>--%>
                        </div>
                        <div class="kjsStar">
                            <div class="Xysl">${course.flowerName}</div>
                            <div class="kjsPf clearfloat addbf">

                                    <%--<c:choose>--%>
                                    <%--<c:when test="${course.score ==null||course.score==0}">--%>
                                    <%--<a class="restIcon"></a>--%>
                                    <%--<a class="restIcon"></a>--%>
                                    <%--<a class="restIcon"></a>--%>
                                    <%--<a class="restIcon"></a>--%>
                                    <%--<a class="restIcon"></a>--%>
                                    <%--</c:when>--%>
                                    <%--<c:otherwise>--%>
                                    <%--<c:forEach begin="1" end="${course.score}">--%>
                                    <%--<a class="restIcon kjsXxcur restIcon_sjn"></a>--%>
                                    <%--</c:forEach>--%>
                                    <%--<c:if test="${course.score < 5}">--%>
                                    <%--<c:forEach begin="1" end="${5-course.score}">--%>
                                    <%--<a class="restIcon"></a>--%>
                                    <%--</c:forEach>--%>
                                    <%--</c:if>--%>
                                    <%--</c:otherwise>--%>
                                    <%--</c:choose>--%>
                            </div>
                        </div>
                    </div>
                </li>

            </c:forEach>
        </ul>
    </div>
</div>
<c:forEach items="${homeSets}" var="set">

    <div class="kjsContent" id="name">
        <div class="kjsLikeKc">
            <p>${set.direction.categoryDesc}</p>
        </div>
        <div class="kjsCrouse clearfloat">
            <div class="kjsLw">
                <ul class="clearfloat">
                    <li class="kjsItem">
                        <a href="${set.leftHref}" style="height: 100%;width: 100%;">
                            <img src="${set.leftModule}">
                        </a>
                    </li>
                </ul>
            </div>
            <div class="kjsRw">
                <ul class="clearfloat">
                    <c:forEach items="${set.courses}" var="course">
                        <c:if test="${not empty course}">
                            <li>
                                <div class="kjsCimg"><a target="_blank"
                                                        href="${basePath}/course/detail/${course.id}"><img
                                        src="${course.coverUrl}"> </a><%--${course.coverUrl}--%>
                                </div>
                                <div class="kjsCTwo">
                                    <div class="clearfloat">
                                        <shiro:guest>
                                            <p class="fl kjsSttext">会员免费</p>
                                            <div class="HoverRight">
                                                <a href="${basePath}/course/play/${course.id}"
                                                   style="display:inline-block; ">
                                                    <p class="kjs_index_txt_sj">
                                                        <span class="dbX">试听</span></p>
                                                    <div class="qieh"></div>
                                                </a>
                                            </div>
                                            <%--
                                                                                        <a class="audBtn fr" href="${basePath}/course/play/${course.id}">试听</a>
                                            --%>
                                        </shiro:guest>
                                        <shiro:user>
                                            <c:choose>
                                                <c:when test="${SESSION_USER.isVIP}">
                                                    <div class="HoverRight">
                                                        <a href="${basePath}/course/play/${course.id}"
                                                           style="display:inline-block; ">
                                                            <p class="kjs_index_txt_sj">
                                                                <span class="dbX">听课</span></p>
                                                            <div class="qieh"></div>
                                                        </a>
                                                    </div>
                                                </c:when>
                                                <c:otherwise>
                                                    <p class="fl kjsSttext">会员免费</p>
                                                    <div class="HoverRight">
                                                        <a href="${basePath}/course/play/${course.id}"
                                                           style="display:inline-block; ">
                                                            <p class="kjs_index_txt_sj">
                                                                <span class="dbX">试听</span></p>
                                                            <div class="qieh"></div>
                                                        </a>
                                                    </div>
                                                    <%--<a class="audBtn fr"
                                                       href="${basePath}/course/play/${course.id}">试听</a>--%>
                                                </c:otherwise>
                                            </c:choose>
                                        </shiro:user>
                                    </div>
                                    <div class="kjsStar">
                                        <div class="Xysl">学员:${course.courseStuNum}人</div>
                                        <div class="kjsPf clearfloat">
                                            <c:choose>
                                                <c:when test="${course.score ==null||course.score==0}">
                                                    <a class="restIcon"></a>
                                                    <a class="restIcon"></a>
                                                    <a class="restIcon"></a>
                                                    <a class="restIcon"></a>
                                                    <a class="restIcon"></a>
                                                </c:when>
                                                <c:otherwise>
                                                    <c:forEach begin="1" end="${course.score}">
                                                        <a class="restIcon kjsXxcur restIcon_sjn"></a>
                                                    </c:forEach>
                                                    <c:if test="${course.score < 5}">
                                                        <c:forEach begin="1" end="${5-course.score}">
                                                            <a class="restIcon"></a>
                                                        </c:forEach>
                                                    </c:if>
                                                </c:otherwise>
                                            </c:choose>
                                        </div>
                                    </div>
                                </div>
                            </li>
                        </c:if>
                    </c:forEach>
                </ul>
            </div>
        </div>
    </div>
</c:forEach>

<div class="kjsContent">
    <div class="kjsLikeKc">
        <p>学员好评</p>
    </div>
    <div class="studV-content clearfloat" style="margin-bottom:50px">
        <div class="study-test clearfloat fl">
            <div class="fl study-pic"><img src="${basePath}/resources-sjn/userCenter/images/study-pic1.png"></div>
            <div class="fl study-right">
                <h2>鲍亚龙</h2>
                <div class="study-tittle">某互联网公司<span>UI设计师</span></div>
                <div class="study-content">
                    我来自内蒙古赤峰，到北京后做过很多种工作，有网络技术、运营专员等。在朋友推荐下学习了设计牛的UI设计课，感觉老师们教的非常棒，对我帮助很大。现在工作过程中如鱼得水，感谢设计牛的老师们。
                </div>
            </div>
        </div>
        <div class="study-test clearfloat fr">
            <div class="fl study-pic"><img src="${basePath}/resources-sjn/userCenter/images/study-pic2.png"></div>
            <div class="fl study-right">
                <h2>董洁</h2>
                <div class="study-tittle">某广告公司<span>设计师</span></div>
                <div class="study-content">
                    设计牛的老师们讲课好有耐心，远比大学的老师认真负责，而且内容也是实实在在工作中用到的，没有“假、大、空”形而上学那些套路。希望能够早日学完我的课程，尽快提升自我，加油！
                </div>
            </div>
        </div>
        <div class="study-test clearfloat fl">
            <div class="fl study-pic"><img src="${basePath}/resources-sjn/userCenter/images/study-pic3.png"></div>
            <div class="fl study-right">
                <h2>李照煜</h2>
                <div class="study-tittle">某装饰公司<span>室内设计师</span></div>
                <div class="study-content">
                    大学里学的就是环境艺术设计，只可惜毕业后缺乏工作经验，图纸做的都不好。在设计牛学习了几门课，老师讲的比较透彻，基本上我是听了一轮就掌握了，现在我做的作品很受客户的喜欢，开始找到自信了，感谢设计牛。
                </div>
            </div>
        </div>
        <div class="study-test clearfloat fr">
            <div class="fl study-pic"><img src="${basePath}/resources-sjn/userCenter/images/study-pic4.png"></div>
            <div class="fl study-right">
                <h2>王宇萌</h2>
                <div class="study-tittle">淘宝某小店<span>店主</span></div>
                <div class="study-content">
                    自己平日里经营着淘宝小店，常常遇到不会处理的产品图片，没有美工怎么可能让自己的宝贝美美的呢，每逢节假日，遇到活动就头疼，花钱找人做banner图，现在一切都好了，学会这些技术后再也不用担心了。一句话：感谢设计牛。
                </div>
            </div>
        </div>
    </div>
</div>


<%--<div class="index-stud" id="student-evaluate">
    <div class="index-stud-con">
        <img src="${basePath}/resources/index/images/index-stu-text.png" class="index-stud-tit">
        <div class="index-stud-vid clearfloat" id="index-video">
            <a class="index-stu-prev"></a>
            <div class="index-stu-ul">
                <ul id="ul" class="clearfloat" style="width: 1300px;">
                    <li>
                        <div class="index-stu-vsize">
                        </div>
                        <div class="index-stu-mes">
                            <p class="index-name">王大锤</p>
                            <p class="index-zw">外贸业务员</p>
                        </div>
                    </li>
                    <li>
                        <div class="index-stu-vsize">
                        </div>
                        <div class="index-stu-mes">
                            <p class="index-name">王大锤</p>
                            <p class="index-zw">外贸业务员</p>
                        </div>
                    </li>
                </ul>
            </div>
            <a class="index-stu-next"></a>
        </div>

    </div>
</div>--%>
<%--<div class="float-left">
    <div class="float-nav">导航</div>
    <div class="float-text">
        <c:forEach items="${homeSets}" var="set" varStatus="status">
            <a onclick="javascript:document.getElementById('name${status.index}').scrollIntoView()">${set.direction.categoryDesc}</a>
            &lt;%&ndash;    <a onclick="javascript:document.getElementById('name1').scrollIntoView()">会计</a>
                <a onclick="javascript:document.getElementById('name2').scrollIntoView()">教师</a>
                <a onclick="javascript:document.getElementById('name3').scrollIntoView()">建筑</a>&ndash;%&gt;
        </c:forEach>
    </div>
</div>--%>
<div class="toolbar">
    <c:choose>
        <c:when test="${SESSION_USER.vipId==1||SESSION_USER.vipId==2||SESSION_USER.vipId==3}">
            <a class="too-consult" id="zixun" href="javascript:void(0)"><i class="reUse"></i><em style="display: none;" ></em></a>
        </c:when>
        <c:otherwise>
            <a class="too-consult " id="qqxn"><i class="re"></i><em style="display: none;" ></em></a>
        </c:otherwise>
    </c:choose>
    <%-- <a class="too-ewm"><i class="restIcon"></i><em></em></a>--%>
    <%-- <a class="too-xn"><i class="restIcon"></i></a>--%>
    <a class="too-ewm"><i class="res"></i><em style="display: none;" data-end="1"></em></a>
    <a class="too-xn"><i class="resq"></i><em style="display: none;top: -158px;"></em></a>
    <a class="too-userDc" target="_blank" href="${basePath}/help?m=2"><i class="restIcon"></i></a>
    <a class="too-scrollT" id="top"><i class="restIcon"></i></a>

</div>
<div class="kjs-fotter">
    <div class="kjs-f-con">
        <div class="kjs-f-text clearfloat">
            <img src="${basePath}/resources-sjn/index/images/cow.png" class="kjs-f-l">
            <div class="kjs-f-c">
                <div class="kjs-f-about">
                    <a href="${basePath}/help?m=5">关于我们</a>|
                    <a href="${basePath}/vip">会员服务</a>|
                    <a href="${basePath}/help?m=3&sm=3">隐私条款</a>|
                    <a href="${basePath}/help?m=3">用户协议</a>|

                    <a href="${basePath}/help">帮助中心</a>|
                    <a href="${basePath}/help?m=4">联系我们</a>|
                    <a href="${basePath}/help?m=2">意见反馈</a>|
                    <a href="http://www.duia.com" target="_blank">去对啊网</a>
                </div>
                <div class="kjs-f-bq">
                    <span>Copyright@2013-2016</span>
                    <span>北京入行教育科技有限公司版权所有</span>
                    <a href="http://www.miit.gov.cn/" target="_blank" style="margin-right: 20px; color: #ddd;">京ICP备1601120号-7</a>
                    <a href="http://www.miit.gov.cn/" target="_blank" style="margin-right: 20px; color: #ddd;">京ICP证160803号</a>
                    <img style="margin-top: -3px;" src="/resources-sjn/index/images/picWb.png"/>
                    <a target="_blank" href="http://www.beian.gov.cn/portal/registerSystemInfo?recordcode=11030102010209" style="color: #dddddd;"><span>京公网安备11030102010209号</span></a>
                </div>
                <div style="color: #ddd;margin: 12px 8px 10px 9px;">
                    <a href="http://xwgdj.beijing.gov.cn/" target="_blank" style="color: #ddd;">出版物经营许可证（批发）新出发京批字第直170038号</a>
                </div>
            </div>
            <%--  <img src="${basePath}/resources/common/images/foter-ewm.png" class="kjs-f-r">--%>
        </div>
        <%--  <div class="sjn-ewm">
             <img src="${basePath}/resources-sjn/index/images/ewmWB.png" class="sjn_wb">
              <img src="${basePath}/resources-sjn/index/images/ewmWX.png" class="sjn_wx">
        </div>--%>
        <%--<img src="${basePath}/resources-sjn/index/images/bot_title.png" class="kjs-fo-tittle">--%>
        <a logo_size="124x47" style="position:absolute;top:0;right:0;" logo_type="realname" href="http://www.anquan.org" ><script src="http://static.anquan.org/static/outer/js/aq_auth.js"></script></a>
    </div>
</div>
<%--<div style="text-align: center;width: 100%; margin-top: 20px;">
    <script src="http://kxlogo.knet.cn/seallogo.dll?sn=e17010611011566150zwak000000&size=0"></script>
    &nbsp;&nbsp;
    <a logo_size="124x47" logo_type="realname" href="http://www.anquan.org" ><script src="http://static.anquan.org/static/outer/js/aq_auth.js"></script></a>
    <div style="margin-top: 20px;"></div>
</div>--%>
<a id="window" style="display:none;" target="_blank"></a>
<a id="qq" style="display:none;" target="_blank"></a>
<script src="${basePath}/resources-sjn/index/js/index.js"></script>
<script type="text/javascript">
    $(".sjn2L .more").hover(function () {
        focusTwo = $(".sjn2L div").index(this);
        $(".kjsnav2Con").css("display", "block");
        $(".kjsnav2Con").children("div").eq(focusTwo).css("display", "block");

    }, function () {
        $(".kjsnav2Con").hover(function () {
            $(".kjsnav2Con").css("display", "block");
            $(".kjsnav2Con").children("div").eq(focusTwo).css("display", "block");

        }, function () {
            $(".kjsnav2Con").css("display", "none");
            $(".kjsnav2Con").children("div").eq(focusTwo).css("display", "none");

        })
        $(".kjsnav2Con").css("display", "none");
        $(".kjsnav2Con").children("div").eq(focusTwo).css("display", "none");

    })

    $(".wx_ewm").hover(function () {
        $(".wx_left").css("display", "block")
    }, function () {
        $(".wx_left").css("display", "none")
    })
    /*$(".sjn2L div").hover(function(){
     $(this).addClass("sjn-hover")
     },function(){
     $(this).removeClass("sjn-hover")
     })*/
    $(".more").each( function() {
        $(this).mouseenter(function() {
            $(this).addClass("sjn-hover")
        } );
        $(this).mouseleave(function() {
            $(this).removeClass("sjn-hover")
        } );
    } );
</script>
<script type="text/javascript">
    $(document).ready(function(){
        var mt = $("#number-one").text();

        if($("#number-one").attr("title").replace(/[^\u0000-\u00ff]/g,"aa").length>12){
            var n = $("#number-one").attr("title").substring(0,6)+'...';
            $("#number-one").text(n)
        }
    })
    $(function(){
        $(".sb-close").click(function(){
//            $(".FloatOn").css("display","none")
            $(".FloatOn1").css("display","none")
//          $(".sb-close").css("display","none")
//            setCookie('close_xn_index','yes',"xn")
//            document.cookie="sb-index=1"
        })
    });
    setInterval(function () {
        $(".sku-one").animate({
            height: Math.round(Math.random() * 8 + 1) + "px"
        }, 350)
        $(".sku-two").animate({
            height: Math.round(Math.random() * 8 + 1) + "px"
        }, 350)
        $(".sku-three").animate({
            height: Math.round(Math.random() * 8 + 1) + "px"
        }, 350)
    }, 350);

    // var vip = $(".widthBfB").attr("vip");
    // var scUrl = $(".widthBfB").attr("mast")
    // $.ajax({
    //     type: "POST",
    //     url: "/practice/get/url",
    //     success: function (result) {
    //         if (result.success) {
    //             $("#window").attr('href',result.data.url1);
    //         }
    //     }
    // })
    function scClick() {
        document.getElementById('window').click();
    }
    function scFun() {
        if (vip == 1 || vip == 2 || vip == 3) {
            scClick();
        } else {
            if (getCookie("taxAuth") != null && getCookie("taxAuth") != '') {
                if (getCookie("taxDays") != null && getCookie("taxDays") != '') {
                    scClick();
                } else {
                    $(".index-shadeO").css("display", "block")
                }
            } else {
                setCookie("taxAuth", 1, 30);
                setCookie("taxDays", 1, 1);
                scClick();
            }
        }
    }

    //设置cookie
    function setCookie(cname, cvalue, exdays) {
        var tme = new Date();
        var ty = tme.getFullYear(); //获取完整的年份(4位,1970-????)
        var tm = tme.getMonth()+1; //获取当前月份(0-11,0代表1月)
        var td = tme.getDate();
        var thour = tme.getHours();
        var tmin= tme.getMinutes();
        var tmiao = tme.getSeconds();
        var ttt=exdays*(86400-(thour*60*60+tmin*60+tmiao))*1000
        var d = new Date();
        if(exdays == "xn"){
            d.setTime(d.getTime() + 60*1000);
            var expires = "expires="+d.toUTCString();
            document.cookie = cname + "=" + cvalue + "; " + expires;

        }else{
            d.setTime(d.getTime() + ttt);
            var expires = "expires="+d.toUTCString();
            document.cookie = cname + "=" + cvalue + "; " + expires
//                    +":domain=test2.duia.com: path=/"
        }

    }
    //获取cookie
    function getCookie(name)
    {
        var arr,reg=new RegExp("(^| )"+name+"=([^;]*)(;|$)");
        if(arr=document.cookie.match(reg))
            return (arr[2]);
        else
            return null;
    }
    //清除cookie
    function clearCookie(name) {
        setCookie(name, "", -1);
    }
    function checkCookie() {
        var user = getCookie("username");
        if (user != "") {
            alert("Welcome again " + user);
        } else {
            user = prompt("Please enter your name:", "");
            if (user != "" && user != null) {
                setCookie("username", user, 365);
            }
        }
    }
    $(".scClose").click(function(){
        $(".index-shadeO").css("display","none")
    });
    $(".endClose").click(function(){
        $(".index-shade").css("display","none")
    });
</script>
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
<script type="text/javascript">
    var consultDetail;
    $(document).ready(function(){

        var vip = $(".widthBfB").attr("vip");
        var datas ={pageNo:1};
        $.ajax({
            type: "POST",
            url:'/consult/detail',
            data:datas,
            success: function(result) {
                consultDetail=result.data

                if (result.data.leftUrl!=null&&getCookie("close_xn_index")!="yes"&&vip==0){
                    var t = '<a><img src='+result.data.imgUrl+'></a>'
                    $(".FloatOn").append(t)
                    $(".FloatOn1").css("display","block")

                }else{
                    $(".FloatOn1").css("display","none")
                }
                if (result.data.rightUrl!=null) {
                    $("#qqxn").css("display","block")
                }else{
                    $("#qqxn").css("display","none")
                }
                if(result.data.groupUrl){
                    $("#zixun").css("display", "block");
                }else{
                    $("#zixun").css("display", "none");
                }
                $('#qq').attr('href','http://'+result.data.groupUrl);
            }
        });
    })
    $(".FloatOn").click(function(){
        var datas ={pageNo:1};
        $.ajax({
            type: "POST",
            url:'/consult/detail',
            data:datas,
            success: function(result) {
                if (result.success) {
                    NTKF.im_openInPageChat(result.data.leftUrl);
                }
            }
        });

    })





    $(".too-consult").click(function(){

        if(vip!=1 && vip!=2 && vip!=3){
            //小能
            NTKF.im_openInPageChat(consultDetail.rightUrl);
        }else{
            //qq
            document.getElementById('qq').click();

        }


    })

    var vip = $(".widthBfB").attr("vip");
    var scUrl = $(".widthBfB").attr("mast")
    $.ajax({
        type: "POST",
        url: "/practice/get/url",
        success: function (result) {
            if (result.success) {
                $("#window").attr('href',result.data.url1);
            }
        }
    })
    function scClick() {
        document.getElementById('window').click();
    }
    function scFun() {
        if (vip == 1 || vip == 2 || vip == 3) {
            scClick();
        } else {
            if (getCookie("taxAuth") != null && getCookie("taxAuth") != '') {
                if (getCookie("taxDays") != null && getCookie("taxDays") != '') {
                    scClick();
                } else {
                    $(".index-shadeO").css("display", "block")
                }
            } else {
                setCookie("taxAuth", 1, 30);
                setCookie("taxDays", 1, 1);
                scClick();
            }
        }
    }

    //设置cookie
    function setCookie(cname, cvalue, exdays) {
        var tme = new Date();
        var ty = tme.getFullYear(); //获取完整的年份(4位,1970-????)
        var tm = tme.getMonth()+1; //获取当前月份(0-11,0代表1月)
        var td = tme.getDate();
        var thour = tme.getHours();
        var tmin= tme.getMinutes();
        var tmiao = tme.getSeconds();
        var ttt=exdays*(86400-(thour*60*60+tmin*60+tmiao))*1000
        var d = new Date();
        if(exdays == "xn"){
            d.setTime(d.getTime() + 60*1000);
            var expires = "expires="+d.toUTCString();
            document.cookie = cname + "=" + cvalue + "; " + expires;

        }else{
            d.setTime(d.getTime() + ttt);
            var expires = "expires="+d.toUTCString();
            document.cookie = cname + "=" + cvalue + "; " + expires
//                    +":domain=test2.duia.com: path=/"
        }

    }
    //获取cookie
    function getCookie(name)
    {
        var arr,reg=new RegExp("(^| )"+name+"=([^;]*)(;|$)");
        if(arr=document.cookie.match(reg))
            return (arr[2]);
        else
            return null;
    }
    //清除cookie
    function clearCookie(name) {
        setCookie(name, "", -1);
    }
    function checkCookie() {
        var user = getCookie("username");
        if (user != "") {
            alert("Welcome again " + user);
        } else {
            user = prompt("Please enter your name:", "");
            if (user != "" && user != null) {
                setCookie("username", user, 365);
            }
        }
    }
    $(".scClose").click(function(){
        $(".index-shadeO").css("display","none")
    });
    $(".endClose").click(function(){
        $(".index-shade").css("display","none")
    });
</script>
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
<%--<script type="text/javascript" src="http://dl.ntalker.com/js/xn6/ntkfstat.js?siteid=kf_9751" charset="utf-8"></script>--%>
<%--<script type="text/javascript">--%>
    <%--var consultDetail;--%>
    <%--$(document).ready(function(){--%>

        <%--var vip = $(".widthBfB").attr("vip");--%>
        <%--var datas ={pageNo:1};--%>
        <%--$.ajax({--%>
            <%--type: "POST",--%>
            <%--url:'/consult/detail',--%>
            <%--data:datas,--%>
            <%--success: function(result) {--%>
                <%--consultDetail=result.data--%>

                <%--if (result.data.leftUrl!=null&&getCookie("close_xn_index")!="yes"&&vip==0){--%>
                    <%--var t = '<a><img src='+result.data.imgUrl+'></a>'--%>
                    <%--$(".FloatOn").append(t)--%>
                    <%--$(".FloatOn1").css("display","block")--%>

                <%--}else{--%>
                    <%--$(".FloatOn1").css("display","none")--%>
                <%--}--%>
                <%--if (result.data.rightUrl!=null) {--%>
                    <%--$("#qqxn").css("display","block")--%>
                <%--}else{--%>
                    <%--$("#qqxn").css("display","none")--%>
                <%--}--%>
                <%--if(result.data.groupUrl){--%>
                    <%--$("#zixun").css("display", "block");--%>
                <%--}else{--%>
                    <%--$("#zixun").css("display", "none");--%>
                <%--}--%>
                <%--$('#qq').attr('href','http://'+result.data.groupUrl);--%>
            <%--}--%>
        <%--});--%>
    <%--})--%>
    <%--$(".FloatOn").click(function(){--%>
        <%--var datas ={pageNo:1};--%>
        <%--$.ajax({--%>
            <%--type: "POST",--%>
            <%--url:'/consult/detail',--%>
            <%--data:datas,--%>
            <%--success: function(result) {--%>
                <%--if (result.success) {--%>
                    <%--NTKF.im_openInPageChat(result.data.leftUrl);--%>
                <%--}--%>
            <%--}--%>
        <%--});--%>

    <%--})--%>





    <%--$(".too-consult").click(function(){--%>

        <%--if(vip!=1 && vip!=2 && vip!=3){--%>
            <%--//小能--%>
            <%--NTKF.im_openInPageChat(consultDetail.rightUrl);--%>
        <%--}else{--%>
            <%--//qq--%>
            <%--document.getElementById('qq').click();--%>

        <%--}--%>


    <%--})--%>

<%--</script>--%>
<%--<script type="text/javascript" src="${basePath}/resources-sjn/index/js/timer.js"></script>--%>
<%--<script type="text/javascript">--%>
    <%--timers();--%>

    <%--$(document).ready(function(){--%>
        <%--$("#love-course-list li").find('.skip').css('cursor','default');--%>
        <%--$(".appointment").click(function(){--%>
            <%--var to = $(".appointment").index(this);--%>
<%--//            var es =  $("#love-course-list li").eq(to).attr("endId")--%>
            <%--var ms =  $(".body").attr("testMobile")--%>
            <%--var courseLiveId = $(".appointment").eq(to).closest("li").attr("endId");--%>
            <%--if(ms==""||ms==null){Util.User.login(function() {--%>
                <%--location.reload();--%>
            <%--});--%>
                <%--return false;--%>
            <%--}--%>

            <%--if( $(".appointment:eq("+to+") span").text()=="取消预约"){--%>
                <%--var dataef ={yes:false,mobile:ms,liveId:courseLiveId};--%>
                <%--$.ajax({--%>
                    <%--type:"POST",--%>
                    <%--url:"/live/booking",--%>
                    <%--data:dataef,--%>
                    <%--success:function(data){;--%>
                        <%--$(".appointment:eq("+to+") span").text("预约直播");--%>
                        <%--$(".appointment:eq("+to+") span").css({"color":"#fff","margin-left":"3px","top":"-2px"});--%>
                        <%--$(".appointment:eq("+to+")").removeClass("end-yes");--%>
                        <%--$(".appointment:eq("+to+") .appointment-ico").css("display","inline-block")--%>
                        <%--$(".appointment:eq("+to+") .appointment-ico").removeClass("subscribeyes-ico");--%>
                        <%--$(".appointment:eq("+to+")").unbind("mouseenter").unbind("mouseleave");--%>
                    <%--}--%>
                <%--})--%>
            <%--}else{--%>
                <%--var datas ={yes:true,mobile:ms,liveId:courseLiveId};--%>
                <%--$.ajax({--%>
                    <%--type:"POST",--%>
                    <%--url:"/live/booking",--%>
                    <%--data:datas,--%>
                    <%--success:function(data){--%>
                        <%--$(".appointment:eq("+to+") span").text("已预约");--%>
                        <%--$(".appointment:eq("+to+") span").css({"color":"#333333","left":"0px","margin-left":"0px","top":"-2px"});--%>
                        <%--$(".appointment:eq("+to+") .appointment-ico").addClass("subscribeyes-ico");--%>
                        <%--$(".appointment:eq("+to+")").addClass("end-yes");--%>
<%--//                        $(".appointment:eq("+to+") .prompt").css("display","block")--%>
<%--//                        setTimeout(function(){$(".appointment:eq("+to+") .prompt").css("display","none")},5000)--%>


                        <%--$(".appointment:eq("+to+")").bind({mouseenter:function(){--%>
                            <%--$(".appointment:eq("+to+") span").text("取消预约");--%>
                            <%--$(".appointment:eq("+to+") span").css({"color":"#ffffff","top":"1px"});--%>
                            <%--$(".appointment:eq("+to+")").removeClass("end-yes");--%>
                            <%--$(".appointment:eq("+to+") .appointment-ico").css("display","none")--%>
                        <%--},mouseleave:function(){--%>
                            <%--$(".appointment:eq("+to+") span").text("已预约");--%>
                            <%--$(".appointment:eq("+to+") span").css({"color":"#333333","left":"0px","margin-left":"0px","top":"-2px"});--%>
                            <%--$(".appointment:eq("+to+")").addClass("end-yes");--%>
                            <%--$(".appointment:eq("+to+") .appointment-ico").css("display","inline-block")--%>
                        <%--}})--%>


                    <%--},--%>
                    <%--error:function(err,error){--%>

                    <%--}--%>
                <%--});--%>
            <%--}--%>
        <%--})--%>
    <%--});--%>

    <%--for(var r = 0; r<$("#love-course-list li").length;r++){--%>
        <%--var zt = $("#love-course-list li").eq(r).attr("endzt")--%>
        <%--if(zt=="true"){--%>

            <%--$("#love-course-list li:eq("+r+") .appointment").unbind("mouseenter").unbind("mouseleave");--%>
            <%--$("#love-course-list li:eq("+r+") .appointment span").text("已预约");--%>
            <%--$("#love-course-list li:eq("+r+") .appointment span").css("color","#333333");--%>
            <%--$("#love-course-list li:eq("+r+") .appointment .appointment-ico").addClass("subscribeyes-ico");--%>
            <%--$("#love-course-list li:eq("+r+") .appointment").addClass("end-yes");--%>
            <%--$("#love-course-list li:eq("+r+") .appointment").bind({mouseenter:function(){--%>
                <%--var n = $(".appointment").index(this)--%>
                <%--$(".appointment:eq("+n+") span").html("取消预约");--%>
                <%--$(".appointment:eq("+n+") span").css({"color":"#ffffff","top":"1px"});--%>
                <%--$(".appointment:eq("+n+")").removeClass("end-yes");--%>
                <%--$(".appointment:eq("+n+") .appointment-ico").css("display","none")--%>
            <%--},mouseleave:function(){--%>
                <%--var n = $(".appointment").index(this)--%>
                <%--$(".appointment:eq("+n+") span").html("已预约");--%>
                <%--$(".appointment:eq("+n+") span").css({"color":"#333333","left":"0px","margin-left":"0px","top":"-2px"});--%>
                <%--$(".appointment:eq("+n+")").addClass("end-yes");--%>
                <%--$(".appointment:eq("+n+") .appointment-ico").css("display","inline-block")--%>
            <%--}})--%>
        <%--}else if(zt=="false"){--%>
            <%--$("#love-course-list li:eq("+r+") .appointment span").text("预约直播");--%>
            <%--$("#love-course-list li:eq("+r+") .appointment span").css("color","#ffffff")--%>
            <%--$("#love-course-list li:eq("+r+") .appointment").removeClass("end-yes");--%>
            <%--$("#love-course-list li:eq("+r+") .appointment .appointment-ico").removeClass("subscribeyes-ico");--%>
            <%--$("#love-course-list li:eq("+r+") .appointment").unbind("mouseenter").unbind("mouseleave");--%>
        <%--}--%>
    <%--}--%>


    <%--//播放直播回放--%>
    <%--function joinLive(id,type){--%>
        <%--//window.location.href = "/live/play/"+id;--%>
        <%--window.open("/live/play/"+id+"?"+type,"_blank");--%>
    <%--}--%>
    <%--function reviewLive(id,type){--%>
        <%--//window.location.href = "/live/play/"+id;--%>
        <%--window.open("/live/reviewLive/"+id+"?"+type,"_blank");--%>
    <%--}--%>

    <%--$(".playback").click(function(){--%>
        <%--reviewLive($(this).closest("li").attr("endid"),$(this).closest("li").attr("endtype"))--%>
    <%--})--%>
    <%--$(".streaming").click(function(){--%>
        <%--joinLive($(this).closest("li").attr("endid"),$(this).closest("li").attr("endtype"))--%>
    <%--})--%>
    <%--for(var r = 0; r<$("#love-course-list li").length;r++){--%>
        <%--if($("#love-course-list li:eq("+r+") .appointment span").text()=="预约直播"||$("#love-course-list li:eq("+r+") .appointment span").text()=="已预约"){--%>
            <%--$("#love-course-list li:eq("+r+") .skip").css("cursor","text")--%>
        <%--}--%>
    <%--}--%>
<%--</script>--%>
<script type="text/javascript" src="${basePath}/resources-sjn/index/js/timer.js"></script>
<script type="text/javascript">
    timers();

    $(document).ready(function(){
        $("#love-course-list li").find('.skip').css('cursor','default');
        $(".appointment").click(function(){
            var to = $(".appointment").index(this);
//            var es =  $("#love-course-list li").eq(to).attr("endId")
            var ms =  $(".body").attr("testMobile")
            var courseLiveId = $(".appointment").eq(to).closest("li").attr("endId");
            if(ms==""||ms==null){Util.User.login(function() {
                location.reload();
            });
                return false;
            }

            if( $(".appointment:eq("+to+") span").text()=="取消预约"){
                var dataef ={yes:false,mobile:ms,liveId:courseLiveId};
                $.ajax({
                    type:"POST",
                    url:"/live/booking",
                    data:dataef,
                    success:function(data){;
                        $(".appointment:eq("+to+") span").text("预约直播");
                        $(".appointment:eq("+to+") span").css({"color":"#fff","margin-left":"3px","top":"-2px"});
                        $(".appointment:eq("+to+")").removeClass("end-yes");
                        $(".appointment:eq("+to+") .appointment-ico").css("display","inline-block")
                        $(".appointment:eq("+to+") .appointment-ico").removeClass("subscribeyes-ico");
                        $(".appointment:eq("+to+")").unbind("mouseenter").unbind("mouseleave");
                    }
                })
            }else{
                var datas ={yes:true,mobile:ms,liveId:courseLiveId};
                $.ajax({
                    type:"POST",
                    url:"/live/booking",
                    data:datas,
                    success:function(data){
                        $(".appointment:eq("+to+") span").text("已预约");
                        $(".appointment:eq("+to+") span").css({"color":"#333333","left":"0px","margin-left":"0px","top":"-2px"});
                        $(".appointment:eq("+to+") .appointment-ico").addClass("subscribeyes-ico");
                        $(".appointment:eq("+to+")").addClass("end-yes");
//                        $(".appointment:eq("+to+") .prompt").css("display","block")
//                        setTimeout(function(){$(".appointment:eq("+to+") .prompt").css("display","none")},5000)


                        $(".appointment:eq("+to+")").bind({mouseenter:function(){
                            $(".appointment:eq("+to+") span").text("取消预约");
                            $(".appointment:eq("+to+") span").css({"color":"#ffffff","top":"1px"});
                            $(".appointment:eq("+to+")").removeClass("end-yes");
                            $(".appointment:eq("+to+") .appointment-ico").css("display","none")
                        },mouseleave:function(){
                            $(".appointment:eq("+to+") span").text("已预约");
                            $(".appointment:eq("+to+") span").css({"color":"#333333","left":"0px","margin-left":"0px","top":"-2px"});
                            $(".appointment:eq("+to+")").addClass("end-yes");
                            $(".appointment:eq("+to+") .appointment-ico").css("display","inline-block")
                        }})


                    },
                    error:function(err,error){

                    }
                });
            }
        })
    });

    for(var r = 0; r<$("#love-course-list li").length;r++){
        var zt = $("#love-course-list li").eq(r).attr("endzt")
        if(zt=="true"){

            $("#love-course-list li:eq("+r+") .appointment").unbind("mouseenter").unbind("mouseleave");
            $("#love-course-list li:eq("+r+") .appointment span").text("已预约");
            $("#love-course-list li:eq("+r+") .appointment span").css("color","#333333");
            $("#love-course-list li:eq("+r+") .appointment .appointment-ico").addClass("subscribeyes-ico");
            $("#love-course-list li:eq("+r+") .appointment").addClass("end-yes");
            $("#love-course-list li:eq("+r+") .appointment").bind({mouseenter:function(){
                var n = $(".appointment").index(this)
                $(".appointment:eq("+n+") span").html("取消预约");
                $(".appointment:eq("+n+") span").css({"color":"#ffffff","top":"1px"});
                $(".appointment:eq("+n+")").removeClass("end-yes");
                $(".appointment:eq("+n+") .appointment-ico").css("display","none")
            },mouseleave:function(){
                var n = $(".appointment").index(this)
                $(".appointment:eq("+n+") span").html("已预约");
                $(".appointment:eq("+n+") span").css({"color":"#333333","left":"0px","margin-left":"0px","top":"-2px"});
                $(".appointment:eq("+n+")").addClass("end-yes");
                $(".appointment:eq("+n+") .appointment-ico").css("display","inline-block")
            }})
        }else if(zt=="false"){
            $("#love-course-list li:eq("+r+") .appointment span").text("预约直播");
            $("#love-course-list li:eq("+r+") .appointment span").css("color","#ffffff")
            $("#love-course-list li:eq("+r+") .appointment").removeClass("end-yes");
            $("#love-course-list li:eq("+r+") .appointment .appointment-ico").removeClass("subscribeyes-ico");
            $("#love-course-list li:eq("+r+") .appointment").unbind("mouseenter").unbind("mouseleave");
        }
    }


    //播放直播回放
    function joinLive(id,type){
        //window.location.href = "/live/play/"+id;
        window.open("/live/play/"+id+"?"+type,"_blank");
    }
    function reviewLive(id,type){
        //window.location.href = "/live/play/"+id;
        window.open("/live/reviewLive/"+id+"?"+type,"_blank");
    }

    $(".playback").click(function(){
        reviewLive($(this).closest("li").attr("endid"),$(this).closest("li").attr("endtype"))
    })
    $(".streaming").click(function(){
        joinLive($(this).closest("li").attr("endid"),$(this).closest("li").attr("endtype"))
    })
    for(var r = 0; r<$("#love-course-list li").length;r++){
        if($("#love-course-list li:eq("+r+") .appointment span").text()=="预约直播"||$("#love-course-list li:eq("+r+") .appointment span").text()=="已预约"){
            $("#love-course-list li:eq("+r+") .skip").css("cursor","text")
        }
    }
</script>

</body>
</html>