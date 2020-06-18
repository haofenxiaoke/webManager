$(function () {

    /*左侧列表*/
    $(".userL-list li a").on('click', function () {
        $(".userL-list li a").removeClass('userL-cur');
        $(this).addClass('userL-cur');
    })

    $(".userR-title a").on('click', function () {
        $(".userR-title a").removeClass('userR-cur');
        $(this).addClass('userR-cur');
        $(this).parent().next().find('.userR-zccount>div').fadeOut().hide().eq($(this).index()).fadeIn();
    })
    $(".userR-input input").on('click', function (e) {
        $(".userR-input").removeClass('userColor');
        if ($(this).parent().attr('class') !== 'userR-input userColor') {
            $(this).parent().attr('class', 'userR-input userColor')
        } else {
            $(this).parent().attr('class', 'userR-input ')
        }
        e.stopPropagation()
    })
    $("body,html").on('click', function () {
        $('.userR-input').attr('class', 'userR-input ');
    })
    $(".play-list li").css('border', '1px solid #e5e5e5')
   /* window.onload=function(){
        $(".crouse-a a").hover(function () {
            $(this).find('i').css('display', 'inline-block');
            $(this).stop().animate({
                width: '75px'
            }, 500)
            $(this).find('i').click(function () {
                $(this).parent().remove();
            })
        }, function () {
            $(this).find('i').css('display', 'none');
            $(this).stop().animate({
                width: '60px'
            }, 500)
        })
    }*/
    var requestParam = Util.getRequestParam("m"); requestParam && $('#m-' + requestParam).click();

    Util.uploadFile('imageFile', 'preview-image', 'head-image-path','headImage');
});