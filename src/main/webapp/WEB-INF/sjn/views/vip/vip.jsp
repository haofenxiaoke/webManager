<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=8,IE=9,chrome=1">
    <title>开通会员-设计牛</title>
    <link rel="stylesheet" href="${basePath}/resources/common/css/rest.css" />
    <link rel="stylesheet" href="${basePath}/resources/login/css/member.css" />
    <link rel="stylesheet" href="${basePath}/resources-sjn/login/css/member.css" />
    <link rel="stylesheet" href="${basePath}/resources/vip/css/scroll.css" />
    <link rel="stylesheet" href="${basePath}/resources-sjn/vip/css/scroll.css" />
    <script type="text/javascript" src="${basePath}/resources/course/js/respond.js" ></script>
    <script type="text/javascript" src="${basePath}/resources/vip/js/vip.js" ></script>
    <script type="text/javascript" src="${basePath}/resources/vip/js/scroll.js" ></script>
</head>
<body>
<input type="hidden" id="is-vip" name="is-vip" value="${userStu.isVIP}">
<input type="hidden" id="user-id" name="user-id" value="${userStu.userid}">
<div class="comboall">
    <div class="all-combo">
    <div class="combo">
        <div class="comboRigh-top">
            <p class="combomoney" id="buy-count"></p>
            <p class="comboNumber">今日会员购买人数</p>
        </div>
        <div class="myscroll">
            <ul id="buy-list">
            </ul>
        </div>
    </div>
    </div>
</div>

<div class="member-dredge">
    <c:forEach items="${vipInfos}" var="vipInfo"  varStatus="status">
        <c:if test="${vipInfo.days <= 30}">
            <div class="monthMember">
                <div class="member-top">月会员</div>
                <div class="member-money">
                    <div class="baoguo"><span>￥</span><span style="font-size: 40px; margin-right: 5px;"><fmt:formatNumber value="${vipInfo.price}" pattern="#"/></span>1个月</div>
                </div>
                <div class="member-list">
                    <ul>
                        <li>畅听所有课程</li>
                        <li>资料下载</li>
                        <li>—</li>
                        <li>听课提醒服务</li>
                        <li>APP观看</li>
                        <li>老师答疑</li>

                    </ul>
                </div>
                <div class="dredge">
                    <p><span style="color:#e62c3a">${vipInfo.planNum}个</span>学习计划上限</p>
                    <div class="dredge-btn" dataType="1">立即开通</div>
                </div>
            </div>
        </c:if>
        <c:if test="${vipInfo.days > 30 && vipInfo.days<=90}">
            <div class="seasonMember">
                <div class="member-top">季会员 </div>
                <div class="member-money">
                    <div class="baoguo"><span>￥</span><span style="font-size: 40px; margin-right: 5px;"><fmt:formatNumber value="${vipInfo.price}" pattern="#"/></span>3个月</div>
                </div>
                <div class="member-list">
                    <ul>
                        <li>畅听所有课程</li>
                        <li>资料下载</li>
                        <li>—</li>
                        <li>听课提醒服务</li>
                        <li>APP观看</li>
                        <li>老师答疑</li>

                    </ul>
                </div>
                <div class="dredge">
                    <p><span style="color:#e62c3a">${vipInfo.planNum}个</span>学习计划上限</p>
                    <div class="dredge-btn" dataType="2">立即开通</div>
                </div>
            </div>
        </c:if>
        <c:if test="${vipInfo.days > 90}">
            <div class="yearMember">
                <div class="member-top">年会员<img src="${basePath}/resources-sjn/vip/images/shejiniu.gif" style="position:relative;top:-20px;"> </div>
                <div class="member-money">
                    <div class="baoguo"><span>￥</span><span style="font-size: 40px; margin-right: 5px;"><fmt:formatNumber value="${vipInfo.price}" pattern="#"/></span>1年</div>
                </div>
                <div class="member-list">
                    <ul>
                        <li>畅听所有课程</li>
                        <li>资料下载</li>
                        <li style="color:#e62c3a">赠送直播课程</li>
                        <li>听课提醒服务</li>
                        <li>APP观看</li>
                        <li>老师答疑</li>

                    </ul>
                </div>
                <div class="dredge">
                    <p><span style="color:#e62c3a">${vipInfo.planNum}个</span>学习计划上限</p>
                    <div class="dredge-btn active" dataType="3" style="background: #e62c3a">立即开通</div>
                    <style>
                        .active:hover{background: #dd2a38!important;}
                    </style>
                </div>
            </div>
        </c:if>
    </c:forEach>

</div>
<div id="test-html">
    1111
</div>
<script>
    var url ='http://tiku.test.haofenvip.com/title/exercise/done?skuCode=8&subjectCode=4&pageNo=1&pageSize=5';
    var url2 = 'http://my.tu.image.com/title/exercise/done?skuCode=8&subjectCode=4&pageNo=1&pageSize=5';
    $(function(){
        $('#test-html').load(url);
    });

</script>
<script type="text/javascript" src="${basePath}/resources/login/js/member.js" ></script>
</body>
</html>