var dy = 0;
$(".qiehuan").click(function() {
	if (dy % 2 == 0) {
		$(".listRight").animate({
			"width": "0"
		}, 1000);
		$(".video-list").animate({
			"width": "12px"
		}, 1000);
		$(".video").animate({
			"margin-right": "12px"
		}, 1000);
		$(".so-all").css("width","1214px")
		$(".qiehuan").css("background", "url(../../../resources/login/images/fxsuojin_4444.png) no-repeat center center")

	} else {
		$(".listRight").animate({
			"width": "308px"
		}, 1000);
		$(".video-list").animate({
			"width": "320px"
		}, 1000);
		$(".video").animate({
			"margin-right": "320px"
		}, 1000);
		$(".so-all").css("width","906px")
		$(".qiehuan").css("background", "url(../../../resources/login/images/fxsuojin_03.png) no-repeat center center")

	}
	dy++;
});
			

$(".lr-top li").click(function(){
	var jy = $(".lr-top li").index(this);
	$(this).css({"background-color":"#f8c208"}).siblings().css({"background-color":"#343635"})
	$(".lr-bottom ul").eq(jy).css("display","block").siblings().css("display","none")
});

$(".answer-nav li").click(function(){
	var jy = $(".answer-nav li").index(this);
	$(this).css({"border-bottom":"2px solid #5583DB","color":"#5583DB"}).siblings().css({"border-bottom":"0px","color":"#333333"});
	$(".answer-xx").eq(jy).css("display","block").siblings().css("display","none");
});
			
function textup(){
	var wenzi = $(".onesrk textarea").val().length;
		$(".onesrk span").text(wenzi);

}
			
$(".pftb").click(function(){
	var isScore = $('#isScore').val();
	if(isScore && isScore == 'true'){
		$('#ypfcg').show();
		setTimeout("$('#ypfcg').hide();",2000);
		// layer.msg('已经评过分啦', {offset: '590px',scrollbar: false,icon: 6});
	}else{
		$(".grade-bj").css("display","block");
	}

});
$(".gb").click(function(){
	$(".grade-bj").css("display","none");
});

$(".tcnrgb").click(function(){
	$(".hytc").css("display","none");
/*	window.location.href="/";*/
});

$(".jdt-right li").click(function(){
	$(".jdt-right span").text(0);
	for (i=0;i<$(".jdt-right li").length;i++) {

	$(".jdt-right li").eq(i).css("background","url(../../../resources/login/images/xxxxxx_05.png) no-repeat center center");
	}
	var yo = $(".jdt-right li").index(this)+1;
	var no = $(".jdt-right span").text();

	for (i=0;i<yo;i++) {

	$(".jdt-right li").eq(i).css("background","url(../../../resources/login/images/xxxx_03.png) no-repeat center center");

	no++;
	$(".jdt-right span").text(no)
	}
});
			
$(".jdt-rightone li").click(function(){
	$(".jdt-rightone span").text(0);
	for (i=0;i<$(".jdt-rightone li").length;i++) {

	$(".jdt-rightone li").eq(i).css("background","url(../../../resources/login/images/xxxxxx_05.png) no-repeat center center");
	}
	var yo = $(".jdt-rightone li").index(this)+1;
	var no = $(".jdt-rightone span").text();

	for (i=0;i<yo;i++) {

	$(".jdt-rightone li").eq(i).css("background","url(../../../resources/login/images/xxxx_03.png) no-repeat center center");

	no++;
	$(".jdt-rightone span").text(no)
	}
});
			
			
$(".hftj").click(function(){
	var huifu = $(".replyWin-bottom textarea").val().length;
	if(huifu>200){
		layer.open({
			offset: '40%',
			content:"亲，超过200字了"
		});
		return;
	}
	//openMsg(".replyWin-bottom textarea",'');
});
function openMsg(strObj,textLength){
	var strObj = $(strObj),size = 200;
	var strLength = strObj.val().length;

	if(strLength>size){
		strObj.val(strObj.val().substring(0,size));
		layer.open({
			offset: '40%',
			content:"亲，超过200字了"
		});
		$(textLength).html(size);
		return;
	}else{
		$(textLength).html(strLength);
	}

}

$(".hf-gb").click(function(){
	$(".reply").css("display","none");
});
;
$("#suggest-textarea").blur(function(){
	$(".suggest-bottom").css("background-color","#f7f9fa");
	$(this).css("background-color","#f7f9fa");
});

$("#suggest-textarea").focus(function(){
	$(".suggest-bottom").css("background-color","#ffffff");
	$(this).css("background-color","#ffffff");
});


$(function(){
	$(".teacher a").click(function(){
		$(".reply").css("display","block");
	});
})
$('#answer-textarea').bind('input propertychange', function() {
	$("#textareaLength").html($(this).val().length);
	if($(this).val().length>200) {
		$("#textareaLength").val($("#textareaLength").val().substring(0,200));
		layer.open({
			offset: '40%',
			content: "亲，超过200字了"
		});
	}
});