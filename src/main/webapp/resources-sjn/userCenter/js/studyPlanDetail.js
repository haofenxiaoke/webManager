/**
 * 课程
 * @author
 * @date 2016年10月12日
 */
function checkPlan(){
    $.post('/plan/check').done(function (result) {
        if(result.success){
            if(result.data){
                //var createHtml='<a class="crouseAdd" href="/plan/made?userCenter=1"><i class="restIcon"></i></a>';
                //$("#plans").append(createHtml);
                $('#courseAdd').css("display","block");
            }else{
                $('#courseAdd').css("display","none");
            }
        }
    })
}
function planTags(planData){
    $.ajax({
        url : '/userCenter/planTags',
        async : true, // 注意此处需要同步，因为返回完数据后，下面才能让结果的第一条selected
        type : "POST",
        timeout:3000,
        dataType : "json",
        data:planData,
        success : function(result) {
            if (result.success) {
                if (result.data) {
                    $("#planTags").html('');
                    var cityPays = '';
                    $.each(result.data, function (index, tag) {
                        cityPays += '<div class="crouseT-mon">' +
                            '<p>' + tag + '</p>' +
                            '</div>';
                    })
                    $("#planTags").append(cityPays);
                    studyPlanNum(planData);
                }
            }
        },
        complete : function(XMLHttpRequest,status){ //请求完成后最终执行参数
            if(status=='timeout'|| status=='error'){//超时,status还有success,error等值的情况
                loadCallBack('/userCenter/right/studyPlan');
            }
        }
    })
}
function studyPlanNum(planData){
    $.ajax({
        url : '/userCenter/studyPlanNum',
        async : true, // 注意此处需要同步，因为返回完数据后，下面才能让结果的第一条selected
        type : "POST",
        timeout:5000,
        dataType : "json",
        data:planData,
        success : function(result) {
            if (result.success) {
                if (result.data) {
                    var studyNum = '';
                    if($('.crouseT-study').html()!=undefined){
                        $('.crouseT-study').html('');
                        var numContent= '<p><i>当前学习人数：</i>'+result.data+'</p>';
                        $('.crouseT-study').html(numContent);
                        //$("#planTags").append('<div class="crouseT-study">'+
                        //    '<p><i>当前学习人数：</i>'+result.data+'</p>'+
                        //    '</div>');
                    }else{
                        studyNum += '<div class="crouseT-study">'+
                            '<p><i>当前学习人数：</i>'+result.data+'</p>'+
                            '</div>';
                        $("#planTags").append(studyNum);
                    }

                }
            }
            planAvgTime(planData);
        },
        complete : function(XMLHttpRequest,status){ //请求完成后最终执行参数
            if(status=='timeout'|| status=='error'){//超时,status还有success,error等值的情况
                loadCallBack('/userCenter/right/studyPlan');
            }
        }
    })
}
function planAvgTime(planData){
    $.ajax({
        url : '/userCenter/planAvgTime',
        async : true, // 注意此处需要同步，因为返回完数据后，下面才能让结果的第一条selected
        type : "POST",
        timeout:5000,
        dataType : "json",
        data:planData,
        success : function(result) {
            if (result.success) {
                if (result.data) {
                    var planAvgTime = '';
                    planAvgTime += '<p><i>每天平均学习时长:</i>'+result.data+'<span>小时</span></p>';
                    $(".crouseT-study").append(planAvgTime);
                }else{
                    var planAvgTime = '';
                    planAvgTime += '<p><i>每天平均学习时长:</i>'+0+'<span>小时</span></p>';
                    $(".crouseT-study").append(planAvgTime);
                }
            }
        },
        complete : function(XMLHttpRequest,status){ //请求完成后最终执行参数
            if(status=='timeout'|| status=='error'){//超时,status还有success,error等值的情况
                loadCallBack('/userCenter/right/studyPlan');
            }
        }
    })
}
function stagePlanFn(planData){
    $.post('/userCenter/stagePlan',planData).done(function (result) {
        if(result.success){
            if(result.data){
                $.each(result.data,function (index,course) {
                    var ideas=course.learningIdeas;
                    /*if(course.learningIdeas.length>17){
                        ideas=course.learningIdeas.substr(0,17)+'...';
                    }else{
                        ideas=course.learningIdeas;
                    }*/
                    var percent=1;
                    var lectureNum = course.lectureNum == 0?1:course.lectureNum;
                    var finishLectureNum = course.finishLectureNum;// == 0?1:course.finishLectureNum
                    //var finishLectureNum = course.lectureOrder == 0?1:course.lectureOrder;
                    if(course.lectureNum == 0 || course.finishLectureNum == 0 ){
                        percent = 1;
                    }else{
                        percent = (Math.round(parseInt(course.finishLectureNum) / parseInt(course.lectureNum) * 10000) / 100.00 );
                    }
                    var stage=document.createElement("div");
                    var  stageNum=parseInt(index)+1;
                    /*判断星星个数*/
                    var starHtml='';
                    for(var num=0;num<5;num++){
                        if(course.score-1>=num){
                            starHtml+= '<a class="liangxing"></a>';
                        }else{
                            starHtml+= '<a class="anxing"></a>';
                        }
                    }
                    var hrefUrl='';
                    if(course.lastCourseLecture==0){
                        hrefUrl='/course/play/'+course.id;
                    }else{
                        hrefUrl='/course/play/'+course.id+'?isUserPlay=true&lectureId='+course.lastCourseLecture;
                    }
                    var courseTitle=course.title;
                    if(courseTitle.length>10){
                        courseTitle=courseTitle.substring(0,10)+'...';
                    }
                    var stageHTML=
                        '<div class="crouseDZ-tit">第'+stageNum+'阶段</div>' +
                        '<div class="crouse-time clearfloat">'+
                        '<div class="kjsCrouse fl"  style="width: 232px;">'+
                        '<ul class="clearfloat">'+
                        ' <li style="margin: 0;">'+
                            // '<div class="kjsCimg"><a href="/course/play/'+course.id+'?isUserPlay=true&lectureId='+course.lastCourseLecture+'" target="_blank"><img src="'+course.coverUrl+'"> </a></div>'+
                        '<div class="kjsCimg"><a href="'+hrefUrl+'" target="_blank"><img src="'+course.coverUrl+'"> </a></div>'+
                        '<div class="kjsCTwo">'+
                        '<div class="clearfloat">'+
                        '<div class="kjsJd">'+
                        '<div style="width: '+100*finishLectureNum/lectureNum+'%;"></div>'+
                        '</div>'+
                        '<div class="kjsSmallj">学习了<span style="color: #ff6700;">'+finishLectureNum+'</span>/'+lectureNum+'课程小节 </div>'+
                        '</div>'+
                        '<div class="kjsStar">'+
                        '<div class="starNum">学员:'+course.courseStuNum+'人</div>'+
                        '<div class="kjsPf clearfloat">'+
                        starHtml+
                        '</div>'+
                        '</div>'+
                        '</div>'+
                        '</li>'+
                        '</ul>'+
                        '</div>'+
                        '<div class="fl crouseDz-con">'+
                        '<p>'+courseTitle+'</p>'+
                        '<div class="">'+
                        '<div class="crouseDay">时长: '+course.dayLength+'天</div>'+
                        '<div class="clearfloat">'+
                        '<div class="crouseDay-time">每天<br><span>'+course.dayHours+'</span>小时</div>'+
                        '<div class="crouseDay-time">听课<br><span>'+course.dayLecture+'</span>节</div>'+
                        '<div class="crouseDay-time">资料<br><span>'+course.dayNode+'</span>节</div>'+
                        '</div>'+
                        /*'<span class="crouse-sl">学习思路：'+ideas+'</span>'+*/
                        '<div id="content-'+stageNum+'" style="display: none;">'+course.learningIdeas+'</div>'+
                        '</div>';
                    // if(ideas.length>17){
                    //     var content=course.learningIdeas;
                        stageHTML+='<a class="crouseMore" onclick="scanMore('+stageNum+')">学习方法</a>';
                    // }
                    stageHTML+=  '</div>'+
                        ' <div class="fl crouseJD">'+
                        '<p>当前进度</p>'+
                        '<div id="courseProgress'+course.id+'" style="height: 150px;width: :150px"></div>'+
                        ' </div>'+
                        ' </div>'+
                        ' </div>';
                    stage.innerHTML=stageHTML;
                    $("#planDiv").append(stage);
                    var progress=userCourseProgress(course.id);
                    initStudyChart("courseProgress"+course.id,progress);
                })
            }
        }
    })
}
