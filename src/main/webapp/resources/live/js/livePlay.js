Channel = Channel || GS.createChannel();
var emojiPath = "http://static.gensee.com/webcast/static/emotion/";
var customEmoji = {
    "【礼物】":{"file":"chat.gift.png"},
    "【愤怒】":{"file":"emotion.angerly.gif"},
    "【鄙视】":{"file":"emotion.bs.gif"},
    "【伤心】":{"file":"emotion.cry.gif"},
    "【再见】":{"file":"emotion.goodbye.gif"},
    "【高兴】":{"file":"emotion.laugh.gif"},
    "【流汗】":{"file":"emotion.lh.gif"},
    "【无聊】":{"file":"emotion.nod.gif"},
    "【疑问】":{"file":"emotion.question.gif"},
    "【你好】":{"file":"emotion.smile.gif"},
    "【反对】":{"file":"feedback.against.gif"},
    "【赞同】":{"file":"feedback.agreed.png"},
    "【鼓掌】":{"file":"feedback.applaud.png"},
    "【太快了】":{"file":"feedback.quickly.png"},
    "【太慢了】":{"file":"feedback.slowly.png"},
    "【值得思考】":{"file":"feedback.think.png"},
    "【凋谢】":{"file":"rose.down.png"},
    "【鲜花】":{"file":"rose.up.png"}
};

/*循环替换wap表情*/
function forReplaceWap(content) {
    for(var key in customEmoji){
        if(content.indexOf(key)!=-1){
            var emojiContent = emojiPath+customEmoji[key].file;
            emojiContent = '<img src="'+emojiContent+'" width="20" height="20" />';
            content = content.split(key).join(emojiContent);
        }
    }
    return content;
}

function isNotNull(value) {
    if (value != null && value != '' && typeof value != 'undefined') {
        return true;
    }
    return false;
}

/*发送信息*/
function addChatContent(content, sender) {
    var htmlContent = '<div style="margin: 10px 15px;">';
    if (vipFlag == 1) {
        htmlContent += '<img src="' + pagePath + '/resources/live/images/vip-zy.gif" alt=""/>&nbsp;';
    }
    /*
     + '<img src="'+pagePath+'/resources/live/images/phone_icon.png" alt=""/>&nbsp;'
     */
    htmlContent += '<span class="chat_user_name">' + sender + '：</span>&nbsp;';
    var sendContent = content;
    content = forReplaceWap(content);
    htmlContent += '<span>' + content + '</span> </div>';
    $("#chatContent").append(htmlContent);
    var sendGenseeMsg = '<span vipFlag="'+vipFlag+'">'+sendContent+'</span>';
    Channel.send("submitChat", {"richtext": sendGenseeMsg});
    chatScroll();
}

function chatScroll() {
    var scrollH = $("#chatContent").height() - $(".livePlay_right_middle").height();
    $(".livePlay_right_middle").scrollTop(scrollH+9999);
    /*$(".live_chat").animate({
     scrollTop: scrollH
     }, 500);*/
}

/*接收其他人信息*/
function otherChatContent(content,sender,msg){
    var htmlContent = '<div style="margin: 10px 15px;">';
    /*老师发送的信息*/
    if (msg != null && msg.senderRole.indexOf("1") != -1 && msg.senderRole.indexOf("2") != -1 && msg.senderRole.indexOf("4") != -1) {
        htmlContent += '<img src="' + pagePath + '/resources/live/images/chat_tea.png" alt=""/>&nbsp;';
    }
    /*vip用户标识*/
    if (content.indexOf('vipFlag="1"') != -1) {
        htmlContent += '<img src="' + pagePath + '/resources/live/images/vip-zy.gif" alt=""/>&nbsp;';
    }
    htmlContent += '<span class="chat_user_name">' + sender + '：</span>&nbsp;';
    content = forReplaceWap(content);
    content = content.split("&lt;").join("<");
    content = content.split("&gt;").join(">");
    htmlContent += '<span>' + content + '</span> </div>';
    $("#chatContent").append(htmlContent);
    chatScroll();
}

/*咨询按钮弹窗*/
function initZx(){
    if(vipFlag != 3){
        $.ajax({
            url:"/consult/detail",
            data:{"pageNo":1},
            type:"post",
            success:function(data){
                if(data!=null && data.success == true && data.data!=null && data.data.leftUrl!=null && data.data.leftUrl!=''){
                    var xnKey = data.data.leftUrl;
                    $(".livePlay_xn").show();
                    $(".livePlay_xn").click(function(){
                        NTKF.im_openInPageChat(xnKey);
                    });
                }
                console.log(data);
            }
        });
    }
}

