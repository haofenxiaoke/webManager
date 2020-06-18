<%--
  Created by IntelliJ IDEA.
  User: admin
  Date: 2016/7/11
  Time: 14:43
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path;
%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt"
           uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>

<head>
    <meta charset="UTF-8">
    <title>订单支付-好分课堂</title>
    <link rel="stylesheet" href="${basePath}/resources/course/css/buy.css"/>
    <%--<link rel="stylesheet" type="text/css" href="http://union.tenpay.com/bankList/css_col4.css"/>--%>
    <link href="${basePath}/resources/common/css/pay_head.css" rel="stylesheet">
    <script src="${basePath}/resources/common/layer-v2.3/layer/layer.js"></script>
    <script type="text/javascript" src="${basePath}/resources/course/js/respond.js"></script>

    <style>
        #J-chooseBankList label {
            margin-left: 10px
        }

        #J-chooseBankList li:last-child {
            display: none;
        }
    </style>

</head>

<body>
<div class="buy-all">
    <div class="Made-nav">
        <a href="${basePath}/" style="padding-left: 0px;">首页</a><img class="old" src="/resources/live/images/jiao2.png"/><a href="${basePath}/vip">开通会员</a><img class="old" src="/resources/live/images/jiao2.png"/><a>订单支付</a>
    </div>
    <div class="buy-succeed content-m-top">
        <div class="buySucceed-left">
            <img src="${basePath}/resources/common/images/duigou.png"/>
        </div>
        <div class="buySucceed-right">
            <p class="dingdan">订单已生成，订单号为<span>${order.orderNum}</span>,请您尽快付款！</p>
            <p class="mingcheng">商品名称：<span>${order.programName}</span></p>
            <p class="jiage">价格：<span><fmt:formatNumber value="${order.costPrice}" type="currency"/>元</span></p>
        </div>
    </div>

    <div class="buy-bottom">
        <div class="terrace">
            <div class="buyBt"><span>支付平台</span></div>
            <div class="select-pay">
                  <div class="select-div">
                      <input type="radio" name="bank_type" value="alipay" checked/>
                      <div class="and-images">
                          <img src="${basePath}/resources/course/images/yinhang_07.png" />
                      </div>
                  </div>
                <div class="select-div">
                    <input type="radio" name="bank_type" value="wx"/>
                    <div class="and-images">
                        <img src="${basePath}/resources/course/images/newPay-weixin.png"/>
                    </div>
                </div>
                <%--<div class="select-div">
                    <input type="radio" name="bank_type" value="tenpay"/>
                    <div class="and-images">
                        <img src="${basePath}/resources/course/images/ljgm_03.png"/>
                    </div>
                </div>--%>
                <%--

                                <div class="select-div">
                                    <input type="radio" name="bank_type" value="unionPay" />
                                    <div class="and-images">
                                        <img src="${basePath}/resources/course/images/yinhang_11.png" />
                                    </div>
                                    <div class="tishi">（无需开通网银）</div>
                                </div>
                --%>

                <%--   <div class="select-div">
                       <input type="radio" name="radio" />
                       <div class="and-images">
                           <img src="${basePath}/resources/course/images/yinhang_13.png" />
                       </div>
                       <div class="tishi">（无需开通网银）</div>
                   </div>--%>
            </div>
        </div>

        <%--<div class="terrace djyc">
            <div class="buyBt"><span>网银支付</span></div>
            <div id="tenpayBankList"></div>
            <input type="hidden" name="bank_type_value" id="bank_type_value" value="0">
            <script>$.getScript("http://union.tenpay.com/bankList/bank.js");</script>
        </div>--%>
        <div class="favorable-wai">
            <div class="favorable">
                <p class="favorable-title">优惠券</p>
                <p class="flexible"><a class="favorable-quantity"><span>${fn:length(voucherList)}</span>张优惠券可用</a>
                	<a class="flexible-btn" style="background: url('../../../resources/common/images/jiahao.png') center center no-repeat; margin-left: 15px;"></a>
                </p>
                <div style=" margin-top: 15px; padding-bottom: 10px; display: none;"
                     class="contract">
                    <table class="watch-head" style="width: 100%;">
                        <tr>
                            <td style="width: 8%; min-width: 8%; max-width: 8%;">选择</td>
                            <td style="width: 25%; min-width: 25%; max-width: 25%;">券号</td>
                            <td style="width: 8%;min-width: 8%; max-width: 8%;">面额</td>
                            <td style="width: 29%; min-width: 29%; max-width: 29%;">券名</td>
                            <%--<td style="width: 9% min-width:9%; max-width: 9%;">券类型</td>--%>
                            <td style="width: 30%; min-width: 30%; max-width: 30%;">使用期限</td>
                        </tr>
                    </table>
                    <div class="DisAll" style="height: 150px;overflow: hidden;">
                        <table class="watch-list" id="list-over" style="width: 100%;">
                            <c:forEach items="${voucherList}" var="voucher" varStatus="status">
                                <c:choose>
                                    <c:when test="${status.first}">
                                        <tr style="background: #fffdee;">
                                            <td style="width: 8%;min-width: 8%; max-width: 8%;"><input type="radio"
                                                                                                       class="alyes"
                                                                                                       name="select-voucher"
                                                                                                       id="${voucher.voucherNum}"/>
                                            </td>
                                            <td style="width: 25%; min-width: 25%; max-width: 25%;">${voucher.voucherNum}</td>
                                            <td id="<fmt:formatNumber type="number"   pattern="##.##" minFractionDigits="2" value="${voucher.price}" />"
                                                style="min-width: 8%; max-width: 8%;"><fmt:formatNumber
                                                    value="${voucher.price}" type="currency"/></td>
                                            <td style="width: 29%;min-width: 29%; max-width: 29%;">${voucher.voucherName}</td>
                                            <%--<td style="width: 9%; min-width: 9%; max-width: 9%;">--%>
                                                <%--<c:choose>--%>
                                                    <%--<c:when test="${voucher.type == 1}">--%>
                                                        <%--代金券--%>
                                                    <%--</c:when>--%>
                                                <%--</c:choose>--%>
                                            <%--</td>--%>
                                            <td style="width: 30%;min-width: 30%; max-width: 30%;">
                                                <fmt:formatDate pattern="yyyy/MM/dd"
                                                                value="${voucher.ctime}"/>-<fmt:formatDate
                                                    pattern="yyyy/MM/dd" value="${voucher.expireDate}"/>
                                            </td>
                                        </tr>
                                    </c:when>
                                    <c:otherwise>
                                        <tr>
                                            <td style="width: 8%;min-width: 8%; max-width: 8%;"><input type="radio"
                                                                                                       class="alyes"
                                                                                                       name="select-voucher"
                                                                                                       id="${voucher.voucherNum}"/>
                                            </td>
                                            <td style="width: 25%; min-width: 25%; max-width: 25%;">${voucher.voucherNum}</td>
                                            <td id="<fmt:formatNumber type="number"  pattern="##.##" minFractionDigits="2" value="${voucher.price}" />"
                                                style="min-width: 8%; max-width: 8%;"><fmt:formatNumber
                                                    value="${voucher.price}" type="currency"/></td>
                                            <td style="width: 29%;min-width: 29%; max-width: 29%;">${voucher.voucherName}</td>
                                            <%--<td style="width: 9%; min-width: 9%; max-width: 9%;">--%>
                                                <%--<c:choose>--%>
                                                    <%--<c:when test="${voucher.type == 1}">--%>
                                                        <%--代金券--%>
                                                    <%--</c:when>--%>
                                                <%--</c:choose>--%>
                                            <%--</td>--%>
                                            <td style="width: 30%;min-width: 30%; max-width: 30%;">
                                                <fmt:formatDate pattern="yyyy/MM/dd"
                                                                value="${voucher.ctime}"/>-<fmt:formatDate
                                                    pattern="yyyy/MM/dd" value="${voucher.expireDate}"/>
                                            </td>
                                        </tr>
                                    </c:otherwise>
                                </c:choose>
                            </c:forEach>
                            <c:if test="${usedVoucher != null}">
                                <tr id="used-voucher-tr"  style="display: none">
                                    <td style="width: 25%; min-width: 25%; max-width: 25%;">${usedVoucher.voucherNum}</td>
                                    <td id="<fmt:formatNumber type="number"  pattern="##.##" minFractionDigits="2" value="${usedVoucher.price}" />"
                                        style="min-width: 8%; max-width: 8%;"><fmt:formatNumber
                                            value="${usedVoucher.price}" type="currency"/></td>
                                    <td style="width: 25%;min-width: 25%; max-width: 25%;">${usedVoucher.voucherName}</td>
                                    <td style="width: 9%; min-width: 9%; max-width: 9%;">
                                        <c:choose>
                                            <c:when test="${usedVoucher.type == 1}">
                                                代金券
                                            </c:when>
                                        </c:choose>
                                    </td>
                                    <td style="width: 25%;min-width: 25%; max-width: 25%;">
                                        <fmt:formatDate pattern="yyyy/MM/dd"
                                                        value="${usedVoucher.ctime}"/>-<fmt:formatDate
                                            pattern="yyyy/MM/dd" value="${usedVoucher.expireDate}"/>
                                    </td>
                                </tr>
                            </c:if>
                        </table>
                    </div>
                    <c:if test="${fn:length(voucherList) > 3}">
                        <div class="whole"><a class="even-more">更多优惠券></a></div>
                    </c:if>
                    <div class="whole"><a class="watch-listBtn">确定</a></div>


                </div>
            </div>
            <%--弹窗代码--%>
            <%--<div class="reply-all" style="display: none;">
            <div class="reply">
                <div class="reply-top">
                    选择优惠券<a class="replyTop-right"></a>
                </div>
                <div class="Farme">
                    <div>
                        <table class="watch-head" style="width: 100%; border-bottom: 1px solid #cccccc;">
                            <tr>
                                <td style="width: 8%; min-width: 8%; max-width: 8%;">选择</td><td style="width: 25%; min-width: 25%; max-width: 25%;">优惠券号</td><td style="width: 8%; min-width: 8%; max-width: 8%;">金额</td><td style="width: 25%; min-width: 25%; max-width: 25%;">券名</td><td style="width: 9% min-width: 9%; max-width: 9%;">券类型</td><td style="min-width: 25%; max-width: 25%;width: 25%;">有效期</td>
                            </tr>
                        </table>
                        <div style="height: 220px;overflow: auto;">
                        <table class="watch-list" id="alertlist" style="width: 100%;">
                            <c:forEach items="${voucherList}" var="voucher" >
                                <tr>
                                    <td style="min-width: 8%; max-width: 8%;width: 8%;"><input type="radio" name="select-voucher" id="${voucher.voucherNum}"/> </td>
                                    <td style="min-width: 25%; max-width: 25%;width: 25%;">${voucher.voucherNum}</td>
                                    <td id="<fmt:formatNumber type="number"  pattern="##.##" minFractionDigits="2" value="${voucher.price}" />" style="min-width: 8%; max-width: 8%;"><fmt:formatNumber value="${voucher.price}" type="currency"/></td>
                                    <td style="min-width: 25%; max-width: 25%;width: 25%;">${voucher.voucherName}</td>
                                    <td style="min-width: 9%; max-width: 9%;width: 9%;">
                                        <c:choose>
                                            <c:when test="${voucher.type == 1}">
                                                代金券
                                            </c:when>
                                        </c:choose>
                                    </td>
                                    <td style="min-width: 25%; max-width: 25%;width:25%;">
                                        <a class="TimeLeft"><fmt:formatDate pattern="yyyy/MM/dd"  value="${voucher.ctime}" /></a><a class="TimeRight">-<fmt:formatDate pattern="yyyy/MM/dd" value="${voucher.expireDate}" /></a>
                                    </td>
                                </tr>
                            </c:forEach>
                        </table>
                    </div>
                </div>
                <div class="whole"><a class="alert-listBtn">确定</a></div>
            </div>
                </div>--%>

            <%--弹窗代码over--%>
            <%--选中之后代码--%>

            <%--选中之后代码--%>
        </div>
        <div class="favorable-bound jiesuan" style="display: none;">
            <p class="bound-title">优惠券</p>
            <p class="modificationFloat">使用了<span>1</span>张优惠券，金额<span id="selected-voucher-price">0</span>元。<a
                    id="modify" class="modification">修改</a><a id="cancel" class="modification" style="margin-left:10px">取消</a>
            </p>
            <div style="border: 1px solid #cccccc; margin-top: 15px;  background: #fffdee;">

                <table class="bound-list" style="width: 100%;">
                    <tr id="selected-voucher-tr">
                    </tr>
                </table>
            </div>
        </div>
        <div class="jiesuan">
            <p class="sum">套餐金额：<span><fmt:formatNumber type="number" pattern="##.##" minFractionDigits="2"
                                                        value="${order.costPrice}"/></span>元</p>
            <p class="reduce">优惠券减免：<span id="voucher-sub-price">0</span>元</p>
            <p class="jine">应付金额：<span id="pay-price"><fmt:formatNumber value="${order.costPrice}"
                                                                        type="currency"/></span></p>
            <div class="mashang"><input type="submit" id="pay-btn" value="立即支付"/></div>
        </div>
    </div>

