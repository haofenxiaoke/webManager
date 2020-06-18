var flag = false;
var tabsId = 'm-1';//默认tab选项卡ID
var pageNum = 1,scrollFlag = true;
$(function(){
    var userid=$("#userid").val();
    var stuId=$("#stuId").val();
    var isVIP=$("#is-vip").val();
    var datas={userid:stuId};
    var vipId=$("#vipid").val()+'';
    var level='userLt-name';
    if(vipId!=null && vipId!=''){
        if(vipId=='1'){
            level+="-month";
        }
        if(vipId=='2'){
            level+="-season";
        }
        if(vipId=='3'){
            level+="-year";
        }
        var vipLevel=$("#vipLevel");
        vipLevel.attr("class",level);
    }
 /*   /!*判断是否注册过会员，如果没有直接返回*!/
    var isVip=true;
    $.ajax({
        url:'/userCenter/hasRegistVip',
        async:true,
        timeout : 5000, //超时时间设置，单位毫秒
        type:"POST",
        dataType:"json",
        data:datas,
        success:function(result){
            if(result.data){
            }else{
                $(".userR-title a").on('click', function () {
                    $(".userR-title a").removeClass('userR-cur');
                    $(this).addClass('userR-cur');
                    var nowTabId = $(this).attr('id');
                    if(nowTabId != tabsId){
                        $(this).parent().next().find('.userR-zccount>div').fadeOut().hide().eq($(this).index()).fadeIn();
                        tabsId = nowTabId;
                        if($(this).index()==1){
                            $("#tableTitle").css("display","none");
                            $("#nodeTable").html('');
                            var noData='<div class="userR-twnone">'+
                                '<img src="/resources/userCenter/images/noPic.png" width="160">'+
                                '<p>您还没有学习资料<br>赶快去找想学习的<a href="/course">课程</a>吧</p>'+
                                '</div>';
                            $("#nodeTable").append(noData);
                        }
                        if($(this).index()==2){
                            $("#timeRanger").css("display","none");
                            $("#record").html('');
                            var noData='<div class="userR-twnone">'+
                                '<img src="/resources/userCenter/images/noPic.png" width="160">'+
                                '<p>您还没有成长记录<br>赶快去找想学习的<a href="/course">课程</a>吧</p>'+
                                '</div>';
                            $("#record").append(noData);
                        }
                    }

                });
                isVip=false;
                var  noRecord='<div class="userR-twnone">'+
                    '<img src="/resources/userCenter/images/noPic.png" width="160">'+
                    '<p>您还没有定制课程<br>赶快去找想学习的<a href="/plan/made">定制课程</a>吧</p>'+
                    '</div>';
                $("#tagsDiv").css("display","none");
                $("#hasPlan").html('');
                $("#hasPlan").append(noRecord);
                return false;
            }
        },
        complete : function(XMLHttpRequest,status){ //请求完成后最终执行参数
            if(status=='timeout'){//超时,status还有success,error等值的情况
                loadCallBack('/userCenter/right/studyPlan');
            }
        }
    })
    if(!isVip){
        return false;
    }*/
    var btnPlanId=$("#planid").val()+'';
    var url='';//获取列表的url判断是否根据计划id
    if(btnPlanId!=null && btnPlanId!=''){
        url='/userCenter/studyPlanList?planid='+btnPlanId;
    }else{
        url='/userCenter/studyPlanList';
    }
    var stagePlan=0;
    if(userid==''||userid==null){

    }else{
        var plans=0;
        $.ajax({
            url : url,
            async : false, // 注意此处需要同步，因为返回完数据后，下面才能让结果的第一条selected
            type : "POST",
            dataType : "json",
            data:datas,
            success : function(result) {
                if (result.success) {
                    if(result.data){
                        var planHtml='';
                        plans =result.data.length;
                        $.each(result.data,function (index,plan) {
                            if(btnPlanId!=null && btnPlanId!=''){
                                stagePlan=btnPlanId;
                                planData={planid:btnPlanId};
                            }else{
                                if(index==0){
                                    stagePlan=plan.id;
                                    planData={planid:plan.id};
                                }
                            }
                            planHtml+='<div class="crouse-a" >'+
                                '<a class="btn70" title='+plan.positionDesc+' value="'+plan.id+'" >'+plan.positionDesc+'</a><i class="restIcon" ></i>'+
                                '</div>';
                        })
                        planHtml+='<a class="crouseAdd" id="courseAdd" style="display: none" href="/plan/made?userCenter=1"><i class="restIcon"></i></a>';
                        $("#plans").append(planHtml);
                        checkPlan();
                        /*计划标签*/
                        planTags(planData);
                        /*计划学习人数*/
                        // studyPlanNum(planData);
                        /*计划每天平均学习时长*/
                        planAvgTime(planData);
                        /*计划阶段详情*/
                        stagePlanFn(planData);
                    }else {
                        $("#hasPlan").html('');
                        var noRecord='';
                        noRecord='<div class="userR-twnone">'+
                            '<img src="/resources/userCenter/images/noPic.png" width="160">'+
                            '<p>您还没有定制课程<br>赶快去找想学习的<a href="/plan/made">定制课程</a>吧</p>'+
                            '</div>';
                        $("#tagsDiv").css("display","none");
                        $("#hasPlan").append(noRecord);

                    }
                } else {
                    alert(result.message);
                }
            },
        });
    }

    var date=moment(new Date()).format('MM/DD/YYYY');
    //设置日期，当前日期的前七天
    var timestamp = new Date().getTime();
    var newDate = new Date(timestamp - 6 * 24 * 3600 * 1000);
    var start=moment(newDate).format('MM/DD/YYYY');
    $("#studyRangeDate").val(start+" - "+date);
    $(".userR-title a").on('click', function () {
        $(".userR-title a").removeClass('userR-cur');
        $(this).addClass('userR-cur');
        //if($(this).index()==2){!flag&&initChart()}
        var nowTabId = $(this).attr('id');
        if(nowTabId != tabsId){
            tabsId = nowTabId;
            $(this).parent().next().find('.userR-zccount>div').fadeOut().hide().eq($(this).index()).fadeIn();
            if($(this).index()==1){
                pageNum=1;
                scrollFlag=true;
                getPlanNodes(1,stagePlan);
                $(window).unbind().scroll(function(){
                    var Bheight=$(document).height();
                    var Stop=$(this).scrollTop();
                    var bottom = Bheight-document.body.clientHeight;
                    if(Stop>=bottom) {
                        //分页
                        if (scrollFlag) {
                            pageNum++;
                            scrollGetNodes(pageNum,stagePlan);
                        }
                    }
                })
            }
            if($(this).index()==2){
                !flag&&makeImg(start,date,stagePlan,userid);
            }
        }
    });
    // 路径配置
    require.config({
        paths: {
            echarts:'/resources/common/echarts-2.2.7/build/dist'
        }
    });

    /*日期控件的基本设置*/
    var optionSet = {
        format: 'MM/DD/YYYY',
        separator: ' - ',
        locale: {
            applyLabel: '确定',
            cancelLabel: '取消',
            fromLabel: '开始日期',
            toLabel: '结束日期',
            daysOfWeek: ['日', '一', '二', '三', '四', '五','六'],
            monthNames: ['1月', '2月', '3月', '4月', '5月', '6月', '7月', '8月', '9月', '10月', '11月', '12月']
        }
    };
    $('#studyRangeDate').daterangepicker(optionSet, function(start, end, label) {//时间变化后的结
        var startDate=moment(start).format('MM/DD/YYYY');
        var endDate=moment(end).format('MM/DD/YYYY');
        makeImg(startDate,endDate,stagePlan,userid);
    });
    /*计划按钮鼠标悬停*/
    btnhover();
});