$(function () {
    initZx();
    /*直播缩放*/
//    $(window).resize(function(){
//        liveZoom();
//    });
    /*发送聊天信息操作*/
    $(".livePlay_send").click(function () {
        var content = $("#chatInput").val();
        if (isNotNull(content)) {
            addChatContent(content, '（我）');
        }
        $("#chatInput").val("");
    });
    /*表情弹出*/
    $(".livePlay_chat_icon").click(function (e) {
        if ($(this).find(".new-livexz").css("display") == "none") {
            $(".new-livexz").show();
        } else {
            $(".new-livexz").hide();
        }
        e.stopPropagation()
        $("body,html").click(function () {
            $(".new-livexz").hide();
        })
    });
    /*发送表情*/
    $(".new-live-ul li").bind("click", function (e) {
        var content = $(this).find("img").attr("alt");
        addChatContent(content, '（我）');
    });
    /*视频和ppt切换*/
    $("body").find(".livePlay_left").find(".livePlay_left_bottom").find(".livePlay_play_func").find(".livePlay_change").click(function(){
        var dataFlag = $(this).attr("data_flag");
        var livePlay_video = $(".livePlay_video");
        var livePlay_ppt = $(".livePlay_ppt");
        if(dataFlag==0){
            /*视频为主*/
            livePlay_video.attr("class","livePlay_ppt");
            livePlay_ppt.attr("class","livePlay_video");
            dataFlag=1;
        }else{
            /*ppt为主*/
            livePlay_video.attr("class","livePlay_video");
            livePlay_ppt.attr("class","livePlay_ppt");
            dataFlag=0;
        }
    });
    /*打开视频操作*/
    $("body").find(".livePlay_left").find(".livePlay_left_bottom").find(".livePlay_play_func").find(".livePlay_video_open").click(function(){
        $(".livePlay_video").css({"opacity":"1","filter":"alpha(opacity=100)","-moz-opacity":"1","-khtml-opacity":"1"});
    });
    /*关闭视频操作*/
    $("body").find(".livePlay_left").find(".livePlay_left_bottom").find(".livePlay_play_func").find(".livePlay_video_close").click(function(){
        $(".livePlay_video").css({"opacity":"0","filter":"alpha(opacity=0)","-moz-opacity":"0","-khtml-opacity":"0"});
    });
    onLineInit();
});

/*键盘enter发送*/
$(document).keydown(function (event) {
    if (event.keyCode == 13) {
        var content = $("#chatInput").val();
        if (isNotNull(content)) {
            addChatContent(content, '（我）');
            $("#chatInput").val("");
            event.returnValue = false;
            return false;
        } else {
            $("#chatInput").val("");
            event.returnValue = false;
            return false;
        }
    }
});

/*聊天信息监听接口*/
function onLineInit() {
    Channel.bind("onUserOnline", function (e) {
    });
    Channel.bind("onUserList", function (e) {
    });
    Channel.bind("onPublicChat", function (e) {
        otherChatContent(e.data.content,e.data.sender,e.data);
    });
    Channel.bind("onPriChat", function (e) {
        otherChatContent(e.data.content,e.data.sender,e.data);
    });
}
function wait(){

}
function extract(){
    var isVip=$("#vipFlag").val();
    var liveType = $("#liveType").val();
    if(isVip!=3){
        $("#endDialog").show();
        $("#buyVip").show();
        CountDown();
    }
}

/*观看学习人数*/
function saveWatch(){
    var liveId=$("#liveId").val();
    $.post('/live/watchEnd',{liveId:liveId}).done(function (result) {

    })
}

/*音量接口*/

/*倒计时 3s后跳转首面*/
function CountDown() {

    var i = 30;
    var down,s = 'S';
    var djs = $('#djs');

    djs.html(i+s);


    down = setInterval(
        function(){
            i--;
            djs.html(i+s);
            if(i == 0){
                clearInterval(down);
                $("#endDialog").hide();
                $("#buyVip").hide();
                window.location.href = '/live';
            }
        },
        1000);

}

//function liveZoom(){
//    var leftWidth = $('.livePlay_left').css('width',$(window).width()-$(".livePlay_right").width()-6+'px');
//    $('.so-all').css('width',$(window).width()-$(".livePlay_right").width()-6+'px');
//    $('.livePlay_left_middle,.livePlay_ppt').css('height',$(window).height()-110+'px');
//    $('.livePlay_right_middle').css('height',$(window).height()-170+'px');
//    $('.livePlay_sk').css('left',($(window).width()-$(".livePlay_right").width()-6-400)/2+'px');
//}
//liveZoom();

