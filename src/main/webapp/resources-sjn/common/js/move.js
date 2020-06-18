function getStyle(obj,name){
    if(obj.currentStyle){
        return obj.currentStyle[name];
    }else{
        return getComputedStyle(obj,false)[name];
    }
}
function starMove(obj,json,fn){
    clearInterval(obj.timer);
    obj.timer=setInterval(function(){
        for(var attr in json){
            var bstop=true;
            var cur=0;
            if(attr=='opacity'){
                cur= Math.round( parseFloat(getStyle(obj,attr))*100);
            }else{
                cur=parseInt(getStyle(obj,attr))
            }
            var speed=(json[attr]-cur)/6;
            speed=speed>0?Math.ceil(speed):Math.floor(speed);
            if(cur!=json[attr])bstop=false;
            if(attr=='opacity'){
                obj.style.opacity=(cur+speed)/100;
                obj.style.filter='alpha(opacity:'+cur+speed+')';
            }else{
                obj.style[attr]=cur+speed+'px';
            }
            if(bstop){
                clearInterval(obj.timer);
                if(fn)fn();
            }
        }
    },30)
}