/*滚动加载章节资料*/
function scrollGetNodes(pageNum,planId){
    $.post('/userCenter/planNodes',{pageNum:pageNum,planId:planId}).done(function (result) {
        if(result.success){
            if(result.data){
                $.each(result.data,function (index,lecture) {
                    var createDate= lecture.publishDateDesc;
                    var imgCss = getImgCss(lecture.lecturePptUrl);
                    var fileSize = 0;
                    if(lecture.fileLength){
                        if((parseInt(lecture.fileLength)/1024)>1024){
                            fileSize=(lecture.fileLength/1024/1024).toFixed(2);//toFixed(0) 不取小数位
                            fileSize+='M';
                        }else{
                            fileSize=(lecture.fileLength/1024).toFixed(2);//toFixed(0) 不取小数位
                            fileSize+='KB';
                        }
                    }
                    var nodesHtml = '<tr>'
                        + '<td height="40" class="pd20">'
                        + '<i class="'+imgCss+'"></i>'
                        + lecture.fileTitle
                        + '</td>'
                        + '<td class="textC">'
                        + fileSize
                        + '</td>'
                        + '<td class="textC">'
                        + createDate
                        + '</td>'
                        + '<td width="70" class="textC">'
                        //+ '<a class="btn70" href="/course/lecture/read/'+lecture.id+'" target="_blank">阅读</a></td></tr>';
                        + '<a href="/download?filePath='+lecture.lecturePptUrl+'" title="'+lecture.fileTitle+'">下载</td></tr>';
                    $("#lectureNodes").append(nodesHtml);
                })
            }else{
                scrollFlag=false;
            }
        }
    })
}

