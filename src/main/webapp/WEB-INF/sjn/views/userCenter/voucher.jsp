<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <link rel="stylesheet" href="/resources/userCenter/css/voucher.css">
  <link href="/resources/userCenter/css/order.css" rel="stylesheet">
    <link href="/resources-sjn/user/css/voucher.css" rel="stylesheet">
    <link href="/resources-sjn/user/css/index.css" rel="stylesheet">
  <script src="/resources/userCenter/js/user.js"></script>
  <script src="/resources/userCenter/js/messageClick.js"></script>
    <style>
        .use{color:#666;}
        .use_sy:hover{color:#333!important;}
    </style>
</head>
<body>
<div class="userRight fr">
  <div class="userR-title">
    <a class="userR-cur">我的优惠券</a>
  </div>
  <div class="userR-con">
    <div class="userR-zccount">
      <div style="display:block;overflow: hidden" id="hasVouchers">
          <c:set var="nowDate" value="<%=System.currentTimeMillis()%>"></c:set>
          <c:forEach var="voucher" items="${effectiveVoucherList}">
            <%--用EL表达式调用list对象的属性循环输出对象的各个属性值--%>
              <div class="${nowDate-voucher.expireDate.getTime() > 0?'ticket_gray':voucher.regulation
                            .replaceAll("30","ticket_yellow")
                            .replaceAll("90","ticket_red")
                            .replaceAll("360","ticket_blue")
                             .replaceAll(",", " ") }">
                <div class="monney"><span>￥</span>${voucher.price}</div>
                <div class="explain vou_color"><div class="explain-left">券号：</div><div>${voucher.voucherNum}</div></div>
                <div class="explain"><div class="explain-left"> 有效期：</div><div><fmt:formatDate value="${voucher.ctime}" pattern="yyyy/MM/dd"></fmt:formatDate>-<fmt:formatDate value="${voucher.expireDate}" pattern="yyyy/MM/dd"></fmt:formatDate></div></div>
                <div class="explain">
                    <div class="explain-left">使用规则：</div>
                    <div id="useRule">${voucher.regulationDesc}</div>
                </div>
                <div class="use use_sy" onclick="window.location.href='/vip'">立即使用</div>
              </div>
          </c:forEach>
            <c:forEach var="voucher" items="${invalidVoucherList}">
                <%--用EL表达式调用list对象的属性循环输出对象的各个属性值--%>
                <div class="ticket_gray">
                    <div class="monney"><span>￥</span>${voucher.price}</div>
                    <div class="explain" style="color: #ffffff;"><div class="explain-left">券号：</div><div>${voucher.voucherNum}</div></div>
                    <div class="explain"><div class="explain-left"> 有效期：</div><div><fmt:formatDate value="${voucher.ctime}" pattern="yyyy/MM/dd"></fmt:formatDate>-<fmt:formatDate value="${voucher.expireDate}" pattern="yyyy/MM/dd"></fmt:formatDate></div></div>
                    <div class="explain">
                        <div class="explain-left">使用规则：</div>
                        <div>${voucher.regulationDesc}
                        </div>
                    </div>
                    <div class="overdue">已过期</div>
                </div>
            </c:forEach>
        <c:if test="${empty effectiveVoucherList && empty invalidVoucherList}">

          <div class="userR-twnone">
            <img src="../../../resources/userCenter/images/noPic.png" width="160">
             <p>暂无优惠券</p>
          </div>
        </c:if>


      </div>
    </div>
  </div>
    <div style="height: 50px;"></div>
</div>
</body>
</html>
