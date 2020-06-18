/**
 * Created by admin on 2016/6/30.
 */
/**
 * 直播课程页面
 * @author
 * @date 2016年7月1日 14:49:17
 */
(function ($) {


    $(document).ready(function () {
        /*获取直播课列表*/
       /* liveList();*/
        bindEvents();
    })


    //绑定各种事件
    function bindEvents() {

    }
    //获取直播列表
    function liveList(){
        var url='/live/list';
        $.post(url).done(function(result){
            if(result.success){
                //成功
                var data=result.data;
                var timestamp = Date.parse(new Date());
               /* if(!data){
                    $("#live_null").show();
                }*/
                if(data){
                    for(var i=0;i<data.length;i++){
                        var liveCourseDiv=document.createElement("div");
                        //liveCourseDiv.class = 'ksj live_content';
                        liveCourseDiv.css('class','ksj live_content');
                        var summary=data[i].summary;
                        if(summary.length>250){
                            summary=summary.substr(0,250)+'......';
                        }
                        /*判断直播状态*/
                        var isLiving='';

                        if(timestamp>data[i].liveStart && timestamp<data[i].liveEnd){
                            isLiving= '<div class="liveJoin">'+
                               /* '<p><span style="color: #5583db;font-size: 22px;">987</span><span>人浏览</span></p>'+*/
                                '<div class="zzzb"><a href="/?name=tom&pass=123"> 正在直播</a></div>'+
                                '</div>'+
                                '</div>';
                        }else if(timestamp>data[i].liveEnd){
                            isLiving='<div class="liveJoin">'+
                               /* '<p><span style="color: #5583db;font-size: 22px;">987</span><span>人浏览</span></p>'+*/
                                '<div class="end">已结束</div>'+
                                '</div>';
                        }else if(data[i].liveStart>timestamp&&(data[i].liveStart-timestamp)<10*60*1000){
                            isLiving='<div class="liveJoin">'+
                               /* '<p><span style="color: #5583db;font-size: 22px;">987</span><span>人浏览</span></p>'+*/
                                '<div class="jjzb"><a href="">即将直播</a> </div>'+
                                '</div>';
                        }
                        //alert(isLiving+'---'+timestamp+'***'+data[i].liveStart+'////结果：'+timestamp>data[i].liveStart && timestamp<data[i].liveEnd);
                        liveCourseDiv.innerHTML= '<div class="kjs live_content">'+
                            ' <div class="liveObj">'+
                            ' <div class="liveImg">'+
                            ' <img src="'+data[i].courseUrl+'" alt="" width="320" height="220px"/>'+
                            ' </div>'+
                            ' <div class="liveInfo">'+
                            ' <span class="liveInfo_title">'+data[i].liveTitle+
                            ' </span>'+
                            ' <p style="line-height:50px;">'+
                            ' <span>方向：</span>'+
                            '<span class="fx">'+data[i].categoryId+'</span>'+
                            ' <span style="margin-left:30px;">时间：</span>'+
                                /*'<span class="sj">'+data[i].liveStart+'</span>'+*/
                            '<span class="sj">'+new Date(data[i].liveStart).toTimeString().substr(0,5)+'-'+new Date(data[i].liveEnd).toTimeString().substr(0,5)+'</span>'+
                            '<span style="margin-left:30px;">老师：</span>'+
                            '<span class="sj">'+data[i].teacherName+'</span>'+
                            ' </p>'+
                            ' <p><span>简介：</span><br/>'+
                            '<span class="jj">'+summary+'</span></p>'+
                            '</div>'+isLiving+
                            '</div>';
                        $("#liveCourseList").append(liveCourseDiv);
                    }
                }else{
                    var noLiveHtml='<div class="kjs live_null">'+
                        '<div class="nullImg">'+
                    '<img src="../../../resources/live/images/live_null.png" alt=""/>'+
                    '<span>该项目在建设中......</span>'+
                    '</div>'+
                    '</div>';
                    $("#liveCourseList").append(liveCourseDiv);
                }

            }else{
                alert(result.message);
            }
        });

    }
    /*跳转正在直播*/
    function courseLiving(liveId){
        alert('跳转到直播页面'+liveId);
    }
})(jQuery)

function joinLive(id){
    //window.location.href = "/live/play/"+id;
    window.open("/live/play/"+id,"_blank");
}
function reviewLive(id){
    //window.location.href = "/live/play/"+id;
    window.open("/live/reviewLive/"+id,"_blank");
}

