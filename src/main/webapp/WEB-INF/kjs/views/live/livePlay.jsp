<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<html lang="zh" xmlns:gs="http://www.gensee.com/gsml">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=8,IE=9,chrome=1">
    <title>${courseLive.liveTitle}-好分课堂</title>
    <link href="/resources/common/css/rest.css" rel="stylesheet">
    <link href="/resources/live/css/livePlay.css" rel="stylesheet">
    <script src="/resources/common/js/jquery-1.9.1.js"></script>
    <script src="${basePath}/resources/common/layer-v2.3/layer/layer.js"></script>
    <script src="${basePath}/resources/common/js/jquery.cookie.js"></script>
    <script src="${basePath}/resources/common/js/utils.js"></script>
    <script type="text/javascript" src="/resources-sjn/common/js/jquery.placeholder.js"></script>
    <script type="text/javascript">
        $(function(){
            $('input, textarea').placeholder();
        });
    </script>
    <script>
        var pagePath = "${basePath}";

        var vipFlag = "${vipFlag}";
        var userName = "${userName}";


    </script>
    <style type="text/css">
        .FloatOn{width: 98px; height: 178px; position: fixed;top: 310px;left: 40px; z-index: 98;}
        .FloatOn1{width: 98px; height: 178px; position: fixed;top: 310px;left: 40px; z-index: 98;}
        .sb-close{ display:block; width: 18px; height: 18px; color: #fff; font-size: 18px; text-align: center;position: absolute; right:2px; top: 0px;
            cursor: pointer;z-index: 99; }
     
    </style>
</head>
<body>
<input type="hidden" id="liveId" value="${liveId}">
<input type="hidden" id="vipFlag"  value="${vipFlag}">
<input type="hidden" id="liveType" value="${courseLive.liveType}">
<div class="live_content clearfloat my-jquery" vip="${SESSION_USER.vipId}">
    <c:choose>
        <c:when test="${vipFlag==3}">

        </c:when>
        <c:when test="${vipFlag==0 && courseLive.liveType==1}">
            <div class="so-all">
                <div class="reminder">
                    开通会员后，可以观看网站所有课程
                </div>
                <a class="dredge" href="${basePath}/vip" target="_blank">立即开通</a>
                <span class="reminder-close"></span>
            </div>
        </c:when>
        <c:when test="${(vipFlag==1 || vipFlag==2) && courseLive.liveType==1}">

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
       
        <div class="live_content_">

            
            <!-- 老师视频 -->
            <div class="livePlay_video" id="end-video">
                <gs:video-live id="objVideo"
                               httpMode="false" ver="4.0"
                               bar="false"
                               site="duia.gensee.com:80"
                               ctx="webcast"
                               uname="${userName}"
                               ownerid="${courseLive.liveId}"
                               lang="zh_CN"
                />
            </div>
            
                     <!-- 课件视频 -->
        <div class="livePlay_left_middle">
            <div class="livePlay_ppt" id="end-ppt">
                <gs:doc site="duia.gensee.com:80"
                        ctx="webcast"
                        uname="${userName}"
                        ownerid="${courseLive.liveId}"
                        lang="zh_CN"
                />
            </div>
            
            <%--试看弹窗--%>
            <div class="livePlay_sk_zz" id="endDialog">

            </div>
            <div class="livePlay_sk" id="buyVip">
                <div class="livePlay_sk_close"><img src="${basePath}/resources/live/images/livePlay_sk_close.png" alt="" id="closeLive"/></div>
                <p style="margin-top: 40px;">试看时间已经结束，<a href="${basePath}/vip" target="_blank"><span style="color: #7497e0;font-size: 18px;cursor: pointer;">开通年会员</span></a>继续观看</p>
                <a href="${basePath}/vip" target="_blank">
                    <span style="display: block;color: #000000;font-size: 18px;"><span id="djs" style="color:#e62c3a;"></span>后离开</span>
                    <p style="background-color: #5583db;width: 200px;border-radius: 5px;margin-left: 100px;cursor: pointer;color: #ffffff;margin-top: 10px;">开通年会员</p>
                </a>
            </div>
            <%--开通会员浮层--%>
            <div class="livePlay_buy">
                <div class="livePlay_buy_content">您可以试看3min，开通年会员免费观看</div>
                <div class="livePlay_buy_kt">开通年会员</div>
                <div class="livePlay_buy_close"><img src="${basePath}/resources/live/images/livePlay_buy_close.png" alt="" /></div>
            </div>
        </div>
        <div class="livePlay_left_bottom">
            <div class="livePlay_kjs_icon">

                <img src="${basePath}/resources/live/images/live_play_icon.png" alt="">
            </div>
            <div class="livePlay_play_func">
                <div class="livePlay_voice"></div>
                <div class="livePlay_change" data_flag="0"></div>
                <div class="livePlay_video_open"></div>
                <div class="livePlay_video_close"></div>

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
                    <input type="text" id="chatInput" placeholder="上课和老师多互动，进步更快哟" />
                </div>
            </div>
            <div class="livePlay_send">
                发送
            </div>
            <c:if test="${vipFlag == 0}">
                <div class="livePlay_xn">
                    咨询老师
                </div>
            </c:if>
        </div>
    </div>
</div>
</div>

<script type="text/javascript">
    var Channel;
    var playerType = "live";
    $(".reminder-close").click(function(){
        $(".so-all").css("display","none")
    })

</script>
<script src="http://static.gensee.com/webcast/static/sdk/js/gssdk.js"></script>
<script src="/resources/live/js/livePlay.js"></script>
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
//        var vip =$(".my-jquery").attr("vip") ;
//        $(".sb-close").click(function(){
//            $(".FloatOn").css("display","none")
//            $(".FloatOn1").css("display","none")
//            setCookie("close_xn_index", "yes", "xn")
//        })
//
//
//
//        if(getCookie("close_xn_livePlay")!="yes"){
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
    $(document).ready(function(){
        var datas ={pageNo:6};
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
        var datas ={pageNo:6};
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
        var datas ={pageNo:6};
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

    })

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

//    if (vip == 1 || vip == 2 || vip == 3) {
//        $(".FloatOn1").css("display","none")
//    }else{
//        $(".FloatOn1").css("display","block")
//    }
    var m = window.location.href;
    getStr(m,"?");
    function getStr(string,str){
        var str_before = string.split(str)[0];
        var str_after = string.split(str)[1];
        if(str_after=="0"||str_after=="0#"){

        }else{

        }
    }

    $(document).ready(function(){
        saveWatch();
    })

</script>
</body>
</html>