</div>
</div>
<!--弹窗-->
<div class="fkcg" id="pay-dialog">
    <div class="fknr">
        <div class="fknr-top">
            <span>请付款</span>
            <div onclick="layer.closeAll();" class="fknrgb"></div>
        </div>
        <div class="fktb">
            <img src="${basePath}/resources/common/images/jintan.png"/>
        </div>
        <p class="fkts">请在您新打开的页面上完成付款</p>
        <p class="fkwc">付款完成前请不要关闭此窗口，完成付款后请根据您的状况点击下面的按钮</p>
        <div class="leixing">
            <input onclick="location.href='${basePath}/userCenter#order';" type="button" value="已付款完成"
                   class="wancheng"/>
            <input onclick="layer.closeAll();$('#pay-btn').click();" type="button" value="重新支付" class="zflx"/>
            <input onclick="layer.closeAll();" type="button" value="其他支付类型" class="zflx"/>
        </div>
    </div>
</div>



<!--弹窗-->
<div class="fkcg"id="pay-refresh">
    <div class="fknr">
        <div class="fknr-top">
            <span>页面失效提示</span>
            <div onclick="layer.closeAll();" class="fknrgb"></div>
        </div>
        <div class="fktb">
            <img src="${basePath}/resources/common/images/jintan.png"/>
        </div>
        <p class="fkts">当前页面已经失效，请刷新后重试</p>
        <p class="fkwc"></p>
        <div class="leixing" style="margin-top: 50px;">
            <%--<input onclick="location.href='${basePath}/userCenter#order';" type="button" value="已付款完成"--%>
                   <%--class="wancheng"/>--%>
            <input id="on-refresh" type="button" value="立即刷新" class="zflx" style="margin-left: 0px;float: none; display: block; margin: 0px auto;"/>
            <%--<input onclick="layer.closeAll();" type="button" value="其他支付类型" class="zflx"/>--%>
        </div>
    </div>
