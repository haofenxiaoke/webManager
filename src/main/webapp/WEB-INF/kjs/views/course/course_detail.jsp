<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<%request.setAttribute("vEnter", "\n");%>
<html lang="zh">
<head>
    <meta charset="UTF-8">
    <title>${course.title}-好分课堂</title>
    <link rel="stylesheet" href="${basePath}/resources/common/css/rest.css" />
    <link rel="stylesheet" href="${basePath}/resources/course/css/curriculum.css" />
    <script type="text/javascript" src="${basePath}/resources/common/js/jquery-1.9.1.js" ></script>
    <script type="text/javascript" src="${basePath}/resources/course/js/detail.js"></script>
    <script type="text/javascript" src="${basePath}/resources/course/js/respond.js" ></script><!--兼容IE6-8@media勿删-->
<style type="text/css">
    .ded{position: absolute;top: 7px;right: 10px;}
</style>
</head>
<body>
<div class="toolbar" style="z-index: 64; display: none;">
    <c:choose>
        <c:when test="${SESSION_USER.vipId==1||SESSION_USER.vipId==2||SESSION_USER.vipId==3}">
            <a class="too-consult" style="display: block;" id="zixun" href="javascript:void(0)"><i class="reUse"></i><em style="display: none;" ></em></a>
        </c:when>
        <c:otherwise>
            <a class="too-consult" style="display: block;" id="qqxn"><i class="re"></i><em style="display: none;" ></em></a>
        </c:otherwise>
    </c:choose>
    <a class="too-ewm" style="background: #5583db;"><i class="res end-res"></i><em data-end="0"><small></small></em></a>
    <a class="too-xn"><i class="resq"></i><em></em></a>
    <a class="too-userDc" target="_blank" href="${basePath}/help?m=2"><i class="restIcon endyou"></i></a>
    <a class="too-scrollT" id="top"><i class="restIcon"></i></a>
