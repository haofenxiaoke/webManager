var iCount;
var autostart = true;
var gid = $.cookie('gid');
var vid =$('#letv_id').val();
var isVIP = $('#is-vip').val();
var ticketValid = $('#ticketValid').val();
var isvipVideo = $('#isvipVideo').val();
var isUserPlay = $('#is-user-play').val()
var courseId = $('#course-id').val();
var lectureId = $('#lecture-id').val();
var videoUnique = $('#letv_id').val();
var watchTimeNode = $('#last-watch-node').val();//上次播放时间
var ajaxDatas = {lectureId:lectureId,gid:gid};
var entryTime = new Date().getTime();//进入播放页时间
var playType=$("#playType").val();//0;乐视 1：cc视频
var ccPlayId=$("#ccPlayId").val();



$(function(){

    //初始化
    initData();

    SetScrollTop();

    //点击跳到会员开通页面
    $(".hytj").click(function(){
        $(".hytc").css("display","none");
        window.open('/vip');
    });

    $('#kthy').click(function(){
        $(".hytc").css("display","none");
        window.open('/vip');
    });

    //资料观看弹出vip 开通框
    $('#data-id li').click(function () {
        var isUpWin = $(this).attr("isUpWin");
        if(isUpWin) {
            $("#vip-data").css("display", "block");
        }
    });

    $('#data-kthy').click(function () {
        $('#vip-data').css("display","none");
        window.open('/vip');
    });

    //播放结束验证、轮播
    iCount = setInterval(function(){
        checkPlay();
    },3000);

    //点击播放下一节
    $('#video-id li').click(function (e) {
    	console.log(e.target.dataset.id)
    	if(e.target.dataset.id == 0 && isVIP == 'false' && ticketValid == 'false') {
    		 $("#vip-video").css("display","block");
    	}else{
    		window.location.href='/course/play/'+courseId+'?lectureId='+$(this).attr('lectureId');
    	}
        
    });

    $(window).unbind().bind(Util.leaveEvent(),function(){
        savePlayRecord();//离开页面时保存记录
        Util.addEventListener();//与公用监听冲突 需重新加入
    });

});

//获取播放数据 cc  乐视
function getPlayData(){
    var datas ={};
    var recordId = $('#record-id').val();
    if(!watchTimeNode) watchTimeNode = 0;
    var watchTime = 0,videoTime = 0,videoProgress = 0;
    datas = {gid:gid,recordId:recordId,courseId:courseId,lectureId:lectureId,watchTimeNode:watchTimeNode,watchTime:watchTime,videoProgress:videoProgress};
    try{
        if(playType==0){
            player = getSWF("playerswfObj");
            videoTime = player.getVideoTime();
            var videoLength = player.getVideoSetting().duration;
            var playState = player.getPlayState().finish;

            //播放节点
            watchTimeNode = parseInt(videoTime);

            //播放进度
            videoProgress = parseInt((videoTime / videoLength).toFixed(2) * 10000 / 100);
            if(playState){
                videoProgress = 100;
                watchTimeNode = parseInt(videoLength);
            }
            if(parseInt(videoLength-videoTime) <60) videoProgress = 100;

            //单位s
            watchTime = parseInt((new Date().getTime()-entryTime)/1000);
        }else if(playType==1){
            //当前播放时间点
            videoTime=_posi;
            //视频总时长
            var videoLength = _totalTime;
            //播放节点
            watchTimeNode = parseInt(videoTime);
            videoProgress = parseInt((videoTime / videoLength).toFixed(2) * 10000 / 100);
            if(_posi==_totalTime&&_totalTime&&_totalTime!=0){
                videoProgress = 100;
                watchTimeNode = parseInt(videoLength);
            }
            if(parseInt(videoLength-videoTime) <60) videoProgress = 100;

            //单位s
            watchTime = parseInt((new Date().getTime()-entryTime)/1000);
        }
        datas = {gid:gid,recordId:recordId,courseId:courseId,lectureId:lectureId,watchTimeNode:watchTimeNode,watchTime:watchTime,videoProgress:videoProgress};
        return datas;
    }catch(e){
        return datas;
    }

}

