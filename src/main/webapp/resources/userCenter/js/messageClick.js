$(function(){
    /*点击系统消息隐藏小红点属性*/
    $('#message').unbind().click(function () {
        var $li = $(this).parent();
        $li.addClass('userL-cur');
        $li.siblings().removeClass('userL-cur');
        $('#'+this.id).next().hide();
        var url="/userCenter/msgTabClick";
        $.post(url, {});
        document.title = this.innerHTML;
        window.location.hash = this.id;
        $('#page-right').load("/userCenter/right/message");
    });
    /*点击我的提问隐藏小红点属性*/
    $('#question').unbind().click(function () {
        var $li = $(this).parent();
        $li.addClass('userL-cur');
        $li.siblings().removeClass('userL-cur');
        $('#'+this.id).next().hide();
        var url="/userCenter/questionTabClick";
        $.post(url, {});
        document.title = this.innerHTML;
        window.location.hash = this.id;
        $(window).scrollTop(0);
        $('#page-right').load("/userCenter/right/question");
    })

})