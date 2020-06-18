<%@ page import="com.kjs.orm.model.CourseText" %>
<%@ page import="com.kjs.common.util.HtmlUtil" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<%request.setAttribute("vEnter", "\n");%>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>${course.title}-设计牛</title>
    <link rel="stylesheet" href="${basePath}/resources/common/css/rest.css" />
    <link rel="stylesheet" href="${basePath}/resources/course/css/curriculum.css" />
    <link rel="stylesheet" href="${basePath}/resources-sjn/course/css/course_detile.css" />
    <script type="text/javascript" src="${basePath}/resources/common/js/jquery-1.9.1.js" ></script>
    <script type="text/javascript" src="${basePath}/resources-sjn/course/js/detail.js"></script>
    <script type="text/javascript" src="${basePath}/resources/course/js/respond.js" ></script><!--兼容IE6-8@media勿删-->
</head>
<body class="dbody" tess="tess">
<input type="hidden" id="course-id" name="course-id" value="${course.id}"/>
<div class="toolbar" style="z-index: 999; display: none;">
    <c:choose>
        <c:when test="${SESSION_USER.vipId==1||SESSION_USER.vipId==2||SESSION_USER.vipId==3}">
            <a class="too-consult zixun"  href="javascript:void(0)"><i class="reUse"></i><em style="display: none;" ></em></a>
        </c:when>
        <c:otherwise>
            <a class="too-consult qqxn" ><i class="re"></i><em style="display: none;" ></em></a>
        </c:otherwise>
    </c:choose>
    <a class="too-ewm" style="background: #e62c3a;"><i class="res end-res"></i><em data-end="0"><small></small></em></a>
    <a class="too-xn"><i class="resq"></i><em style="top: -158px;"></em></a>
    <a class="too-userDc" target="_blank" href="${basePath}/help?m=2"><i class="restIcon"></i></a>
    <a class="too-scrollT" id="top"><i class="restIcon"></i></a>
