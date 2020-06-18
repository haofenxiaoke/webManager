<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2016/7/4 0004
  Time: 上午 10:39
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <title>直播列表-好分课堂</title>
  <link href="/resources/common/css/rest.css" rel="stylesheet">
  <link href="/resources/live/css/live.css" rel="stylesheet">
    <link href="/resources/live/css/kjs-live.css" rel="stylesheet">
  <script src="/resources/live/js/live.js"></script>
</head>
<body>
<div class="kjs" vip="${SESSION_USER.vipId}">
  <div class="Made-nav">
    <a href="/" style="padding-left: 0;">首页</a><img class="old" src="/resources/live/images/jiao2.png"/> <a href="">直播列表</a>
  </div>
</div>
<%--<div class="kjs live_content content-m-top" id="liveCourseList">--%>
    <%--<c:forEach items="${liveCourses}" var="liveCourse">--%>
        <%--<div class="liveObj">--%>
            <%--<!-- 直播图片 -->--%>
            <%--<div class="liveImg">--%>
                <%--<img src="${liveCourse.courseUrl}" alt=""/>--%>
            <%--</div>--%>
            <%--<div class="liveInfo">--%>
       <%--<span class="liveInfo_title">--%>
           <%--${liveCourse.liveTitle}--%>
           <%--&lt;%&ndash;<c:choose><c:when test="${fn:length(liveCourse.liveTitle) > 20}">${fn:substring(industry.categoryDesc, 0, 19)}...</c:when><c:otherwise>${liveCourse.liveTitle}</c:otherwise></c:choose>&ndash;%&gt;--%>
       <%--</span>--%>
                <%--<c:if test="${liveCourse.liveType==0}">--%>
                    <%--<span class="near"></span>--%>
                <%--</c:if>--%>
                <%--<p style="line-height:50px;">--%>
                    <%--<span>方向：</span>--%>
                    <%--<span class="fx">${liveCourse.directionName}</span>--%>
                        <%--&lt;%&ndash;<span class="sj">${liveCourse.liveStart}</span>&ndash;%&gt;--%>
                    <%--<span style="margin-left:30px;">老师：</span>--%>
                    <%--<span class="sj">${liveCourse.flowerName}</span>--%>
                <%--</p>--%>
                <%--<p><span>简介：</span><br/>--%>
          <%--<span class="jj" title="${liveCourse.summary}">--%>
            <%--<c:if test="${fn:length(liveCourse.summary)>'138'}">--%>
                <%--${fn:substring(liveCourse.summary,0,138)}...--%>
            <%--</c:if>--%>
            <%--<c:if test="${fn:length(liveCourse.summary)<='138'}">--%>
                <%--${liveCourse.summary}--%>
            <%--</c:if>--%>
          <%--</span>--%>
            <%--</div>--%>

            <%--<c:if test="${liveCourse.isLiving == 1}">--%>
                <%--<div class="liveJoin">--%>
                    <%--<div class="zzzb" onclick="joinLive('${liveCourse.id}')"><div class="sku-play">--%>
                        <%--<span class="sku-one"></span>--%>
                        <%--<span class="sku-two"></span>--%>
                        <%--<span class="sku-three"></span>--%>
                    <%--</div>直播中</div>--%>
                    <%--<p style="display: block; width: 145px;line-height: 25px; text-align: center;"><span style="float: left;color: #666666;font-size: 18px;margin: 10px 6px 0px 0px;">${liveCourse.respDates}</span><span style="float: left;color: #666666;font-size: 18px;margin-top: 10px;"><fmt:formatDate value="${liveCourse.startTime}" pattern="HH:mm"></fmt:formatDate>-<fmt:formatDate value="${liveCourse.endTime}" pattern="HH:mm"></fmt:formatDate></span></p>--%>
                <%--</div>--%>
            <%--</c:if>--%>
            <%--<c:if test="${liveCourse.isLiving == 2}">--%>
                <%--<div class="liveJoin end-make" endzt="${liveCourse.livingFlag}">--%>
                    <%--<a class="jjzb heid" courseLiveId="${liveCourse.id}" testMobile="${SESSION_USER.mobile}" ><div class="subscribe-ico"></div><span>预约直播</span><div class="prompt">课前<div>5分钟</div>会短信提醒你上课</div></a>--%>
                    <%--<p style="display: block; width: 145px;line-height: 25px; text-align: center;"><span style="float: left; color: #666666;font-size: 18px;margin: 10px 6px 0px 0px; ">${liveCourse.respDates}</span><span style="float: left;color: #666666;font-size: 18px;margin-top: 10px;"><fmt:formatDate value="${liveCourse.startTime}" pattern="HH:mm"></fmt:formatDate>-<fmt:formatDate value="${liveCourse.endTime}" pattern="HH:mm"></fmt:formatDate></span></p>--%>
                <%--</div>--%>
            <%--</c:if>--%>
            <%--<c:if test="${liveCourse.isLiving == 3}">--%>
                <%--<div class="liveJoin">--%>
                    <%--<div class="jjzb" onclick="reviewLive('${liveCourse.id}')"><div class="playback-ico"></div><span>观看回放</span></div>--%>
                    <%--<p style="display: block; width: 145px;line-height: 25px; text-align: center;"><span style="float: left;color: #666666;font-size: 18px;margin: 10px 6px 0px 0px;">${liveCourse.respDates}</span><span style="float: left;color: #666666;font-size: 18px;margin-top: 10px;"><fmt:formatDate value="${liveCourse.startTime}" pattern="HH:mm"></fmt:formatDate>-<fmt:formatDate value="${liveCourse.endTime}" pattern="HH:mm"></fmt:formatDate></span></p>--%>
                <%--</div>--%>
            <%--</c:if>--%>
            <%--<c:if test="${liveCourse.isLiving == 4}">--%>
                <%--<div class="liveJoin">--%>
                    <%--<div class="end" >已结束</div>--%>
                    <%--<p style="display: block; width: 145px;line-height: 25px; text-align: center;"><span style="float: left;color: #666666;font-size: 18px;margin: 10px 6px 0px 0px;">${liveCourse.respDates}</span><span style="float: left;color: #666666;font-size: 18px;margin-top: 10px;"><fmt:formatDate value="${liveCourse.startTime}" pattern="HH:mm"></fmt:formatDate>-<fmt:formatDate value="${liveCourse.endTime}" pattern="HH:mm"></fmt:formatDate></span></p>--%>
                <%--</div>--%>
            <%--</c:if>--%>


        <%--</div>--%>
    <%--</c:forEach>--%>
    <%--<c:if test="${empty liveCourses}">--%>
        <%--<div class="kjs live_null" id="live_null" style="display: block">--%>
            <%--<div class="nullImg">--%>
                <%--<img src="/resources/live/images/live_null.png" alt=""/>--%>
                <%--<span>该项目在建设中......</span>--%>
            <%--</div>--%>
        <%--</div>--%>
    <%--</c:if>--%>
