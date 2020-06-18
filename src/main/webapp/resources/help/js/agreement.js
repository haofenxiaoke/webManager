$(".helpRight-top li").click(function(){
	var pig = $(".helpRight-top li").index(this);
	$(".helpRight-top li").eq(pig).css("border-bottom","2px solid #5583DB").siblings().css("border-bottom","0px");
	$(".agreement-xxk").eq(pig).css("display","block").siblings().css("display","none");
});

$(function () {
	var sm = Util.getRequestParam('sm');
	sm && $('#sm-' + sm).click();
});