/**
 * 答疑
 * @author zhenghui
 * @date 2016年7月15日
 */
(function ($) {


    $(document).ready(function () {
        bindEvents();
        setTimeout(function(){
            loadAnswers();
        },500);
    })

    //绑定各种事件
    function bindEvents() {

        //发表提问
        $('.one-an').click(function () {
            askQuestions();
        });

        $('.xsxiaoxi').click(function () {
            window.location.href='/plan/made';
        });

        //评分 grade-bt
        $('.pftj').click(function () {
            toScore();
        });

    }

    //发表提问
    function askQuestions(){
        var isVIP= $('#is-vip').val();
        var userId = $('#user-id').val();
        var courseId = $('#course-id').val();
        var lectureId = $('#lecture-id').val();
        var defaultContent = '有问必答，等你来问';
        var content = $('.onesrk textarea').val();
        if(content == defaultContent || !content){
            layer.open({
                offset: '50%',
                content: '您还没有写问题!',
                scrollbar: false
            });
            return;
        }

        var datas = {questions:content,courseId:courseId,lectureId:lectureId};

        //用户未登录
        if(!userId || userId == -1){
            Util.User.login(function(user){
                $('#user-id').val(user.id);
                saveQuestions(datas);
                window.location.reload();
            })
        }else{
            saveQuestions(datas);
        }
    }

    function saveQuestions(datas){
        $.post('/course/save/question', datas).done(function (result) {
            if (result.success) {
                $('#textareaLength').html(0);
                loadAnswers();
                $('.onesrk textarea').val('');//清空内容
            }else{
                //console.log(result.message);
            }
        })
    }

    //加载答疑内容
    function loadAnswers(){
        var isVIP= $('#is-vip').val();
        var userId = $('#user-id').val();
        var courseId = $('#course-id').val();

        //用户未登录
        if(!userId || userId == -1){
            //return;
        }
        var url = '/course/list/answer?courseId='+courseId;
        $.post(url).done(function (result) {
            if (result.success) {
                var nullVal='',htmlContent = nullVal,repyContent = nullVal;
                if(!result.data){
                }else{
                    //提问数
                    $('#answer-num').html('提问（<span>'+result.data.length+'</span>条）');
                    //QuestionDto
                    $.each(result.data, function(index, answer) {
                        //答复
                        repyContent = nullVal;
                        if(answer.replyList){
                            $.each(answer.replyList, function(index, reply){
                                /*if(reply.replyUserid == -1){*/
                                    var tearch =
                                        '<div class="xs-teacher">'+
                                        '<div class="teacher-waibu">'+
                                        '<div class="teacher-tx">'+
                                        '<img src='+reply.imgUrl+' />'+
                                        '</div>'+
                                        '<span>{{replyUserName}}</span>'+
                                        '</div>'+
                                        '<p class="time"><span>{{replyTime}}</span></p>' +
                                        '<p class="teacher">' +
                                        '{{replyContent}}<a></a>' +
                                        '</p>'+
                                        '</div>';
                                    tearch  = tearch.replace("{{replyUserName}}",reply.flowerName)
                                        .replace("{{replyContent}}", reply.replyContent).replace("{{replyTime}}", reply.replyTime);
                                    repyContent +=tearch;
                                /*}else{
                                    var student =
                                        '<div class="xs-student">'+
                                        '<div class="teacher-waibu">'+
                                        '<div class="student-tx">'+
                                        '<img src="/resources/login/images/d53f8794a4c27d1e1679045b1fd5ad6edcc438d5.jpg.gif" />'+
                                        '</div>'+
                                        '</div>'+
                                        '<p class="student">' +
                                        '<span>我回复：</span>' +
                                        '{{replyContent}}'+
                                        '<p class="time">' +
                                        '<span>{{replyTime}}</span>' +
                                            //'<span>12:50</span>' +
                                        '</p>'+
                                        '</p>'+
                                        '</div>';
                                    student  = student.replace("{{replyContent}}", reply.replyContent).replace("{{replyTime}}", reply.replyTime);
                                    repyContent +=student;
                                }*/
                            })
                            if(repyContent) repyContent ='<div class="xianshi">'+repyContent+'</div>'
                        }
                        var answerContent =
                            '<div class="twhd">'+
                                '<div class="twhd-tx">'+
                                    '<div class="picture">'+
                                        '<img src="{{imgurl}}">'+
                                    '</div>'+
                                    '<div class="picName">'+
                                        '<span class="NameBt">{{userName}}</span>'+
                            '<p class="teme">' +
                            '<span>{{questionTime}}</span>' +
                                //'<span>11:13</span>' +
                            '</p>'+
                                        '<div class="xuexi">'+
                                            '<p class="xuexiP">{{questions}}</p>'+
                                        '</div>'+
                                    '</div>'+
                                '</div>'+
                                repyContent+
                            '</div>';
                        var imgUrl = answer.imgurl;
                        if(!imgUrl) imgUrl = '/resources/common/images/photo.jpg';
                        answerContent = answerContent.replace("{{userName}}", answer.displayName).replace("{{imgurl}}", imgUrl)
                            .replace("{{questionTime}}", answer.questionTime).replace("{{questions}}", answer.questions);
                        htmlContent +=answerContent;
                    })
                }
                $('#answers-id').html(htmlContent);
                $.ajax({
                    type: "POST",
                    url:'/course/list/answer?courseId='+courseId,
                    success: function(result) {
                        if (result.success&&result.data) {
                            for(var p = 0;p<result.data.length;p++){
                                if(result.data[p].vipLevel==1){
                                    $(".twhd:eq("+p+") .picName").find(".NameBt").after( '<span class="restIcon" style="background-position: 0px -87px;"></span>')
                                }else if(result.data[p].vipLevel==2){
                                    $(".twhd:eq("+p+") .picName").find(".NameBt").after( '<span class="restIcon" style="background-position: 0px -107px;"></span>')
                                }else if(result.data[p].vipLevel==3){
                                    $(".twhd:eq("+p+") .picName").find(".NameBt").after( '<span class="restIcon" style="background-position: 0px -127px;"></span>')
                                }else{
                                    $(".twhd:eq("+p+") .picName").find(".NameBt").after( '<span class="restIcon" style="background-position: 0px 25px;"></span>')
                                }
                            }

                        }
                    }
                });
                $(".teacher a").click(function(){
                    $(".reply").css("display","block");
                });
            }else{
                //console.log(result.message);
            }
        })
    }

    //评分
    function toScore(){
        var lectureId = $('#lecture-id').val();
        var clarity = $('.jdt-right p span').html();
        var wittySpeech = $('.jdt-rightone p span').html();
        var isFluency = $('.fxk input[name="playradio"]:checked ').val();
        var suggest = $('.suggest-bottom textarea').val();
        var datas ={};

        if(!lectureId){
            $('#video-id li').each(function(index,vids){
                if(index == 0) lectureId = $(this).attr('value');
            })
        }

        var msgHtml;
        if(parseInt(clarity) == 0){
            $('#pfmsg').html('请对课程内容评分!');
            return;
        }
        if(parseInt(wittySpeech) == 0){
            $('#pfmsg').html('请对老师演讲风格进行评分!');
            return;
        }
        if(!isFluency){
            $('#pfmsg').html('请对视频流畅度进行评分!');
            return;
        }

        datas['gid'] = $.cookie('gid');
        if(clarity) datas['clarity'] = clarity;
        if(wittySpeech) datas['wittySpeech'] = wittySpeech;
        if(isFluency) datas['isFluency'] = isFluency;
        if(suggest) datas['suggest'] = suggest;
        if(lectureId) datas['lectureId'] = lectureId;

        $.post('/course/save/score', datas).done(function (result) {
            if (result.success) {
                $('#isScore').val('true');
                $('#pfcg').show();
                setTimeout("$('#pfcg').hide();",2000);
                // layer.msg('评论成功', {offset: '590px',scrollbar: false,icon: 1});
                $(".grade-bj").css("display","none");
            }else{
                //console.log(result.message);
            }
        })
    }

    //判断json的长度
    function getJsonLength(jsonData){

        var jsonLength = 0;

        for(var item in jsonData){

            jsonLength++;

        }

        return jsonLength;

    }


})(jQuery)