<%--</div>--%>
<ul class="kjs-cut">
    <li style="margin-left: 15px;" class="pitchUp"><a class="pitchUpA">近期直播</a></li>
    <li><a>历史直播</a></li>
</ul>
<div class="brother">
<div class="exchange">
<!--直播-->

    <c:if test="${isLivingListEmpty==false}">
    <div class="each-title">直播中</div>
    </c:if>
    <c:forEach items="${liveCourses}" var="liveCourse">
        <c:if test="${liveCourse.isLiving == 1}">
        <div class="kjs live_content content-m-top">
        <div class="liveObj">
            <p class="end-p"><span style="float: left;color: #666666;font-size: 14px;">${liveCourse.respDates}</span><span style="float: left;color: #666666;font-size: 14px; margin-left: 10px;"><fmt:formatDate value="${liveCourse.startTime}" pattern="HH:mm"></fmt:formatDate>~<fmt:formatDate value="${liveCourse.endTime}" pattern="HH:mm"></fmt:formatDate></span></p>
            <div class="teacher-all">
                <img src="${liveCourse.teacherUrl}"/>
                <span class="sj" title="${liveCourse.flowerName}"><c:choose><c:when test="${fn:length(liveCourse.flowerName) > 4}">${fn:substring(liveCourse.flowerName, 0, 4)}...</c:when><c:otherwise> ${liveCourse.flowerName}</c:otherwise></c:choose></span>
            </div>
            <div class="liveInfo">
       <span class="liveInfo_title">
           ${liveCourse.liveTitle}
       </span>
                <c:if test="${liveCourse.liveType==0}">
                    <c:if test="${liveCourse.type==2}">
                          <span class="near" style="display:inline-block;"></span>
                    </c:if>
                    <c:if test="${liveCourse.type==1}">
                        <span class="near1" style="display:inline-block;"></span>
                    </c:if>
                </c:if>
                <p style="line-height:50px;">
                    <%--<span>方向：</span>--%>
                    <span class="fx">${liveCourse.directionName}</span>
                </p>
            </div>
            <div class="endMan">${liveCourse.bookNumber}人已约</div>
            <div class="liveJoin">
                <div class="zzzb" onclick="joinLive('${liveCourse.id}')">
                    <div class="sku-play">
                    <span class="sku-one"></span>
                    <span class="sku-two"></span>
                    <span class="sku-three"></span>
                </div>直播中</div>

            </div>
        </div>
