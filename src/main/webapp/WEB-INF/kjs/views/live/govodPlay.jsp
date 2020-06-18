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
      <link href="${basePath}/resources/common/css/index.css" rel="stylesheet">
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
        var webcastId = "${not empty courseLive?courseLive.liveId:0}";
        var recordingId = "${not empty courseLive?courseLive.recordingId:0}";
    </script>
    <style type="text/css">
        .FloatOn{width: 98px; height: 178px; position: fixed;top: 310px;left: 40px; z-index: 98;}
        .FloatOn1{width: 98px; height: 178px; position: fixed;top: 310px;left: 40px; z-index: 98;}
        .sb-close{ display:block; width: 18px; height: 18px; color: #fff; font-size: 18px; text-align: center;position: absolute; right:2px; top: 0px;
            cursor: pointer;z-index: 99; }
            
        #loding_img{position:absolute; z-index: 999; width:100%; height:100%;}
    </style>
    <script>

  
    </script>
</head>
<body>
<input type="hidden" id="liveId" value="${liveId}">
<input type="hidden" id="vipFlag"  value="${vipFlag}">
<input type="hidden" id="liveType" value="${courseLive.liveType}">


	<!-- <img src="/resources/common/images/indexgif.gif" id="loding_img"> -->


<div class="kjs live_content clearfloat" vip="${SESSION_USER.vipId}">


        <div class="livePlay_left_top">
           <div class="haofen_img">
           <a href="/">
           	<img src="/resources/common/images/u138.png" width="325px" height="48px">
           	</a>
           </div>
            <div class="livePlay_userInfo">
         
         
          <c:choose>
                    <c:when test="${not empty userId}">
                        <div style="height: 18px;margin: 27px 10px;padding:0px 2px;line-height: 18px;border-radius: 3px;">
                        <div>
                            
                            <a href="${basePath}/logout"><span style="cursor: pointer; font-size: 16px;">退出</span></a>
                        </div>
                            <c:if test="${vipFlag == 0}">
                                <div style="width: 45px; height: 45px; margin-top: -11px; cursor: pointer;" class="head_login_img">
                                 
                                	<img src="${(SESSION_USER.imgurl == '' || SESSION_USER.imgurl == null)?'/resources/common/images/photo.jpg':SESSION_USER.imgurl}" alt="" width="40" height="40" style="border-radius: 50%; margin-left: 10px;" >
                              
                                </div>
                            </c:if>
                            
                            <c:if test="${vipFlag > 0}">
                            
                            <div class="head_login_img">
                            <img src="${(SESSION_USER.imgurl == '' || SESSION_USER.imgurl == null)?'/resources/common/images/photo.jpg':SESSION_USER.imgurl}" alt="" width="40" height="40" style="border-radius: 50%; margin-left: 10px; margin-top:-14px; cursor:pointer;" >
                             <img src="${basePath}/resources/live/images/vip-zy.gif" alt="" / style="margin-top:-8px;margin-left: 6px; cursor:pointer;">
                            </div>
                               
                                
                            </c:if>
                        </div>
                        
                    </c:when>
                    <c:otherwise>
                        <div>
                            <a href="#" onclick="Util.User.login(function() {
                                 location.reload();
                                });"><span style="cursor: pointer; font-size: 20px;">登录</span></a>
                            <%--<a href="/login"></a>--%>
                           <%-- <a href="${basePath}/logout"><span style="cursor: pointer;">退出</span></a>--%>
                        </div>
                    </c:otherwise>
                </c:choose>
         
          
        
        <div class="Down1 juzhong">
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
       
       
        <div class="fxtb juzhong">
            <div class="Ico"></div>
           <div class="erweima_xcx ewm_hidd erweima">
                 	<img src="/resources/common/images/xcx_yuan.jpg">
            <div class="ewm_title" style="margin-top: -21px !important;">好分小课</div>
              </div>
        </div>
        
        <div class="fxtb juzhong">
            <div class="dapp"></div>
            <div class="erweima erweima_xcx ewm_hidd" style="margin-left: -36px;">
                 <div style="text-align: center; font-size: 18px; float: left; margin-left: 10px;">敬请期待！</div>
            </div> 
        </div>

            <div class="zxzx c_zlzl juzhong">
            <div class="PIco"></div>
           
        </div>

            </div>
        </div>


    <div class="livePlay_left">

        <div class="live_content_">
        <div class="livePlay_left_middle" id="livePlay_left_middle">
            <div class="livePlay_ppt" id="end-ppt" style="background-color: white;">
                <gs:doc site="duia.gensee.com:80"
                        ctx="webcast"
                        uname="${userName}"
                        ownerid="${courseLive.recordingId}"
                        lang="zh_CN"
                />
            </div>
            <div class="livePlay_video" id="end-video" style="background-color: black;">
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
            
            
            <!-- 领取资料 -->
			<div class="lqzl">
				<div class="lq_ewm"></div>
				<div class="btn_lingqu c_zlzl">直接领取</div>
			</div>            
            
            
            <!-- 聊天 -->
            <div class="livePlay_right">
			<div class="livePlay_right_middle">
            	<div id="chatContent">

            	</div>
        </div>
        <div class="livePlay_right_bottom" id="livePlay_right_bottom">
            <div class="livePlay_func">
                <div class="livePlay_chat_icon">
                   
                    
                      
                </div>
                <div class="livePlay_func_input">
                    <input type="text" id="chatInput" placeholder="上课和老师多互动，进步更快哟" />
                </div>
            </div>


            <c:if test="${vipFlag==0}">
                <div class="livePlay_xn">
                    咨询老师
                </div>
            </c:if>
            
                    <div class="livePlay_send">
                发送
            </div>
        </div>
    </div> 
