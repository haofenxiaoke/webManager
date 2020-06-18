/**
 * 计划
 * @author zhenghui
 * @date 2016年7月8日
 */
(function ($) {
	$(document).ready(function () {
		bindEvents();
		bindEvents2();
		setTimeout(function(){showPosition();},500);
	})

	//绑定各种事件
	function bindEvents() {

		$(document).click(function (event) {
			$('.sanjiaoBorder').slideUp(500);
			$('.sanjiao').slideUp(500);
			$('.xskPost').slideUp(500);
			$(".xsanjiaoBorder").slideUp(500);
			$(".xsanjiao").slideUp(500);
			$(".xskIndustry").slideUp(500);
		});

		$("#postShow").click(function(event){
			event.stopPropagation();//取消事件冒泡
			$(".sanjiaoBorder").slideToggle(500);
			$(".sanjiao").slideToggle(500);
			$(".xskPost").slideToggle(500);
		});


		$(".xskPost li").click(function(){
			var allLi = $(".xskPost li").index(this);
			var lk = $(".xskPost li").eq(allLi).closest(".jiaoyu").index();
			var xb = $(".jiaoyu:eq("+lk+") li").index(this);
			//$(".xskPost li").eq(allLi).css("color","#5583DB").siblings().css("color","#666666");
			for (i=0;i<$(".jiaoyu").length;i++) {
				if(i==lk){
					$(".jiaoyu:eq("+i+") li").eq(xb).css("color","#222222").siblings().css("color","#999999");
				}else{
					$(".jiaoyu:eq("+i+") li").css("color","#999999");
				}
			}

			$(".jiaoyu:eq("+!lk+") li").css("color","#999999")
			var fuzhi = $(".xskPost p").eq(lk).text();
			var lizhi = $(".xskPost li").eq(allLi).text();

			$(".post input").val(lizhi);
			$('#direction-id').val($(this).attr("direction-id"));

			//填充分类显示信息
			$(".sanjiaoBorder").slideUp(500);
			$(".sanjiao").slideUp(500);
			$(".xskPost").slideUp(500);
			$('#position-id').val('');
			$(".industry input").val('');
			showPosition();
		});

		$("#industryShow").click(function(event){
			if(!$('#direction-id').val()){
				layer.alert('请先选择方向！');
				return;
			}
			event.stopPropagation();//取消事件冒泡
			$(".xsanjiaoBorder").slideToggle(500);
			$(".xsanjiao").slideToggle(500);
			$(".xskIndustry").slideToggle(500);

		});
	}

	function bindEvents2() {

		$(".xskIndustry li").click(function(){
			var abt = $(".xskIndustry li").index(this);
			var hytext = $(".xskIndustry li").eq(abt).text();

			$(".xskIndustry li").eq(abt).css("color","#222222").siblings().css("color","#999999");
			$(".industry input").val(hytext);
			$('#position-id').val($(this).attr("position-id"));
			$(".xsanjiaoBorder").slideUp(500);
			$(".xsanjiao").slideUp(500);
			$(".xskIndustry").slideUp(500);
		});
	}

	//根据方向显示行业
	function showPosition(){
		var directionId = $('#direction-id').val();
		if(!directionId) return;

		$.post('/plan/list/position/'+directionId).done(function (result) {
			if (result.success) {
				var positionContent='';
				$.each(result.data, function(index, position) {
					positionContent +='<li position-id="'+position.id+'">'+position.categoryDesc+'</li>';
				})
				positionContent = '<ul>'+positionContent+'</ul>';
				$('.shangye').html(positionContent);
				bindEvents2();
			} else {
				//console.log(result.message);
			}
		})
	}


})(jQuery)


