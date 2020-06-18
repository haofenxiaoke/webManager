<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="zh">
<head>
  <meta charset="UTF-8">
  <title>学习计划</title>
  
  <link href="/resources/common/css/rest.css" rel="stylesheet">
  <script>document.write("<link rel='stylesheet' href='/resources/userCenter/css/user.css?time="+Math.random()+"'>")</script>
  <!-- <link href="/resources/userCenter/css/user.css" rel="stylesheet"> -->
  <link href="/resources/index/css/kjs-index.css" rel="stylesheet">
  <link href="/resources/common/plugins/bootstrap/css/bootstrap.css" rel="stylesheet"/>
  <link href="/resources/common/plugins/bootstrap-daterangepicker/daterangepicker-bs3.css" rel="stylesheet"/>
  <script src="/resources/common/plugins/bootstrap/js/bootstrap.min.js"></script>
  <script src="/resources/common/plugins/bootstrap-daterangepicker/moment.min.js"></script>
  <script src="/resources/common/plugins/bootstrap-daterangepicker/daterangepicker.js"></script>
  <style type="text/css">
    .scSeeO a{color: #fff !important;}
    .scSeeO a:hover{color: #fff !important;}
    .old{width: 5px; height: 9px; margin:0px 0px 3px 3px;}
    .FloatOn1{ position: fixed;top: 310px;left: 15px; z-index: 98;display: none;}
    .FloatOn{ position: fixed;top: 310px;left: 15px; z-index: 98;}
  </style>
</head>
<body>
<input type="hidden" id="vipid" value="${user.vipId}" vip="${SESSION_USER.vipId}">

<div class="kjs clearfloat mt20" style="height: auto">
  <div class="userLeft fl" style="height: 130%">
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
      <div class="userLt-time"><fmt:formatDate value="${user.registTime}" pattern="yyyy-MM-dd"></fmt:formatDate>&nbsp;加入好分小课<!-- <a  href="/vip">权限说明</a> --></div>
      <%--<c:if test="${vipEndTime!=null}"> <div class="userLt-time">会员到期：&nbsp;<fmt:formatDate value="${vipEndTime}" pattern="yyyy-MM-dd"></fmt:formatDate>&nbsp;</div></c:if>--%>

    </div>
    <!--list-->
    <ul class="userL-list">
<!--       <li ><a id="studyPlan">学习计划&nbsp;&nbsp;&nbsp;&nbsp;</a></li> -->
    <!--   <li><a id="okCourseCode">已兑换课程</a></li> -->
 <!--      <li><a id="courseCode">课程码&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</a></li> -->
      <li><a id="playRecord" class="userL-cur">播放记录&nbsp;&nbsp;&nbsp;&nbsp;</a></li>
      <%--<li><a id="index-3">我的提问</a></li>--%>
      <%-- <li style="position: relative;"><a id="question">我的提问&nbsp;&nbsp;&nbsp;&nbsp;</a><c:if test="${unReadQuestionClass == true}"><span class="message-red-radius"></span></c:if></li> --%>
      <li><a id="order" >订单管理&nbsp;&nbsp;&nbsp;&nbsp;</a></li>
      <li><a id="safeSet" >账户管理&nbsp;&nbsp;&nbsp;&nbsp;</a></li>
      <li style="position: relative;"  ><a id="message">消息管理&nbsp;&nbsp;&nbsp;&nbsp;</a><c:if test="${unReadMsgClass == true}"><span class="message-red-radius"></span></c:if></li>
      <li><a id="voucher" >优惠券&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</a></li>
    </ul>
  </div>
  <div id="page-right"></div>
</div>
<script>

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
      document.title = this.innerHTML.replace(/&nbsp;/ig, "");
      var id = this.id;
      var url = '/userCenter/right/' + id+"?t="+(new Date).valueOf();
      //加载右侧
      loadCallBack(url);
      window.location.hash = id;
      $(window).scrollTop(0);
    });
    //判断是否是需要加载订单页面，如果不是的话进页面后先加载学习计划页面
    (window.location.hash == '#order' &&   $("#order").click()) ||
    (window.location.hash == '#safeSet' &&   $("#safeSet").click()) || $("#playRecord").click();
  });

  function loadCallBack(url){
    layer.load(2,{offset:  ['100px', '1000px']});//开启菊花
    $.get(url).done(function (html) {
      layer.closeAll('loading');//关闭菊花
      if (html.indexOf('index-page') != -1) { //Session 失效时，自动刷新跳转未登录页面，替代AJAX查询isLogin()接口
        location.reload();
      } else {
        $('#page-right').html(html);
        $(window).scrollTop(0);
      }
    }).fail(function () {
      layer.alert('服务器很忙，请稍后再试！');
    }).always(function () {
      layer.closeAll('loading');//关闭菊花
    });
  }