//根据文件类型选择样式
function getImgCss(fileName) {
    var imgType = fileName.substr(fileName.lastIndexOf("."));
    var imgCss = imgType.indexOf('.rar')?'onepice_one':'onepice';
    return imgCss;
}

/*根据计划Id获取计划课程的章节资料*/

function getPlanNodes(pageNum,planId){
    $.post('/userCenter/planNodes',{pageNum:pageNum,planId:planId}).done(function (result) {
        //$("#lectureNodes").html('');
        if(result.success){
            if(result.data){
                $("#lectureNodes").html('<tr class="studyBt" id="tableTitle">'+
                    '<td width="40%" class="pd20">文件名</td>'+
                    '<td class="textC" width="20%">文件大小</td>'+
                    '<td class="textC" width="20%">上传时间</td>'+
                    '<td class="textC" width="20%">操作</td>'+
                    '</tr>');
                $.each(result.data,function (index,lecture) {
                    var createDate= moment(lecture.publishDate).format('YYYY-MM-DD');
                    if(lecture.publishDate==null){
                        createDate=moment(new Date()).format('YYYY-MM-DD');
                    }
                    var imgCss = getImgCss(lecture.lecturePptUrl);
                    var fileSize = 0;
                    if(lecture.fileLength){
                        if((parseInt(lecture.fileLength)/1024)>1024){
                            fileSize=(lecture.fileLength/1024/1024).toFixed(2);//toFixed(0) 不取小数位
                            fileSize+='M';
                        }else{
                            fileSize=(lecture.fileLength/1024).toFixed(2);//toFixed(0) 不取小数位
                            fileSize+='KB';
                        }
                    }
                    var nodesHtml = '<tr>'
                        + '<td height="40" class="pd20">'
                        + '<i class="'+imgCss+'"></i>'
                        + lecture.fileTitle
                        + '</td>'
                        + '<td class="textC">'
                        + fileSize
                        + '</td>'
                        + '<td class="textC">'
                        + createDate
                        + '</td>'
                        + '<td width="70" class="textC">'
                        + '<a href="/download?filePath='+lecture.lecturePptUrl+'" title="'+lecture.fileTitle+'">下载</td></tr>';
                    $("#lectureNodes").append(nodesHtml);
                })
            }else{
                scrollFlag=false;
                $("#nodeTable").html('');
                var noData='<div class="userR-twnone">'+
                    '<img src="/resources/userCenter/images/noPic.png" width="160">'+
                    '<p>您还没有学习资料<br>赶快去找想学习的<a href="/course">课程</a>吧</p>'+
                    '</div>';
                $("#nodeTable").append(noData);
            }
        }
    })
}
/*制作折线图*/
function makeImg(start,end,planid,userid){
    flag = true;
    //var stamp=end.getTime();

    var dateStart=new Date(start);
    var dateEnd=new Date(end);
    var days = dateEnd.getTime() -dateStart.getTime();
    var dayLongth = parseInt(days / (1000 * 60 * 60 * 24));//距离今天的日期差
    var xLabels=new Array();/*X轴数据*/
    var xStart=start.substr(0,5);
    var xEnd=end.substr(0,5);
    for(var i=0;i<=dayLongth;i++){
        xLabels.push(moment(new Date(dateStart.getTime()+i*1000*60*60*24)).format('MM/DD/YYYY').substr(0,5));
    }

    //个人观看数据
    var personalData=[];
    //平均观看数据
    var avgData=[];
    var  personData={dateStart:start,dateEnd:end,planid:planid,userid:$("#stuId").val()};
    var avg={dateStart:start,dateEnd:end,planid:planid}

    //获取个人学习时长
    personalStudyTime(personData,personalData);

    /*   personalStudyTime(personData,personalData);*/
    avgStudyTime(avg,avgData);
    /*画图 填充数据*/
    initChart(xLabels,personalData,avgData);
}
/*获取计划平均学习时长*/
function avgStudyTime(data,avgData){
    //获取平均学习时长
    $.ajax({
        url : '/userCenter/avgData',
        async : false, // 注意此处需要同步，因为返回完数据后，下面才能让结果的第一条selected
        type : "POST",
        dataType : "json",
        data:data,
        success : function(result) {
            if(result.success){
                if(result.data){
                    $.each(result.data,function (index,daylength) {
                        avgData.push(daylength);
                    })
                }else{

                }
            }
        }
    });
}
/*获取个人学习时长*/
function personalStudyTime(personData,personalData){
    //获取个人学习时长
    $.ajax({
        url : '/userCenter/personalData',
        async : false, // 注意此处需要同步，因为返回完数据后，下面才能让结果的第一条selected
        type : "POST",
        dataType : "json",
        data:personData,
        success : function(result) {
            if(result.success){
                if(result.data){
                    $.each(result.data,function (index,daylength) {
                        personalData.push(daylength);
                    })
                }else{

                }
            }
        }
    });
}