</div>
<div class="inside">
    <div class="Made-nav">
        <a href="/" style="padding-left: 0px;">首页</a> > <a href="${basePath}/course">全部课程</a> > <a href="${basePath}/course?directionId=${direction.id}">${direction.categoryDesc}</a> > <a href="${basePath}/course?directionId=${direction.id}&positionId=${position.id}">${position.categoryDesc}</a> > <a>${course.title}</a>
    </div>
    <div class="curriculum-bottom content-m-top">
        <div class="ccbottom-left"><img src="${course.coverUrl}"></div>
        <div class="ccbottom-right">
            <div class="zhuti">
                <span>
                    <c:if test="${fn:length(course.title)>20 }">${ fn:substring(course.title,0,11)}...</c:if>
                    <c:if test="${fn:length(course.title)<=20 }">${ course.title}</c:if>
                </span>
                <div class="fx">
                    <img id="fx-img" src="${basePath}/resources-sjn/course/images/sjn_share.png">
                    <div class="duihua">
                        <a>
                            <div class="weixin">
                                <script type="text/javascript">
                                    (function(){
                                        var p = {
                                            url:location.href, /*获取URL，可加上来自分享到QQ标识，方便统计*/
                                            desc:'', /*分享理由(风格应模拟用户对话),支持多分享语随机展现（使用|分隔）*/
                                            title:'我正在设计牛学习《${course.title}》，干货满满！你也来学吧！', /*分享标题(可选)*/
                                            summary:'${courseSummary}', /*分享摘要(可选)*/
                                            pics:'${course.coverUrl}', /*分享图片(可选)*/
                                            flash: '', /*视频地址(可选)*/
                                            site:'QQ分享', /*分享来源(可选) 如：QQ分享*/
                                            style:'202',
                                            width:24,
                                            height:24
                                        };
                                        var s = [];
                                        for(var i in p){
                                            s.push(i + '=' + encodeURIComponent(p[i]||''));
                                        }
                                        document.write(['<a class="qcShareQQDiv" href="http://connect.qq.com/widget/shareqq/index.html?',s.join('&'),'" target="_blank">分享到QQ</a>'].join(''));
                                    })();
                                </script>
                                <script src="http://connect.qq.com/widget/loader/loader.js" widget="shareqq" charset="utf-8"></script>
                            </div>
                        </a>
                        <a>
                            <div class="kongjian">
                                <script type="text/javascript">
                                    document.write(['<a href="http://sns.qzone.qq.com/cgi-bin/qzshare/cgi_qzshare_onekey?pics=${course.coverUrl}&summary=${courseSummary}&url=',
                                        encodeURIComponent(location.href),'&title=','我正在设计牛学习《${course.title}》，干货满满！你也来学吧！','" ' +
                                        'target="_blank"  title="分享到QQ空间">' +
                                        '<img src="http://qzonestyle.gtimg.cn/ac/qzone_v5/app/app_share/qz_logo.png" width="24" height="24" alt="分享到QQ空间" /><\/a>'].join(''));
                                </script>
                            </div>
                        </a>
                    </div>
                </div>
            </div>
            <div class="haoping">
                <span>好评:</span>
                <div class="kjsPfx clearfloat">
                    <c:if test="${course.score >= 5}">
                        <c:forEach var="x" begin="1" end="5" step="1">
                            <a class="sjn_restBG kjsXxcur"></a>
                        </c:forEach>
                    </c:if>
                    <c:if test="${course.score < 5}">
                        <c:forEach var="x" begin="1" end="${course.score}" step="1">
                            <a class="sjn_restBG kjsXxcur"></a>
                        </c:forEach>
                        <c:forEach var="x" begin="1" end="${5 - course.score}" step="1">
                            <a class="restIcon"></a>
                        </c:forEach>
                    </c:if>
                </div>
            </div>
            <div class="rs">
                <p><img src="${basePath}/resources/login/images/xingxing_10.png"/>已购买人数<span>${course.courseStuNum}</span></p>
            </div>
            <div class="rs">
                <p>版本号：<span class="rsBan">第<x id="version">${course.version}</x>版</span></p>
            </div>
            <div class="duixiang">
                <div class="dx-top"><span>适合对象:</span>
                    <c:forEach items="${suitables}" var="suitable">
                        <div class="dximg" title="${suitable.content}">${suitable.content}</div>
                    </c:forEach>
                </div>
                <div class="kc"><span>课程优势:</span>
                    <ul>
                        <c:forEach items="${advantages}" var="advantage">
                            <li>${advantage.content}</li>
                        </c:forEach>
                    </ul>
                </div>
            </div>
            <div class="st">
                <c:if test="${userStu.isVIP == false}">
                    <div class="huiyuan">购买会员</div>
                    <div class="shiting"><a title="试听课程">试听课程</a></div>
                </c:if>
                <c:if test="${userStu.isVIP == true}">
                    <div class="shiting"><a title="听课">听课</a></div>
                </c:if>
            </div>
        </div>

    </div>

    <div class="curriculum-teach">
        <div class="xuanxiangka">
            <div class="xxk">
                <ul>
                    <li class="crouse_l_nav"><a>课程介绍</a></li>
                    <li><a>课程目录</a></li>
                    <li><a>学员评价</a></li>
                    <div class="members_Li">
                        <c:if test="${userStu.isVIP == false}">
                            <button class="members" id="members-1">购买会员</button>
                        </c:if>
                        <c:if test="${userStu.isVIP == true}">
                            <button class="members" id="members-2">听课</button>
                        </c:if>
                    </div>
                </ul>

            </div>
            <div class="chi">
                <div class="one" name="jieshao">
                    <div class="brief">
                        <p class="firstb"><span class="firsts">简</span>介</p>
                        <div class="lastb">${courseText.summary}</div>
                        <div class="cle"></div>
                    </div>
                   <%-- <div class="brief brieff">
                        <p class="firstb">岗位职责</p>
                        <div class="lastb">${courseText.jobDuty}</div>
                        <div class="cle"></div>
                    </div>--%>
                    <div class="brief brieF brieff">
                        <p class="firstb">老师介绍</p>
                        <div class="lastb">
                            <p class="briefImg"><img src='${teacher.imgUrl}'></p>
                            <div class="teach">
                                <p class="teachD">${teacher.flowerName}</p>
                                <p class="teaDuction">${fn:replace(teacher.introduction,vEnter,'<br />') }</p>
                            </div>
                            <div class="cle"></div>
                        </div>
                        <div class="cle"></div>
                    </div>
                </div>
                <div class="one" style="display: none;">

                    <ul class="catalog" id="catalog">
                        <c:forEach items="${courseLectures}" var="courseLecture">
                            <li value="${courseLecture.id}" type="${courseLecture.isvipVideo}" isVIP="${userStu.isVIP}">
                                <p>
                                    <img src="${basePath}/resources/course/images/sign.png">
                                    <span>${courseLecture.lectureName}<span>（<fmt:formatNumber type="number" value="${courseLecture.videoLength/60}" maxFractionDigits="0"/>分钟）</span></span>
                                    <c:if test="${userStu.isVIP == true}"><button>听课</button></c:if>
                                    <c:if test="${userStu.isVIP == false}">
                                        <c:if test="${courseLecture.isvipVideo == 1}"><button>试听</button></c:if>
                                    </c:if>
                                </p>
                            </li>
                        </c:forEach>
                    </ul>
                </div>
                <div class="one" style="display: none;" id="teacher-commen">
                    <ul class="commen" id="commen">
                        <li>
                            <div><img src="${basePath}/images/header.png"><span>史密斯</span></div>
                            <ul>
                                <li class="xing">
                                    <span class="liangxing"></span>
                                    <span class="liangxing"></span>
                                    <span class="liangxing"></span>
                                    <span class="liangxing"></span>
                                    <span class="anxing"></span>
                                </li>
                                <li class="lastLi">课程讲得非常详细，感觉自己要学的东西太多了，以后要经常来听课学习。</li>
                            </ul>
                            <span class="date">2016-08-30</span>
                        </li>
                    </ul>
                    <div class="no_Spe">
                        <div class='no_Img'><img src="${basePath}/images/norepeat.png"></div>
                        <p>暂无学员评论</p>
                    </div>
                </div>
            </div>
        </div>
        <div style="width: 372px;float: right;">
            <div class="flock">
                <span class="flock-title">加群学习</span>
                <div class="flock-content">
                    <div class="flock-left">
                        <img src="/resources-sjn/course/images/xiaoqie.png"/>
                    </div>
                    <div class="flock-right">
                        <a target="_blank" href="//shang.qq.com/wpa/qunwpa?idkey=dbf7c1bb9d9a7de20222e1c6f9ba460fb1566755e3ab495f4911dea8e39b5eb9"><p style="margin-top: 1px;color: #333333;">设计牛实战训练群</p></a>
                        <p style="color: #666;">群号：558686941</p>
                        <p style="color: #999;">老师全程服务，学习更有效</p>
                    </div>
                </div>
            </div>
            <div class="allsee">
                <div class="like">大家都在看</div>
                <c:forEach items="${hotVideos}" var="hotVideo">
                    <div class="like-nr">
                        <div class="nr-start">
                            <div class="stratLeft">
                                <a href="${basePath}/course/detail/${hotVideo.courseId}"><img src="${hotVideo.coverUrl}" /></a>
                            </div>
                            <div class="startRight">
                                <span class="btbt">
                                    <c:if test="${fn:length(hotVideo.title)>10 }">${ fn:substring(hotVideo.title,0,11)}...</c:if>
                                    <c:if test="${fn:length(hotVideo.title)<=10 }">${ hotVideo.title}</c:if>
                                </span>
                                <p>
                                    <img src="${basePath}/resources/login/images/sihai_11.png" />
                                    <span style="margin-right: 25px;">${hotVideo.playNumber}</span>
                                    <img src="${basePath}/resources/login/images/sihai_13.png" />
                                    <span>${hotVideo.commentNum}</span>
                                </p>
                            </div>
                        </div>
                    </div>
                </c:forEach>
                <c:if test="${null==hotVideos||hotVideos.isEmpty()}" >
                    <div class="like-nr">
                        <div class="zanwu">
                            <img src="${basePath}/resources/course/images/zanwu_03.png" />
                            <p>暂无视频</p>
                        </div>
                    </div>
                </c:if>
            </div>
        </div>
    </div>

