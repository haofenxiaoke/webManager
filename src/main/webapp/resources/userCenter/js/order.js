(function (window,$) {

    $(function(){
        var vipId=$("#vipid").val()+'';
        var level='userLt-name';
        if(vipId!=null && vipId!=''){
            if(vipId=='1'){
                level+="-month"
            }
            if(vipId=='2'){
                level+="-season"
            }
            if(vipId=='3'){
                level+="-year"
            }
            var vipLevel=$("#vipLevel")
            vipLevel.attr("class",level);
        }
        window.cancelOrder =function (orderId){

            layer.confirm('您确定要取消该订单吗？', {
                btn: ['确定','取消'], //按钮
                fix:true,
                offset:'150px'
            }, function(){
                $.post('/userCenter/cancelOrder',{orderId:orderId}).done(function (result) {
                    if(result.success){
                        /*alert('取消订单成功！');*/
                        getOrders();
                        layer.msg('取消订单成功！', {icon: 1,time:2000});
                    }else{
                        layer.msg("取消过程中遇到问题，该订单取消失败！",{time: 5000});
                    }
                })
            }, function(){
                layer.msg('操作已取消', {
                    time: 2000//20s后自动关闭
                });
            });

        }
        getOrders();

    });
    function getOrders(){
        $("#orders").html('');
        $.post('/userCenter/orderList').done(function (result) {
            if (result.success) {
                if(result.data){
                    $.each(result.data,function (index,order) {
                        var payStatus='';
                        var operation='';
                        if(order.payStatus==0){
                            payStatus='待支付';
                            operation= '<a class="btn70" style=" background-color: #f8c208; border-radius: 0; line-height: 28px; width:75px; height: 28px;" href="/order/buy?orderNum='+order.orderNum+'">立即支付</a>'+
                                '<a class="cancelOrder" onclick="cancelOrder('+order.id+')" >取消订单</a>';
                        }else if(order.payStatus==1){
                            if(order.auditStatus==2){
                                payStatus='已退款';
                                operation='<a></a>';
                            }else{
                                payStatus='已支付';
                                operation='<a></a>';
                            }

                        }/*else if(order.payStatus==2){
                            payStatus='已退款';
                            operation='<a>已退款</a>';
                        }*/
                        var orderDate= order.orderTimeDesc;
                        //var orderDate=Date.parse(order.orderTime);
                        var orderHtml=
	                        '<span>订单编号:'+order.orderNum+'</span>'+
	                        '<span>下单时间:'+orderDate+'</span>'+
                        	'<table class="orderTable" >'+
                            '<thead>'+
                            '<tr height="45">'+
                            '<td style="width: 21%">订单详情</td>'+
                            ' <td style="width: 17.5%">会员价格</td>'+
                            ' <td style="width: 17.5%">实付金额</td>'+
                            ' <td style="width: 17.5%">订单状态</td>'+
                            ' <td style="width: 17.5%;border-right:1px solid #e0e0e0;">操作</td>'+
                            ' </tr>'+
                            ' </thead>'+
                            '<tr class="borR">'+
                            '<td >'+order.programName+'</td>'+
                            '<td >￥'+order.costPrice+'</td>'+
                            '<td >￥'+order.realpayPrice+'</td>'+
                            '<td>'+
                            '<p>'+payStatus+'</p>'+
                           /* '<a>订单详情</a>'+*/
                            '</td>'+
                            '<td >'+
                            operation+
                            '</td>'+

                            '</table>';
                        $("#orders").append(orderHtml);
                    })
                }else{//无订单时显示的内容
                    var orderHtml='<div class="userR-twnone">'+
                        '<img src="../../../resources/userCenter/images/noPic.png" width="160">'+
                        '<p>您还没有购买学习课程<br>赶快去选<a  href="/course">课程</a>吧</p>'+
                        '</div>';
                    $("#orders").append(orderHtml);
                }
            } else {
                alert(result.message);
            }
        });
    }

})(this,jQuery);