<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<html lang="en" xmlns:gs="http://www.gensee.com/gsml">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=8,IE=9,chrome=1">
    <title>${courseLive.liveTitle}-设计牛</title>
    <link href="/resources/common/css/rest.css" rel="stylesheet">
    <link href="/resources/live/css/livePlay.css" rel="stylesheet">
    <link href="/resources-sjn/live/css/livePlay.css" rel="stylesheet">
    <script src="/resources/common/js/jquery-1.9.1.js"></script>
    <script src="${basePath}/resources/common/layer-v2.3/layer/layer.js"></script>
    <script src="${basePath}/resources/common/js/jquery.cookie.js"></script>
    <script src="${basePath}/resources-sjn/common/js/utils.js"></script>
    <script>
        var pagePath = "${basePath}";
        var vipFlag = "${vipFlag}";
        var userName = "${userName}";
        var webcastId = "${not empty courseLive?courseLive.liveId:0}";
        var recordingId = "${not empty courseLive?courseLive.recordingId:0}";

    </script>
<style type="text/css">
    .register {
        background: #444444 !important;
    }
    .register:hover{
        background: #333333 !important;
    }
</style>
</head>
<body>
<input type="hidden" id="liveId" value="${liveId}">
<input type="hidden" id="vipFlag"  value="${vipFlag}">
<input type="hidden" id="liveType" value="${courseLive.liveType}">
<div class="kjs live_content clearfloat">
    <c:choose>
        <c:when test="${vipFlag==3}">

        </c:when>
        <c:otherwise>
            <div class="so-all">
                <div class="reminder">
                    你可以试听15分钟，开通年会员后，可观看所有直播课
                </div>
                <a class="dredge" href="${basePath}/vip" target="_blank">开通年会员</a>
                <span class="reminder-close"></span>
            </div>
        </c:otherwise>
    </c:choose>
    <div class="livePlay_left">
        <div class="livePlay_left_top">
            <div class="livePlay_teaInfo">
                <div class="livePlay_courseInfo">
                    <span style="font-size: 20px;color: #333333;">${courseLive.liveTitle}</span>
                    <br/>
                    <span style="font-size: 14px;color: #999999;">老师：${courseLive.flowerName}</span>
                </div>
            </div>
            <div class="livePlay_userInfo">
                <c:choose>
                    <c:when test="${not empty userId}">
                        <div style="height: 18px;margin: 27px 10px;padding:0px 2px;line-height: 18px;border-radius: 3px;">
                            <c:if test="${vipFlag == 0}">
                                <img src="${basePath}/resources/live/images/live_vip_pt.png" alt="" style="margin-top: -4px"/>
                                <span style="color: #666;font-size: 12px;margin-right: 0px;">普通</span>
                            </c:if>
                            <c:if test="${vipFlag > 0}">
                                <img src="${basePath}/resources/live/images/vip-zy.gif" alt="" />
                            </c:if>
                        </div>
                        <div>
                            <span>${userName}</span>
                            <a href="${basePath}/logout"><span style="cursor: pointer;">退出</span></a>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <div>
                            <a href="#" onclick="Util.User.login(function() {
                                 location.reload();
                                });"><span style="cursor: pointer;">登录</span></a>
                            <%--<a href="/login"></a>--%>
                           <%-- <a href="${basePath}/logout"><span style="cursor: pointer;">退出</span></a>--%>
                        </div>
                    </c:otherwise>
                </c:choose>

            </div>
        </div>
        <div class="livePlay_left_middle">
            <div class="livePlay_ppt" id="end-ppt">
                <gs:doc site="duia.gensee.com:80"
                        ctx="webcast"
                        uname="${userName}"
                        ownerid="${courseLive.recordingId}"
                        lang="zh_CN"
                />
            </div>
            <div class="livePlay_video" id="end-video">
                <gs:video-vod id="objVideo"
                              httpMode="false" ver="4.0"
                              bar="false"
                              site="duia.gensee.com:80"
                              ctx="webcast"
                              uname="${userName}"
                              ownerid="${courseLive.recordingId}"
                              lang="zh_CN"
                />
            </div>
            <%--试看弹窗--%>
            <div class="livePlay_sk_zz" id="endDialog">

            </div>
            <div class="livePlay_sk" id="buyVip">
                <div class="livePlay_sk_close"><img src="${basePath}/resources/live/images/livePlay_sk_close.png" alt="" id="closeLive"/></div>
                <p style="margin-top: 40px;">试看时间已经结束，<a href="${basePath}/vip" target="_blank"><span style="color: #e62c3a;font-size: 18px;cursor: pointer;">开通年会员</span></a>继续观看</p>
                <a href="${basePath}/vip" target="_blank">
                    <span style="display: block;color: #000000;font-size: 18px;"><span id="djs" style="color:#e62c3a;"></span>后离开</span>
                    <p class="open-member">开通年会员</p>
                </a>
            </div>
            <%--开通会员浮层--%>
            <div class="livePlay_buy">
                <div class="livePlay_buy_content">您可以试看3min，开通会员免费观看</div>
                <div class="livePlay_buy_kt">开通会员</div>
                <div class="livePlay_buy_close"><img src="${basePath}/resources/live/images/livePlay_buy_close.png" alt="" /></div>
            </div>
        </div>
        <div class="livePlay_left_bottom">
            <div class="livePlay_kjs_icon">
                <img src="${basePath}/resources-sjn/live/images/sjn-livelogo.png" alt="">
            </div>
            <div class="livePlay_play_func">
                <div class="livePlay_voice"></div>
                <%--<div class="livePlay_change" data_flag="0"></div>
                <div class="livePlay_video_open"></div>
                <div class="livePlay_video_close"></div>--%>

                <div class="kjs-voice">
                    <div class="kjs-voice-bg" id="scal">
                        <div class="kjs-vi-color" id="saHeight" style="height: 80px;"></div>
                        <span class="kjs-vi-radius"></span>
                    </div>
                </div>

            </div>
        </div>
    </div>
    <div class="livePlay_right">
        <div class="livePlay_right_top">
            大家都在说
            <%--注意！会计下半年考试比较难！
            <span>点击了解</span>--%>
        </div>
        <div class="livePlay_right_middle">
            <div id="chatContent">

            </div>
        </div>
        <div class="livePlay_right_bottom">
            <div class="livePlay_func">
                <div class="livePlay_chat_icon">
                    <img src="${basePath}/resources/live/images/chat_icon.png" alt="" />
                    <div class="new-livexz">
                        <div class="new-bq-tit">默认表情</div>
                        <div class="new-live-ul">
                            <ul class="clearfloat">
                                <li><a href="javascript:;"><img alt="【礼物】"
                                                                src="http://static.gensee.com/webcast/static/emotion/chat.gift.png"/></a>
                                </li>
                                <li><a href="javascript:;"><img alt="【愤怒】"
                                                                src="http://static.gensee.com/webcast/static/emotion/emotion.angerly.gif"/></a>
                                </li>
                                <li><a href="javascript:;"><img alt="【鄙视】"
                                                                src="http://static.gensee.com/webcast/static/emotion/emotion.bs.gif"/></a>
                                </li>
                                <li><a href="javascript:;"><img alt="【伤心】"
                                                                src="http://static.gensee.com/webcast/static/emotion/emotion.cry.gif"/></a>
                                </li>
                                <li><a href="javascript:;"><img alt="【再见】"
                                                                src="http://static.gensee.com/webcast/static/emotion/emotion.goodbye.gif"/></a>
                                </li>
                                <li><a href="javascript:;"><img alt="【高兴】"
                                                                src="http://static.gensee.com/webcast/static/emotion/emotion.laugh.gif"/></a>
                                </li>
                                <li><a href="javascript:;"><img alt="【流汗】"
                                                                src="http://static.gensee.com/webcast/static/emotion/emotion.lh.gif"/></a>
                                </li>
                                <li><a href="javascript:;"><img alt="【无聊】"
                                                                src="http://static.gensee.com/webcast/static/emotion/emotion.nod.gif"/></a>
                                </li>
                                <li><a href="javascript:;"><img alt="【疑问】"
                                                                src="http://static.gensee.com/webcast/static/emotion/emotion.question.gif"/></a>
                                </li>
                                <li><a href="javascript:;"><img alt="【你好】"
                                                                src="http://static.gensee.com/webcast/static/emotion/emotion.smile.gif"/></a>
                                </li>
                                <li><a href="javascript:;"><img alt="【反对】"
                                                                src="http://static.gensee.com/webcast/static/emotion/feedback.against.gif"/></a>
                                </li>
                                <li><a href="javascript:;"><img alt="【赞同】"
                                                                src="http://static.gensee.com/webcast/static/emotion/feedback.agreed.png"/></a>
                                </li>
                                <li><a href="javascript:;"><img alt="【鼓掌】"
                                                                src="http://static.gensee.com/webcast/static/emotion/feedback.applaud.png"/></a>
                                </li>
                                <li><a href="javascript:;"><img alt="【太快了】"
                                                                src="http://static.gensee.com/webcast/static/emotion/feedback.quickly.png"/></a>
                                </li>
                                <li><a href="javascript:;"><img alt="【太慢了】"
                                                                src="http://static.gensee.com/webcast/static/emotion/feedback.slowly.png"/></a>
                                </li>
                                <li><a href="javascript:;"><img alt="【值得思考】"
                                                                src="http://static.gensee.com/webcast/static/emotion/feedback.think.png"/></a>
                                </li>
                                <li><a href="javascript:;"><img alt="【凋谢】"
                                                                src="http://static.gensee.com/webcast/static/emotion/rose.down.png"/></a>
                                </li>
                                <li><a href="javascript:;"><img alt="【鲜花】"
                                                                src="http://static.gensee.com/webcast/static/emotion/rose.up.png"/></a>
                                </li>
                            </ul>
                        </div>
                    </div>
                </div>
                <div class="livePlay_func_input">
                    <input type="text" id="chatInput" placeholder="登录发信息，免费领干货" />
                </div>
            </div>
            <div class="livePlay_send">
                发送
            </div>
        </div>
    </div>
