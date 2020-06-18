/**
 * Created by admin on 2017/4/8.
 */
function timers(){
var date = new Date();
var y = date.getFullYear(); //获取完整的年份(4位,1970-????)
var m = date.getMonth()+1; //获取当前月份(0-11,0代表1月)
var d = date.getDate();
var hour = date.getHours();
var min= date.getMinutes();
var miao = date.getSeconds();
var dateyesterday = new Date();
dateyesterday.setDate(dateyesterday.getDate()-1);//昨天的日期
var ys = dateyesterday.getFullYear(); //获取完整的年份(4位,1970-????)
var ms = dateyesterday.getMonth()+1; //获取当前月份(0-11,0代表1月)
var ds = dateyesterday.getDate();
var datetomorrow = new Date();
datetomorrow.setDate(datetomorrow.getDate()+1);//明天的日期
var ysT = datetomorrow.getFullYear(); //获取完整的年份(4位,1970-????)
var msT = datetomorrow.getMonth()+1; //获取当前月份(0-11,0代表1月)
var dsT = datetomorrow.getDate();

//alert(dateweek)

for(var i=0;i<$("#love-course-list li").length;i++){

    var mo = parseInt($("#love-course-list li:eq("+i+") .mart").attr("moststart"),10);
    var moo =parseInt($("#love-course-list li:eq("+i+") .mart").attr("mostend"),10)
    var data1 = new Date(mo);
    var yss = data1.getFullYear(); //获取完整的年份(4位,1970-????)
    var mss = data1.getMonth()+1; //获取当前月份(0-11,0代表1月)
    var dss = data1.getDate();
    var hour1 = data1.getHours();
    var min1= data1.getMinutes();
    var miao1 = data1.getSeconds();
    if (hour1<10) { hour1="0" + hour1 }
    if (min1<10) { min1="0" + min1 }
    if (miao1<10) { miao1="0" + miao1 }
    var data2 = new Date(moo);
    var ysss = data2.getFullYear(); //获取完整的年份(4位,1970-????)
    var msss = data2.getMonth()+1; //获取当前月份(0-11,0代表1月)
    var dsss = data2.getDate();
    var hour2 = data2.getHours();
    var min2 = data2.getMinutes();
    var miao2 = data2.getSeconds();
    if (hour2<10) { hour2="0" + hour2 }
    if (min2<10) { min2="0" + min2 }
    if (miao2<10) { miao2="0" + miao2 }
    if(y!=yss){
        $("#love-course-list li:eq("+i+") .mart").html(yss+"年"+mss+"月"+dss+"日"+"  "+hour1+":"+min1+""+"-"+hour2+":"+min2)
        if(y>yss){
            var t='<a class="playback"><div class="playback-ico"></div><span class="ansewr">观看回放</span></a>'
            $(".addbf").eq(i).html(t)
        }else{
            var t = '<a class="appointment"><div class="appointment-ico"></div><span>预约直播</span><div class="prompt">课前<div>5分钟</div>会短信提醒你上课</div></a>'
            $(".addbf").eq(i).html(t)
        }
    }else if(y==yss){
        $("#love-course-list li:eq("+i+") .mart").html(mss+"月"+dss+"日"+"  "+hour1+":"+min1+""+"-"+hour2+":"+min2)
        if(m<mss){
            var t = '<a class="appointment"><div class="appointment-ico"></div><span>预约直播</span><div class="prompt">课前<div>5分钟</div>会短信提醒你上课</div></a>'
            $(".addbf").eq(i).html(t)
        }else if(m>mss){
            var t='<a class="playback"><div class="playback-ico"></div><span class="ansewr">观看回放</span></a>'
            $(".addbf").eq(i).html(t)
        }else if(m==mss){
            if(d<dss){
                var t = '<a class="appointment"><div class="appointment-ico"></div><span>预约直播</span><div class="prompt">课前<div>5分钟</div>会短信提醒你上课</div></a>'
                $(".addbf").eq(i).html(t)
            }else if(d>dss){
                var t='<a class="playback"><div class="playback-ico"></div><span class="ansewr">观看回放</span></a>'
                $(".addbf").eq(i).html(t)
            }else if(d==dss){
                $("#love-course-list li:eq("+i+") .mart").html("今天"+"  "+hour1+":"+min1+""+"-"+hour2+":"+min2)
                if((parseInt(hour)*60+parseInt(min))>=(parseInt(hour1)*60+parseInt(min1))&&(parseInt(hour)*60+parseInt(min))<=(parseInt(hour2)*60+parseInt(min2))) {
                    var t = '<div class="streaming"><div class="sku-play"><span class="sku-one"></span> <span class="sku-two"></span> <span class="sku-three"></span></div><span>正在直播</span></div>'
                    $(".addbf").eq(i).html(t)
                }else if((parseInt(hour)*60+parseInt(min))<(parseInt(hour1)*60+parseInt(min1))){
                    var t = '<a class="appointment"><div class="appointment-ico"></div><span>预约直播</span><div class="prompt">课前<div>5分钟</div>会短信提醒你上课</div></a>'
                    $(".addbf").eq(i).html(t)
                }else if((parseInt(hour)*60+parseInt(min))>(parseInt(hour2)*60+parseInt(min2))){
                    var t='<a class="playback"><div class="playback-ico"></div><span class="ansewr">观看回放</span></a>'
                    $(".addbf").eq(i).html(t)
                }
            }
        }

    }
    if(y==yss&&m==mss&&d==dss){
        $("#love-course-list li:eq("+i+") .mart").html("今天"+"  "+hour1+":"+min1+""+"-"+hour2+":"+min2)
        if((parseInt(hour)*60+parseInt(min))>=(parseInt(hour1)*60+parseInt(min1))&&(parseInt(hour)*60+parseInt(min))<=(parseInt(hour2)*60+parseInt(min2))) {
            var t = '<div class="streaming"><div class="sku-play"><span class="sku-one"></span> <span class="sku-two"></span> <span class="sku-three"></span></div><span class="now">正在直播</span></div>'
            $(".addbf").eq(i).html(t)
        }else if((parseInt(hour)*60+parseInt(min))<(parseInt(hour1)*60+parseInt(min1))){
            var t = '<a class="appointment"><div class="appointment-ico"></div><span>预约直播</span><div class="prompt">课前<div>5分钟</div>会短信提醒你上课</div></a>'
            $(".addbf").eq(i).html(t)
        }else if((parseInt(hour)*60+parseInt(min))>(parseInt(hour2)*60+parseInt(min2))){
            var t='<a class="playback"><div class="playback-ico"></div><span class="ansewr">观看回放</span></a>'
            $(".addbf").eq(i).html(t)
        }
    }else if(ys==yss&&ms==mss&&ds==dss){
        $("#love-course-list li:eq("+i+") .mart").html("昨天"+"  "+hour1+":"+min1+""+"-"+hour2+":"+min2)
        var t='<a class="playback"><div class="playback-ico"></div><span class="ansewr">观看回放</span></a>'
        $(".addbf").eq(i).html(t)
    }else if(ysT==yss&&msT==mss&&dsT==dss){
        $("#love-course-list li:eq("+i+") .mart").html("明天"+"  "+hour1+":"+min1+""+"-"+hour2+":"+min2)
        var t = '<a class="appointment"><div class="appointment-ico"></div><span>预约直播</span><div class="prompt">课前<div>5分钟</div>会短信提醒你上课</div></a>'
        $(".addbf").eq(i).html(t)
    }
}
}
//
//function joinLive(id){
//    //window.location.href = "/live/play/"+id;
//    window.open("/reviewLive/"+id,"_blank");
//}