</div>

<script>
    var price = ${order.costPrice};
    var voucherNum, payPrice;
    var hasPlan = false;

    $(function () {
        var data = {
            directionId: '${did}',
            industryId: '${iid}',
            positionId: '${pid}'
        }

        if (data.directionId != '' && data.industryId != '' && data.positionId != '') {
            hasPlan = true;
        }

        $('#pay-btn').click(function () {
            if (payPrice < 0) {
                layer.alert('支付金额错误!');
                return;
            } else if (payPrice == 0) {
                $('#pay-btn').prop('disabled', true);
                $('#pay-btn').val('正在支付');
                $.post('${basePath}/order/paid', {orderNum: '${order.orderNum}'})
                        .done(function (result) {
                            if (result.success) {
                                location.href = '${basePath}/userCenter#order';
                            } else {
                                $.post('${basePath}/pay/voucher', {orderNum: '${order.orderNum}', voucherNum: voucherNum}).done(function (result) {
                                    if (result.success) {
                                        if (hasPlan) {
                                            $.post('${basePath}/plan/save', data);
                                        }
                                        location.href = '${basePath}/userCenter#order';
                                    } else {
                                        layer.alert('支付失败，请稍后再试！');
                                    }
                                });
                            }
                        });
            } else {
                var $radio = $('input:radio:checked');
                var payType = $radio.val();
                var url = '${basePath}/pay/' + payType + '?orderNum=${order.orderNum}';
                if ($radio.attr('id')) {
                    url = '${basePath}/pay/tenpay?orderNum=${order.orderNum}&bank_type_value=' + payType;
                }
                layer.open({
                    offset: '50%',
                    type: 1,
                    closeBtn: 1,
                    shadeClose: true,
                    content: $('#pay-dialog')
                });
                window.open(url);

                var query = setInterval(function () {

                    $.post('${basePath}/order/paid', {orderNum: '${order.orderNum}'})
                            .done(function (result) {
                                if (result.success) {
                                    if (hasPlan) {
                                        $.post('${basePath}/plan/save', data);
                                    }
                                    clearInterval(query);
                                }
                            });
                }, 1000);
            }
        });


    });

