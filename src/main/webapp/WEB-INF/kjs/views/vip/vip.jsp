<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<html lang="en"  style="background-color: rgb(153,153,153);">
<head>
    <meta charset="UTF-8">
    <title>开通会员-好分课堂</title>
    <link rel="stylesheet" href="${basePath}/resources/common/css/rest.css" />
    <link rel="stylesheet" href="${basePath}/resources/login/css/member.css" />
    <link rel="stylesheet" href="${basePath}/resources/vip/css/scroll.css" />
    <script type="text/javascript" src="${basePath}/resources/common/js/jquery-1.9.1.js"></script>
    <script type="text/javascript" src="${basePath}/resources/course/js/respond.js" ></script>
    <script type="text/javascript" src="${basePath}/resources/vip/js/vip.js" ></script>
    <script type="text/javascript" src="${basePath}/resources/vip/js/scroll.js" ></script>
    <style>
    	body{
    	 background-color: rgb(242,242,242) !important;
    	 min-width: 1648px;
    	}
    </style>
</head>
<body >
<input type="hidden" id="is-vip" name="is-vip" value="${userStu.isVIP}">
<input type="hidden" id="user-id" name="user-id" value="${userStu.userid}">


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
                        <li>讲义查阅</li>
                        <li>—</li>
                        <li>听课提醒服务</li>
                        <li>APP观看</li>
                        <li>老师答疑</li>

                    </ul>
                </div>
                <div class="dredge">
                    <p><span style="color:#ff6700">${vipInfo.planNum}个</span>学习计划上限</p>
                    <div class="dredge-btn" dataType="1" >立即开通</div>
                </div>
            </div>
        </c:if>
        <c:if test="${vipInfo.days > 30 && vipInfo.days<=90}">
            <div class="seasonMember">
                <div class="member-top">季会员</div>
                <div class="member-money">
                    <div class="baoguo"><span>￥</span><span style="font-size: 40px; margin-right: 5px;"><fmt:formatNumber value="${vipInfo.price}" pattern="#"/></span>3个月</div>
                </div>
                <div class="member-list">
                    <ul>
                        <li>畅听所有课程</li>
                        <li>讲义查阅</li>
                        <li>—</li>
                        <li>听课提醒服务</li>
                        <li>APP观看</li>
                        <li>老师答疑</li>

                    </ul>
                </div>
                <div class="dredge">
                    <p><span style="color:#ff6700">${vipInfo.planNum}个</span>学习计划上限</p>
                    <div class="dredge-btn" dataType="2">立即开通</div>
                </div>
            </div>
        </c:if>
        <c:if test="${vipInfo.days > 90}">
            <div class="yearMember">
                <div class="member-top">年会员<img src="${basePath}/resources/vip/images/tuijian.gif" style="position:relative;top:-20px;"> </div>
                <div class="member-money">
                    <div class="baoguo"><span>￥</span><span style="font-size: 40px; margin-right: 5px;"><fmt:formatNumber value="${vipInfo.price}" pattern="#"/></span>1年</div>
                </div>
                <div class="member-list">
                    <ul>
                        <li>畅听所有课程</li>
                        <li>讲义查阅</li>
                        <li style="color:#ff6700;">赠送直播课程</li>
                        <li>听课提醒服务</li>
                        <li>APP观看</li>
                        <li>老师答疑</li>

                    </ul>
                </div>
                <div class="dredge">
                    <p><span style="color:#ff6700">${vipInfo.planNum}个</span>学习计划上限</p>
                    <div class="dredge-btn" dataType="3" style="background:#ff6700; ">立即开通</div>
                </div>
            </div>
        </c:if>
    </c:forEach>

</div>

