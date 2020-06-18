$(".help-left li").click(function () {
    var hm = $(".help-left li").index(this);
    $(".help-left li").eq(hm).css({
        "color": "#5583DB",
        "border-left": "3px solid #5583DB"
    }).siblings().css({"color": "#666666", "border-left": "3px solid #ffffff"})
});

$(function () {
    var m = Util.getRequestParam('m');
    if (m)
        $('#' + m).click();
    else
        $('#1').click();



});
