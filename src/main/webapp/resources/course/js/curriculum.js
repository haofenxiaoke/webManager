$(function () {

    var scrTop=$('.xxk').offset().top;
    $(".xxk li").on('click', function () {
        $(".xxk li").removeClass('crouse_l_nav');
        $(this).addClass('crouse_l_nav');
        $(this).parent().parent().next().find(">div").hide().eq($(this).index()).show();
        $('body,html').animate({scrollTop:500 }, 500)
    })
    $(window).scroll(function () {
        var scr = $(window).scrollTop();
        if (scrTop-scr<=50) {
            $('.xxk').addClass('crouse_bfb');
            $(".xuanxiangka").css("padding-top","51px")
            $('.members_Li').show();
        } else {
            $(".xuanxiangka").css("padding-top","0px")
            $('.xxk').removeClass('crouse_bfb');
            $('.members_Li').hide();
        }
    })
    $('.catalog li').hover(function () {
        var ind = $('.catalog li').index(this)
        if ($('.catalog li:eq(' + ind + ') button').length > 0) {
            $('.catalog li').eq(ind).css({background: '#fffdee', cursor: 'pointer'})
        } else {
            $('.catalog li').eq(ind).css({background: '#fff'})
        }

    }, function () {
        $(this).css({background: '#fff'})
    })
})