</script>
<script language="javascript" type="text/javascript">
  NTKF_PARAM = {
    siteid: "kf_9751",              //企业id
    settingid: "kf_9751_1431594125839",           //应答客服组id，在客户端生成代码界面创建
    uid: "${SESSION_USER.id!=''?SESSION_USER.id:''}",                //用户id，登录用户必填，游客为空字符串
    uname: "${SESSION_USER.displayName!=''?SESSION_USER.displayName:''}",             //用户名，登录用户必填，游客为空字符串
    isvip: "0",            //是否为vip用户，登录用户可选，游客为"0"
    userlevel: ""   //网站用户级别，登录用户可选，游客不填
  }
</script>
<script type="text/javascript" src="http://dl.ntalker.com/js/xn6/ntkfstat.js?siteid=kf_9751" charset="utf-8"></script>
<script type="text/javascript">
  var consultDate ={pageNo:7};
//  $(function(){
//    var vip =$("#vipid").attr("vip") ;
//      $(".sb-close").click(function(){
//          $(".FloatOn").css("display","none")
//          $(".FloatOn1").css("display","none")
//        setCookie("close_xn_index", "yes", "xn")
//      })
//
//
//
//    if(getCookie("close_xn_userCenter_index")!="yes"){
//      $(".FloatOn").css("display","block")
//      /*$(".FloatOn1").css("display","block")*/
//      if (vip == 1 || vip == 2 || vip == 3) {
//        $(".FloatOn1").css("display","none")
//      }else{
//        $(".FloatOn1").css("display","block")
//      }
//    }else{
//      $(".FloatOn").css("display","none")
//      $(".FloatOn1").css("display","none")
//    }
//
//
//
//
//  });
/*
  $(".too-consult").click(function(){
    var datas ={pageNo:7};
    $.ajax({
      type: "POST",
      url:'/consult/detail',
      data:datas,
      success: function(result) {
        if (result.success) {
          if(${SESSION_USER.id!=''}){
            NTKF.im_openInPageChat(result.data.rightUrl);
          }else{
            NTKF.im_openInPageChat(result.data.groupUrl);
          }

        }
      }
    });

  })
*/

  //设置cookie
  function setCookie(cname, cvalue, exdays) {
    var tme = new Date();
    var ty = tme.getFullYear(); //获取完整的年份(4位,1970-????)
    var tm = tme.getMonth()+1; //获取当前月份(0-11,0代表1月)
    var td = tme.getDate();
    var thour = tme.getHours();
    var tmin= tme.getMinutes();
    var tmiao = tme.getSeconds();
    var ttt=exdays*(86400-(thour*60*60+tmin*60+tmiao))*1000
    var d = new Date();
    if(exdays == "xn"){
      d.setTime(d.getTime() + 60*1000);
    }else{
      d.setTime(d.getTime() + ttt);
    }
    var expires = "expires="+d.toUTCString();
    document.cookie = cname + "=" + cvalue + "; " + expires;
  }
  //获取cookie
  function getCookie(cname) {
    var name = cname + "=";
    var ca = document.cookie.split(';');
    for(var i=0; i<ca.length; i++) {
      var c = ca[i];
      while (c.charAt(0)==' ') c = c.substring(1);
      if (c.indexOf(name) != -1) return c.substring(name.length, c.length);
    }
    return "";
  }
  //清除cookie
  function clearCookie(name) {
    setCookie(name, "", -1);
  }
  function checkCookie() {
    var user = getCookie("username");
    if (user != "") {
      alert("Welcome again " + user);
    } else {
      user = prompt("Please enter your name:", "");
      if (user != "" && user != null) {
        setCookie("username", user, 365);
      }
    }
  }


</script>
</body>
</html>