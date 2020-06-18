//小程序动态效果
// 文字块从左到右
function getStyle(dom, attr) {
            if (window.getComputedStyle) {
                return window.getComputedStyle(dom, null)[attr];
            } else {
                return dom.currentStyle[attr];
            }
        }

function startMove(dom, attrObj, callback) {
            clearInterval(dom.timer);
            var iSpeed = null, iCur = null;
            dom.timer = setInterval(function () {
                var bStop = true;
                for (var attr in attrObj) {
                    if (attr == 'opacity') {
                        iCur = parseFloat(getStyle(dom, attr)) * 100;
                    } else {
                        iCur = parseInt(getStyle(dom, attr));
                    }
                    iSpeed = (attrObj[attr] - iCur) / 7;
                    iSpeed = iSpeed > 0 ? Math.ceil(iSpeed) : Math.floor(iSpeed);
                    if (attr == 'opacity') {
                        dom.style.opacity = (iCur + iSpeed) / 100;
                    } else {
                        dom.style[attr] = iCur + iSpeed + 'px';
                    }
                    if (iCur != attrObj[attr]) {
                        bStop = false;
                    }
                }
                if (bStop) {
                    clearInterval(dom.timer);
                    typeof callback == 'function' && callback();
                }

            }, 30);
        }
        
function check(){
            var sw2 = document.getElementById('sw2');
            var sw3 = document.getElementById('sw3');
            var sw4 = document.getElementById('sw4');
            if(sw2.offsetTop <= window.pageYOffset + window.innerHeight){
            	startMove(free_all, { left: 532 })
                startMove(xcx_title, { left: 540 })
                startMove(xcx_dikuai, { right: 0 })
                startMove(xcx_pic, { top: 266 })
            }
            if(sw3.offsetTop <= window.pageYOffset + window.innerHeight){
            	startMove(gzh_pic, { top: 260 })
                startMove(gzh1_dikuai, { left: 244 })
                startMove(content_info, { right: 505 })
                
            }
            if(sw4.offsetTop <= window.pageYOffset + window.innerHeight){
            	startMove(gzh2_left, { left: 477 })
            	startMove(gzh2_pic, { top: 222 })
//            	startMove(yuan2, { top: 296,right: 421 })
            	
            }
        } 

        window.onscroll = function () {
        	check()
        }
        
        
		var centerx = 247; //圆心X
		var centery = 247; //圆心Y
		var r = 258; //半径
		var oimages = document.getElementsByClassName("yuan2") //集合
		var cnt =3; //圆数
		var da = 360 / cnt; //图片间隔角度
		var a0 = 0; //已旋转角度
		var timer;

		function posimgs() {
			for (var i = 0; i < cnt; i++) {
				oimages[i].style.left = centerx + r * Math.cos((da * i + a0) / 180 * Math.PI) + "px";

				oimages[i].style.top = centery + r * Math.sin((da * i + a0) / 180 * Math.PI) + "px";
				
			}
			
		}

		// posimgs();
function start() {
			timer = window.setInterval("posimgs();a0++;", 100);
		}

function stop() {
			window.clearInterval(timer);
		}
		
start();	