//插入播放器代码
function play(vid,wid) {
    var playid = "C250F345AC028912";
    if (vid) {
        var swfobj=new SWFObject('http://union.bokecc.com/flash/player.swf', 'playerswfObj', '100%', '100%', '8');
        if(vid!=null){
            swfobj=new SWFObject('http://yuntv.letv.com/bcloud.swf', 'playerswfObj', '100%', '100%', '8');
            swfobj.addParam("flashvars","uu=dbt1cswrwl&vu="+vid+"&pu=1D2FE7723B&auto_play=1&gpcflag=1&width=1280&height=720&share=0&extend=0");
        }
        swfobj.addVariable( "videoid" , vid);		// spark_videoid,视频所拥有的
        swfobj.addVariable( "mode" , "api");		// mode, 注意：必须填写，否则无法播放
        swfobj.addVariable( "autostart" , autostart);	// 开始自动播放，true/false
        swfobj.addVariable( "jscontrol" , "true");	// 开启js控制播放器，true/false
        swfobj.addParam('allowFullscreen','true');
        swfobj.addVariable( "playerid" , playid);
        swfobj.addParam('playerid',playid);
        swfobj.addParam('allowScriptAccess','always');
        swfobj.addParam('wmode','transparent');
        swfobj.write(wid);
    } else {

    }
}

//获取播放器对象
function getSWF( swfID ) {
    if( window.document[ swfID ] ) {
        return window.document[ swfID ];
    } else if( navigator.appName.indexOf( "Microsoft" ) == -1 ) {
        if( document.embeds && document.embeds[ swfID ] ) {
            return document.embeds[ swfID ];
        }
    } else {
        return document.getElementById( swfID );
    }
}

//播放前vip验证、异步加载信息、播放
function initData(){
    //延迟0.2s后播放
    setTimeout(function(){
        if(isvipVideo == 0 && isVIP == 'false' && ticketValid == 'false') return;
        if(playType==0){
            play(vid,'playerswf');
        }else if(playType==1){
            ccVideoPlay(ccPlayId);
        }
        setTimeout(function(){pushLastPlayPoint();},3000);
    },200);
    if(playType==0 ){
        if(!videoUnique) return;
    }else if(playType==1){
        if(!ccPlayId) return;
    }

    if(isvipVideo == 0 && isVIP == 'false' && ticketValid == 'false'){
        $("#vip-video").css("display","block");
        return;
    }
    lastWatchNode();
    fillScoreState();
    savePlayRecord();
}

//推到上次的位置 cc 乐视
function pushLastPlayPoint(){
    var timeNode = $('#last-watch-node').val();
    try{
        if( playType==0){
            var player = getSWF("playerswfObj");
            if(isUserPlay){
                if(timeNode){
                    player.seekTo(parseInt(timeNode));
                }
            }else player.seekTo(parseInt(3));
        }else if(playType==1){
            if(isUserPlay){
                if(timeNode){
                    loadCompleteHandler(parseInt(timeNode));
                }
            }else loadCompleteHandler(parseInt(3));
        }

    }catch(e){}
}

//定位滚动条高度
function SetScrollTop() {
    var scroll = $('#listRight');
    var oTop = $('#ls-'+lectureId).offset().top-180;
    scroll.scrollTop(scroll.scrollTop()+oTop);
}

//存储视频播放记录
function savePlayRecord(){
    try{

        var datas = getPlayData();
        if(!datas || datas.length==0) return;

        $.post('/course/save/video', datas).done(function (result) {
            if (result.success) {
                $('#record-id').val(result.data)

            }else{

            }
        })
    }catch(e){

    }
}

//播发结束验证 cc 乐视
function checkPlay(){
    try{
        $('#video-id li').each(function(index,vids){
            var nowLectureId = $(this).attr('lectureId');
            if(nowLectureId == lectureId){
                if( playType==0){
                    player = getSWF("playerswfObj");
                    if(player.getPlayState().finish){
                        var _isvipVideo = $(this).attr('isvipVideo');
                        if((index+1 == $('#video-id li').size()) || (_isvipVideo == 0 && isVIP == false && ticketValid == 'false') ){
                            clearInterval(iCount);
                            return false;
                        }else{
                            //轮播
                            var loopObj = $('#video-id li:eq('+(index+1)+')');
                            window.location.href='/course/play/'+loopObj.attr('courseId')+'?lectureId='+loopObj.attr('lectureId');
                        }
                    }
                    return false;
                }else if(playType==1){
                    if(_posi==_totalTime&&_totalTime&&_totalTime!=0 ){
                        var _isvipVideo = $(this).attr('isvipVideo');
                        if((index+1 == $('#video-id li').size()) || (_isvipVideo == 0 && isVIP == false && ticketValid == 'false') ){
                            clearInterval(iCount);
                            return false;
                        }else{
                            //轮播
                            var loopObj = $('#video-id li:eq('+(index+1)+')');
                            window.location.href='/course/play/'+loopObj.attr('courseId')+'?lectureId='+loopObj.attr('lectureId');
                        }
                    }
                    return false;
                }

            }
        })
    }catch(e) {

    }
}