</script>
<script type="text/javascript">
    var variable;
    var extyq = 1;
    var orderVoucherNum = '${order.voucherNum}';
    $(".flexible-btn").click(function () {

        if (extyq % 2 == 0) {
            $(".contract").slideUp("slow")
            $(".flexible-btn").css("background", "url(../../../resources/common/images/jiahao.png) no-repeat center center").text("");
        } else {
            $(".contract").slideDown("slow")
            $(".flexible-btn").css("background", "#f8c208").css("width" ,"40px").css("height","20px").css("border-radius","4px").css("color","#171717").css("text-align","center").css("font-size","10px").css("line-height","20px").css("margin-top","0").text("取消")
            }
        extyq++;
    });
    $("#list-over input").change(function () {
        var g = $("#list-over input").index(this);
        for (i = 0; i < $("#list-over input").length; i++) {
            if (i == g) {
                $("#list-over tr").eq(i).css("background", "#fffdee");
                $("#list-over input").eq(i).prop("checked", true);
            }
            else {
                $("#list-over tr").eq(i).css("background", "#fff");
                $("#list-over input").eq(i).prop("checked", false);
            }
        }
    })

    $(".even-more").click(function () {
        $(".DisAll").css("overflow", "auto");
        $(".even-more").css("display", "none");
        variable = 0;
    })
    $(".replyTop-right").click(function () {
        $(".reply-all").css("display", "none")
    })
    $(".watch-listBtn").click(function () {
        onSelectedVoucher();
    });
    $("#modify").click(function () {
        $(".favorable").css("display", "block");
        $(".favorable-bound").css("display", "none");
        if (variable == 0) {
            $(".DisAll").css("overflow", "auto");
            $(".even-more").css("display", "none");
        } else {
            $(".DisAll").css("overflow", "hidden");
            $(".even-more").css("display", "block");
        }
    });

    $("#cancel").click(function () {
        $.post('/order/voucher/cancel', {orderNum: '${order.orderNum}'}).done(function (result) {
            if(result.success){
                $(".favorable").css("display", "block");
                $(".favorable-bound").css("display", "none");
                $(".flexible-btn").css("background", "url(../../../resources/common/images/jiahao.png) no-repeat center center");
                $('.contract').hide();
                $('#voucher-sub-price').html(0);
                payPrice = price;
                $('#pay-price').html('￥' + payPrice);
                $('input:radio[name=select-voucher]:checked').removeProp('checked');
                extyq++;
            }
        });
    });

    $("#alertlist input").change(function () {
        var e = $("#alertlist input").index(this);
        for (j = 0; j < $("#alertlist input").length; j++) {
            if (j == e) {
                $("#alertlist tr").eq(j).css("background", "#fffdee");
                $("#alertlist input").eq(j).prop("checked", true);
            }
            else {
                $("#alertlist tr").eq(j).css("background", "#fff");
                $("#alertlist input").eq(j).prop("checked", false);
            }
        }
    })
    /* $(".alert-listBtn").click(function () {
     onSelectedVoucher();
     });
     */
    <c:if test="${fn:length(voucherList) > 0}">
    $(".flexible-btn").click();
    </c:if>
    function onSelectedVoucher() {
        var $radio = $('input:radio[name=select-voucher]:checked');
        if ($radio.length == 0) {
            layer.alert('请选择优惠券!', {offset: '45%'});
            return;
        }
        voucherNum = $radio.attr('id');
        if (orderVoucherNum == voucherNum){//重复使用同一优惠券
            closeList($radio);
        }else{
            $.post('/order/voucher/use', {orderNum: '${order.orderNum}', voucherNum: voucherNum})
                    .done(function (result) {
                        if (result.success) {
                            closeList($radio);
                        }else{
                            //如果ELSE,可能优惠券不存在或已被使用~
                            //显示错误信息
                            console && console.log(result.message);
                            //弹出页面失效弹框
$("#pay-refresh").css("display","block")
                            //刷新页面
                            $("#on-refresh").click(function(){
                                location.reload();
                            })

                        }
                    });
        }
    }


    if (orderVoucherNum != ''){
        var $radio = $('#' + orderVoucherNum);
        closeList($radio);
        $radio.prop('checked', true);
    }

    /**
     * 收起订单列表，显示已选择优惠券信息
     */
    function closeList($radio) {
        var html = $($($radio.parent()).parent()).html();
        html = html.substring(html.indexOf('</td>'));
        $('#selected-voucher-tr').html(html);
        var voucherPrice = $($($radio.parent()).siblings('td')).get(1).id;
        $('#selected-voucher-price').html(voucherPrice);
        $('#voucher-sub-price').html(voucherPrice);
        payPrice = price - voucherPrice;
        $('#pay-price').html('￥' + payPrice);
        $('#selected-voucher-tr input').css("display","none")
        $(".reply-all").css("display", "none");
        $(".favorable").css("display", "none");
        $(".favorable-bound").css("display", "block");
    }

</script>
</body>
</html>
