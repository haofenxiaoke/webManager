(function ($) {
    $(function(){
        $(window).scrollTop(0);//初始化滚动条置顶
        var vipId=$("#vipid").val()+'';
        var level='userLt-name';
        if(vipId!=null && vipId!=''){
            if(vipId=='1'){
                level+="-month"
            }
            if(vipId=='2'){
                level+="-season"
            }
            if(vipId=='3'){
                level+="-year"
            }
            var vipLevel=$("#vipLevel")
            vipLevel.attr("class",level);
        }
    var userid=$("#userid").val();
    var dayNames = new Array("星期日","星期一","星期二","星期三","星期四","星期五","星期六");
        $.post('/userCenter/playRecordList',{userid:userid,pageNum:1}).done(function (result) {
            if (result.success) {
                if(result.data){
                    var recordHtml='';
                    var today = new Date();
                    var year=today.getFullYear();
                    var month=today.getMonth()+1;
                    var day=today.getDate();
                    $.each(result.data,function (index,course) {
                        var lectureNum = course.lectureNum == 0?1:course.lectureNum;
                        var finishLectureNum = course.courseProgress;
                        var date=new Date(course.createTime);
                        var recordMonth=date.getMonth()+1;
                        var recordDate=date.getDate();
                        var days = today.getTime() - course.createTime;
                        var dayLongth = parseInt(days / (1000 * 60 * 60 * 24));//距离今天的日期差
                        if(day==recordDate && month==recordMonth){/*dayLongth==0*/
                            var todayLi=document.createElement("li");
                            todayLi.innerHTML='<div class="kjsCimg_"><a href="/course/play/'+course.courseId+'?isUserPlay=true&lectureId='+course.lectureId+'" target="_blank"><img src="'+course.imgUrl+'"> </a></div>'+
                                '<div class="kjsCTwo">'+
                                '<div class="clearfloat">'+
                                '<div class="kjsJd">'+
                                '<div style="width:'+100*finishLectureNum/lectureNum+'%;"></div>'+
                                '</div>'+
                                '<div class="kjsSmallj">学习了<span style="color: #ff6700;">'+finishLectureNum+'</span>/'+lectureNum+'课程小节 </div>'+
                            '</div>'+
                            '<div class="kjsStar">'+
                                '<div class="playLook"><i class="restIcon"></i>看到第'+course.lectureOrder+'讲<span>'+course.watchProgress+'%</span></div>'+
                            '</div>'+
                            '</div>';
                            $("#today").append(todayLi);
                        }else if(day-recordDate==1){/*dayLongth==1*/
                            var yesterdayLi=document.createElement("li");
                            yesterdayLi.innerHTML='<div class="kjsCimg_ "><a href="/course/play/'+course.courseId+'?isUserPlay=true&lectureId='+course.lectureId+'" target="_blank"><img src="'+course.imgUrl+'"> </a></div>'+
                                '<div class="kjsCTwo">'+
                                '<div class="clearfloat">'+
                                '<div class="kjsJd">'+
                                '<div style="width:'+100*finishLectureNum/lectureNum+'%;"></div>'+
                                '</div>'+
                                '<div class="kjsSmallj">学习了<span style="color: #ff6700;">'+finishLectureNum+'</span>/'+lectureNum+'课程小节 </div>'+
                                '</div>'+
                                '<div class="kjsStar">'+
                                '<div class="playLook"><i class="restIcon"></i>看到第'+course.lectureOrder+'讲<span>'+course.watchProgress+'%</span></div>'+
                                '</div>'+
                                '</div>';
                            $("#yesterday").append(yesterdayLi);
                        }else if(dayLongth<=7){
                            var inWeekLi=document.createElement("li");
                            inWeekLi.innerHTML='<div class="kjsCimg_"><a href="/course/play/'+course.courseId+'?isUserPlay=true&lectureId='+course.lectureId+'" target="_blank"><img src="'+course.imgUrl+'"> </a></div>'+
                                '<div class="kjsCTwo">'+
                                '<div class="clearfloat">'+
                                '<div class="kjsJd">'+
                                '<div style="width:'+100*finishLectureNum/lectureNum+'%;"></div>'+
                                '</div>'+
                                '<div class="kjsSmallj">学习了<span style="color: #ff6700;">'+finishLectureNum+'</span>/'+lectureNum+'课程小节 </div>'+
                                '</div>'+
                                '<div class="kjsStar">'+
                                '<div class="playLook"><i class="restIcon"></i>看到第'+course.lectureOrder+'讲<span>'+course.watchProgress+'%</span></div>'+
                                '</div>'+
                                '</div>';
                            $("#inWeek").append(inWeekLi);
                        }else{
                            var inMonthLi=document.createElement("li");
                            inMonthLi.innerHTML='<div class="kjsCimg_"><a href="/course/play/'+course.courseId+'?isUserPlay=true&lectureId='+course.lectureId+'" target="_blank"><img src="'+course.imgUrl+'"> </a></div>'+
                                '<div class="kjsCTwo">'+
                                '<div class="clearfloat">'+
                                '<div class="kjsJd">'+
                                '<div style="width:'+100*finishLectureNum/lectureNum+'%;"></div>'+
                                '</div>'+
                                '<div class="kjsSmallj">学习了<span style="color: #ff6700;">'+finishLectureNum+'</span>/'+lectureNum+'课程小节 </div>'+
                                '</div>'+
                                '<div class="kjsStar">'+
                                '<div class="playLook"><i class="restIcon"></i>看到第'+course.lectureOrder+'讲<span>'+course.watchProgress+'%</span></div>'+
                                '</div>'+
                                '</div>';
                            $("#inMonth").append(inMonthLi);
                        }

                    })
                }else{
                    $("#records").html('');
                    var noRecord='<div class="userR-twnone">'+
                    '<img src="/resources/userCenter/images/noPic.png" width="160">'+
                    '<p>您还没有观看视频<br>赶快去找想学习的<a href="/course">课程</a>吧</p>'+
                    '</div>';
                    $("#hasRecords").append(noRecord);
                }
            } else {

            }
        });


    //滚动翻页

    var pageNum = 1,flag = true;
    $(window).scroll(function(){
        var Bheight=$(document).height();
        var Stop=$(this).scrollTop();
        var bottom = Bheight-document.body.clientHeight;
        if(Stop>=bottom){
            //分页
            if(flag){
                pageNum++;
                /*加载课程记录数据*/
                $.post('/userCenter/playRecordList', {userid:userid,pageNum:pageNum}).done(function (result) {
                    if (result.success) {
                        if(result.data){
                            var recordHtml='';
                            var today = new Date();
                            var year=today.getFullYear();
                            var month=today.getMonth()+1;
                            var day=today.getDate();
                            $.each(result.data,function (index,course) {
                                var lectureNum = course.lectureNum == 0?1:course.lectureNum;
                                var finishLectureNum =course.courseProgress;
                                var date=new Date(course.createTime);
                                var recordMonth=date.getMonth()+1;
                                var recordDate=date.getDate();
                                var days = today.getTime() - course.createTime;
                                var dayLongth = parseInt(days / (1000 * 60 * 60 * 24));//距离今天的日期差
                                if(day==recordDate && month==recordMonth){/*dayLongth==0*/
                                    var todayLi=document.createElement("li");
                                    todayLi.innerHTML='<div class="kjsCimg_"><a href="/course/play/'+course.courseId+'?isUserPlay=true&lectureId='+course.lectureId+' " target="_blank"><img src="'+course.imgUrl+'"> </a></div>'+
                                        '<div class="kjsCTwo">'+
                                        '<div class="clearfloat">'+
                                        '<div class="kjsJd">'+
                                        '<div style="width:'+100*finishLectureNum/lectureNum+'%;"></div>'+
                                        '</div>'+
                                        '<div class="kjsSmallj">学习了<span style="color: #ff6700;">'+finishLectureNum+'</span>/'+lectureNum+'课程小节 </div>'+
                                        '</div>'+
                                        '<div class="kjsStar">'+
                                        '<div class="playLook"><i class="restIcon"></i>看到第'+course.lectureOrder+'讲<span>'+course.watchProgress+'%</span></div>'+
                                        '</div>'+
                                        '</div>';
                                    $("#today").append(todayLi);
                                }else if(day-recordDate==1){/*dayLongth==1*/
                                    var yesterdayLi=document.createElement("li");
                                    yesterdayLi.innerHTML='<div class="kjsCimg_"><a href="/course/play/'+course.courseId+'?isUserPlay=true&lectureId='+course.lectureId+'" target="_blank"><img src="'+course.imgUrl+'"> </a></div>'+
                                        '<div class="kjsCTwo">'+
                                        '<div class="clearfloat">'+
                                        '<div class="kjsJd">'+
                                        '<div style="width:'+100*finishLectureNum/lectureNum+'%;"></div>'+
                                        '</div>'+
                                        '<div class="kjsSmallj">学习了<span style="color: #ff6700;">'+finishLectureNum+'</span>/'+lectureNum+'课程小节 </div>'+
                                        '</div>'+
                                        '<div class="kjsStar">'+
                                        '<div class="playLook"><i class="restIcon"></i>看到第'+course.lectureOrder+'讲<span>'+course.watchProgress+'%</span></div>'+
                                        '</div>'+
                                        '</div>';
                                    $("#yesterday").append(yesterdayLi);
                                }else if(dayLongth<=7){
                                    var inWeekLi=document.createElement("li");
                                    inWeekLi.innerHTML='<div class="kjsCimg_"><a href="/course/play/'+course.courseId+'?isUserPlay=true&lectureId='+course.lectureId+'" target="_blank"><img src="'+course.imgUrl+'"> </a></div>'+
                                        '<div class="kjsCTwo">'+
                                        '<div class="clearfloat">'+
                                        '<div class="kjsJd">'+
                                        '<div style="width:'+100*finishLectureNum/lectureNum+'%;"></div>'+
                                        '</div>'+
                                        '<div class="kjsSmallj">学习了<span style="color: #ff6700;">'+finishLectureNum+'</span>/'+lectureNum+'课程小节 </div>'+
                                        '</div>'+
                                        '<div class="kjsStar">'+
                                        '<div class="playLook"><i class="restIcon"></i>看到第'+course.lectureOrder+'讲<span>'+course.watchProgress+'%</span></div>'+
                                        '</div>'+
                                        '</div>';
                                    $("#inWeek").append(inWeekLi);
                                }else{
                                    var inMonthLi=document.createElement("li");
                                    inMonthLi.innerHTML='<div class="kjsCimg_"><a href="/course/play/'+course.courseId+'?isUserPlay=true&lectureId='+course.lectureId+'" target="_blank"><img src="'+course.imgUrl+'"> </a></div>'+
                                        '<div class="kjsCTwo">'+
                                        '<div class="clearfloat">'+
                                        '<div class="kjsJd">'+
                                        '<div style="width:'+100*finishLectureNum/lectureNum+'%;"></div>'+
                                        '</div>'+
                                        '<div class="kjsSmallj">学习了<span style="color: #ff6700;">'+finishLectureNum+'</span>/'+lectureNum+'课程小节 </div>'+
                                        '</div>'+
                                        '<div class="kjsStar">'+
                                        '<div class="playLook"><i class="restIcon"></i>看到第'+course.lectureOrder+'讲<span>'+course.watchProgress+'%</span></div>'+
                                        '</div>'+
                                        '</div>';
                                    $("#inMonth").append(inMonthLi);
                                }

                            })
                        }else{
                           flag=false;
                        }
                    } else {
                    }
                })
            }
            ///
        }
    })


});
    //绑定各种事件
    function bindEvents() {
        //样式
        $(".kjsPx a").eq(0).css('color','#5583db');
        $(".kjsPx a").click(function(){
            $(".kjsPx a").css('color','#666');
            $(this).css('color','#5583db')
        })

        //点击筛选条件触发
        $('.kjsCrnum1 a').click(function () {
            $(this).css("color", "#5583db").siblings().css("color", "");
        });
        //点击排序触发
        $('.kjsPx a').click(function () {
            $(this).css("color", "#5583db").siblings().css("color", "");
        });

        //更多
        $('.kjsmore').click(function () {
            fillMore($(this).attr('dataType'));
            $(this).css("color", "#5583db");
            $('.loding-a').css('padding-bottom','10px')
        });
    }

})(jQuery)