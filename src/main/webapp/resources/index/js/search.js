/**
 * 搜索页脚本
 * @author 李恒名
 * @date 2016年7月13日 14:49:17
 */
(function ($) {
    var page = 2;//初始页码

    $(document).ready(function () {
        old();
        bindEvents();
    });

    //绑定各种事件
    function bindEvents() {

        //监控滚动条异步加载数据
        $(window).bind("scroll",function() {
            ($(window).scrollTop() >= ($(document).height() - document.body.clientHeight)) && loadData(page++);
        });

        //搜索按钮点击事件
        $('#search-btn-div').click(function () {
            var word = $.trim($('#search-word-div').val());
            if (word)
                location.href = '/search?word=' + word;
            else
                layer.alert('请输入搜索内容!',{
                    title:'温馨提示'
                });
        });

        $('#search-word-div').focus(function () {
            Util.onEnter(function () {
                $('#search-btn-div').click();
            });
        });

        $('#made-plan').click(function () {
            vipCheckPlanNum();
        });
    }

    function loadData(page) {
        layer.load(2);//加载中样式
        var html = '';
        $.post('/search/async', {word:word, page: page}).done(function (result) {
            setTimeout(function(){
                layer.closeAll('loading');
            }, 100);//加载成功后关闭
            if (result.success){
                var html = '';
                var list = result.data.list;
                if (list.length > 0){
                    $.each(list, function (index, course) {
                        html += '<li style="display: none">';
                            html += '<div class="kjsCimg"><a href="/course/detail/'+course.id+'"><img src="' + course.coverUrl + '"></a></div>';
                            html += '<div class="kjsCTwo">';
                                html += ' <div class="clearfloat">';
                                    if(isVIP){
                                        html += '<div class="HoverRight">';
                                        html += '<a href="${basePath}/course/play/'+course.id+'" style="display:inline-block; ">';
                                        html += '<p class="kjs_index_txt_sj">';
                                        html += '<span class="dbX">听课</span></p>';
                                        html += '<div class="qieh"></div>';
                                        html += '</a>';
                                        html += '</div>';
                                    }else{
                                        html += '<p class="fl kjsSttext">会员免费</p>';
                                        html += '<div class="HoverRight">';
                                        html += '<a href="${basePath}/course/play/'+course.id+'" style="display:inline-block; ">';
                                        html += '<p class="kjs_index_txt_sj">';
                                        html += '<span class="dbX">试听</span></p>';
                                        html += '<div class="qieh"></div>';
                                        html += '</a>';
                                        html += '</div>';
                                    }

                               html += '</div>';
                               html += '<div class="kjsStar">';
                                    html += '<div class="starNum">学员:' + course.courseStuNum + '人</div>';
                                    html += '<div class="kjsPf clearfloat">';
                                        for (var i = course.score; i > 0; i--) {
                                            html += '<a class="restIcon kjsXxcur"></a>';
                                        }
                                        if (course.score < 5) {
                                            for (var i = 5 - course.score; i > 0; i--) {
                                                html += '<a class="restIcon"></a>';
                                            }
                                        }
                                    html += '</div>';
                                html += '</div>';
                            html += '</div>';
                        html += '</li>';
                    });
                    $('#course-list').append(html);
                    $('#course-list li').fadeIn("slow");
                }
            }
        });
    }

    //提供静态页面时自带的js
    function  old(){
        $(".kjsPx a").eq(0).css('color','#5583db');
        $(".kjsPx a").click(function () {
            $(".kjsPx a").css('color', '#666');
            $(this).css('color', '#5583db')
        });
    }

    //vip用户跳转定制计划验证
    function vipCheckPlanNum(){
        var url = '/plan/made';
        $.post('/plan/check').done(function (result) {
            if (result.success) {
                if (result.data) window.location.href = url;
                else layer.alert("计划数已达上限!", {
                    offset: '150px'
                });
            }
        })
    }

})(jQuery)

