/*
$(function(){

    $.post('/userCenter/voucherList').done(function (result) {
        if(result.success){
            //alert('获取优惠券列表成功！');
            if(result.data){
                $.each(result.data,function (index,voucher) {
                    var voucherLi=document.createElement("li");
                    voucherLi.innerHTML='<div class="kjsCimg"></div>'+
                        '<div class="kjsCTwo">'+
                        '<div class="clearfloat">'+
                        '<div class="kjsJd">'+
                        '<div style="width:'+100*0.5+'%;"></div>'+
                        '</div>'+
                        '<div class="kjsSmallj">学习了<span style="color: #ff6700;">'+voucher.ctime+'</span>-'+voucher.expireDate+'课程小节 </div>'+
                        '</div>'+
                        '<div class="kjsStar">'+
                        '<div class="playLook"><i class="restIcon"></i>看到第'+10+'讲<span>'+100+'%</span></div>'+
                        '</div>'+
                        '</div>';
                    $("#vouchers").append(voucherLi);
                })
            }else{
                var voucherLi='<div class="userR-twnone">'+
                    '<img src="../../../resources/userCenter/images/noPic.png" width="160">'+
                    '<p>您没有任何优惠券</p>'+
                    '</div>';
                $("#hasVouchers").append(voucherLi);
            }
        }else{
            layer.msg("获取优惠券列表过程中遇到问题，该订单取消失败！",{time: 5000});
        }
    })


});
*/