<%--<div class="middle">--%>
    <%--<div class="middle0">--%>
        <%--<div class="mtop">--%>
            <%--<div class="vipImg">--%>
                <%--<img src="${basePath}/resources/vip/images/VIP1.png">--%>
            <%--</div>--%>
            <%--<div class="vipTxt">--%>
                <%--<p class="vipTxt1">开通年会员，即可尊享“畅听全网课程”等八大特权</p>--%>
                <%--<p class="vipTxt2">一次性开通12个月立即成为尊贵的年VIP</p>--%>
                <%--<p class="vipTxt3"><span>999</span><em>元/年</em>( <i>原价3999元</i> )</p>--%>
                <%--<p>--%>
                    <%--<span class="vipTxt4 dredge-btn" dataType="3">开通会计狮年会员</span>--%>
                    <%--<c:if  test="${!SESSION_USER.isVIP}">--%>
                        <%--<i class="vipTxt4" id="vipTxt4i">在线咨询</i>--%>
                    <%--</c:if>--%>
                <%--</p>--%>
            <%--</div>--%>
        <%--</div>--%>
        <%--<div class="mmid">--%>
            <%--<p class="mmidImg"><img src="${basePath}/resources/vip/images/tejia.png"></p>--%>
            <%--<ul class="mmidUl">--%>
                <%--<li class="mmidLi1">--%>
                    <%--<p class="mmidP1" id="mmidp1"></p>--%>
                    <%--<p class="mmidP2">畅听全网课程</p>--%>
                    <%--<p class="mmidP3">老会计手把手教你做账</p>--%>
                <%--</li>--%>
                <%--<li class="mmidLi2 mmidLi1" style="margin: 0 2px;">--%>
                    <%--<p class="mmidP1" id="mmidp2"></p>--%>
                    <%--<p class="mmidP2">会员专享直播课</p>--%>
                    <%--<p class="mmidP3">畅享互动式教学的乐趣</p>--%>
                <%--</li>--%>
                <%--<li class="mmidLi3 mmidLi1" style="margin-right: 2px;">--%>
                    <%--<p class="mmidP1" id="mmidp3"></p>--%>
                    <%--<p class="mmidP2">学习计划</p>--%>
                    <%--<p class="mmidP3">让学习变得有条有理</p>--%>
                <%--</li>--%>
                <%--<li class="mmidLi4 mmidLi1">--%>
                    <%--<p class="mmidP1" id="mmidp4"></p>--%>
                    <%--<p class="mmidP2">讲义查阅</p>--%>
                    <%--<p class="mmidP3">巩固课堂学习效果</p>--%>
                <%--</li>--%>
            <%--</ul>--%>
        <%--</div>--%>
        <%--<div class="mbut mmid">--%>
            <%--<p class="mbutImg mmidImg"><img src="${basePath}/resources/vip/images/fuwu.png"></p>--%>
            <%--<ul class="mbutUl">--%>
                <%--<li class="mbutLi1 mmidLi1">--%>
                    <%--<p class="mmidP1" id="mbutp1"></p>--%>
                    <%--<p class="mmidP2">APP上课</p>--%>
                    <%--<p class="mmidP3">随时随地想听就听</p>--%>
                <%--</li>--%>
                <%--<li class="mbutLi2 mmidLi1" style="margin: 0 2px;">--%>
                    <%--<p class="mmidP1" id="mbutp2"></p>--%>
                    <%--<p class="mmidP2">免费答疑</p>--%>
                    <%--<p class="mmidP3">解决你工作中的难题</p>--%>
                <%--</li>--%>
                <%--<li class="mbutLi3 mmidLi1" style="margin-right: 2px;">--%>
                    <%--<p class="mmidP1" id="mbutp3"></p>--%>
                    <%--<p class="mmidP2">听课提醒</p>--%>
                    <%--<p class="mmidP3">不错过每一天的学习</p>--%>
                <%--</li>--%>
                <%--<li class="mbutLi4 mmidLi1">--%>
                    <%--<p class="mmidP1" id="mbutp4"></p>--%>
                    <%--<p class="mmidP2">技能进阶</p>--%>
                    <%--<p class="mmidP3">每次的进步看得见</p>--%>
                <%--</li>--%>
            <%--</ul>--%>
        <%--</div>--%>
    <%--</div>--%>
<%--</div>--%>


<script type="text/javascript" src="${basePath}/resources/login/js/member.js" ></script>
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

    changeColor();
    var flag = 1;
    function changeColor(){
       var colorInterval = setInterval(function () {
           flag++;
           if(flag%2 ==0){
               $('#vipTxt4i').css("background","#f25807");
           }else{
               $('#vipTxt4i').css("background","#ff6700");
           }
        },500);
    }

    $("#vipTxt4i").click(function(){

        if(vip!=1 && vip!=2 && vip!=3){
            //小能
            NTKF.im_openInPageChat(consultDetail.rightUrl);
        }else{
            //qq
//            document.getElementById('qq').click();
            NTKF.im_openInPageChat(consultDetail.groupUrl);
        }
    })

</script>
</body>
</html>