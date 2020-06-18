
var extyq = 0;
	$(".flexible-btn").click(function(){
		$("#list-over").slideToggle("500");
		if(extyq%2==0){
			$(".flexible-btn").css("background","url(../../../resources/course/images/jia.png) no-repeat center center");
		}else{
			$(".flexible-btn").css("background","url(../../../resources/course/images/jian.png) no-repeat center center");
		}
		extyq++;
	});
$(".modification").click(function(){
$(".favorable").css("display","block")
})