</div>
        </c:if>

    </c:forEach>

<!--预约-->
    <c:if test="${unStartLivingListEmpty==false}">
    <div class="each-title">未开始</div>
    </c:if>
<c:forEach items="${liveCourses}" var="liveCourse">
    <c:if test="${liveCourse.isLiving == 2}">
        <div class="kjs live_content content-m-top">
            <div class="liveObj">
                <p class="end-p"><span style="float: left; color: #666666;font-size: 14px; ">${liveCourse.respDates}</span><span style="float: left;color: #666666;font-size: 14px;margin-left: 10px;"><fmt:formatDate value="${liveCourse.startTime}" pattern="HH:mm"></fmt:formatDate>~<fmt:formatDate value="${liveCourse.endTime}" pattern="HH:mm"></fmt:formatDate></span></p>
                <div class="teacher-all">
                    <img src="${liveCourse.teacherUrl}"/>
                    <span class="sj" title="${liveCourse.flowerName}"><c:choose><c:when test="${fn:length(liveCourse.flowerName) > 4}">${fn:substring(liveCourse.flowerName, 0, 4)}...</c:when><c:otherwise> ${liveCourse.flowerName}</c:otherwise></c:choose></span>
                </div>
                <div class="liveInfo">
       <span class="liveInfo_title">
           ${liveCourse.liveTitle}
       </span>
                    <c:if test="${liveCourse.liveType==0}">
                        <c:if test="${liveCourse.type==2}">
                            <span class="near" style="display:inline-block;"></span>
                        </c:if>
                        <c:if test="${liveCourse.type==1}">
                            <span class="near1" style="display:inline-block;"></span>
                        </c:if>
                    </c:if>
                    <p style="line-height:50px;">
                        <%--<span>方向：</span>--%>
                        <span class="fx">${liveCourse.directionName}</span>
                    </p>
                </div>
                <div class="endMan">${liveCourse.bookNumber}人已约</div>
                <div class="liveJoin end-make" endzt="${liveCourse.livingFlag}">
                    <a class="jjzb heid subscribe" courseLiveId="${liveCourse.id}" testMobile="${SESSION_USER.mobile}" ><div class="subscribe-ico"></div><span>预约直播</span><div class="prompt">课前<div>5分钟</div>会短信提醒你上课</div></a>
                </div>
            </div>
        </div>
    </c:if>
</c:forEach>

<!--回放-->
    <div class="each-title">已结束</div>
