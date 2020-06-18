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
  <title>直播课-设计牛</title>
  <link href="/resources/common/css/rest.css" rel="stylesheet">
  <link href="/resources/live/css/live.css" rel="stylesheet">
  <link href="/resources-sjn/live/css/live.css" rel="stylesheet">
  <script src="/resources/live/js/live.js"></script>
</head>
<body>
<div class="kjs">
  <div class="Made-nav">
    <a href="/" style="padding-left: 0;">首页</a> > <a href="#">直播列表</a>
  </div>
</div>
<div class="kjs live_content content-m-top" id="liveCourseList">
  <c:forEach items="${liveCourses}" var="liveCourse">
      <div class="liveObj">
          <!-- 直播图片 -->
          <div class="liveImg">
              <img src="${liveCourse.courseUrl}" alt=""/>
          </div>
          <div class="liveInfo">
       <span class="liveInfo_title">
           ${liveCourse.liveTitle}
           <%--<c:choose><c:when test="${fn:length(liveCourse.liveTitle) > 20}">${fn:substring(industry.categoryDesc, 0, 19)}...</c:when><c:otherwise>${liveCourse.liveTitle}</c:otherwise></c:choose>--%>
       </span>
              <c:if test="${liveCourse.liveType==0}">
                  <span class="near"></span>
              </c:if>
              <p style="line-height:50px;">
                  <span>方向：</span>
                  <span class="fx">${liveCourse.directionName}</span>
                      <%--<span class="sj">${liveCourse.liveStart}</span>--%>
                  <span style="margin-left:30px;">老师：</span>
                  <span class="sj">${liveCourse.flowerName}</span>
              </p>
              <p><span>简介：</span><br/>
          <span class="jj" title="${liveCourse.summary}">
            <c:if test="${fn:length(liveCourse.summary)>'138'}">
                ${fn:substring(liveCourse.summary,0,138)}...
            </c:if>
            <c:if test="${fn:length(liveCourse.summary)<='138'}">
                ${liveCourse.summary}
            </c:if>
          </span>
          </div>

          <c:if test="${liveCourse.isLiving == 1}">
              <div class="liveJoin">
                  <div class="zzzb" onclick="joinLive('${liveCourse.id}')"><div class="sku-play">
                      <span class="sku-one"></span>
                      <span class="sku-two"></span>
                      <span class="sku-three"></span>
                  </div>直播中</div>
                  <p style="display: block; width: 145px;line-height: 25px; text-align: center;"><span style="float: left;color: #666666;font-size: 18px;margin: 10px 6px 0px 0px;">${liveCourse.respDates}</span><span style="float: left;color: #666666;font-size: 18px;margin-top: 10px;"><fmt:formatDate value="${liveCourse.startTime}" pattern="HH:mm"></fmt:formatDate>-<fmt:formatDate value="${liveCourse.endTime}" pattern="HH:mm"></fmt:formatDate></span></p>
              </div>
          </c:if>
          <c:if test="${liveCourse.isLiving == 2}">
              <div class="liveJoin end-make" endzt="${liveCourse.livingFlag}">
                  <a class="jjzb heid" courseLiveId="${liveCourse.id}" testMobile="${SESSION_USER.mobile}" ><div class="subscribe-ico"></div><span>预约直播</span><div class="prompt">课前<div>5分钟</div>会短信提醒你上课</div></a>
                  <p style="display: block; width: 145px;line-height: 25px; text-align: center;"><span style="float: left; color: #666666;font-size: 18px;margin: 10px 6px 0px 0px; ">${liveCourse.respDates}</span><span style="float: left;color: #666666;font-size: 18px;margin-top: 10px;"><fmt:formatDate value="${liveCourse.startTime}" pattern="HH:mm"></fmt:formatDate>-<fmt:formatDate value="${liveCourse.endTime}" pattern="HH:mm"></fmt:formatDate></span></p>
              </div>
          </c:if>
          <c:if test="${liveCourse.isLiving == 3}">
              <div class="liveJoin">
                  <div class="jjzb" onclick="reviewLive('${liveCourse.id}')"><div class="playback-ico"></div><span>观看回放</span></div>
                  <p style="display: block; width: 145px;line-height: 25px; text-align: center;"><span style="float: left;color: #666666;font-size: 18px;margin: 10px 6px 0px 0px;">${liveCourse.respDates}</span><span style="float: left;color: #666666;font-size: 18px;margin-top: 10px;"><fmt:formatDate value="${liveCourse.startTime}" pattern="HH:mm"></fmt:formatDate>-<fmt:formatDate value="${liveCourse.endTime}" pattern="HH:mm"></fmt:formatDate></span></p>
              </div>
          </c:if>
          <c:if test="${liveCourse.isLiving == 4}">
              <div class="liveJoin">
                  <div class="end" >已结束</div>
                  <p style="display: block; width: 145px;line-height: 25px; text-align: center;"><span style="float: left;color: #666666;font-size: 18px;margin: 10px 6px 0px 0px;">${liveCourse.respDates}</span><span style="float: left;color: #666666;font-size: 18px;margin-top: 10px;"><fmt:formatDate value="${liveCourse.startTime}" pattern="HH:mm"></fmt:formatDate>-<fmt:formatDate value="${liveCourse.endTime}" pattern="HH:mm"></fmt:formatDate></span></p>
              </div>
          </c:if>


      </div>
  </c:forEach>
    <c:if test="${empty liveCourses}">
        <div class="kjs live_null" id="live_null" style="display: block">
            <div class="nullImg">
                <img src="/resources/live/images/live_null.png" alt=""/>
                <span>该项目在建设中......</span>
            </div>
        </div>
    </c:if>
