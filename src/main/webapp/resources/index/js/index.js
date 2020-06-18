/**
 * 主页脚本
 * @author 李恒名
 * @date 2016年6月28日 14:49:17
 */
(function ($) {
    $(".kjsBotPic").css("background-color",$("#defaultBgColor").val());
    $(document).ready(function () {
        old();
        bindEvents();
    });


    //绑定各种事件
    function bindEvents() {
        //启动轮播图
        $('.banner').unslider({
            keys: true,
            delay: 5000
        });
        //登录按钮点击事件
        $('#login-modal-btn').click(function () {
            Util.User.indexLogin();
        });
        //注册按钮点击事件
        $('#register-modal-btn').click(function () {
            Util.Modal.show('/resources/modal/register.html');
        });
        //搜索按钮点击事件
        $('#search-btn').click(function () {
            var word = $.trim($('#search-word').val());
            if (word)
                location.href = '/search?word=' + word;
            else
                layer.alert('请输入搜索内容!',{
                    title:'温馨提示',
                    end:function () {
                        $('#search-word').focus();
                    }
                });
        });
        //右侧浮动
        Util.rightFloat();

        $('#search-word').focus(function () {
            Util.onEnter(function () {
                $('#search-btn').click();
            });
        });
    }


    function loadLoveCourseList(){
        $.getJSON().done(function (result) {

            if(result.success()){
                var html = '';
                $.each(result.data,function (key,course) {
                    html+='<li>';
                    html+=' <div class="kjsCimg"><a><img src="/resources/index/images/crousePic1.png"> </a></div>';
                    html+='<div class="kjsCTwo">';
                    html+=' <div class="clearfloat">';
                    html+=' <div class="kjsJd">';
                    html+=' <div style="width: 10%;"></div>';
                    html+=' </div>';
                    html+=' <div class="kjsSmallj">学习了<span style="color: #ff6700;">10</span>/26课程小节 </div>';
                    html+='</div>';
                    html+='<div class="kjsStar">';
                    html+='<div>学员:54666人</div>';
                    html+='<div class="kjsPf clearfloat">';
                    html+='<a class="restIcon kjsXxcur"></a>';
                    html+='<a class="restIcon kjsXxcur"></a>';
                    html+='<a class="restIcon kjsXxcur"></a>';
                    html+='<a class="restIcon kjsXxcur"></a>';
                    html+='<a class="restIcon"></a>';
                    html+='</div>';
                    html+='</div>';
                    html+=' </div>';
                    html+=' </li>';
                })
            }
        });
        $('#love-course-list').html(html);
    }



    //提供静态页面时自带的js
    function  old(){

        var oDiv1=document.getElementById("kjsHove")
        var oDiv2=document.getElementById("kjsCon")
        var timer=null;
        oDiv2.onmouseover=oDiv1.onmouseover=function(){
            clearInterval(timer);
            oDiv2.style.display='block';
            oDiv1.className='kjsRetext kjsLh';
        }
        oDiv2.onmouseout=oDiv1.onmouseout=function(){
            oDiv2.style.display='none';
            oDiv1.className='kjsRetext';
        }

        var task;
        $('.kjsDlyd a').hover(function(){
            var kjsJdCon = "";
            var dataFlag = $(this).attr("data_flag");
            if(dataFlag=="1"){
                kjsJdCon = '<p>量身定制学习方案<br/>薪资平均增长36%</p>';
            }else if(dataFlag=="2"){
                kjsJdCon = '<p>赠送课程学习资料<br/>学习变得更高效</p>';
            }else if(dataFlag=="3"){
                kjsJdCon = '<p>记录你点滴的成长<br/>成功路上会计狮一路相伴</p>';
            }else{
                kjsJdCon = '<p>老师实时答疑解惑<br/>让学习变得更简单</p>';
            }
            $(this).find('p').css('color', '#5583db');
            task = setTimeout(function () {
                $(this).find('p').css('color', '#5583db');
                $(".kjsJdCon").css('display', 'block');
                $(".kjsJdCon").html(kjsJdCon);
            }, 600);
        },function(){
                clearInterval(task);
                $(this).find('p').css('color','#666')
                $(".kjsJdCon").css('display','none');
        });
        //$(".dlXj-num1").hover(function(){
        //    $(this).find('i').css('background-position'," 0px -26px")
        //    $(this).find('p').css('color',"#5583db")
        //},function(){
        //    $(this).find('i').css('background-position'," 0px 0px")
        //    $(this).find('p').css('color',"#666666")
        //})
        //$(".dlXj-num2").hover(function(){
        //    $(this).find('i').css('background-position',"  -26px -25px")
        //    $(this).find('p').css('color',"#5583db")
        //},function(){
        //    $(this).find('i').css('background-position'," -26px 0px")
        //    $(this).find('p').css('color',"#666666")
        //})
        //$(".dlXj-num3").hover(function(){
        //    $(".kjsJdCon").css('top',0);
        //    $(this).find('i').css('background-position'," -49px -26px")
        //    $(this).find('p').css('color',"#5583db")
        //},function(){
        //    $(".kjsJdCon").css('top','58px');
        //    $(this).find('i').css('background-position'," -49px 0px")
        //    $(this).find('p').css('color',"#666666")
        //})
        //$(".dlXj-num4").hover(function(){
        //    $(".kjsJdCon").css('top',0);
        //    $(this).find('i').css('background-position'," 24px -26px")
        //    $(this).find('p').css('color',"#5583db")
        //},function(){
        //    $(".kjsJdCon").css('top','58px');
        //    $(this).find('i').css('background-position'," 24px 0px")
        //    $(this).find('p').css('color',"#666666")
        //})

        $(".kjsNav2 .kjsnav2L a").hover(function(){
            $(".kjsD").hide();
            $(".kjsBanBtn").hide();
            $(".kjsnav2Con").show();
            $(".kjsNav2 .kjsnav2L a").removeClass("kjsnavCur");
            $(".kjsNav2 .kjsnav2L a i").css('background-position','-135px -4px')
            $(this).addClass('kjsnavCur');
            $(this).find('i').css('background-position','-125px -4px')
            $(this).parent().next().find(">div").hide().eq($(this).index()).show();
        },function(){
            $(".kjsD").show();
            $(".kjsBanBtn").show();
        });
        $(".kjsNav2").hover(function () {

        }, function () {
            $(".kjsnav2Con").hide();
            $(".kjsNav2 .kjsnav2L a").removeClass("kjsnavCur");
            $(".kjsNav2 .kjsnav2L a i").css('background-position', '-135px -4px')
        });

        $(".kjsnav2Con").hover(function(){
            $(".kjsD").hide();
            $(".kjsBanBtn").hide();
        },function(){
            $(".kjsD").show();
            $(".kjsBanBtn").show();
        });

        $("#ul").width(liw);
        function getClass(oParent,sClass){
            var aEl=oParent.getElementsByTagName("*");
            var arr=[];
            for(var i=0;i<aEl.length;i++){
                if(aEl[i].className==sClass){
                    arr.push(aEl[i])
                }
            }
            return arr;
        }
        /*function three(){
            var app=document.getElementById("index-video");
            var ul=document.getElementById("ul");
            var li=app.getElementsByTagName('li');
            var prev=getClass(app,'index-stu-prev')[0];
            var next=getClass(app,'index-stu-next')[0];
            var now=0;
            function tab(){
                if(now==0){
                    starMove(ul,{left:0})
                }else if(now==li.length-1){
                    starMove(ul,{left:-(now)*li[0].offsetWidth})
                }else{
                    starMove(ul,{left:-(now)*li[0].offsetWidth})
                }
            }
            prev.onclick=function(){
                now--;
                if(now==-1){
                    now=0;
                }
                tab();
            }
            next.onclick=function(){
                now++;
                if(now>=li.length){
                    now=li.length-1;
                }
                tab();
            }
        }
        three();*/
    }
    var liw=$("#ul li:eq(0)").width()*$("#ul li").length+'px';

   for(var i=0;i<$('.kjsContent').size();i++){
       $('#name').attr('id','name'+i);
   }
    i++;

    function test(index){
       for(var i=0;i<$('.float-text a').size();i++){
           if(i==index){
               $('.float-text a').eq(i).addClass("curHover");
           }else{
               $('.float-text a').eq(i).removeClass("curHover");
           }
       }

    }

   $(window).scroll(function(){
       var Stop=$(this).scrollTop();
       $('.float-left').show();
       if(Stop>=880){
           test(0)
       }
        if(Stop>=880+$('#name1').height()-10){
            test(1)
       }
       if(Stop>=880+$('#name1').height()+$('#name2').height()-10){
           test(2)
       }
       if(Stop>=880+$('#name1').height()+$('#name2').height()+$('#name3').height()-10){
           test(3)
       }
   });



})(jQuery)