/*获取用户课程的学习进度  参数 课程id*/
function userCourseProgress(courseId){
    var progress=0;
    /*获取该课程的学习进度*/
    $.ajax({
        async: false,
        type : "POST",
        url : '/userCenter/userCourseProgress',
        dataType : 'json',
        data:{courseId:courseId},
        success : function(result) {
            if(result.success){
                progress=result.data;
            }
        }
    });
    return progress;
}

/*计划的onhover事件  删除事件，切换事件*/
function btnhover(){
    $(".crouse-a").hover(function () {
        //$(this).find('i').css('display', 'inline-block');
        $(this).find('i').css('display', 'block');
        $(this).stop().animate({
            padding: '0px 30px 0px 10px'
        }, 500)
    }, function () {
        $(this).find('i').css('display', 'none');
        $(this).stop().animate({
            padding: '0px 10px 0px 10px'
        }, 500)
    });

    $('.crouse-a').find('a').unbind().click(function(){
        var planId = $(this).attr('value');
        $.get('/userCenter/right/studyPlan?planid=' + planId).done(function (html) {
            html = html.replace('var m', '//var m');
            $('#page-right').html(html);
        });

    })
    $('#sjn-qx-btn').click( function(){$('#delTip').css('display','none');});
    $('#delCloseBtn').click( function(){$('#delTip').css('display','none');});
    $('.crouse-a').find('i').click(function () {
        var planId = $(this).parent().find('a').attr('value');
        /*调用方法删除计划*/
       /* layer.confirm('您确定要删除该计划吗？', {
            btn: ['确定','取消'], //按钮
            offset:'150px'
        }, function(){
            $(this).parent().remove();
            $.post('/userCenter/cancelPlan',{planid:planId}).done(function (result) {
                if(result.success){
                    /!*alert('取消订单成功！');*!/
                    layer.msg('删除计划成功！', {icon: 1,time:3000});
                    window.location.reload();
                }else{
                    layer.msg("删除过程中遇到问题，该计划删除失败！",{time: 3000});
                }
            })
        }, function(){
            layer.msg('操作已取消', {
                time: 2000//20s后自动关闭
            });
        });*/
        $('#delTip').css('display','block');
        $('#sjn-qd-btn').click(function(){
            var data={planid:planId};
            $.post('/userCenter/cancelPlan',data).done(function (result) {
                if(result.success){
                    $('#delTip').css('display','none');
                    $('#delSuccess').css('display','block');
                    var tiaozhuan= setInterval('window.location.reload();',3000);
                    $(document).click(function(){
                        $("#delSuccess").css('display','none');
                        $(document).unbind();
                        window.location.reload();
                        clearInterval(tiaozhuan);
                    });
                   
                }else{
                    $('#delFalse').css('display','block');
                    setTimeout(" $('#delFalse').css('display','none');",3000);
                }
            })
        });


    })
}
/*确定删除计划按钮时间*/
function delPlanBtn(planId){
    $.post('/userCenter/cancelPlan',{planid:planId}).done(function (result) {
        if(result.success){
            //layer.msg('删除计划成功！', {icon: 1,time:3000});
            //window.location.reload();
            // top.location.href = "/userCenter";
            // url = '/userCenter';
            // parent.location.href = url;
            $('#page-right').load("/userCenter/right/studyPlan");

        }else{
            layer.msg("删除过程中遇到问题，该计划删除失败！",{time: 3000});
        }
    })
}
/*成长记录图*/
function initChart(xData,personalData,avgData){

    // 使用
    require(
        [
            'echarts',
            'echarts/chart/line', // 使用柱状图就加载bar模块，按需加载
            'echarts/chart/bar'
        ],
        function (ec) {
            // 基于准备好的dom，初始化echarts图表
            var myChart = ec.init(document.getElementById('main'));

            var option = {
                /* title : {
                 text: '成长记录',
                 subtext: ''
                 },*/
                tooltip : {
                    trigger: 'axis'
                },
                legend: {
                    data:['我的','平均学习时长']
                },
                toolbox: {
                    x:865,
                    show : true,
                    feature : {
                        /* mark : {show: true},
                         dataView : {show: true, readOnly: false},
                         magicType : {show: true, type: ['line', 'bar']},
                         restore : {show: true},*/
                        saveAsImage : {show: true}
                    }
                },
                calculable : true,
                xAxis : [
                    {
                        type : 'category',
                        boundaryGap : false,
                        data : xData
                    }
                ],
                yAxis : [
                    {
                        type : 'value',
                        axisLabel : {
                            formatter: '{value}分钟'
                        }
                    }
                ],
                series : [
                    {
                        name:'我的',
                        type:'line',
                        data:personalData
                        /* markPoint : {
                         data : [
                         {type : 'max', name: '最大值'},
                         {type : 'min', name: '最小值'}
                         ]
                         },
                         markLine : {
                         data : [
                         {type : 'average', name: '平均值'}
                         ]
                         }*/
                    },
                    {
                        name:'平均学习时长',
                        type:'line',
                        data:avgData
                        /* markPoint : {
                         data : [
                         {name : '周最低', value : -2, xAxis: 1, yAxis: -1.5}
                         ]
                         },
                         markLine : {
                         data : [
                         {type : 'average', name : '平均值'}
                         ]
                         }*/
                    }
                ]
            };
            // 为echarts对象加载数据
            myChart.setOption(option);
        }
    );
}