</div>

<script type="text/javascript">
    var consultDate ={pageNo:5};
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
                var dataef ={yes:false,mobile:ms,liveId:courseLiveId};
                $.ajax({
                    type:"POST",
                    url:"/live/booking",
                    data:dataef,
                    success:function(data){
                        $(".heid:eq("+to+") span").text("预约直播");
                        $(".heid:eq("+to+") span").css({"color":"#ffffff","left":"50%","margin-left":"-15px"});
                        $(".heid:eq("+to+")").removeClass("end-yes");
                        $(".heid:eq("+to+") .subscribe-ico").css("display","inline-block")
                        $(".heid:eq("+to+") .subscribe-ico").removeClass("subscribeyes-ico");
                        $(".heid:eq("+to+")").unbind("mouseenter").unbind("mouseleave");
                    }
                })
            }else{
                var datas ={yes:true,mobile:ms,liveId:courseLiveId};
                $.ajax({
                    type:"POST",
                    url:"/live/booking",
                    data:datas,
                    success:function(data){
                        $(".heid:eq("+to+") span").text("已预约");
                        $(".heid:eq("+to+") span").css({"color":"#333333","left":"58px","margin-left":"0px"});
                        $(".heid:eq("+to+") .subscribe-ico").addClass("subscribeyes-ico");
                        $(".heid:eq("+to+")").addClass("end-yes");
                        $(".heid:eq("+to+") .prompt").css("display","block")
                        setTimeout(function(){$(".heid:eq("+to+") .prompt").css("display","none")},5000)

                        $(".heid:eq("+to+")").bind({mouseenter:function(){
                            $(".heid:eq("+to+") span").text("取消预约");
                            $(".heid:eq("+to+") span").css({"color":"#ffffff","left":"50%","margin-left":"-24px"});
                            $(".heid:eq("+to+")").removeClass("end-yes");
                            $(".heid:eq("+to+") .subscribe-ico").css("display","none")
                        },mouseleave:function(){
                            $(".heid:eq("+to+") span").text("已预约");
                            $(".heid:eq("+to+") span").css({"color":"#333333","left":"58px","margin-left":"0px"});
                            $(".heid:eq("+to+")").addClass("end-yes");
                            $(".heid:eq("+to+") .subscribe-ico").css("display","inline-block")
                        }})


                    },
                    error:function(err,error){

                    }
                });
            }
        })
    });

    for(var r = 0; r<$(".end-make").length;r++){
        var zt = $(".end-make").eq(r).attr("endzt")
        if(zt=="true"){
            $(".heid:eq("+r+")").unbind("mouseenter").unbind("mouseleave");
            $(".heid:eq("+r+") span").text("已预约");
            $(".heid:eq("+r+") span").css("color","#333333");
            $(".heid:eq("+r+") .subscribe-ico").addClass("subscribeyes-ico");
            $(".heid:eq("+r+")").addClass("end-yes");



            $(".heid:eq("+r+")").bind({mouseenter:function(){
                var n = $(".heid").index(this)
                $(".heid:eq("+n+") span").text("取消预约");
                $(".heid:eq("+n+") span").css({"color":"#ffffff","left":"50%","margin-left":"-24px"});
                $(".heid:eq("+n+")").removeClass("end-yes");
                $(".heid:eq("+n+") .subscribe-ico").css("display","none")
            },mouseleave:function(){
                var n = $(".heid").index(this)
                $(".heid:eq("+n+") span").text("已预约");
                $(".heid:eq("+n+") span").css({"color":"#333333","left":"58px","margin-left":"0px"});
                $(".heid:eq("+n+")").addClass("end-yes");
                $(".heid:eq("+n+") .subscribe-ico").css("display","inline-block")
            }})
        }else if(zt=="false"){
            $(".heid:eq("+r+") span").text("预约直播");
            $(".heid:eq("+r+") span").css("color","#ffffff")
            $(".heid:eq("+r+")").removeClass("end-yes");
            $(".heid:eq("+r+") .subscribe-ico").removeClass("subscribeyes-ico");
            $(".heid:eq("+r+")").unbind("mouseenter").unbind("mouseleave");
        }
    }

</script>
</body>
</html>