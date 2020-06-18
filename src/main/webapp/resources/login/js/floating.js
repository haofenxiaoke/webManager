$(".jihua li").mouseover(function(){
				var gtr = $(".jihua li").index(this);
				if(gtr==0){
				$(".jilu .yc").animate({"left":"0px"},500);
				$(".jihua li").eq(gtr).css("background","url(../../../resources/login/images/beijingaa_03.png) center center");
				}
				if(gtr==1){$(".jilu .yd").animate({"left":"0px"},500);
				$(".jihua li").eq(gtr).css("background","url(../../../resources/login/images/beijing_05.png) center center");
				}
			})
			$(".jihua li").mouseout(function(){
				var gtr = $(".jihua li").index(this);
				if(gtr==0){
				$(".jilu .yc").animate({"left":"-240px"},500);
				$(".jihua li").eq(gtr).css("background","url(../../../resources/login/images/sy_03.png) center center");
				}
				if(gtr==1){$(".jilu .yd").animate({"left":"-240px"},500);
				$(".jihua li").eq(gtr).css("background","url(../../../resources/login/images/sy_04.png) center center");
				}
			})
			/*--this is down--*/
			$(".jilu li").mouseover(function(){
				var gtr = $(".jilu li").index(this);
				if(gtr==0){
				$(".jihua .yc").animate({"left":"0px"},500);
				$(".jilu li").eq(gtr).css("background","url(../../../resources/login/images/beijing_12.png) center center");
				}
				if(gtr==1){$(".jihua .yd").animate({"left":"0px"},500);
				$(".jilu li").eq(gtr).css("background","url(../../../resources/login/images/beijing_10.png) center center");
				}
			})
			$(".jilu li").mouseout(function(){
				var gtr = $(".jilu li").index(this);
				if(gtr==0){
				$(".jihua .yc").animate({"left":"-240px"},500);
				$(".jilu li").eq(gtr).css("background","url(../../../resources/login/images/sy_09.png) center center");
				}
				if(gtr==1){$(".jihua .yd").animate({"left":"-240px"},500);
				$(".jilu li").eq(gtr).css("background","url(../../../resources/login/images/sy_07.png) center center");
				}
			})