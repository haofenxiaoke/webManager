/**
 * Created by admin on 2017/4/26.
 * 李昆
 */
function ls() {
    var watchDate;
    var dataId;
    var test;
    var id;
    $(document).ready(function () {
        var datalist = new Date();
        var datalistNear = datalist.getFullYear(); //获取完整的年份(4位,1970-????)
        var datalistMonth = datalist.getMonth() + 1; //获取当前月份(0-11,0代表1月)
        monthDiff(
            new Date(2017, 1), // November 4th, 2008
            new Date(datalistNear, datalistMonth)  // March 12th, 2010
        );
    })

    function monthDiff(d1, d2) {
        var months;
        var neardata = d2.getFullYear() - d1.getFullYear();
        neardata += 2017;
        months = (d2.getFullYear() - d1.getFullYear()) * 12;
        months -= d1.getMonth() + 1;
        months += d2.getMonth();
        //console.log(months+1)
        months += 2;
        var yy='<div class="zw"></div>';
        for (var m = months-1; m >= 0; m--) {
            var t = m + 1;
            var r;

            if (t <= 12) {
                if (t < 10) {
                    r = "0" + t;
                } else {
                    r = t;
                }
                yy += '<a test=' + "2017-" + r + '>' + 2017 + '年' + t + '月' + '</a>'
            } else {
                if ((t - 12) < 10) {
                    r = "0" + (t - 12);
                } else {
                    r = t - 12;
                }
                yy += '<a test=' + neardata + "-" + r + '>' + neardata + '年' + (t - 12) + '月' + '</a>'
            }

        }
        $(".near-data ul").html(yy)
        if ($(".near-data ul a").length < 10) {
            //$(".near-data .unwind").text("展开")
            //$(".near-data .unwind").css("display","none")
        } else {
            $(".near-data .unwind").text("收起")
            $(".near-data .unwind").css("display","block")
        }


        $(".near-data .unwind").click(function () {
            if ($(this).text() == "展开") {
                $(this).text("收起");
                $(".near-data").css("height", "auto")
            } else {
                $(this).text("展开");
                $(".near-data").css("height", "40px")
            }
        })


        $(".near-data ul a").click(function () {
            $(this).css("color", "#5583db").siblings().css("color", "#666666");
            $(".near-data .dataAll").css("color", "#666666");
            test = $(this).attr("test");
            watchDate = {watchDate: test};
            dataList(watchDate,dataId);
        })
        $(".near-data .dataAll").click(function () {
            $(this).css("color", "#5583db");
            $(".near-data ul a").css("color", "#666666");
            watchDate =null;
            dataList(watchDate,dataId);
        })
    }

    dataList();
    function dataList(undata,unid) {
        var dataIdendData;
        if(undata==undefined&&unid!=undefined){
            dataIdendData =unid
        }else if(undata!=undefined&&unid==undefined){
            dataIdendData =undata
        }else if(undata==undefined&&unid==undefined){
            dataIdendData =null
        }else{
          dataIdendData ={watchDate:test,directionId: id}
        }
        $.ajax({
            type: "POST",
            url: '/live/history/list',
            data: dataIdendData,
            success: function (result) {
                if (result.success) {
                    if (result.data.historyList.length != 0) {
                        var all = "";
                        for (var z = 0; z < result.data.historyList.length; z++) {
                            var datastart = new Date(result.data.historyList[z].startTime);
                            var hourstart = datastart.getHours();
                            var minstart = datastart.getMinutes();
                            if (hourstart < 10) {
                                hourstart = "0" + hourstart
                            }
                            if (minstart < 10) {
                                minstart = "0" + minstart
                            }
                            var dataend = new Date(result.data.historyList[z].endTime);
                            var hourend = dataend.getHours();
                            var minend = dataend.getMinutes();
                            if (hourend < 10) {
                                hourend = "0" + hourend
                            }
                            if (minend < 10) {
                                minend = "0" + minend
                            }
                            var teacherName = result.data.historyList[z].flowerName;
                            var teacher=result.data.historyList[z].flowerName;
                            if(teacherName.length>4){
                                teacherName=teacherName.substr(0,4)+"...";
                            }
                            all += '<div class="kjs live_content content-m-top nearlu">' +
                                '<div class="liveObj">' +
                                '<p class="end-p">' +
                                '<span style="float: left;color: #666666;font-size: 14px;">' + result.data.historyList[z].respDates
                                + '</span>' +
                                '<span style="float: left;color: #666666;font-size: 14px;margin-left: 10px;">' + hourstart + ':' + minstart + '~' + hourend + ':' + minend
                                + '</span></p>' +
                                '<div class="teacher-all">' +
                                '<img src=' + result.data.historyList[z].teacherUrl + '>' +
                                '<span class="sj" title='+teacher+'>' + teacherName + '</span>' +
                                '</div>' +
                                '<div class="liveInfo">' +
                                '<span class="liveInfo_title">' +
                                result.data.historyList[z].liveTitle
                                + '</span>' +
                                '<span class="near"></span>' +

                                '<p style="line-height:50px;">' +
                                '<span class="fx">' + result.data.historyList[z].directionName + '</span>' +
                                '</p>' +
                                '</div>' +
                                '<div class="endMan">' + result.data.historyList[z].bookNumber + '人已约' + '</div>' +
                                '<div class="liveJoin">' +
                                '<div class="jjzb" onclick="reviewLive(' + result.data.historyList[z].id + ')"><div class="playback-ico"></div><span>观看回放</span></div>' +
                                '</div>' +
                                '</div>' +
                                '</div>';

                        }
                        $(".history").html(all)
                        for(var y = 0; y < result.data.historyList.length; y++){
                            if (result.data.historyList[y].liveType == 0) {
                                $(".nearlu:eq("+y+") .near").css("display", "inline-block ")
                            }else{
                                $(".nearlu:eq("+y+") .near").css("display", "none")
                            }
                            if(result.data.historyList[y].recordId){
                            }else{
                                var td ='<div class="end" style="font-size: 14px;cursor: text;" >已结束</div>'
                                $(".history .liveJoin").eq(y).html(td)
                            }
                        }
                    } else {
                        var none = '<div class="None">' +
                            '<img src="/resources/live/images/meioyukecheng.png"/>' +
                            '<p>暂无直播课程，试试其他选择吧！</p>' +
                            '</div>'
                        $(".history").html(none)
                    }
                }
            }
        });


    }

    var categoryDesc='<div class="zw"></div>';
    $.ajax({
        type: "POST",
        url: '/live/history/list',
        success: function (result) {
            if(result.data.directionList){
                var mu = result.data.directionList.length;
                if(mu>7){
                    mu=7;
                }
                for(var d=0;d<mu;d++){
                    categoryDesc+= '<a id='+result.data.directionList[d].id+'>'+result.data.directionList[d].categoryDesc+'</a>'
                }
                $(".near-direction ul").html(categoryDesc)
                if ($(".near-direction ul a").length < 10) {
                    //$(".near-direction .unwind").text("展开")
                    //$(".near-direction .unwind").css("display","none")
                } else {
                    $(".near-direction .unwind").css("display","block")
                    $(".near-direction .unwind").text("收起")
                }
                $(".near-direction .unwind").click(function () {
                    if ($(this).text() == "展开") {
                        $(this).text("收起");
                        $(".near-direction").css("height", "auto")
                    } else {
                        $(this).text("展开");
                        $(".near-direction").css("height", "40px")
                    }
                })

                $(".near-direction ul a").click(function () {
                    $(this).css("color", "#5583db").siblings().css("color", "#666666")
                    $(".near-direction .dataAll").css("color", "#666666")
                    id = $(this).attr("id");
                    dataId = {directionId: id};
                    dataList(watchDate,dataId);
                })
                $(".near-direction .dataAll").click(function () {
                    $(this).css("color", "#5583db")
                    $(".near-direction ul a").css("color", "#666666")
                    dataId = null;
                    dataList(watchDate,dataId);
                })
            }
        }
    })

}
$(".kjs-cut a").click(function(){
    var night = $(".kjs-cut a").index(this);
    $(".kjs-cut li").eq(night).addClass("pitchUp").siblings().removeClass("pitchUp")
    for(var i=0;i<$(".kjs-cut li").length;i++){
        if(i==night){ $(".kjs-cut li:eq("+i+") a").addClass("pitchUpA")}else{ $(".kjs-cut li:eq("+i+") a").removeClass("pitchUpA")}
    }
    $(".exchange").eq(night).css("display","block").siblings().css("display","none");
    if(night==1){
        ls();
    }
})