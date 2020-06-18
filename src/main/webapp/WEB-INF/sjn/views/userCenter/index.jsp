<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>学习计划</title>
  <link href="/resources/common/css/rest.css" rel="stylesheet">
  <link href="/resources/userCenter/css/user.css" rel="stylesheet">
  <link href="/resources/index/css/kjs-index.css" rel="stylesheet">
  <link href="/resources-sjn/user/css/index.css" rel="stylesheet"/>
  <link href="/resources/common/plugins/bootstrap/css/bootstrap.css" rel="stylesheet"/>
  <link href="/resources/common/plugins/bootstrap-daterangepicker/daterangepicker-bs3.css" rel="stylesheet"/>
  <script src="/resources/common/plugins/bootstrap/js/bootstrap.min.js"></script>
  <script src="/resources/common/plugins/bootstrap-daterangepicker/moment.min.js"></script>
  <script src="/resources/common/plugins/bootstrap-daterangepicker/daterangepicker.js"></script>
</head>
<body>
<input type="hidden" id="vipid" value="${user.vipId}">
<div class="kjs clearfloat mt30">
  <div class="userLeft fl">
    <!--头像-->
    <div class="userLtop">
      <div class="userLt-tx">
        <c:choose>
          <c:when test="${empty user.imgurl}">
            <img src="/resources/common/images/photo.jpg">
          </c:when>
          <c:otherwise>
            <img  src="${user.imgurl}">
          </c:otherwise>
        </c:choose>
      </div>
      <div class="userLt-name" id="vipLevel">
        <span id="pageUserName">
          <c:choose>
            <c:when test="${fn:length(SESSION_USER.displayName)>12 }">
              ${ fn:substring(SESSION_USER.displayName,0,13)}...
            </c:when>
            <c:otherwise>
              ${SESSION_USER.displayName}
            </c:otherwise>
          </c:choose>
        </span>
        <i class="restIcon " ></i>
      </div>
      <div class="userLt-time"><fmt:formatDate value="${user.registTime}" pattern="yyyy-MM-dd"></fmt:formatDate>&nbsp;加入设计牛<a  href="/vip">权限说明</a></div>
      <%--<c:if test="${vipEndTime!=null}"> <div class="userLt-time">会员到期：&nbsp;<fmt:formatDate value="${vipEndTime}" pattern="yyyy-MM-dd"></fmt:formatDate>&nbsp;</div></c:if>--%>

    </div>
    <!--list-->
    <ul class="userL-list">
      <li class="userL-cur"><a id="studyPlan">学习计划</a></li>
      <li><a id="playRecord">播放记录</a></li>
      <li style="position: relative;"><a id="question">我的提问</a><c:if test="${unReadQuestionClass == true}"><span class="message-red-radius"></span></c:if></li>
      <li><a id="safeSet" >账户管理</a></li>
      <li><a id="order" >订单管理</a></li>
      <li style="position: relative;"  ><a id="message">消息管理</a><c:if test="${unReadMsgClass == true}"><span class="message-red-radius"></span></c:if></li>
      <li><a id="voucher" >优惠券&nbsp;&nbsp;&nbsp;&nbsp;</a></li>
    </ul>
  </div>
  <div id="page-right"></div>
</div>
<script type="text/javascript">
  var consultDate ={pageNo:7};
  $(function () {
    var vipId=$("#vipid").val()+'';
    var level='userLt-name';
    if(vipId!=null && vipId!=''){
      if(vipId=='1'){
        level+="-month";
      }
      if(vipId=='2'){
        level+="-season";
      }
      if(vipId=='3'){
        level+="-year";
      }
      var vipLevel=$("#vipLevel");
      vipLevel.attr("class",level);
    }
    //绑定Click事件
    $('.userL-list a').click(function () {
      //更换当前Active CSS
      var $li = $(this).parent();
      $li.addClass('userL-cur');
      $li.siblings().removeClass('userL-cur');
      //更换标题
      document.title = this.innerHTML.replace('&nbsp;&nbsp;&nbsp;&nbsp;','');
      var id = this.id;
      var url = '/userCenter/right/' + id+"?t="+(new Date).valueOf();
      //加载右侧
      loadCallBack(url);
      window.location.hash = id;
      $(window).scrollTop(0);
    });
    //判断是否是需要加载订单页面，如果不是的话进页面后先加载学习计划页面
    (window.location.hash == '#order' &&   $("#order").click()) ||
    (window.location.hash == '#safeSet' &&   $("#safeSet").click()) || $("#studyPlan").click();
  });

  function loadCallBack(url){
    layer.load(2,{offset:  ['100px', '1000px']});//开启菊花
    $.get(url).done(function (html) {
      layer.closeAll('loading');//关闭菊花
      if (html.indexOf('index-page') != -1) { //Session 失效时，自动刷新跳转未登录页面，替代AJAX查询isLogin()接口
        location.reload();
      } else {
        $('#page-right').html(html);
       // $(window).scrollTop(0);//初始化滚动条置顶
      }
    }).fail(function () {
      layer.alert('服务器很忙，请稍后再试！');
    }).always(function () {
      layer.closeAll('loading');//关闭菊花
    });
  }
</script>
</body>
</html>