</div>
            
          
           
        </div> 
        
        <div class="c_zl c_zlzl" id="c_zl"></div>
        
    </div>

</div>
<script>
    var Channel;
    
/*     document.onreadystatechange = completeLoading;
    function completeLoading() {

        if (document.readyState == "complete") {

        	document.getElementById("loding_img").style.display="none"
	
            

        }

    } */

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
<script>




function getCookie(name)
{
    var arr,reg=new RegExp("(^| )"+name+"=([^;]*)(;|$)");

    if(arr=document.cookie.match(reg))

        return (arr[2]);
    else
        return null;
}

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
//            $('#qq').attr('href','http://'+result.data.rightUrl);
        }
    });

})


$(".c_zlzl").click(function(){
	

    if(vip!=1 && vip!=2 && vip!=3){
        //小能
        NTKF.im_openInPageChat(consultDetail.rightUrl);
    }else{
        //qq
//        document.getElementById('qq').click();
        NTKF.im_openInPageChat(consultDetail.groupUrl);
    }
})


$(function(){
    $(".head_login_img").click(function(){
        window.location.href = "/userCenter";
    });
    Util.navbarCss();
});

    var chatMaps;
    var playerType = "govod";
    var videoLength;
    var playTime = 0;
    var pauseFlag = 0;
    Channel.bind("onDataReady",function(e){
        if(vipFlag == 3){
            var playInterval = setInterval(function(){
                if(pauseFlag == 0){
                    if(playTime>0){
                        $(".left-time").html(timeDuration(playTime)+ "/" + timeDuration(videoLength/1000));
                    }
                    var playProg = playTime*1000*100.0/videoLength;
                    $(".prog").width(playProg+"%");
                    $(".prog-video").css("left",playProg*$(".livePlay_left_bottom").width()/100-26+"px");
                    if(playTime*1000 >= videoLength){
                        return;
                    }
                    playTime++;
                }
            },1000);
            /*获取回放视频总时长*/
            Channel.bind("onFileDuration", function (e) {
                videoLength = e.data.duration;
                $(".left-time").html("00:00:00/" + timeDuration(videoLength/1000));
            });

            Channel.bind("onSeekCompleted", function (e) {
                if(e.data.timestamp >0){
                    /*跳转成功后处理*/
                    if($(".menu").attr("data-flag")==2){
                        $(".menu").click();
                    }
                }
            });

            Channel.bind("onAPIError",function(e){
                console.log(e);
            });

            Channel.bind("onPause",function(e){
                $(".pauseVideo").hide();
                $(".playVideo").show();
                pauseFlag = 1;
            });

            Channel.bind("play",function(e){
                $(".playVideo").hide();
                $(".pauseVideo").show();
                pauseFlag = 0;
            });

            Channel.bind("onPlayheadTime",function(e){
                if(e.data!=null){
                    $(".prog-hc").width(e.data.downloadProgress+"%");
                    if(e.data.downloadProgress == 100){
                        /*清除定时器*/
                        clearInterval(genseeVideoPlan);
                    }
                    /*滚动条进度*/
                }
            });
            var progVideo = document.getElementById("prog-video");
            var leftMiddle = document.getElementById("livePlay_left_middle");
            var rightMiddle = document.getElementById("livePlay_right_middle");
            var rightBottom = document.getElementById("livePlay_right_bottom");

            var left = 0;
            /*播放拖拽*/
            progVideo.onmousedown = function(event){
                var event = event || window.event;
                var leftVal = event.clientX - this.offsetLeft;
                var that = this;
                document.onmousemove = function(event){
                    var event = event || window.event;
                    barleft = event.clientX - leftVal;
                    if(barleft < 0)
                        barleft = -26;
                    else if(barleft > $(".livePlay_left_bottom").width()-28)
                        barleft = $(".livePlay_left_bottom").width()-28;
                    that.style.left = barleft + "px";
                    playTime = (barleft+26)*1.0*videoLength/$(".livePlay_left_bottom").width()/1000;
                    window.getSelection ? window.getSelection().removeAllRanges() : document.selection.empty();
                }
            }
            progVideo.onmouseup = function(){
                seekToGovod(playTime*1000);
                document.onmousemove = null;
            }
            leftMiddle.onmouseup = function(){
                seekToGovod(playTime*1000);
                document.onmousemove = null;
            }
            rightBottom.onmouseup = function(){
                seekToGovod(playTime*1000);
                document.onmousemove = null;
            }
            rightMiddle.onmouseup = function(){
                seekToGovod(playTime*1000);
                document.onmousemove = null;
            }
            $(".pauseVideo").click(function(){
                Channel.send("pause");
            });
            $(".playVideo").click(function(){
                Channel.send("play");
            });

            $(".prog-bg").click(function(e){
                playTime = e.pageX*1.0*videoLength/$(".livePlay_left_bottom").width()/1000;
                seekToGovod(playTime*1000);
            });

            $(".prog").click(function(e){
                playTime = e.pageX*1.0*videoLength/$(".livePlay_left_bottom").width()/1000;
                seekToGovod(playTime*1000);
            });

            /*视频缓冲进度*/
            var genseeVideoPlan = setInterval(function(){
                Channel.send("playheadTime");
            },2000);
        }
    });

    function timeDuration(second) {
        if (!second || isNaN(second))return;
        second = parseInt(second);
        var time = '';
        var hour = second / 3600 | 0;
        if (hour != 0) {
            time += checkTime(hour) + ':';
        } else {
            time += '00:';
        }
        var min = (second % 3600) / 60 | 0;
        time += checkTime(min) + ':';
        var sec = (second - hour * 3600 - min * 60) | 0;
        time += checkTime(sec);
        return time;
    }

    function checkTime(num) {
        var n = Number(num);
        if (n < 10)n = "0" + n;
        return n;
    }

    /*设置跳转时间方法*/
    function seekToGovod(seekTime){
        Channel.send("seek", {"timestamp": seekTime});
    }
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
    });*/

    /*function getChatMore(){
        Channel.send("submitChatHistory",function(e){
            console.log(e);
        });
    }*/
    var vip = $(".live_content").attr("vip")
    if (vip == 1 || vip == 2 || vip == 3) {
        $(".FloatOn1").css("display","none")
    }
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
