$(function() {
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
    var userName=$("#userName").val();
    getQuestions(userName,1);

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
                $.ajax({
                    type : "post",
                    url : "/userCenter/questionList",
                    data:{pageNum:pageNum},
                    async : false,
                    success : function(result){
                        if(result.success){
                            if(result.data){
                                $.each(result.data, function(index, question) {
                                    var questionDate= question.questionTimeDesc;
                                    var questionHtml='';
                                    var imgUrl = $('.userLt-tx img').attr('src');
                                    questionHtml+='<dt class="fl"><img src="'+imgUrl+'" width="50" height="50"> </dt>'+
                                        '<dd class="fl">'+
                                        '<div class="spec-message">'+
                                        '<p>'+userName+'</p>'+
                                        '<span>来源：'+'<a href="/course/play/'+question.courseId+'?lectureId='+question.lectureId+'" target="_blank" style="color: #999;">'+question.title+'&nbsp;</a>' +questionDate+' </span>'+
                                        '<div>'+question.questions+'</div>'+
                                        '</div>';

                                    /*获取提问的老师回复*/
                                    $.ajax({
                                        type : "post",
                                        url : "/userCenter/replyList",
                                        //data : "test=" + test,
                                        data:{questionId:question.id},
                                        async : false,
                                        success : function(replyResult){
                                            if(replyResult.success){
                                                if(replyResult.data){
                                                    $.each(replyResult.data,function(index,questionReply){
                                                        var replyDate=questionReply.replyTimeDesc;
                                                        questionHtml+='<div class="spec-reply">'+
                                                            '<div class="clearfloat mb10">'+
                                                            '<div class="fl spec-hlleft">'+
                                                            '<img src="/resources/login/images/u=2917768045,692532680&fm=11&gp=0.jpg" width="30px" />'+
                                                            '<p>老师</p>'+
                                                            '</div>'+
                                                            '<div class="fl spec-hlR">'+
                                                            '<p>'+questionReply.replyContent+'</p>'+
                                                            '<span>'+replyDate+'</span>'+
                                                            '</div>'+
                                                            '</div>'+
                                                            '</div>';
                                                    })
                                                }else{
                                                }
                                            }else{

                                            }
                                        }
                                    });

                                    questionHtml+='</dd> </dt>';
                                    $("#questions").append(questionHtml);
                                })
                            }else{
                                flag=false;
                            }

                        }else{
                        }
                    }
                });
            }
            ///
        }
    })


})
function getQuestions(userName,pageNum){
    $.ajax({
        type : "post",
        url : "/userCenter/questionList",
        data:{pageNum:pageNum},
        async : false,
        success : function(result){
            if(result.success){
                if(result.data){//'<span>来源：'+'<a href="/course/play'+question.lectureId+'&nbsp;" target="_blank">'+question.title+'</a>' +questionDate+' </span>'+
                    $.each(result.data, function(index, question) {
                        var questionDate=question.questionTimeDesc;
                        var questionHtml='';
                        var imgUrl = $('.userLt-tx img').attr('src');
                        questionHtml+='<dt class="fl"><img src="'+imgUrl+'" width="50" height="50"> </dt>'+
                            '<dd class="fl">'+
                            '<div class="spec-message">'+
                            '<p>'+userName+'</p>'+
                            //'<span>来源：'+question.title +questionDate+' </span>'+
                            '<span>来源：'+'<a href="/course/play/'+question.courseId+'?lectureId='+question.lectureId+'" target="_blank" style="color: #999;">'+question.title+'&nbsp;</a>' +questionDate+' </span>'+
                            '<div>'+question.questions+'</div>'+
                            '</div>';

                        /*获取提问的老师回复*/
                        $.ajax({
                            type : "post",
                            url : "/userCenter/replyList",
                            //data : "test=" + test,
                            data:{questionId:question.id},
                            async : false,
                            success : function(replyResult){
                                if(replyResult.success){
                                    if(replyResult.data){
                                        $.each(replyResult.data,function(index,questionReply){
                                            var replyDate=questionReply.replyTimeDesc;
                                            questionHtml+='<div class="spec-reply">'+
                                                              '<div class="clearfloat mb10">'+
                                                                 '<div class="fl spec-hlleft">'+
                                                                     '<img src="/resources/login/images/u=2917768045,692532680&fm=11&gp=0.jpg"  width="30">'+
                                                                     '<p>老师</p>'+
                                                                 '</div>'+
                                                                 '<div class="fl spec-hlR">'+
                                                                        '<p>'+questionReply.replyContent+'</p>'+
                                                                        '<span>'+replyDate+'</span>'+
                                                                 '</div>'+
                                                              '</div>'+
                                                           '</div>';
                                        })
                                    }else{

                                    }
                                }else{

                                }
                            }
                        });

                        questionHtml+='</dd> </dt>';
                        $("#questions").append(questionHtml);
                    })
                }else{
                    var noQuestion='<div class="userR-twnone">'+
                        '<img src="/resources/userCenter/images/noPic.png" width="160">'+
                        '<p>您还没有提问任何问题</p>'+
                        '</div>';
                    $("#questionContent").append(noQuestion);
                }

            }else{
            }
        }
    });
}