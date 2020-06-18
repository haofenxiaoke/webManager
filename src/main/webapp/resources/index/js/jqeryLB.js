$(document).ready(function(){
    /*背景切换*/
    var starIndex =-1;
    var liLenth=$(".kjsBotLb>a");
    var num=$(".kjsD li").length;
    var timer=null;
    $('.kjsBotLb>div:gt(0)').hide();
    /*点击圈圈*/
    $(".kjsD li").click(function(){
        $(this).addClass('cur').siblings().removeClass('cur');
        var index1=$(".kjsD li").index(this);
        liLenth.eq(index1).fadeIn('slow').siblings().fadeOut('slow');
        $(".kjsBotLb").css("background-color",liLenth.eq(index1).attr("data_bgcolor"));
        starIndex=index1;
    })
    /*左侧点击*/
    $('.kjsBanBtnL').click(function(){
        if(starIndex==-1){
            starIndex=num-1;
        }
        liLenth.eq(starIndex-1).fadeIn('slow').siblings().fadeOut('slow');
        $(".kjsBotLb").css("background-color",liLenth.eq(starIndex-1).attr("data_bgcolor"));
        $(".kjsD li").eq(starIndex-1).addClass('cur').siblings().removeClass('cur')
        starIndex--;
    })
    /*右侧点击*/
    $('.kjsBanBtnR').click(function(){
        autoBanner();
    })

    //自动播放
    function starPlay(){
        timer=setInterval(function(){
            autoBanner();
        },5000);
    }
    starPlay()
    $('.kjsNav').mouseout(function(){
        starPlay();
        $('.kjsBanBtnL').hide();
        $('.kjsBanBtnR').hide();
    })
    $('.kjsNav').mouseover(function(){
        clearInterval(timer);
        $('.kjsBanBtnL').show();
        $('.kjsBanBtnR').show();
    })
    function autoBanner(){
        if(starIndex==num-1){
            starIndex=-1;
        }
        liLenth.eq(starIndex+1).fadeIn('slow').siblings().fadeOut('slow');
        $(".kjsD li").eq(starIndex+1).addClass('cur').siblings().removeClass('cur');
        $(".kjsBotLb").css("background-color",liLenth.eq(starIndex+1).attr("data_bgcolor"));
        starIndex++;
    }
})
