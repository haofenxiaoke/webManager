$(document).ready(function(){
				var jk = $(".member-list li").length;
				for (i=0;i<jk;i++) {
					if(i%2==0){
					$(".monthMember .member-list li").eq(i).css("background","#fafbfc");
					$(".seasonMember .member-list li").eq(i).css("background","#fafbfc");
					$(".yearMember .member-list li").eq(i).css("background","#fafbfc");
					}
				}
				
			});