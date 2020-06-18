/**
 * 课程详情
 * @author zhenghui
 * @date 2016年7月5日
 */
(function ($) {


    $(document).ready(function () {
        bindEvents();
        loadeValuates();
        scrollToPage();
    })

    //绑定各种事件
    function bindEvents() {

        $('.shiting').click(function () {
            window.open('/course/play/'+$('#course-id').val());
        });

        $('.huiyuan').click(function () {
            window.open('/vip');
        });

        $('#members-1').click(function () {
            window.open('/vip');
            return false;
        });

        $('#members-2').click(function () {
            window.open('/course/play/'+$('#course-id').val());
        });

        //版本号
        //$('#version').html(Util.convertToChinese($('#version').html()));

        $('#catalog li').click(function () {
            var courseId = $('#course-id').val();
            var lectureId = $(this).attr('value');
            var type = $(this).attr('type');
            var isVIP = $(this).attr('isVIP');
            var url = '/course/play/'+courseId+'?lectureId='+lectureId;
            if(type == 1 || isVIP == 'true') window.location.href = url;
        });

    }

    //学员评价
    function loadeValuates(){
        var courseId = $('#course-id').val();
        pageNum = 1;flag= true;
        var datas ={courseId:courseId,page:pageNum};
        $.post('/course/list/evaluate',datas).done(function (result) {
            if (result.success){
                if(!result.data){
                    $('#teacher-commen').html(fillDatas(result.data));
                }else{
                    $('#commen').html(fillDatas(result.data));
                }
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
            if(Stop>=bottom){
                //////
                var nullVal='';
                //分页
                if(flag) pageNum++;
                var datas  = {page:pageNum,courseId:$('#course-id').val()};
                if(datas){
                    /*加载课程数据*/
                    $.post('/course/list/evaluate', datas).done(function (result) {
                        if (result.success) {
                            //异步加载课程信息
                            if(!result.data){
                                flag = false;
                            }else{
                                $('.commen').append(fillDatas(result.data));
                               /* $(".commen:last").css('opacity',0)
                                setTimeout(function(){
                                    $(".commen").css('opacity',1)
                                },500)*/
                            }
                        }
                    })
                }
            }
        })
    }

    //ajax填充数据
    function fillDatas(data){
        var nullVal='',htmlContent = nullVal;
        if(!data){
            htmlContent = '<div class="no_Spe" style="display: block;">' +
                '<div class="no_Img"><img src="/resources/course/images/norepeat.png"></div>'+
                '<p>暂无学员评论</p></div>';
        }else{
            $.each(data, function(index,evaluate) {
                //评分
                var kjsPf = nullVal;
                $.each(new Array(5),function (index) {
                    if(parseInt(evaluate.score)>4){
                        kjsPf +='<span class="liangxing"></span>';
                    }else{
                        if(index+1 <= parseInt(evaluate.score)){
                            kjsPf +='<span class="liangxing"></span>';
                        }else{
                            kjsPf +='<span class="anxing"></span>';
                        }
                    }
                })
                var templ =
                    ' <li>'+
                    '<div><div class="commenImg"><img src="{{imgurl}}"></div><span title="{{name}}">{{displayName}}</span></div>'+
                    '<ul>'+
                    '<li class="xing">'+
                    kjsPf+
                    '</li>'+
                    '<li class="lastLi">{{content}}</li>'+
                    '</ul>'+
                    '<span class="date">{{etime}}</span>'+
                    '</li>';

                var imgUrl = '/resources/common/images/photo.jpg';
                if(evaluate.imgurl){
                    imgUrl = evaluate.imgurl;
                }

                var finDisplayName=evaluate.displayName,name = finDisplayName;
                if(evaluate.displayName!=null && evaluate.displayName.length>4){
                    finDisplayName=evaluate.displayName.substr(0,3)+'...';
                }
                if(!finDisplayName){
                    finDisplayName = '游客';
                    name = finDisplayName;
                }

                templ  = templ.replace("{{imgurl}}", imgUrl).replace("{{displayName}}", finDisplayName)
                    .replace("{{content}}", evaluate.content).replace("{{etime}}", evaluate.etime).replace("{{name}}", name);
                htmlContent +=templ;
            });
        }
        return htmlContent;
    }

})(jQuery)