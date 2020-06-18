$(function () {
    var liHeight = 45;
    var num = 1;
    var liScroll = 500;
    var lodingSpeed = 3000;
   // var conTent = '<li>北京市139****129购买了<span>599元会员套餐</span></li>';
    setInterval(function () {
       // $('.myscroll ul').append(conTent);
        if ($('.myscroll ul').children().length > 3){
            $('.myscroll ul').animate({
                'margin-top': -liHeight * num + 'px'
            }, liScroll);
            num++;
        }
    }, lodingSpeed)
});