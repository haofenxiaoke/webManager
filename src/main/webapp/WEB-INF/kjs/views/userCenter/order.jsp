<%--
  Created by IntelliJ IDEA.
  User: chaishuxiang
  Date: 2016/7/6 0006
  Time: 上午 10:16
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="zh">
<head>
  <link href="/resources/userCenter/css/order.css" rel="stylesheet">
  <script src="/resources/userCenter/js/user.js"></script>
  <script src="/resources/userCenter/js/order.js"></script>
  <script src="/resources/userCenter/js/messageClick.js"></script>
</head>
<body>
<input type="hidden" value="${user.userid}" id="userid">
<input type="hidden" id="vipid" value="${userVip.vipId}">
<div class="userRight fr">
  <div class="userR-title">
    <a class="userR-cur">订单管理</a>
  </div>
  <div class="userR-con">
    <div class="userR-zccount">
      <div style="display:block">
        <div class="h30"></div>
        <div class="studyZl" id="orders">
          <%--<table class="orderTable" >
            <thead>
            <tr height="45">
              <td style="width: 30%">订单详情</td>
              <td style="width: 20%">金额</td>
              <td style="width: 20%">订单状态</td>
              <td style="width: 20%;border-right:1px solid #e0e0e0;">操作</td>
            </tr>
            </thead>
            <tr class="borR">
              <td >会计狮会员三个月</td>
              <td >￥2450</td>
              <td>
                <p>待支付</p>
                <a>订单详情</a>
              </td>
              <td >
                <a class="btn70">立即支付</a>
                <a>取消订单</a>
              </td>
            </tr>
            <tr class="borB">
              <td colspan="4" style="text-align: left;">
                <span>订单号:1218098210980</span>
                <span>下单时间:2016-6-23 09:50:33</span>
              </td>
            </tr>
          </table>
          <table class="orderTable" >
            <thead>
            <tr height="45">
              <td style="width: 30%">订单详情</td>
              <td style="width: 20%">金额</td>
              <td style="width: 20%">订单状态</td>
              <td style="width: 20%;border-right:1px solid #e0e0e0;">操作</td>
            </tr>
            </thead>
            <tr class="borR">
              <td >会计狮会员三个月</td>
              <td >￥2450</td>
              <td>
                <p>待支付</p>
                <a>订单详情</a>
              </td>
              <td >
                <a class="btn70">立即支付</a>
                <a>取消订单</a>
              </td>
            </tr>
            <tr class="borB">
              <td colspan="4" style="text-align: left;">
                <span>订单号:1218098210980</span>
                <span>下单时间:2016-6-23 09:50:33</span>
              </td>
            </tr>
          </table>--%>


        </div>
        <!--<div class="userR-twnone">-->
        <!--<img src="../../../resources/userCenter/images/noPic.png" width="160">-->
        <!--<p>您还没有购买学习课程<br>赶快去选<a>课程</a>吧</p>-->
        <!--</div>-->
      </div>
    </div>
  </div>
</div>
</body>
</html>
