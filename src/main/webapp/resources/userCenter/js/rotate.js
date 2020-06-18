$(document).ready(function(){
    var deg=0;
    var images	= $('#stage img').removeClass('default').addClass('animationReady');
    var dim		= { width:images.width(),height:images.height()};
    var cnt = images.length;
    var centerX = $('#stage').width()/2;
    var centerY = $('#stage').height()/2 - dim.height/4;
    function rotate(step,total){
        deg+=step;
        var eSin,eCos,newWidth,newHeight,q;
        for(var i=0;i<cnt;i++){
            q = ((360/cnt)*i+deg)*Math.PI/180;
            eSin= Math.sin(q);
            eCos= Math.cos(q);
            q = (0.6+eSin*0.4);
            newWidth= q*dim.width;
            newHeight= q*dim.height;
            images.eq(i).css({
                top			: centerY+15*eSin,
                left		: centerX+300*eCos,
                opacity		: 0.8+eSin*0.2,
                marginLeft	: -newWidth/2,
                zIndex		: Math.round(300+eSin*20),
                width:newWidth
            })
        }
        total-=Math.abs(step);
        if(total<=0) return false;
        setTimeout(function(){rotate(step,total)},40);
    }
    rotate(10,360/cnt);
    $('#phoneCarousel .previous').click(function(){
        rotate(-10,360/cnt);
    });
    $('#phoneCarousel .next').click(function(){
        rotate(10,360/cnt);
    });
    $('#phoneCarousel .previous,#phoneCarousel .next').hover(function(){
        clearInterval(timer);
    },function(){
        timer=setInterval(function(){rotate(10,360/cnt);},20000);
    });
    var timer=null;
    timer=setInterval(function(){rotate(10,360/cnt);},20000);
});