</div>
<script type="text/javascript" src="${basePath}/resources/course/js/curriculum.js" ></script>
<script type="text/javascript">
    var consultDate ={pageNo:3};
    $(".fx").hover(function(){
        $("#fx-img").attr("src","${basePath}/resources-sjn/course/images/sjn_shareH.png")
    },function(){
        $("#fx-img").attr("src","${basePath}/resources-sjn/course/images/sjn_share.png")
    })
</script>
<script type="text/javascript">
    for(mu=0;mu< $(".dximg").length;mu++){
        var str= $(".dximg").eq(mu).text().length;//原始字符串

        var s = $(".dximg").eq(mu).text();//要展示的字符串
        if(str>6){
            s=s.substr(0,6)+"...";
            $(".dximg").eq(mu).text(s)
        }
    }


    $(".toolbar a").hover(function(){
        if($(this).attr("class")=="too-ewm"&&$(".too-ewm em").attr("data-end")==1){ $(this).css("background","#e62c3a")}
        else if($(this).attr("class")!="too-ewm"){
            $(this).css("background","#e62c3a")
            $(".too-ewm").css("background","#444851")
        }

    },function(){
        if($(this).attr("class")=="too-ewm"&&$(".too-ewm em").attr("data-end")==1){ $(this).css("background","#444851")}
        else if($(this).attr("class")!="too-ewm"){ $(this).css("background","#444851")}
    })


//
//    function setCookieLI(name, value, hours, path, domain, secure) {
//        var cdata = name + "=" + value;
//        if (hours) {
//            var d = new Date();
//            d.setHours(d.getHours() + hours);
//            cdata += "; expires=" + d.toGMTString();
//        }
//        cdata += path ? ("; path=" + path) : "";
//        cdata += domain ? ("; domain=" + domain) : "";
//        cdata += secure ? ("; secure=" + secure) : "";
//        document.cookie = cdata;
//    }
//
//    //读cookie操作
//    function getCookieLI(name) {
//        var reg = eval("/(?:^|;\\s*)" + name + "=([^=]+)(?:;|$)/");
//        return reg.test(document.cookie) ? RegExp.$1 : "";
//    }
//    //删除cookie操作
//    function removeCookieLI(name, path, domain) {
//        this.setCookie(name, "", -1, path, domain);
//    }
</script>
</body>
</html>