</div>
<script>
    var Channel;
    var livePlay_ppt = $(".livePlay_ppt");
    livePlay_ppt.hide();
    $('.livePlay_video').attr('class','livePlay_ppt');
</script>
<script src="http://static.gensee.com/webcast/static/sdk/js/gssdk.js"></script>
<script src="/resources/live/js/livePlay.js"></script>
<script>
    var chatMaps;
    var playerType = "govod";
    /*Channel.bind("onDataReady",function(e){
        Channel.bind("onChatHistory", function (e) {
            if(e.data!=null && e.data!=''){
                for(var i = 0;i<e.data.list.length;i++){
                    var sender = e.data.list[i].sender;
                    var content = e.data.list[i].content;
                    content = content.split("&lt;").join("<");
                    content = content.split("&gt;").join(">");
                    var vipFlag = 0;
                    if(content.indexOf('vipFlag="1"')>0){
                        vipFlag = 1;
                    }
                    govodChatContent(content,sender,vipFlag);
                }
                if(e.data.more=="true"){
                    getChatMore();
                }
            }
        });
        getChatMore();
    });

    function getChatMore(){
        Channel.send("submitChatHistory",function(e){
            console.log(e);
        });
    }*/

    /*回放展示信息*/
    function govodChatContent(content, sender, vipFlag) {
        var htmlContent = '<div style="margin: 10px 15px;">';
        if (vipFlag == 1) {
            htmlContent += '<img src="' + pagePath + '/resources/live/images/vip-zy.gif" alt=""/>&nbsp;';
        }
        htmlContent += '<span class="chat_user_name">' + sender + '：</span>&nbsp;';
        content = forReplaceWap(content);
        htmlContent += '<span>' + content + '</span> </div>';
        $("#chatContent").append(htmlContent);
        chatScroll();
    }
    $(".reminder-close").click(function(){
        $(".so-all").css("display","none")
    })
    $(document).ready(function(){
        saveWatch();
    })
</script>
</body>
</html>
