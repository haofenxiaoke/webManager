/**
 * 课程
 * @author zhenghui
 * @date 2016年7月5日
 */
(function ($,window) {
    $(document).ready(function () {
        bindEvents();
        bindEvents2();
        scrollToPage();
        var clickStatus2 = $("#i-more").css("display");
        var clickStatus3 = $("#p-more").css("display");

        if(clickStatus2=="block"||clickStatus2=="inline-block"){
            $("#i-more").click();
        }
        if(clickStatus3=="block"||clickStatus3=="inline-block"){
            $("#p-more").click();
        }


    });


    //绑定各种事件
    function bindEvents() {

        //样式 点击排序触发
        $(".kjsPx a").eq(0).css('color','#5583db');
        $(".kjsPx a").eq(0).attr('select', 'true');

        $('.kjsPx a').unbind().click(function () {
            $(this).attr('select', 'true').siblings().attr('select', 'false');
            $(this).css("color", "#5583db").siblings().css("color", "");
            getCourses();
        });


        //vip用户跳转定制计划验证
        $('.nav-right a').unbind().click(function () {
            vipCheckPlanNum();
        });

        //是否显示更多
        //showMore();

        //更多
        $('.kjsmore').click(function () {
            if($(this).attr('more')=='true'){
                fillMore($(this).attr('dataType'));
                $(this).css("color", "#5583db");
                $(this).attr('more', 'false');

            }else{
                var dataType = $(this).attr('dataType');

                if(dataType == 2){
                    $('#industry-more').slideUp()
                $("#i-more").text("展开")
                    //$('#industry-more').html('');
                }
                if(dataType == 3){ //$('#position-more').html('');
                    $('#position-more').slideUp()
                $("#p-more").text("展开")
                }
                $(this).css("color", "#5583db");
                //$('.loding-a').css('padding-bottom','0px');
                $(this).attr('more', 'true');
                //不是更多行是否有选中 选中不加载课程
                var flag = false;
                $(this).parent().find("div a").each(function(){
                    if($(this).attr('select')=='true'){
                        flag = true;
                    }
                })

                if(!flag){
                    $(this).parent().find("a").css('color','');
                    $(this).parent().find("a").attr('select', 'false');
                    $(this).parent().find("a").eq(0).css('color','#5583db');
                    $(this).parent().find("a").eq(0).attr('select', 'true');
                    getCourses();
                }

            }
        });


    }

    //点击筛选条件触发
    function bindEvents2() {
        $('#direction a').unbind().click(function () {

            var _direction = $('#direction'),_industry=$('#industry'),_position=$('#position');

            _direction.find("a").css("color", "");
            $(this).css("color", "#5583db").siblings().css("color", "");
            _industry.find("a").eq(0).css("color", "#5583db");
            _position.find("a").eq(0).css("color", "#5583db");
            _direction.find("a").attr('select', 'false');
            _industry.find("a").attr('select', 'false');
            _position.find("a").attr('select', 'false');

            $(this).attr('select', 'true');
            _industry.find("a").eq(0).attr('select', 'true');
            _position.find("a").eq(0).attr('select', 'true');

            var iMore = $('#i-more'),pMore = $('#p-more');
            iMore.attr('more', 'true');
            iMore.css("color", "");
            pMore.attr('more', 'true');
            pMore.css("color", "");

            getCourses();

            fillCategory();

        });

        bindClick4A('#position');
        bindClick4A('#industry');
    }
    function bindClick4A(select){
        $(select +' a').unbind().click(function () {
            $(select).find("a").css("color", "")

            $(select +' a').css("color", "");
            if(select.indexOf('more') != -1){
                $(select.substr(0,select.indexOf('-'))+' a').css("color", "");
            }
            $(this).css('color', '#5583db');

            $(select).find("a").attr('select', 'false');
            $(this).attr('select', 'true');
            getCourses();
        });
    }
    /*参数条件*/
    function getDatas(){
       
        var nullVal='',dataType=nullVal,dataValue=nullVal,datas={};
      
                    datas['directionId']=window.location.search.substring(1).split('&')[0].split('=')[1];
                    datas['industryDesc']="新版";
                    datas['positionId']=window.location.search.substring(1).split('&')[1].split('=')[1];
                    datas['sortName']="create_Date";

        //排序类型 sortType
       
              
      
        return datas;
    }

    /*条件过滤课程*/
    function getCourses() {
        var nullVal='',datas  = getDatas();
        //清空数据
        pageNum = 1;flag= true;
        //分页
        datas['page'] = pageNum;
        if(datas){
            layer.load(2);//加载中样式
            /*加载课程数据*/
            $.post('/course/list', datas).done(function (result) {
                setTimeout(function(){
                    layer.closeAll('loading');
                }, 100);//加载成功后关闭
                if (result.success) {
                    //异步加载课程信息
                    var htmlContent = nullVal;
                    $('.kjsCrouse').html(nullVal);
                    if(!result.data){
                        htmlContent =
                            '<div class="clearfloat" style="background: #fff;">'+
                            '<div style="text-align: center;width: 1224px;padding:100px 0;font-size: 14px;color:#666;">'+
                            '<div><img src="/resources/course/images/zanwu_03.png" style="margin-bottom:30px;"></div>'+
                            '课程正在准备中，敬请期待~' +
                            '</div></div>';
                        $('#main').html(htmlContent);
                    }else{
                        $.each(result.data, function(index, course) {
                            var vipStr = nullVal,percent=1,isVIP = $('#is-vip').val(),isTicketValid = $("#is-ticket").val();
                            if(isVIP == 'false' && course.validStatus == false){
                                vipStr =
                                    '<p class="fl kjsSttext">会员免费</p>'+
                                    '<div class="HoverRight">'+
                                    '<a href="/course/play/'+course.id+'" style="display:inline-block; " target="_blank">试听' +
                                    '<p class="kjs_index_txt_sj"><span class="dbX">试听</span></p>'+
                                    '<div class="qieh"></div>'+
                                    '</a>' +
                                    '</div>';
                            }else{
                                var lectureNum = course.lectureNum == 0?1:course.lectureNum;
                                var finishLectureNum = course.finishLectureNum == 0?1:course.finishLectureNum;
                                if(course.lectureNum == 0 || course.finishLectureNum == 0 ) percent = 1;
                                else percent = (Math.round(parseInt(course.finishLectureNum) / parseInt(course.lectureNum) * 10000) / 100.00 );
                                vipStr =
                                    '<div class="kjsJd">' +
                                    '<div style="width: '+parseInt(percent)+'%;"></div>' +
                                    '</div>'+
                                    '<div class="kjsSmallj">学习了<span style="color: #ff6700;">{{finishLectureNum}}</span>/{{lectureNum}}课程小节</div>';
                            }

                            //评分
                            var kjsPf = nullVal;
                            $.each(new Array(5),function (index) {
                                if(parseInt(course.score)>4){
                                    kjsPf +='<a class="restIcon kjsXxcur"></a>';
                                }else{
                                    if(index+1 <= parseInt(course.score)){
                                        kjsPf +='<a class="restIcon kjsXxcur"></a>';
                                    }else{
                                        kjsPf +='<a class="restIcon"></a>';
                                    }
                                }
                            })

                            var templ = ''+
                                '<li>' +
                                '<div class="kjsCimg">' +
                                '<a href="/course/detail/{{id}}" target="_blank"><img src="{{coverUrl}}"> </a>' +
                                '</div>'+
                                '<div class="kjsCTwo">' +
                                '<div class="clearfloat">' +vipStr+ '</div>'+
                                '<div class="kjsStar">' +
                                '<div class="starNum">学员:{{courseStuNum}}人</div>'+
                                '<div class="kjsPf clearfloat">' +
                                kjsPf+
                                '</div>' +
                                '</div>' +
                                '</div>' +
                                '</li>';
                            templ  = templ.replace("{{coverUrl}}", course.coverUrl)
                                .replace("{{id}}", course.id).replace("{{finishLectureNum}}", course.finishLectureNum)
                                .replace("{{lectureNum}}", course.lectureNum).replace("{{courseStuNum}}", course.courseStuNum);

                            if((index+1)% 5 == 4) htmlContent +=templ;
                            if((index+1)% 5 == 3) htmlContent += templ;
                            if((index+1)% 5 == 2) htmlContent += templ;
                            if((index+1)% 5 == 1) htmlContent += templ;
                            if((index+1)% 5 == 0 || index == 4) htmlContent += templ;
                        })
                        htmlContent = '<ul class="clearfloat">'+htmlContent+'</ul>';
                        $('.kjsCrouse .clearfloat').remove();
                        // console.log(htmlContent);
                        $('#main').html(htmlContent);
                    }
                } else {
                }
            })
        }
    }

    /*
     *根据方向查询课程分类
     */
    function fillCategory(){
        var url  ='/course/list/category';
        var nullVal='',directionId=nullVal,datas  = getDatas();
        var industryContent=nullVal,positionContent=nullVal;

        //清空更多信息 undefined
        $('#position-more').html(nullVal);
        $('#industry-more').html(nullVal);

        /*$('.loding-a').css('padding-bottom','0px');*/

        if(datas['directionId']){
            url = url+"?directionId="+datas['directionId'];
        }

        layer.load(2);//加载中样式
        $.get(url).done(function (result) {
            setTimeout(function(){
                layer.closeAll('loading');
            }, 500);//加载成功后关闭
            if (result.success) {

                if(result.data.industryMore == true) $('#industry .fr').show();
                else $('#industry .fr').hide();
                if(result.data.positionMore == true) $('#position .fr').show();
                else $('#position .fr').hide();

                //行业
                $.each(result.data.industrys, function(index, industry) {
                    industryContent += '<a dataType="2" dataValue="'+industry.categoryDesc+'" select=false>'+industry.categoryDesc+'<p class="wx-bb">'+industry.categoryDesc+'</p></a>';
                })
                //职位
                $.each(result.data.positions, function(index, position) {
                    positionContent += '<a dataType="3" dataValue="'+position.id+'" select=false>'+position.categoryDesc+'<p class="wx-bb">'+position.categoryDesc+'</p></a>';
                })
                var htmlContent = '';
                $('#industry-content').html(industryContent);
                $('#position-content').html(positionContent);
                var clickStatus = $("#i-more").css("display");
                var clickStatus1 = $("#p-more").css("display");
               /* alert(clickStatus)*/
                var clickFlag = $("#i-more").attr("flag");
                if(clickStatus=="block"||clickStatus=="inline-block"){
                    $("#i-more").click();
                    }else{
                    $("#industry-more").css("padding-bottom","0px")
                }
                if(clickStatus1=="block"||clickStatus1=="inline-block"){
                    $("#p-more").click();
                }else{
                    $("#position-more").css("padding-bottom","0px")
                }
                //异步加载后 添加事件
                bindEvents2();
            }else {

            }
        });
    }

    //更多
    function fillMore(dataType){

        var url  ='/course/list/more?dataType='+dataType;
        var nullVal='',directionId=nullVal,datas  = getDatas();
        if(datas['directionId']){
            url = url+"&directionId="+datas['directionId'];
        }
        $.get(url).done(function (result) {
            if (result.success) {
                var htmlContent = '';

                if(!result.data){

                    layer.msg('没有更多内容了!', {time: 3000,icon: 6});
                    return;
                }
                $.each(result.data, function(index, more) {
                    if(dataType == 2){
                        $('#industry .loding-a').css('padding-bottom','10px');
                        htmlContent += '<a dataType="2" dataValue="'+more.categoryDesc+'" select=false>'+more.categoryDesc+'</a>';
                        $("#i-more").text("收起")
                        $('#industry-more').slideDown()

                    }
                    if(dataType == 3){
                        $('#position .loding-a').css('padding-bottom','10px');
                        htmlContent += '<a dataType="3" dataValue="'+more.id+'" select=false>'+more.categoryDesc+'</a>';
                        $("#p-more").text("收起")
                        $('#position-more').slideDown()

                    }
                })
                if(dataType == 2){ $('#industry-more').html(htmlContent);
                for(rr=0;rr< $("#industry-more a").length;rr++){
                    var ttt= $("#industry-more a").eq(rr).text().length;//原始字符串

                    var sem = $("#industry-more a").eq(rr).text();//要展示的字符串

                    var mo = '<p class="wx-bb">'+sem+'</p>'
                    if(ttt>6){
                        se=sem.substr(0,5)+"...";
                        $("#industry-more a").eq(rr).text(se)
                    }
                    $("#industry-more a").eq(rr).append(mo)

                    $("#industry-more a:eq("+rr+") .wx-bb").css("width",ttt*12+"px")
                     }

                    bindClick4A('#industry-more');
                }

                if(dataType == 3) {
                    $('#position-more').html(htmlContent);
                    for (mu = 0; mu < $("#position-more a").length; mu++) {
                        var str = $("#position-more a").eq(mu).text().length;//原始字符串

                        var st = $("#position-more a").eq(mu).text();//要展示的字符串

                        var mtt = '<p class="wx-bb">' + st + '</p>'
                        if (str > 6) {
                            s = st.substr(0, 5) + "...";
                            $("#position-more a").eq(mu).text(s)
                        }
                        $("#position-more a").eq(mu).append(mtt)
                        $("#position-more a:eq("+mu+") .wx-bb").css("width",str*12+"px")
                    }

                    bindClick4A('#position-more');
                    //异步加载后 添加事件
                    bindEvents2();
                }
            }else {

            }
        });
    }

    //vip用户跳转定制计划验证
    function vipCheckPlanNum(){
        var url = '/plan/made';
        var isVIP= $('#is-vip').val();
        $.post('/plan/check').done(function (result) {
            if (result.success) {
                if(result.data) window.location.href= url;
                else layer.alert("计划数已达上限!",{
                    offset:'150px'
                });
            }
        })
    }

    //滚动翻页
    var pageNum = 1,flag = true;
    function scrollToPage(){
        $(window).scroll(function(){
        	
            var Bheight=$(document).height();
            var Stop=$(this).scrollTop();
            var bottom = Bheight-document.body.clientHeight;
//            console.log(Stop,bottom)
            if(Stop + 2 > bottom){
                //////
            	console.log(1)  
                var nullVal='',datas  = getDatas();
                //分页
                if(flag) pageNum++;
                datas['page'] = pageNum;
                if(datas){
                	
                    //layer.load(2);//加载中样式
                    /*加载课程数据*/
                    $.post('/course/list', datas).done(function (result) {
                        /* setTimeout(function(){
                         layer.closeAll('loading');
                         }, 100);//加载成功后关闭*/
                    	
                        if (result.success) {
                            //异步加载课程信息
                        	console.log(result.data)
                            var htmlContent = nullVal;
                            
                            if(!result.data){
                                flag = false;
                            }else{
                                $.each(result.data, function(index, course) {
                                    var vipStr = nullVal,percent=1,isVIP = $('#is-vip').val(),isTicketValid = $("#is-ticket").val();
                                   
                                        vipStr +=
                                        	'<li>'+
                                            '<div class="kjsCimg" style="width: 270px; height:173px; position: relative;">'+
                                            '<a href="/course/play/'+ course.id +' " target="_blank" style="width: 270px; height:173px;">'+
                                            '<div class="mengban"></div>'+
                                            '<img src="{{coverUrl}}" >'+
                                            '</a>' +
                                            '</div>'+
                                            '</li>';
                                        vipStr  = vipStr.replace("{{coverUrl}}", course.coverUrl)
//                                        .replace("{{id}}", course.id).replace("{{finishLectureNum}}", course.finishLectureNum)
//                                        .replace("{{lectureNum}}", course.lectureNum).replace("{{courseStuNum}}", course.courseStuNum);

//                                    if((index+1)% 5 == 4) htmlContent +=vipStr;
//                                    if((index+1)% 5 == 3) htmlContent += vipStr;
//                                    if((index+1)% 5 == 2) htmlContent += vipStr;
//                                    if((index+1)% 5 == 1) htmlContent += vipStr;
//                                    if((index+1)% 5 == 0 || index == 4) htmlContent += vipStr;
                                      htmlContent += vipStr
//                                      console.log(vipStr)
                                })
                                
                                $('#c_list').append(htmlContent);
//                                console.log(htmlContent)
                                /*$('.kjsCrouse').last().hide();*/
//                                $(".kjsCrouse:last").css('opacity',0)
//                                setTimeout(function(){
//                                    $(".kjsCrouse").css('opacity',1)
//                                },500)
                            }
                        } else {

                        }
                    })
                }
                ///
            }
        })
    }


})(jQuery,this)
