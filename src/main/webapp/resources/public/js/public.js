$(document).ready(function() {
    $('#fullpage').fullpage({
        slidesColor: ['#1bbc9b', '#4BBFC3', '#7BAABE', '#f90'],
        anchors: ['page1', 'page2', 'page3', 'page4','page5'],
        navigation: true,

        afterLoad:function(anchorLink){
            var page1= $('.pubN-textAnimate>img');
            var page2= $('.publicTwo-test>img');
            var page3= $('.publicThree-test>img');
            var page3Con=$('.pubilc-ys');
            var page4= $('.publicFour-test>img');
            var page4Con=$('.publicFour-picD .pic1Animat');
            var page5Con=$('.publicFive-picD>div');
            var page5= $('.publicFive-test>img');
            if(anchorLink=='page1'){
                page1.addClass('pay')
                page2.removeClass('pay')
                page3.removeClass('pay')
                page4.removeClass('pay')
                page3Con.removeClass('pays')
                page4Con.removeClass('pubFour-pay');
                page5Con.removeClass('pubFive-pay')
                page5.removeClass('pay')
            }
            if(anchorLink=='page2'){
                page1.removeClass('pay')
                page2.addClass('pay')
                page3.removeClass('pay')
                page4.removeClass('pay')
                page5.removeClass('pay')
                page3Con.removeClass('pays')
                page4Con.removeClass('pubFour-pay');
                page5Con.removeClass('pubFive-pay')
            }
            if(anchorLink=='page3'){
                page1.removeClass('pay')
                page2.removeClass('pay')
                page3.addClass('pay')
                page3Con.addClass('pays')
                page4.removeClass('pay')
                page4Con.removeClass('pubFour-pay');
                page5Con.removeClass('pubFive-pay')
                page5.removeClass('pay')
            }
            if(anchorLink=='page4'){
                page1.removeClass('pay')
                page2.removeClass('pay')
                page3.removeClass('pay')
                page3Con.removeClass('pays')
                page4.addClass('pay')
                page5.removeClass('pay')
                /*page4Con.addClass('pubFour-pay');*/
                $('.publicFour-pic1 .publicFour-tx').addClass('pubFour-pay')
                $('.publicFour-pic1 .publicFour-chat').addClass('pubFour-pay')
                setTimeout(function(){
                    $('.publicFour-pic2 .publicFour-tx').addClass('pubFour-pay')
                    $('.publicFour-pic2 .publicFour-chat').addClass('pubFour-pay')
                },1000)
                setTimeout(function(){
                    $('.publicFour-pic3 .publicFour-tx').addClass('pubFour-pay')
                    $('.publicFour-pic3 .publicFour-chat').addClass('pubFour-pay')
                },2000)
                page5Con.removeClass('pubFive-pay')

            }
            if(anchorLink=='page5'){
                page1.removeClass('pay')
                page2.removeClass('pay')
                page3.removeClass('pay')
                page4.removeClass('pay')
                page3Con.removeClass('pays')
                page4Con.removeClass('pubFour-pay');
                page5.addClass('pay')
                page5Con.addClass('pubFive-pay')
            }
        }
    });
});