function sendGovodMsg(msg){
    var sender = msg.sender;
    var content = msg.msg;
    content = content.split("&lt;").join("<");
    content = content.split("&gt;").join(">");
    var vipFlag = 0;
    if(content.indexOf('vipFlag="1"')>0){
        vipFlag = 1;
    }
    govodChatContent(content,sender,vipFlag);
}
window.onload=function(){
    var liveId=$("#liveId").val();
    if(playerType == "govod"){
        $.ajax({url:"/live/getLiveRecord?liveId="+webcastId+"&recordId="+recordingId,
            type:"get",
            success:function(data){
                if(data!=null && data.data!=null && data.data!=''){
                    chatMaps = data.data;
                    var times = data.message;
                    if(times!=null && times!=""){
                        times = eval('(' + times + ')');
                    }
                    var startTime = parseInt(times.startTime);
                    var endTime =  parseInt(times.endTime);
                    chatTimer=setInterval(function(){
                        if(startTime==endTime){
                            clearInterval(chatTimer);
                        }
                        var msg = chatMaps[startTime];
                        if(msg!=null && msg!=""){
                            sendGovodMsg(msg);
                        }
                        startTime+=1000;
                    },1000);
                }
            }
        });
    }
    var vipFlag=$("#vipFlag").val();
    var liveType = $("#liveType").val();
    var kill;
    var killme;
    //if(liveType==1){
    //    $(".so-all").css("display","none")
    //}
    if(vipFlag!=3 && liveType==0){
        $.post('/live/canWatch',{liveId:liveId}).done(function (result) {
            if(result.success){
                var cookieName="lastLiveTime"+liveId;
                if(result.data){
                    if($.cookie("cookieName")==undefined){
                        $("#endDialog").hide();
                        $("#buyVip").hide();
                        killme =  setTimeout(function(){
                            $.cookie("cookieName",cookieName);
                            var isVip=$("#vipFlag").val();
                            var liveType = $("#liveType").val();
                            if(isVip!=3){
                                $("#endDialog").show();
                                $("#buyVip").show();
                                CountDown();
                            }
                        },1000*60*15);
                    }
                    else{
                        $("#endDialog").show();
                        $("#buyVip").show();
                        CountDown();
                    }
                }else{
                    kill = setTimeout(function(){
                        $.cookie("cookieName",cookieName)
                        var isVip=$("#vipFlag").val();
                        var liveType = $("#liveType").val();
                        if(isVip!=3){
                            $("#endDialog").show();
                            $("#buyVip").show();
                            CountDown();
                        }
                    },1000*60*15);
                }
                //function extract(){
                //    var lastLiveTime=$.cookie(cookieName);
                //    var isVip=$("#vipFlag").val();
                //    var liveType = $("#liveType").val();
                //    if(isVip!=3){
                //        $("#endDialog").show();
                //        $("#buyVip").show();
                //        CountDown();
                //    }
                //
                //}
                //if($.cookie(cookieName)==undefined){
                //    var date = new Date();
                //    var h=date.getHours();       //获取当前小时数(0-23)
                //    var m=date.getMinutes();     //获取当前分钟数(0-59)
                //    var s=date.getSeconds();
                //    /*
                //     date.setTime(date.getTime()+(64800+1680-(h*3600+m*60+s))*1000);//失效时间
                //     */
                //    date.setTime(date.getTime()+(86400-(h*3600+m*60+s))*1000);
                //
                //    $.cookie(cookieName,new Date().getTime(),{"expires":date});
                //}else{
                //    //$.cookie(cookieName,new Date().getTime());//如果cookie没有cookiename存入
                //    /*设置cookie失效时间*/
                //
                //}
            }else{

            }
        })

    }
    $("#closeLive").click(function(e){
        window.location.href="/live/recent";
    })

    $('.livePlay_voice').click(function(e){
        if($('.kjs-voice').css('display')=='none'){
            $('.kjs-voice').show();
        }else{
            $('.kjs-voice').hide();
        }
        e.stopPropagation()
    })

    $("body,html").click(function () {
        $(".kjs-voice").hide();
    })
//    var scal=document.getElementById("scal").getElementsByTagName("span")[0];
//    var scalHeight = 80;
//    var spor=document.getElementById("scal");
//    var sWitche=document.getElementById("saHeight");
//    var disY=80;
//    scal.onmousedown=function(ev){
//        var Event=ev||event;
//        disY=Event.clientY+scalHeight;
//        document.onmousemove=function(ev){
//            var Event=ev||event;
//            var b=disY-Event.clientY;
//            if(b>=80){b=80}
//            if(b<=0){b=0}
//            scal.style.bottom=b+'px';
//            scalHeight = b;
//            var cc=b/(spor.offsetHeight-scal.offsetHeight);
//            sWitche.style.height=80*cc+'px';
//            var now= parseFloat( b)/ parseFloat(80);
//            Channel.send("submitVolume", {"value": now});
//        }
//        document.onmouseup=function(){
//            this.onmousemove=null;
//            this.onmouseup=null;
//        }
//        return false;
//    }


}