<c:forEach items="${liveCourses}" var="liveCourse">
    <c:if test="${liveCourse.isLiving == 3}">
        <div class="kjs live_content content-m-top">
            <div class="liveObj">
                <p class="end-p"><span style="float: left;color: #666666;font-size: 14px;">${liveCourse.respDates}</span><span style="float: left;color: #666666;font-size: 14px;margin-left: 10px;"><fmt:formatDate value="${liveCourse.startTime}" pattern="HH:mm"></fmt:formatDate>~<fmt:formatDate value="${liveCourse.endTime}" pattern="HH:mm"></fmt:formatDate></span></p>
                <div class="teacher-all">
                    <img src="${liveCourse.teacherUrl}"/>
                    <span class="sj" title="${liveCourse.flowerName}"><c:choose><c:when test="${fn:length(liveCourse.flowerName) > 4}">${fn:substring(liveCourse.flowerName, 0, 4)}...</c:when><c:otherwise> ${liveCourse.flowerName}</c:otherwise></c:choose></span>
                </div>
                <div class="liveInfo">
       <span class="liveInfo_title">
           ${liveCourse.liveTitle}
       </span>
                    <c:if test="${liveCourse.liveType==0}">
                        <c:if test="${liveCourse.type==2}">
                            <span class="near" style="display:inline-block;"></span>
                        </c:if>
                        <c:if test="${liveCourse.type==1}">
                            <span class="near1" style="display:inline-block;"></span>
                        </c:if>
                    </c:if>
                    <p style="line-height:50px;">
                        <%--<span>方向：</span>--%>
                        <span class="fx">${liveCourse.directionName}</span>
                    </p>
                </div>
                <div class="endMan">${liveCourse.bookNumber}人已约</div>
                <div class="liveJoin">
                    <div class="jjzb" onclick="reviewLive('${liveCourse.id}')"><div class="playback-ico"></div><span>观看回放</span></div>
                </div>
            </div>
        </div>
    </c:if>
    <c:if test="${liveCourse.isLiving == 4}">
    <div class="kjs live_content content-m-top">
    <div class="liveObj">
    <p class="end-p"><span style="float: left;color: #666666;font-size: 14px;">${liveCourse.respDates}</span><span style="float: left;color: #666666;font-size: 14px;margin-left: 10px;"><fmt:formatDate value="${liveCourse.startTime}" pattern="HH:mm"></fmt:formatDate>~<fmt:formatDate value="${liveCourse.endTime}" pattern="HH:mm"></fmt:formatDate></span></p>
    <div class="teacher-all">
    <img src="${liveCourse.teacherUrl}"/>
    <span class="sj" title="${liveCourse.flowerName}"><c:choose><c:when test="${fn:length(liveCourse.flowerName) > 4}">${fn:substring(liveCourse.flowerName, 0, 4)}...</c:when><c:otherwise> ${liveCourse.flowerName}</c:otherwise></c:choose></span>
    </div>
    <div class="liveInfo">
    <span class="liveInfo_title">
    ${liveCourse.liveTitle}
    </span>
    <c:if test="${liveCourse.liveType==0}">
        <c:if test="${liveCourse.type==2}">
            <span class="near" style="display:inline-block;"></span>
        </c:if>
        <c:if test="${liveCourse.type==1}">
            <span class="near1" style="display:inline-block;"></span>
        </c:if>
    </c:if>
    <p style="line-height:50px;">
    <%--<span>方向：</span>--%>
    <span class="fx">${liveCourse.directionName}</span>
    </p>
    </div>
        <div class="endMan">${liveCourse.bookNumber}人已约</div>
    <div class="liveJoin">
    <div class="end" style="font-size: 14px; cursor: text;" >已结束</div>

    </div>
    </div>
    </div>
    </c:if>
</c:forEach>


<%--<!--结束-->--%>
<%--<c:forEach items="${liveCourses}" var="liveCourse">--%>
    <%--<c:if test="${liveCourse.isLiving == 4}">--%>
        <%--<div class="kjs live_content content-m-top">--%>
            <%--<div class="liveObj">--%>
                <%--<p class="end-p"><span style="float: left;color: #666666;font-size: 18px;">${liveCourse.respDates}</span><span style="float: left;color: #666666;font-size: 18px;margin-left: 10px;"><fmt:formatDate value="${liveCourse.startTime}" pattern="HH:mm"></fmt:formatDate>-<fmt:formatDate value="${liveCourse.endTime}" pattern="HH:mm"></fmt:formatDate></span></p>--%>
                <%--<div class="teacher-all">--%>
                    <%--<img src="${liveCourse.teacherUrl}"/>--%>
                    <%--<span class="sj">${liveCourse.flowerName}</span>--%>
                <%--</div>--%>
                <%--<div class="liveInfo">--%>
       <%--<span class="liveInfo_title">--%>
           <%--${liveCourse.liveTitle}--%>
       <%--</span>--%>
                    <%--<c:if test="${liveCourse.liveType==0}">--%>
                        <%--<span class="near"></span>--%>
                    <%--</c:if>--%>
                    <%--<p style="line-height:50px;">--%>
                        <%--<span>方向：</span>--%>
                        <%--<span class="fx">${liveCourse.directionName}</span>--%>
                    <%--</p>--%>
                <%--</div>--%>
                <%--<div class="liveJoin">--%>
                    <%--<div class="end" >已结束</div>--%>

                <%--</div>--%>
            <%--</div>--%>
        <%--</div>--%>
    <%--</c:if>--%>