/*观看进度环形图*/
function initStudyChart(divId,progress){

    // 使用
    require(
        [
            'echarts',
            'echarts/chart/pie'
        ], function (ec) {
            // 基于准备好的dom，初始化echarts图表
            var myChart = ec.init(document.getElementById(divId));
            var labelTop = {
                normal : {
                    color:'#5583db',

                    label : {

                        color:'#333',
                        show : true,
                        position : 'center',
                        formatter : '{b}',
                        textStyle: {
                            marggin:'5px',
                            color:'#999',
                            baseline : 'bottom'
                        }
                    },
                    labelLine : {
                        show : false
                    }
                }
            };
            var labelFromatter = {
                normal : {
                    color:'#333',
                    label : {
                        formatter : function (params){
                            return 100 - params.value + '%'
                        },
                        labelBottom:'20px',
                        textStyle: {
                            labelTop:'20px',
                            color:'#333 ',
                            baseline : 'top'
                        }
                    }
                }
            }
            var labelBottom = {
                normal : {
                    color: '#ccc',
                    label : {
                        show : true,
                        position : 'center'
                    },
                    labelLine : {
                        show : false
                    }
                },
                emphasis: {
                    //color: 'rgb(255,111,12)'
                    color:'#ccc'
                }
            };
            var radius = [50, 65];
            var option = {
                /* legend: {
                 x : 'center',
                 y : 'center',
                 data:[
                 '视频'
                 ]
                 },*/
                series : [
                    {
                        type : 'pie',
                        center : ['50%', '50%'],
                        radius : radius,
                        x: '0%', // for funnel
                        itemStyle : labelFromatter,
                        data : [
                            {name:'other', value:100-progress, itemStyle : labelBottom},
                            {name:'视频', value:progress,itemStyle : labelTop}
                        ]
                    }
                ]
            };


            // 为echarts对象加载数据
            myChart.setOption(option);
        }
    );
}

/*查看更多*/
function scanMore(id){
    var ideas=JSON.parse($('#content-'+id).html());
    var learningIdea1=ideas.learningIdeas1;
    var learningIdea2=ideas.learningIdeas2;
    var learningIdea3=ideas.learningIdeas3;
    $('#learningIdea1').text('').append('<span></span>'+learningIdea1);
    $('#learningIdea2').text('').append('<span></span>'+learningIdea2);
    $('#learningIdea3').text('').append('<span></span>'+learningIdea3);
    $('.js-tc').show();
    $('.js-black').show();
    event.stopImmediatePropagation();//取消事件冒泡；
    /* $(document).click(function(){
     $(".js-tc").hide();
     $(".js-black").hide();
     });*/
}

$('.js-close').click(function(){
    $('.js-tc').hide();
    $('.js-black').hide();
})