</div>
<input type="hidden" id="course-id" name="course-id" value="${course.id}"/>
<div class="inside" vip="${userStu.isVIP}">
    <div class="Made-nav">
        <a href="/" style="padding-left: 0px;">首页</a> <img class="old" src="/resources/live/images/jiao2.png"/> <a href="${basePath}/course">全部课程</a> <img class="old" src="/resources/live/images/jiao2.png"/> <a href="${basePath}/course?directionId=${direction.id}">${direction.categoryDesc}</a><img class="old" src="/resources/live/images/jiao2.png"/> <a href="${basePath}/course?directionId=${direction.id}&positionId=${position.id}">${position.categoryDesc}</a><img class="old" src="/resources/live/images/jiao2.png"/> <a>${course.title}</a>
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
                    <img src="${basePath}/resources/login/images/fx.png">
                    <div class="duihua">
                        <a>
                            <div class="weixin">
                                <script type="text/javascript">
                                    (function(){
                                        var p = {
                                            url:location.href, /*获取URL，可加上来自分享到QQ标识，方便统计*/
                                            desc:'', /*分享理由(风格应模拟用户对话),支持多分享语随机展现（使用|分隔）*/
                                            title:'我正在会计狮学习《${course.title}》，干货满满！你也来学吧！', /*分享标题(可选)*/
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
                        <%--<a>--%>
                            <%--<div class="kongjian">--%>
                                <%--<script type="text/javascript">--%>
                                    <%--(function(){--%>
                                        <%--var p = {--%>
                                            <%--url:location.href,--%>
                                            <%--showcount:'0',/*是否显示分享总数,显示：'1'，不显示：'0' */--%>
                                            <%--desc:'',/*默认分享理由(可选)*/--%>
                                            <%--summary:'${courseSummary}',/*分享摘要(可选)*/--%>
                                            <%--title:'我正在会计狮学习《${course.title}》，干货满满！你也来学吧！',/*分享标题(可选)*/--%>
                                            <%--site:'腾讯网',/*分享来源 如：腾讯网(可选)*/--%>
                                            <%--pics:'${course.coverUrl}', /*分享图片的路径(可选)*/--%>
                                            <%--style:'202',--%>
                                            <%--width:31,--%>
                                            <%--height:31--%>
                                        <%--};--%>
                                        <%--var s = [];--%>
                                        <%--for(var i in p){--%>
                                            <%--s.push(i + '=' + encodeURIComponent(p[i]||''));--%>
                                        <%--}--%>
                                        <%--document.write(['<a version="1.0" class="qzOpenerDiv" href="http://sns.qzone.qq.com/cgi-bin/qzshare/cgi_qzshare_onekey?',s.join('&'),'" target="_blank">分享</a>'].join(''));--%>
                                    <%--})();--%>
                                <%--</script>--%>
                                <%--<script src="http://qzonestyle.gtimg.cn/qzone/app/qzlike/qzopensl.js#jsdate=20111201" charset="utf-8"></script>--%>
                            <%--</div>--%>
                        <%--</a>--%>

                        <script type="text/javascript">
                            (function () {
                                var p = {
//                url: 'http://pan.baidu.com/s/1DVCYI',
                                    showcount: '1',/*是否显示分享总数,显示：'1'，不显示：'0' */
                                    desc: '',/*默认分享理由(可选)*/
                                    summary: '${courseSummary}',/*分享摘要(可选)*/
                                    title: '我正在会计狮学习《${course.title}》，干货满满！你也来学吧！',/*分享标题(可选)*/
                                    site: '',/*分享来源 如：腾讯网(可选)*/
                                    pics: '${course.coverUrl}', /*分享图片的路径(可选)*/
                                    style: '202',
                                    width: 50,
                                    height: 30
                                };
                                var s = [];
                                for (var i in p) {
                                    s.push(i + '=' + encodeURIComponent(p[i] || ''));
                                }
//           document.write(['<a version="1.0" class="qzOpenerDiv" href="http://sns.qzone.qq.com/cgi-bin/qzshare/cgi_qzshare_onekey?', s.join('&'), '" target="_blank">分享</a>'].join(''));
                                document.write(['<a class="ded" href="http://sns.qzone.qq.com/cgi-bin/qzshare/cgi_qzshare_onekey?url=',encodeURIComponent(location.href), s.join('&'),'&title=',encodeURIComponent(document.title),'" target="_blank"  title="分享"><img src="/resources/course/images/111.png" alt="分享" /><\/a>'].join(''));
                            })();
                        </script>
                    </div>
                </div>
            </div>
            <div class="haoping">
                <span>好评:</span>
                <div class="kjsPfx clearfloat">
                    <c:if test="${course.score >= 5}">
                        <c:forEach var="x" begin="1" end="5" step="1">
                            <a class="restIcon kjsXxcur"></a>
                        </c:forEach>
                    </c:if>
                    <c:if test="${course.score < 5}">
                        <c:forEach var="x" begin="1" end="${course.score}" step="1">
                            <a class="restIcon kjsXxcur"></a>
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
                <c:if test="${userStu.isVIP == false and userStu.ticketValid == false}">
                    <div class="huiyuan">购买会员</div>
                    <div class="shiting"><a title="直接听课">直接听课</a></div>
                </c:if>
                <c:if test="${userStu.isVIP == true or userStu.ticketValid == true}">
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
                    <li class="members_Li">
                        <c:if test="${userStu.isVIP == false and userStu.ticketValid == false}">
                            <button class="members" id="members-1">购买会员</button>
                        </c:if>
                        <c:if test="${userStu.isVIP == true or userStu.ticketValid == true}">
                            <button class="members" id="members-2">听课</button>
                        </c:if>
                    </li>
                </ul>

            </div>
            <div class="chi">
                <div class="one" name="jieshao">
                    <div class="brief">
                        <p class="firstb"><span class="firsts">简</span>介</p>
                        <div class="lastb">${courseText.summary}</div>
                        <div class="cle"></div>
                    </div>
                    <div class="brief brieff">
                        <p class="firstb">岗位职责</p>
                        <div class="lastb">${courseText.jobDuty}</div>
                        <div class="cle"></div>
                    </div>
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
                            <li value="${courseLecture.id}" type="${courseLecture.isvipVideo}"  isVIP="${userStu.isVIP}"  ticketValid="${userStu.ticketValid}">
                                <p>
                                    <img src="${basePath}/resources/course/images/sign.png">
                                    <span>${courseLecture.lectureName}<span>（<fmt:formatNumber type="number" value="${courseLecture.videoLength/60}" maxFractionDigits="0"/>分钟）</span></span>
                                    <c:if test="${userStu.isVIP == true or userStu.ticketValid == true}"><button>听课</button></c:if>
                                    <c:if test="${userStu.isVIP == false and userStu.ticketValid == false}">
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
                                    <span></span>
                                    <span></span>
                                    <span></span>
                                    <span></span>
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
            <%--<div class="account">
                <span class="flock-title">实操做账</span>
                <a class="startwork" onclick="scFun()"><span class="startworkSpan"></span>动手做账</a>
                <p>实操做账是对真实的会计实务场景进行模拟训练的系统，用于强化视频课的学习效果，帮助你更好地胜任财务工作。</p>
            </div>
            <div class="flock">
                <span class="flock-title">一键加群</span>
                <div class="flock-content">
                    <div class="flock-left">
                        <img src="/resources/course/images/xiaoqie.png"/>
                    </div>
                    <div class="flock-right">
                        <a target="_blank" href="//shang.qq.com/wpa/qunwpa?idkey=c30cef6f94622c5623a19dc7a529d17dea3031415f30d09c5d9392bc52b890d1"><img border="0" src="//pub.idqqimg.com/wpa/images/group.png" alt="会计狮实战训练群-2" title="会计狮实战训练群-2"></a>
                        &lt;%&ndash;<a target="_blank" href="//shang.qq.com/wpa/qunwpa?idkey=4e771e00281569ffba8f6ea8643e0d66f4979c1b3fcbc875e0f5f602ed031d69"><img border="0" src="//pub.idqqimg.com/wpa/images/group.png" alt="会计狮实战训练群-1" title="会计狮实战训练群-1"></a>&ndash;%&gt;
                        &lt;%&ndash;<a target="_blank" href="//shang.qq.com/wpa/qunwpa?idkey=77b36f9397da06cc56f1396d7cf69bb4089bfdb58915ee0a3831ef2afbbc9f21"><p style="margin-top: 1px;color: #5583db;">会计狮实战训练群</p></a>&ndash;%&gt;
                        <p style="color: #666; margin-top: 15px;">群号：365392724 </p>
                        <p style="color: #999;">老师全程服务，学习更有效</p>
                    </div>
                </div>
            </div>--%>
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

<div class="index-shadeO" >
    <div class="scSeeO">
        <span class="scClose"></span>
        <p class="scSee-topO">实操做账为<span>会员专享</span><div style="text-align: center; margin-top: 10px;font-size: 14px; color: #666;">你已经体验过一次,开通会员后继续学习</div></p>
        <a href="${basePath}/vip">立即开通</a>
    </div>
</div>
<%--<div class="FloatOn1">
    <span class="sb-close">x</span>
    <div class="FloatOn">

    </div>
</div>--%>
<a id="window" style="display:none;" target="_blank"></a>
<a style="display:none" id="head_window1" target="_blank"></a>
<script type="text/javascript" src="${basePath}/resources/course/js/curriculum.js" ></script>
<script type="text/javascript">
//    $(function(){
//        $(".sb-close").click(function(){
//            $(".FloatOn").css("display","none")
//            $(".FloatOn1").css("display","none")
//            setCookie("close_xn_index", "yes", "xn")
//        })
//
//
//
//        if(getCookie("close_xn_course_detail")!="yes"){
//            $(".FloatOn").css("display","block")
//            /*$(".FloatOn1").css("display","block")*/
//            if (vip == 1 || vip == 2 || vip == 3) {
//                $(".FloatOn1").css("display","none")
//            }else{
//                $(".FloatOn1").css("display","block")
//            }
//        }else{
//            $(".FloatOn").css("display","none")
//            $(".FloatOn1").css("display","none")
//        }
//
//
//
//    });
    for(mu=0;mu< $(".dximg").length;mu++){
        var str= $(".dximg").eq(mu).text().length;//原始字符串

        var s = $(".dximg").eq(mu).text();//要展示的字符串
        if(str>6){
            s=s.substr(0,6)+"...";
            $(".dximg").eq(mu).text(s)
        }
    }
$(".toolbar a").hover(function(){
    if($(this).attr("class")=="too-ewm"&&$(".too-ewm em").attr("data-end")==1){ $(this).css("background","#5583db")}
    else if($(this).attr("class")!="too-ewm"){
        $(this).css("background","#5583db")
        $(".too-ewm").css("background","#444851")
    }

},function(){
    if($(this).attr("class")=="too-ewm"&&$(".too-ewm em").attr("data-end")==1){ $(this).css("background","#444851")}
    else if($(this).attr("class")!="too-ewm"){ $(this).css("background","#444851")}
})

//    $(".too-xn").hover(function(){
//        $(".too-ewm em").attr("data-end","1")
//        $(this).css("background","#5583db")
//        $(".too-ewm").css("background","#444851")
//        $(".too-userDc").css("background","#444851")
//        $(".too-scrollT").css("background","#444851")
//    },function(){})
//
//    $(".too-userDc").hover(function(){
//        $(".too-ewm em").attr("data-end","1")
//        $(this).css("background","#444851")
//    },function(){})
//
//    $(".too-scrollT").hover(function(){
//        $(".too-ewm em").attr("data-end","1")
//        $(this).css("background","#444851")
//    },function(){})

    $(".startwork").hover(function(){
        $(".startwork").addClass("startK")
        $(".startworkSpan").addClass("backups")
    },function(){
        $(".startwork").removeClass("startK")
        $(".startworkSpan").removeClass("backups")
    })



    var vip = $(".inside").attr("vip");
    var courseId = $('#course-id').val();
    var dataT={courseId:courseId};

$.ajax({
    type: "POST",
    url: "/practice/get/url",
    data: dataT,
    success: function (result) {
        if (result.success) {
            $("#head_window1").attr('href',result.data.url2);

        }
    }
});


function scFun() {
    var ms =  $(".body").attr("testMobile")
    if(ms==""||ms==null){Util.User.login(function() {
        location.reload();
    });
    }else{
        document.getElementById('head_window1').click();
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
        }else{
            d.setTime(d.getTime() + ttt);
        }
        var expires = "expires="+d.toUTCString();
        document.cookie = cname + "=" + cvalue + "; " + expires;
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
    })
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
    /*$(document).ready(function(){
        var datas ={pageNo:3};
        $.ajax({
            type: "POST",
            url:'/consult/detail',
            data:datas,
            success: function(result) {
                if (result.data.imgUrl!=null) {
                    var t = '<a><img src='+result.data.imgUrl+'></a>'
                    $(".FloatOn").append(t)
                }else{
                    $(".FloatOn1").css("display","none")
                }
            }
        });
    })
    $(".FloatOn").click(function(){
        var datas ={pageNo:3};
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

    })*/
    var consultDate ={pageNo:3};
    /*$(".too-consult").click(function(){
        var datas ={pageNo:3};
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

    })*/
</script>
</body>
</html>