<%--</c:forEach>--%>
</div>
<div class="exchange" style="display:none; ">
    <div class="near-data">
        <span class="dataR">日期：</span>
        <a class="dataAll">全部</a>
         <ul>

         </ul>
        <a class="unwind">展开</a>
    </div>

    <div class="near-direction">
        <span class="dataR">方向：</span>
        <a class="dataAll">全部</a>
        <ul>

        </ul>
        <a class="unwind">展开</a>
    </div>
    <!--回放-->
    <div class="each-title">已结束</div>
  <div class="history">

  </div>
</div>
</div>

<script type="text/javascript">
    setInterval(function () {
        $(".sku-one").animate({
            height: Math.round(Math.random() * 13 + 1) + "px"
        }, 350)
        $(".sku-two").animate({
            height: Math.round(Math.random() * 13 + 1) + "px"
        }, 350)
        $(".sku-three").animate({
            height: Math.round(Math.random() * 13 + 1) + "px"
        }, 350)
    }, 350);
    $(document).ready(function(){
   $(".heid").click(function(){
       var to = $(".heid").index(this);
       var ms =  $(".heid").eq(to).attr("testMobile")
       var courseLiveId = $(".heid").eq(to).attr("courseLiveId");
       if(ms==""||ms==null){Util.User.login(function() {
           location.reload();
       });
       return false;
       }

       if( $(".heid:eq("+to+") span").text()=="取消预约"){
           var yu = parseInt($(".heid:eq("+to+")").parent().siblings(".endMan").text())
           var dataef ={yes:false,mobile:ms,liveId:courseLiveId,people:yu};
           $.ajax({
               type:"POST",
               url:"/live/booking",
               data:dataef,
               success:function(data){

                   $(".heid:eq("+to+")").parent().siblings(".endMan").text((yu-1)+"人已约")
//                   $(".endMan").html()
                   $(".heid:eq("+to+") span").text("预约直播");
                   $(".heid:eq("+to+") span").css({"color":"#5583db","left":"50%","margin-left":"-15px"});
                   $(".heid:eq("+to+")").removeClass("end-yes");
                   $(".heid:eq("+to+")").removeClass("end-no");
                   $(".heid:eq("+to+") .subscribe-ico").css("display","inline-block")
                   $(".heid:eq("+to+") .subscribe-ico").removeClass("subscribeyes-ico");
                   $(".heid:eq("+to+")").unbind("mouseenter").unbind("mouseleave");
               }
           })
       }else{
           var yu = parseInt($(".heid:eq("+to+")").parent().siblings(".endMan").text())
           if( $(".heid:eq("+to+") span").text()=="预约直播"){
               var datas ={yes:true,mobile:ms,liveId:courseLiveId,people:yu};
           }else{
               var datas ={yes:true,mobile:ms,liveId:courseLiveId};
           }
        $.ajax({
            type:"POST",
            url:"/live/booking",
            data:datas,
            success:function(data){
                if( $(".heid:eq("+to+") span").text()=="预约直播"){
                    $(".heid:eq("+to+")").parent().siblings(".endMan").text((yu+1)+"人已约")
                }
                $(".heid:eq("+to+") span").text("已预约");
                $(".heid:eq("+to+") span").css({"color":"#5583db","left":"58px","margin-left":"0px"});
                $(".heid:eq("+to+") .subscribe-ico").addClass("subscribeyes-ico");
                $(".heid:eq("+to+")").addClass("end-yes");
                $(".heid:eq("+to+") .prompt").css("display","block")
                setTimeout(function(){$(".heid:eq("+to+") .prompt").css("display","none")},5000)

                    $(".heid:eq("+to+")").bind({mouseenter:function(){
                        $(".heid:eq("+to+") span").text("取消预约");
                        $(".heid:eq("+to+") span").css({"color":"#ffffff","left":"50%","margin-left":"-24px"});
                        $(".heid:eq("+to+")").removeClass("end-yes");
                        $(".heid:eq("+to+")").addClass("end-no");
                        $(".heid:eq("+to+") .subscribe-ico").css("display","none")
                    },mouseleave:function(){
                        $(".heid:eq("+to+") span").text("已预约");
                        $(".heid:eq("+to+") span").css({"color":"#5583db","left":"58px","margin-left":"0px"});
                        $(".heid:eq("+to+")").addClass("end-yes");
                        $(".heid:eq("+to+")").removeClass("end-no");
                        $(".heid:eq("+to+") .subscribe-ico").css("display","inline-block")
                    }})


            },
            error:function(err,error){

            }
        });
       }
    })
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
//    $(function(){
//        var vip = $(".kjs").attr("vip")
////        $(".sb-close").click(function(){
////            $(".FloatOn").css("display","none")
////            $(".FloatOn1").css("display","none")
////            setCookie("close_xn_index", "yes", "xn")
////        })
////
////
////        if(getCookie("close_xn_liveList")!="yes"){
////            $(".FloatOn").css("display","block")
////            /*$(".FloatOn1").css("display","block")*/
////            if (vip == 1 || vip == 2 || vip == 3) {
////                $(".FloatOn1").css("display","none")
////            }else{
////                $(".FloatOn1").css("display","block")
////            }
////        }else{
////            $(".FloatOn").css("display","none")
////            $(".FloatOn1").css("display","none")
////        }
//
//
//
//    });
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
        }else{
            d.setTime(d.getTime() + ttt);
        }
        var expires = "expires="+d.toUTCString();
        document.cookie = cname + "=" + cvalue + "; " + expires;
    }
    //获取cookie
    function getCookie(cname) {
        var name = cname + "=";
        var ca = document.cookie.split(';');
        for(var i=0; i<ca.length; i++) {
            var c = ca[i];
            while (c.charAt(0)==' ') c = c.substring(1);
            if (c.indexOf(name) != -1) return c.substring(name.length, c.length);
        }
        return "";
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
    var consultDate ={pageNo:5};

    /*$(".too-consult").click(function(){
        var datas ={pageNo:5};
        $.ajax({
            type: "POST",
            url:'/consult/detail',
            data:datas,
            success: function(result) {
                if (result.success) {
                    if(${SESSION_USER.id!=''}){
                        NTKF.im_openInPageChat(result.data.rightUrl);
                    }else{
                        NTKF.im_openInPageChat(result.data.groupUrl);
                    }

                }
            }
        });

    });*/
    for(var r = 0; r<$(".end-make").length;r++){
        var zt = $(".end-make").eq(r).attr("endzt")
        if(zt=="true"){
            $(".heid:eq("+r+")").unbind("mouseenter").unbind("mouseleave");
            $(".heid:eq("+r+") span").text("已预约");
            $(".heid:eq("+r+") span").css("color","#5583db");
            $(".heid:eq("+r+") .subscribe-ico").addClass("subscribeyes-ico");
            $(".heid:eq("+r+")").addClass("end-yes");


            $(".heid:eq("+r+")").bind({mouseenter:function(){
                var n = $(".heid").index(this)
                $(".heid:eq("+n+") span").text("取消预约");
                $(".heid:eq("+n+") span").css({"color":"#ffffff","left":"50%","margin-left":"-24px"});
                $(".heid:eq("+n+")").removeClass("end-yes");
                $(".heid:eq("+n+")").addClass("end-no");
                $(".heid:eq("+n+") .subscribe-ico").css("display","none")
            },mouseleave:function(){
                var n = $(".heid").index(this)
                $(".heid:eq("+n+") span").text("已预约");
                $(".heid:eq("+n+") span").css({"color":"#5583db","left":"58px","margin-left":"0px"});
                $(".heid:eq("+n+")").addClass("end-yes");
                $(".heid:eq("+n+")").removeClass("end-no");
                $(".heid:eq("+n+") .subscribe-ico").css("display","inline-block")
            }})
        }else if(zt=="false"){
            $(".heid:eq("+r+") span").text("预约直播");
            $(".heid:eq("+r+") span").css("color","#5583db")
            $(".heid:eq("+r+")").removeClass("end-yes");
            $(".heid:eq("+r+") .subscribe-ico").removeClass("subscribeyes-ico");
            $(".heid:eq("+r+")").unbind("mouseenter").unbind("mouseleave");
        }
    }

$(".zzzb").hover(function(){
    var t = $(".zzzb").index(this);
    var tm = '进入教室 '+
              '<img src="/resources/live/images/jiao1.png"/>'
    $(".zzzb").eq(t).html(tm)
},function(){
    var t = $(".zzzb").index(this);
    var tm = '<div class="sku-play">'+
            '<span class="sku-one"></span>'+
            '<span class="sku-two"></span>'+
            '<span class="sku-three"></span>'+
            '</div>直播中'
    $(".zzzb").eq(t).html(tm)

})

</script>
<script type="text/javascript" src="/resources/live/js/datalist.js"></script>
</body>
</html>