//章节视频上次播放时间节点
function lastWatchNode(){

    $.post('/course/video/lastWatchNode', ajaxDatas).done(function (result) {
        if (result.success) {
            $('#last-watch-node').val(result.data);
        }else{

        }
    })
}

//更改是否评分状态
function fillScoreState(){

    $.post('/course/check/score', ajaxDatas).done(function (result) {
        if (result.success) {
            $('#isScore').val(result.data);
        }else{

        }
    })
}

$('.onesrk textarea').on('click',function(e){
    $(this).parent().css({'border':'1px solid #5583db','background':'#fff'});
    $(this).css('background','#fff');
    e.stopPropagation();
})
$('body,html').on('click',function(){
    $('.onesrk').css({'border':'1px solid #e0e0e0','background':'#f7f9fa'});
    $('.onesrk textarea').css('background','#f7f9fa');
})


/*CC加载完成后 初始化相关监听事件*/
function loadedHandler(){
    /*用户点击播放监听*/
    CKobject.getObjectById('ckplayer_a1').addListener('play','playHandler');
    /*用户点击暂停监听*/
    CKobject.getObjectById('ckplayer_a1').addListener('pause','pauseHandler');
    /*监听视频结束*/
    CKobject.getObjectById('ckplayer_a1').addListener('ended','endedHandler');
    /*监听视频播放时间*/
    CKobject.getObjectById('ckplayer_a1').addListener('time','timeHandler');
    /*获取总时长*/
    CKobject.getObjectById('ckplayer_a1').addListener('totaltime','totaltimeHandler');
    CKobject.getObjectById('ckplayer_a1').addListener('loadComplete','loadCompleteHandler');
    CKobject.getObjectById('ckplayer_a1').addListener('bounceTime','bounceTimeHandler');
    CKobject.getObjectById('ckplayer_a1').addListener('buffer','bufferHandler');
}
//调到指定时间播放
function loadCompleteHandler(time){
    if(time!=undefined && time > 0){
        CKobject.getObjectById('ckplayer_a1').videoSeek(time);

    }
}

//暂停
function ccPause(){
    CKobject.getObjectById('ckplayer_a1').videoPause();
    if(vipFlag!=0){
        clearInterval(timer);
    };

};

function playHandler(){
    console.log("播放");
}

function pauseHandler() {
    console.log("暂停");
}

function endedHandler(){
    console.log("结束");
}
var _posi=0 ;
function timeHandler(number){
    _posi = number;
}
var _totalTime=0 ;
function totaltimeHandler(number){
    _totalTime = number;
}
var bufferNumber;
function bufferHandler(number){
    bufferNumber=number;
}

//cc播放
function ccVideoPlay(ccVideoId) {

    if(ccVideoId!=undefined&&ccVideoId!=null){
        var videoUrl = getCcInfo(ccVideoId);
        if (!isEmpty(videoUrl)) {
            document.getElementById("a1").html = "";
            ccVideoInit(videoUrl);
        }
    }

}

/*获取cc播放地址*/
function getCcInfo(ccVideoId) {
    var videoUrl = '';
    var param = {}, appKey = "vi2YxND1LJlGqVvtvESam2j0adU0NRnM", enterTime = new Date();
    param.userid = "83A12B9E94EB4438";
    param.auto_play = true;
    param.format = "json";
    param.hlsflag = 1;
    param.videoid = ccVideoId;
    var params = appendParams(param);
    param.time = enterTime.getTime();
    params += "&time=" + param.time + "&salt=" + appKey;
    param.hash = getSingByNoKey(params);
    params = appendParams(param);
    params = des.encryptByDES(params, "duia_2017");
    $.ajax({
        url: '/course/cc/info',
        data: {params: params},
        type: 'post',
        dataType: 'json',
        async: false,
        success: function (data) {
            if (data.data != 500 && data.data != 101&&data.data.indexOf("copy")!=-1) {
                videoUrl = JSON.parse(data.data).video.copy[0].playurl;
            }
        },
        error: function (e, err) {
            //console.log(err);
        }
    });
    return videoUrl;
}
