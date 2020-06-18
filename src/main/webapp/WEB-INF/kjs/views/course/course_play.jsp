<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<%request.setAttribute("vEnter", "\n");%>
<html lang="zh">
<head>
    <meta charset="UTF-8">
    <title>${course.title}-好分课堂</title>
    <link rel="stylesheet" href="${basePath}/resources/common/css/rest.css" />
    <link rel="stylesheet" href="${basePath}/resources/course/css/videoPlay.css" />
        <link href="${basePath}/resources/common/css/index.css" rel="stylesheet">
    <script src="${basePath}/resources/common/js/jquery-1.9.1.js"></script>
    <script src="${basePath}/resources/common/layer-v2.3/layer/layer.js"></script>
    <script src="${basePath}/resources/common/js/jquery.cookie.js"></script>
    <script type="text/javascript" src="${basePath}/resources/course/js/answer.js"></script>
    <script type="text/javascript" src="${basePath}/resources/course/js/respond.js"></script>
    <script src="${basePath}/resources/common/js/utils.js"></script>
    <!--兼容IE6-8@media勿删-->
<style type="text/css">
    #likeBTN{text-decoration: none;
        display: block;
        width: 30px;
        font-size: 14px;
        margin-top: 4px;}
    .weixin ifarme{margin-left: 7px;}
    .index-shadeO{ width: 100%; height: 100%;position: fixed; top: 0;left: 0;background: rgba(0,0,0,0.3);z-index: 99; display: none;}
    .scSeeO{ width: 400px; height: 200px;position: fixed; top: 50%; left: 50%; margin: -100px 0px 0px -200px; background: #fff; border-radius: 5px;}
    .scSee-topO{ text-align: center;font-size: 14px; height: 14px;line-height: 14px;color: #666666; margin-top: 50px;}
    .scSee-topO span{color:#ff6700 !important;}
    .scSeeO a{display: block; margin: 0px auto;width: 180px; height: 40px;line-height: 40px; text-align: center;font-size: 12px;background: #ff6700;border-radius: 3px;margin-top: 20px;}
    .scClose{ width: 25px; height: 25px;position: absolute;top: 15px;right: 12px; background: url("/resources/index/images/vipClose.png") no-repeat;cursor: pointer;}
    .endClose{ width: 25px; height: 25px;position: absolute;top: 15px;right: 12px; background: url("/resources/index/images/vipClose.png") no-repeat;cursor: pointer;}
    .jiathis_button_qzone{ color:#666666; margin-top: 10px;}
    .ded{position: absolute;top: 7px;right: 10px;}
    body{
    	background-color: #1b1b1b !important;
    }
</style>
</head>

<body>
<input type="hidden" id="is-vip" name="is-vip" value="${userStu.isVIP}">
<input type="hidden" id="ticketValid" name="ticketValid" value="${userStu.ticketValid}">
<input type="hidden" id="user-id" name="user-id" value="${userStu.id}">
<input type="hidden" id="lecture-id" name="lecture-id" value="${lectureId}"/>
<input type="hidden" id="course-id" name="course-id" value="${courseId}"/>
<input type="hidden" id="letv_id" name="letv_id" value="${videoUnique}"/>
<input type="hidden" id="isvipVideo" name="isvipVideo" value="${isvipVideo}"/>
<input type="hidden" id="is-user-play" name="is-user-play" value="${isUserPlay}"/>
<input type="hidden" id="record-id" name="record-id"/>
<input type="hidden" id="last-watch-node" name="last-watch-node"/>
<input type="hidden" id="isScore" name="isScore"/>
<input type="hidden" id="playType" value="${videoType}"/>
<input type="hidden" id="ccPlayId" value="${ccVideoUnique}"/>

<%--<div class="toolbar" style="z-index: 64;">--%>
    <%--&lt;%&ndash;<a class="too-ewm"><i class="res"></i><em><small></small></em></a>&ndash;%&gt;--%>
    <%--&lt;%&ndash;<a class="too-xn"><i class="resq"></i><em></em></a>&ndash;%&gt;--%>
    <%--<a class="too-userDc" target="_blank" href="${basePath}/help?m=2"><i class="restIcon"></i></a>--%>
    <%--<a class="too-scrollT" id="top"><i class="restIcon"></i></a>--%>
<%--</div>--%>
<% System.out.println("liveSets= " + pageContext.findAttribute("liveSets") ); %>

<div class="course_play_top">
		<div class="haofen_img chuizhijuzhong">
		 <a href="/">
			<img src="/resources/common/images/haofenxiaoke.png" width="133px" height="40px">
			</a>
		</div>
				<shiro:guest>
                <div class="course_title_right"  style="line-height: 80px;"><a onclick="Util.User.login(function() { location.reload();});">登录</a></div>
                </shiro:guest>
                <shiro:user>
                	<div class="course_title_right">
                        <div class="head_login_img">
                            <img  src="${(SESSION_USER.imgurl == '' || SESSION_USER.imgurl == null)?'/resources/common/images/photo.jpg':SESSION_USER.imgurl}" alt="" width="40" height="40" />
                        </div>
                        <div style=" margin-right: 20px;">
                            <a href="${basePath}/logout" style="color: #ffffff;font-size: 12px;text-decoration: none; line-height: 80px;">退出</a>
 
                        </div>
                    </div>
                </shiro:user>
		
		<div class="course_title "> <img src="/resources/common/images/lv.png"> ${course.title} </div>
		
	</div>

<div class="video-all" test="${userStu.vipId}" vip="${userStu.isVIP}">
	
    <div class="video-play content-m-top">
        <c:choose>
            <c:when test="${userStu.vipId==1||userStu.vipId==2||userStu.vipId==3 || userStu.ticketValid == true}">

            </c:when>
            <c:otherwise>
            <div class="so-all">
                <div class="reminder">
                    	<c:forEach items="${liveSets}" var="course" begin="0" end="0">
                    	${course.flowerName}正在直播中，点击开启直播新领程！
                    	</c:forEach>
                    	 <span class="reminder-close"></span>
                </div>
                <%-- <a class="dredge" href="${basePath}/vip">立即开通</a> --%>
                <!-- <span class="reminder-close"></span> -->
            </div>
            </c:otherwise>
        </c:choose>
        <!-- 视频右侧边栏 -->
        <div class="video-list">
           <!--  <div class="listLeft">
                <div class="qiehuan"></div>
            </div> -->
                            <div class="lr-top">
                    <ul>
                        <li style="background-color: #f8c208; " >目录</li>
                        <li >直播列表</li>
                    </ul>
                </div>
            <div class="listRight" id="listRight">

                <div class="lr-bottom">
                    <ul id="video-id">
                        <c:forEach items="${courseLectures}" var="courseLecture">
                            <c:if test="${userStu.isVIP == true or userStu.ticketValid == true}">
                                <a title="${courseLecture.lectureName}" id="ls-${courseLecture.id}">
                                    <li <c:if test="${lectureId != courseLecture.id}">style="color: #FFFFFF;"</c:if>
                                        <c:if test="${lectureId == courseLecture.id}">style="color: #f8c208;"</c:if>
                                        courseId="${course.id}" lectureId="${courseLecture.id}" videoId="${courseLecture.videoUnique}" isvipVideo="${courseLecture.isvipVideo}" data-id="${courseLecture.isvipVideo}">
                                        <span style="width:160px; display:inline-block; overflow:hidden; white-space: nowrap"><c:if test="${fn:length(courseLecture.lectureName)>15 }">${ fn:substring( courseLecture.lectureName ,0,15)}...</c:if>
                                        <c:if test="${fn:length(courseLecture.lectureName)<=15 }">${courseLecture.lectureName}</c:if>
                                    	</span>
                                    	<span style="float:right; color:#5583db;margin-right:10px;">免费</span>
                                    </li>
                                </a>
                            </c:if>
                            <c:if test="${userStu.isVIP == false and userStu.ticketValid == false}">
                                <c:if test="${courseLecture.isvipVideo == 1}">
                                    <a title="${courseLecture.lectureName}" id="ls-${courseLecture.id}">
                                        <li <c:if test="${lectureId != courseLecture.id}">style="color: #FFFFFF;"</c:if>
                                            <c:if test="${lectureId == courseLecture.id}">style="color: #f8c208;"</c:if>
                                            courseId="${course.id}" lectureId="${courseLecture.id}" videoId="${courseLecture.videoUnique}" isvipVideo="${courseLecture.isvipVideo}" data-id="${courseLecture.isvipVideo}">
                                            <span style="width:160px; display:inline-block; overflow:hidden; white-space: nowrap"><c:if test="${fn:length(courseLecture.lectureName)>15 }">${ fn:substring( courseLecture.lectureName ,0,15)}...</c:if>
                                            <c:if test="${fn:length(courseLecture.lectureName)<=15 }">${courseLecture.lectureName}</c:if>
                                            </span>
                                            <span style="float:right; color:#5583db;margin-right:10px;">免费</span>
                                        </li>
                                    </a>
                                </c:if>
                                <c:if test="${courseLecture.isvipVideo == 0}">
                                    <a title="${courseLecture.lectureName}" id="ls-${courseLecture.id}">
                                        <li <c:if test="${lectureId == courseLecture.id}">style="color: #FFFFFF;"</c:if>
                                            courseId="${course.id}" lectureId="${courseLecture.id}" isvipVideo="${courseLecture.isvipVideo}" data-id="${courseLecture.isvipVideo}">
                                            <span style="width:160px; display:inline-block; overflow:hidden; white-space: nowrap"><c:if test="${fn:length(courseLecture.lectureName)>15 }">${ fn:substring( courseLecture.lectureName ,0,15)}...</c:if>
                                            <c:if test="${fn:length(courseLecture.lectureName)<=15 }">${courseLecture.lectureName}</c:if> 
                                             </span>
                                            <span style="float:right; color:#f8c208; margin-right:10px;">会员</span>
                                        </li>
                                    </a>
                                </c:if>
                            </c:if>
                        </c:forEach>
                    </ul>
                    <!-- 直播列表 -->
                    <ul style="display: none;" id="data-id">
                         <c:forEach items="${liveSets}" var="course" begin="0" end="2"> 
                            <li style="height:auto; border-bottom: 1px solid black; width: 240px; margin-left: 0px;" endId="${course.id}" endzt="${course.livingFlag}"　liveId="${course.id}" endtype="${course.liveType}">
                            <a href="${basePath}/live/reviewLive/${course.id}"  target="_blank">
                            	<div class="live_top">
                            		
                            			<div class="live_img">
                            				<img src="${course.teacherUrl}" width="40px" height="40px" style="margin-right: 0px; margin-top: 0px;">
                            			</div>
                            		<div class="live_right">
                            			<img src="/resources/common/images/wjump.gif">
                            		</div>
                            			<div class="live_title">${course.directionName}</div>
                            		
                            		
                            	</div>
                            	<div class="live_bottom" title="${course.liveTitle}"><c:choose><c:when test="${fn:length(course.liveTitle) > 10}">${fn:substring(course.liveTitle, 0, 9)}...</c:when><c:otherwise> ${course.liveTitle}</c:otherwise></c:choose>~</div>
                            	</a>
                            </li>
                            
                            
                        </c:forEach> 
                    </ul>
                </div>

            </div>
        </div>
        <c:if test="${videoType==0}">
        <div class="video" id="playerswf"> </div>
        </c:if>
       <c:if test="${videoType==1}">
           <div class="video" id="a1"></div>
       </c:if>
       
       <div class="share">
          <div class="zxzx c_lqzl">
            <div class="PIco">
            	
            </div>
           
        </div>
        
        <div class="Down1">
            <div class="DownOimg"></div>
            <div class="ewm ewm_hidd">
                    	<div class="erweima ewm1">
                    		<img src="/resources/common/images/kuaiji_ewm.jpg">
                    		<div class="ewm_title">会计资料信息库</div>
                    	</div>
                    	<div class="erweima ewm2">
                    		<img src="/resources/common/images/jiaozi_ewm.jpg">
                    		<div class="ewm_title">教师资格信息资料库</div>
             </div>
           	</div>
        </div>
       
       
        <div class="fxtb">
            <div class="Ico"></div>
           <div class="erweima_xcx ewm_hidd erweima">
                 	<img src="/resources/common/images/xcx_yuan.jpg">
            <div class="ewm_title" style="margin-top: -2px !important;">好分小课</div>
              </div>
        </div>
        
        <div class="fxtb">
            <div class="dapp"></div>
           <div class="erweima erweima_xcx ewm_hidd" style="margin-left: -36px;">
                 <div style="text-align: center; font-size: 18px; float: left; margin-left: 10px; line-height: 70px;">敬请期待！</div>
            </div> 
        </div>
		
		

        <div class="share-right">
            <div class="lingquziliao c_lqzl">领取资料</div>
        </div>

    </div>
       
    </div>


   

    <!--评分弹窗-->
    <div class="grade-bj">
        <div class="grade">
            <div class="grade-bt">
                <span>评分</span><div class="gb"></div>
            </div>
            <div class="grade-jdt">
                <ul>
                    <li>
                        <div class="jdt-left">内容清晰：</div>
                        <div class="jdt-right">
                            <ul>
                                <li></li>
                                <li></li>
                                <li></li>
                                <li></li>
                                <li></li>
                            </ul>
                            <p><span>0</span>分</p>
                        </div>
                    </li>
                    <li>
                        <div class="jdt-left">演讲风趣：</div>
                        <div class="jdt-rightone">
                            <ul>
                                <li></li>
                                <li></li>
                                <li></li>
                                <li></li>
                                <li></li>
                            </ul>
                            <p><span>0</span>分</p>
                        </div>
                    </li>
                    <li>
                        <div class="jdt-left">视频流畅：</div>
                        <div class="jdt-righttwo">
                            <div class="fxk"><input type="radio" name="playradio" value="5">流畅不卡顿</div>
                            <div class="fxk"><input type="radio" name="playradio" value="3">偶尔卡顿</div>
                            <div class="fxk"><input type="radio" name="playradio" value="1">卡顿无法上课</div>
                        </div>
                    </li>
                </ul>
                <div class="suggest">
                    <div class="suggest-top">
                        <span class="suggestTop-l">其他建议（选填）</span><span class="suggestTop-r">可输入&nbsp;&nbsp;<span id="suggest-id">0</span>/200字</span>
                    </div>
                    <div class="suggest-bottom">
                        <textarea style="resize:none;" oninput="openMsg('#suggest-textarea','#suggest-id');" id="suggest-textarea"></textarea>
                    </div>
                </div>

            </div>
            <div>
                <div id="pfmsg" style="text-align:center;margin-top: 5px; color: red;"></div>
                <input type="submit" value="评分" class="pftj">
            </div>
        </div>
    </div>
    <!--评分弹窗-->
    <!--回复弹窗-->
    <div class="reply">
        <div class="reply-win">
            <div class="replyWin-top">
                <span>回复</span><div class="hf-gb"></div>
            </div>
            <div class="replyWin-bottom">
                <textarea></textarea>
                <div class="jinzhi"><span>0</span>/200</div>
            </div>
            <div><input type="submit" class="hftj"></div>
        </div>
    </div>
    <!--回复弹窗-->
    <!--会员弹窗-->
    <div class="hytc" style="display:none;" id="vip-video">
        <div class="tcnr">
            <div class="tcnr-top">
                <div class="tcnrgb"></div>
            </div>
            <div class="tctx">该视频需要<span id="kthy" style="cursor: pointer;">开通会员</span>才可以观看</div>
            <div class="kthy"><input type="submit" class="hytj" value="开通会员"></div>
        </div>
    </div>
    <div class="hytc" style="display:none;" id="vip-data">
        <div class="tcnr">
            <div class="tcnr-top">
                <div class="tcnrgb"></div>
            </div>
            <div class="tctx">该讲义需要<span id="data-kthy" style="cursor: pointer;">开通会员</span>才可以观看</div>
            <div class="kthy"><input type="submit" class="hytj" value="开通会员"></div>
        </div>
    </div>
    <!--会员弹窗-->
    <!--成功弹窗-->
    <div class="fxtc" style="display: none;">
        <div class="undefined">
            <img src="${basePath}/resources/course/images/fenxiang.png" />
            <span style="font-size: 18px;">分享成功</span>
        </div>
    </div>
    <div class="fxtc" style="display: none;" id="pfcg">
        <div class="undefined">
            <img src="${basePath}/resources/course/images/fenxiang.png" />
            <span style="font-size: 18px;">评论成功</span>
        </div>
    </div>
    <div class="fxtc" style="display: none;" id="ypfcg">
        <div class="undefined">
            <img src="${basePath}/resources/course/images/fenxiang.png" />
            <span style="font-size: 18px;">已经评过分啦</span>
        </div>
    </div>
    <!--成功弹窗-->
</div>
<%--可以试看1天弹窗--%>

<div class="index-shadeO" >
    <div class="scSeeO">
        <span class="scClose"></span>
        <p class="scSee-topO">实操做账为<span>会员专享</span><div style="text-align: center; margin-top: 10px;font-size: 14px; color: #666;">你已经体验过一次,开通会员后继续学习</div></p>
        <a href="${basePath}/vip">立即开通</a>
    </div>
</div>

 <div class="kjs-fotter" style="border 1px solid black; margin-top:129px; ">
    <div class="kjs-f-con">
        <div class="kjs-f-text clearfloat">
            <img src="${basePath}/resources/common/images/foter-logo.png" class="kjs-f-l" style="width:48px; height:48px;">
            <div class="kjs-f-c" style="height: 91px;">
                <div class="kjs-f-about" style="height: 20px;" >
                    <a href="${basePath}/help?m=5">关于我们</a>|
                    <a href="${basePath}/vip">会员服务</a>|
                    <a href="${basePath}/help?m=3&sm=3">隐私条款</a>|
                    <a href="${basePath}/help?m=3">用户协议</a>|
                    <a href="${basePath}/help">帮助中心</a>|
                    <a href="${basePath}/help?m=4">联系我们</a>|
                    <a href="${basePath}/help?m=2">意见反馈</a>|
                    <a href="http://www.duia.com" target="_blank">去对啊网</a>
                </div>
                <div class="kjs-f-bq" style="height: 20px;">
                    <span>Copyright@2016</span>
                    <span>北京入行教育科技有限公司版权所有</span>
                    <a href="http://www.miit.gov.cn/" target="_blank" style="margin-right: 20px; ">京ICP备16011120号-10</a>
                    <a href="http://www.miit.gov.cn/" target="_blank" style="margin-right: 20px;">京ICP证160803号</a>
                    <img style="margin-top: -3px; height: 20px; width: 20px;" src="/resources/index/images/picWb.png" />
                    <a target="_blank" href="http://www.beian.gov.cn/portal/registerSystemInfo?recordcode=11030102010060" "><span>京公网安备11030102010060号</span></a>
                </div>
                <div style="margin: 12px 8px 10px 9px;">
                    <a href="http://xwgdj.beijing.gov.cn/" target="_blank">出版物经营许可证（批发）新出发京批字第直170038号</a>
                </div>
            </div>
          <%--  <img src="${basePath}/resources/common/images/foter-ewm.png" class="kjs-f-r">--%>
        </div>
      <%--  <img src="${basePath}/resources/common/images/foter-wa.png" class="kjs-fo-tittle">--%>
        <%--<a class="kjs-fo-tittle"style="top: 0px;" key ="57a7f329efbfb00b583282a1"  logo_size="124x47"  logo_type="realname"  href="http://www.anquan.org" ><script src="//static.anquan.org/static/outer/js/aq_auth.js"></script></a>--%>
    </div>
</div>

<a id="window" style="display:none;" target="_blank"></a>
<a style="display:none" id="head_window1" target="_blank"></a>
<script src="${basePath}/resources/common/swfobject/swfobject.js"></script>
<%--cc--%>
<script src="${basePath}/resources/common/js/md5.min.js"></script>
<script src="${basePath}/resources/common/js/tools1.js"></script>
<script src="${basePath}/resources/common/js/duia_util.js"></script>
<script src="${basePath}/resources/common/js/duia-des.js"></script>
<script src="${basePath}/resources/ccvideo/js/ckplayer.js"></script>
<script src="http://common.duia.com/resource/otherCcvideo/js/ccVideo.js" type="text/javascript"></script>
<script type="text/javascript" src="${basePath}/resources/course/js/videoPlay.js" ></script>
<script src="${basePath}/resources/course/js/le_yun.js"></script>

<script type="text/javascript">

$(function(){
    $(".head_login_img").click(function(){
        window.location.href = "/userCenter";
    });
    Util.navbarCss();
});
var vip = $(".body").attr("vip");
var scUrl = $(".head_center").attr("mast")
$.ajax({
    type: "POST",
    url: "/practice/get/url",
    success: function (result) {
        if (result.success) {
            $("#head_window").attr('href',result.data.url1);
        }
    }
});


    $(function(){
        $(".fxtb").hover(function(){
            $(".duihua").show();
        },function(){
            $(".duihua").hide();
        });
        $(".reminder-close").click(function(){
            $(".so-all").css("display","none")
        })
     /*    setTimeout(function(){
            $(".so-all").stop().animate({"top":"381px"},500)
        },5000) */

        /* $("#playerswf").hover(function(){
            $(".so-all").stop().animate({"top":"381px"},500)
           settime = setTimeout(function(){
                $(".so-all").stop().animate({"top":"381px"},500)

            },7000)
        },function(){
            $(".so-all").stop().animate({"top":"381px"},500)
            clearTimeout(settime)
        }) */

       /*  $(".so-all").hover(function(){
            $(".so-all").stop().animate({"top":"381px"},500) */
//           settime = setTimeout(function(){
//                $(".so-all").stop().animate({"bottom":"0px"},500)
//
//            },7000)
       /*  },function(){ */
//            $(".so-all").stop().animate({"bottom":"0px"},500)
//            clearTimeout(settime)
      /*   }) */
    });
</script>

<script type="text/javascript">
/* 在线咨询 */
 
   var consultDate;
    var consultDetail;
    $(document).ready(function(){
       /* var datas ={pageNo:1};*/
        $.ajax({
            type: "POST",
            url:'/consult/detail',
            data:consultDate,
            success: function(result) {
                consultDetail=result.data

                if (result.data.leftUrl!=null &&getCookie("close")!="yes"&&vip==0) {
                    var t = '<a><img src='+result.data.imgUrl+'></a>'
                    
                    $("#vipTxt4i").css("display","block")
                }else{
                
                    $("#vipTxt4i").css("display","none")
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
//                $('#qq').attr('href','http://'+result.data.rightUrl);
            }
        });

    })

 
$(".c_lqzl").click(function(){
	

    if(vip!=1 && vip!=2 && vip!=3){
        //小能
        NTKF.im_openInPageChat(consultDetail.rightUrl);
    }else{
        //qq
//        document.getElementById('qq').click();
        NTKF.im_openInPageChat(consultDetail.groupUrl);
    }
})

    $(function () {
        $(".xxk li").on('click', function () {
            $(".xxk li").removeClass('crouse_l_nav');
            $(this).addClass('crouse_l_nav');
            $(this).parent().parent().next().find(">div").hide().eq($(this).index()).show();

        });

//        $(".sb-close").click(function(){
//            $(".FloatOn").css("display","none")
//            $(".FloatOn1").css("display","none")
//            setCookie("close_xn_index", "yes", "xn")
//        })
//
//
//
//        if(getCookie("close_xn_course_play")!="yes"){
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




    });
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
            return false;
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
    var consultDate ={pageNo:4};
    var courseId = $('#course-id').val();
   /* $(".too-consult").click(function(){
        var datas ={pageNo:4};
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