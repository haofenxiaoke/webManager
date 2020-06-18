<%--
  Created by IntelliJ IDEA.
  User: admin
  Date: 2016/7/7
  Time: 14:33
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="fmt"
           uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>微信支付-设计牛</title>
    <link href="${basePath}/resources/common/css/pay_head.css" rel="stylesheet">
    <link rel="stylesheet" href="${basePath}/resources/course/css/weixin.css" />
    <link rel="stylesheet" href="${basePath}/resources-sjn/order/css/wx.css" />
</head>
<body>
<div class="weixin-all">
    <div class="weixin-top">
        <div class="wxTop-left">
            <p class="banphone">请您及时付款，以便订单尽快处理！ 订单号：<span>${orderNum}</span></p>
            <p class="banbuy">请您在提交订单后<span>24小时</span>内完成支付，否则订单会自动取消。</p>
        </div>
        <div class="wxTop-right">
            应付金额<span><fmt:formatNumber value="${price}" type="currency"/></span>元
        </div>
    </div>

    <div class="weixin-bottom">
        <div class="botBt">微信支付</div>

        <div class="ewm">
            <div class="ma">
                ${qrcode}
            </div>
            <div class="ewmsj">
                二维码过期还剩<span id="timeout" style="color:#e62c3a;">${timeout}</span>秒，过期后请刷新页面重新获取二维码。
            </div>
            <div class="ewmts">
                <img src="${basePath}/resources-sjn/order/images/saomiao.png" />
            </div>
        </div>

        <div class="tp">
            <img src="${basePath}/resources-sjn/order/images/sjn_iphone.png" />
        </div>
    </div>
</div>
<script>
    $(function () {
        var timeout= ${timeout};
        var task = setInterval(function () {
            if (timeout > 1){
                timeout--;
                $('#timeout').html(timeout);
            }else{
                clearInterval(task);
                $('.ewmsj').html('二维码过期已过期，请后请<a href="" style="color: blue;text-decoration:underline">刷新</a>页面重新获取二维码。')
            }
        }, 1000);

       var query = setInterval(function () {

           $.post('${basePath}/order/paid', {orderNum:'${orderNum}'})
                   .done(function (result) {
                        if (result.success) {
                            clearInterval(query);
                            location.href = '${basePath}' + result.data;
                        }
                 });
        },1000);
    });
</script>
</body>
</html>
