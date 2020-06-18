$(".xxk li").on('click',function(){
	$(".xxk li").removeClass('crouse_l_nav');
	$(this).addClass('crouse_l_nav');
	$(this).parent().parent().next().find(">div").hide().eq($(this).index()).show();
	$('body,html').animate({scrollTop:460},500)
})
$(window).scroll(function(){
	var scr = $(document).scrollTop()
	if(scr>=467){
        $('.xxk').addClass('crouse_bfb');
		$('.members_Li').show();
	}else{
		$('.xxk').removeClass('crouse_bfb');
		$('.members_Li').hide();
	}
})
$('.catalog li').hover(function(){
	var ind = $('.catalog li').index(this)
	if($('.catalog li:eq('+ind+') button').length>0){
		$('.catalog li').eq(ind).css({background:'#fffdee',cursor:'pointer'})
	}else{
		$('.catalog li').eq(ind).css({background:'#fff'})
	}

},function(){
	$(this).css({background:'#fff'})
})





