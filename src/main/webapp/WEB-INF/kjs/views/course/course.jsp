<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.Date" %>
<%@ page import="com.kjs.common.bean.Constants" %>
<%@ page import="com.kjs.orm.model.UserStu" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<html lang="zh">
<head>
  <meta charset="UTF-8">
  <title>全部课程-好分课堂</title>
  <link href="${basePath}/resources/common/css/rest.css" rel="stylesheet">
  <link href="/resources/common/css/index.css" rel="stylesheet">
  <link href="${basePath}/resources/course/css/gap.css" rel="stylesheet"/>
  <link href="${basePath}/resources/index/css/kjs-index.css" rel="stylesheet">
  
     <script src="${basePath}/resources/common/js/jquery-1.9.1.js"></script>
    <script src="${basePath}/resources/common/layer-v2.3/layer/layer.js"></script>
    <script src="${basePath}/resources/common/js/jquery.cookie.js"></script>
    <script src="${basePath}/resources/common/js/utils.js"></script>
    <script src="${basePath}/resources/course/js/course.js"></script>
<style type="text/css">
  .kjsPf{top: 8px !important;}
</style>
</head>
<body>
<input type="hidden" id="is-vip" name="is-vip" value="${userStu.isVIP}">
<input type="hidden" id="direction-id" name="direction-id" value="${industryId}">
<input type="hidden" id="position-id" name="position-id" value="${positionId}">

	<% System.out.println("positions= " + pageContext.findAttribute("positions") ); %>
<!-- 顶部 -->

<div class="top">
        <div class="top-wrap">
            <!-- 左边图片 -->
            <div class="title_img">
                <a href="${basePath}/"><img src="/resources/common/images/u138.png" alt=""></a>
            </div>
            <!-- 右边分类 -->
            <div class="title_nav">
                <!-- 选择课程 -->
                <div class="nav_text" id="chose_title">
                <div class="yellow_sku">
                <span id="pos_title"></span>
                    <img src="/resources/common/images/xialav.png" alt="">
                    </div>
                    <div class="wrapw">
                    <div class="top_list" id="top_list">
                    	<c:forEach items="${directions}" var="dire">
                        <ul class="list_content">
                            <li class="list_content_tou">${dire.categoryDesc}</li>
                            <c:forEach items="${dire.positions}" var="position">
                            <a href="${basePath}/course?directionId=${dire.id}&positionId=${position.id}" style="color:#9a9e9f;" class="a_list">
								<li class="list_sm" data-id="${position.id}">
							${position.categoryDesc}
							</li>
							</a>
							</c:forEach>
                            
                        </ul>
						</c:forEach>
                    </div>
                </div>
                </div>
                <div class="nav_text">公众号
                	<div class="ewm ewm_hidd">
                    	<div class="erweima ewm1">
                    			<img src="/resources/common/images/kuaiji_ewm.jpg">
                    		<div class="ewm_title">会计资料信息库</div>
                    	</div>
                    	<div class="erweima ewm2">
                    		<img src="/resources/common/images/jiaozi_ewm.jpg">
                    		<div class="ewm_title">教师资格信息资料库</div>
                    	</div>
                    </div>
                </div>
                <div class="nav_text">小程序
                 <div class="erweima_xcx ewm_hidd erweima">
                 	<img src="/resources/common/images/xcx_yuan.jpg">
                 	<div class="ewm_title">好分小课</div>
                 </div> 

                </div>
                <div class="nav_text">APP
                   <div class="erweima erweima_xcx ewm_hidd" style="margin-left: -36px">
                   	<div style="text-align: center;">敬请期待！</div>
                   </div> 
                   

                </div>
                <div class="nav_text"><a a href="${basePath}/vip" style="color:#343635">会员</a></div>
               <shiro:guest>
				<div class="nav_text"><a onclick="Util.User.login(function() { location.reload();});" style="color:#343635">登录</a></div>
            	</shiro:guest>
            <shiro:user>
                	<div class="head_login" style="margin-left: 65px;">
                        <div class="head_login_img" style="float: left; cursor: pointer;">
                            <img src="${(SESSION_USER.imgurl == '' || SESSION_USER.imgurl == null)?'/resources/common/images/photo.jpg':SESSION_USER.imgurl}" alt="" width="40" height="40"  style="border-radius:50%; margin-top: 20px;"/>
                        </div>
                        <div style="margin-left: 45px; line-height: 80px; height: 80px">
                            <a href="${basePath}/logout" style="color: #171717;font-size: 12px;text-decoration: none;font-size: 16px;">退出</a>
 
                        </div>
                    </div>
                </shiro:user>
            </div>

        </div>
    </div>

<!-- 顶部 -->



<div style="min-width: 1648px">
<div class="live_kjs" style="background-color:#f7d078; width: 100%; min-width: 1648px;">




 <!-- 直播课程 -->
 <div class="live_list">
            <ul id="live_list_ul">
            <c:forEach items="${liveSets}" var="course" begin="0" end="2" varStatus="live_index">
            
                <li class="live_info" endId="${course.id}" endzt="${course.livingFlag}"　liveId="${course.id}" endtype="${course.liveType}" data-id="${live_index.index}">
                   <a href="${basePath}/live/reviewLive/${course.id}"  target="_blank">
                    <div class="live_info_wrap" data-id="${live_index.index}">
                        <div class="top_info" data-id="${live_index.index}">
                            <div class="top_info_left">
                                <div class="point"></div>
                                <div class="class_info" data-id="${live_index.index}">${course.directionName}</div>
                            </div>
                            <div class="top_info_right" data-id="${live_index.index}">
                                <!-- <img src="./wjump.gif" alt=""> -->
                            </div>
                        </div>

                        <div class="mid_content"  title="${course.liveTitle}" data-id="${live_index.index}">
                            <c:choose><c:when test="${fn:length(course.liveTitle) > 10}">${fn:substring(course.liveTitle, 0, 9)}...</c:when><c:otherwise> ${course.liveTitle}</c:otherwise></c:choose>
                        </div>

                        <div class="bottom_live" data-id="${live_index.index}">
                            <div class="live_click" data-id="${live_index.index}">
                                点击进入直播间
                            </div>
                            <div class="teach_img" data-id="${live_index.index}">
                                <img src="${course.teacherUrl}" alt="" data-id="${live_index.index}">
                            </div>
                        </div>

                    </div>
                    </a>
                </li>
                
                </c:forEach>
            </ul>
        </div>

</div>

<div class="kjsCrWid" style="margin-top: 40px;">
 
  
  
  <!-- 视频课程 -->
  <div class="kjsCrouse" id="main">
    <ul class="clearfloat" id="c_list">
      <c:if test="${null==courses||courses.isEmpty()}" >
        <li style="text-align: center;width: 1224px;height: auto;color:#999;padding-bottom: 100px;">
          <div style="margin: 100px 0 50px 0;"><img src="/resources/course/images/zanwu_03.png"></div>
          课程正在准备中，敬请期待...
        </li>
      </c:if>
      <c:forEach items="${courses}" var="course"  varStatus="status">
          <li>
            <div class="kjsCimg" style="width: 270px; height:173px; position: relative;"><a href="${basePath}/course/play/${course.id}" target="_blank" style="width: 270px; height:173px;"><div class="mengban"></div><img src="${course.coverUrl}" > </a></div>
          </li>
      </c:forEach>
    </ul>
  </div>
</div>
</div>




<div class="kjs-fotter" style="border 1px solid black;">
    <div class="kjs-f-con">
        <div class="kjs-f-text clearfloat">
            <img src="${basePath}/resources/common/images/foter-logo.png" class="kjs-f-l" style="width:48px; height:48px;">
            <div class="kjs-f-c" style="height: 91px;">
                <div class="kjs-f-about" style="height: 20px;" >
                    <a href="${basePath}/help?m=5">关于我们</a>|
                    <a href="${basePath}/vip">会员服务</a>|
                    <a href="${basePath}/help?m=3&sm=3">隐私条款</a>|
                    <a href="${basePath}/help?m=3">用户协议</a>|
                    <a href="${basePath}/help">帮助中心</a>|
                    <a href="${basePath}/help?m=4">联系我们</a>|
                    <a href="${basePath}/help?m=2">意见反馈</a>|
                    <a href="http://www.duia.com" target="_blank">去对啊网</a>
                </div>
                <div class="kjs-f-bq" style="height: 20px;">
                    <span>Copyright@2016</span>
                    <span>北京入行教育科技有限公司版权所有</span>
                    <a href="http://www.miit.gov.cn/" target="_blank" style="margin-right: 20px; ">京ICP备16011120号-10</a>
                    <a href="http://www.miit.gov.cn/" target="_blank" style="margin-right: 20px;">京ICP证160803号</a>
                    <img style="margin-top: -3px; height: 20px; width: 20px;" src="/resources/index/images/picWb.png" />
                    <a target="_blank" href="http://www.beian.gov.cn/portal/registerSystemInfo?recordcode=11030102010060" "><span>京公网安备11030102010060号</span></a>
                </div>
                <div style="margin: 12px 8px 10px 9px;">
                    <a href="http://xwgdj.beijing.gov.cn/" target="_blank">出版物经营许可证（批发）新出发京批字第直170038号</a>
                </div>
            </div>
          <%--  <img src="${basePath}/resources/common/images/foter-ewm.png" class="kjs-f-r">--%>
        </div>
      <%--  <img src="${basePath}/resources/common/images/foter-wa.png" class="kjs-fo-tittle">--%>
        <%--<a class="kjs-fo-tittle"style="top: 0px;" key ="57a7f329efbfb00b583282a1"  logo_size="124x47"  logo_type="realname"  href="http://www.anquan.org" ><script src="//static.anquan.org/static/outer/js/aq_auth.js"></script></a>--%>
    </div>
</div>


<!-- 右侧内容  -->

<div class="righ_guding">
        <ul>
            <li class="gift_1 c_lqzl">
                <img src="/resources/common/images/gift.png" alt="">
            </li>
            <li>
                <div class="zaixianzixun bg_b bgh bg_y c_lqzl"><img src="/resources/common/images/zx.png" alt=""></div>
            </li>
            <li>
                <div class="gzh bg_b bgh"><img src="/resources/common/images/gzh.png" alt=""></div>
                <div class="double_ewm right_ewm">
                	<div class="d_ewm_1" style="border-right: 1px dashed black;">
                		<div class= "kj_ewm"></div>
                		<div class="ewm_content">会计资料信息库</div>
                	</div>
                	<div class="d_ewm_2">
                		<div class= "js_ewm"></div>
                		<div class="ewm_content" style=" margin-left: 152px">教师资格信息资料库</div>
                	</div>
                </div>
            </li>
            <li>
                <div class="sapp bg_b bgh"><img src="/resources/common/images/xcx.png" alt=""></div>
                <div class="right_ewm only_ewm">
                	<div class="d_ewm_1">
                		<div class= "xcx_ewm"></div>
                		<div class="ewm_content">好分小课</div>
                	</div>
                </div>
            </li>
            <li>
               <div class="app3 bg_b bgh"><img src="/resources/common/images/app.png" alt=""></div>
               <div class="right_ewm only_ewm_">
               	<div class="d_ewm_1">
                		<div class= "app_ewm">敬请期待!</div>
                		<div class="ewm_content"></div>
                	</div>
               </div>
            </li>
            <li class="rock c_lqzl">
                <img src="/resources/common/images/rock.png" alt="">
            </li>
        </ul>
    </div>

<!-- 右侧内容 -->

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
<script>Util.rightFloat();</script>
<script type="text/javascript">
var a = "${courses}"
function touchColor(dom) {
    var bg_y = document.getElementsByClassName("bg_y")
    for (var i = 0; i < bg_y.length; i++) {
        bg_y[i].classList.remove('bg_y');
    }
    dom.classList.add('bg_y')
}

var list= document.getElementsByClassName("righ_guding")[0].children[0].children

var list_content = document.getElementsByClassName("righ_guding")[0]
list_content.onmouseover = function (e) {
    var bg_y = document.getElementsByClassName("bgh")
    if (e.path[1].classList[2] == "bgh") {
        touchColor(e.target)
    }
}


var vip = $(".body").attr("vip");
var scUrl = $(".head_center").attr("mast")



function headScFun() {

    var ms =  $(".body").attr("testMobile")
    if(ms==""||ms==null){Util.User.login(function() {
        location.reload();
    });
        return false;
    }else{
        document.getElementById('head_window').click();
    }
}


$.ajax({
    type: "POST",
    url: "/practice/get/url",
    success: function (result) {
        if (result.success) {
            $("#window").attr('href',result.data.url1);
        }
    }
});
function scFun() {
    var ms =  $(".body").attr("testMobile")
    if(ms==""||ms==null){Util.User.login(function() {
        location.reload();
    });
    }else{
        document.getElementById('window').click();

    }
}



/* 在线咨询 */

var consultDate;
 var consultDetail;
 $(document).ready(function(){
    /* var datas ={pageNo:1};*/
     $.ajax({
         type: "POST",
         url:'/consult/detail',
         data:consultDate,
         success: function(result) {
             consultDetail=result.data

             if (result.data.leftUrl!=null &&getCookie("close")!="yes"&&vip==0) {
                 var t = '<a><img src='+result.data.imgUrl+'></a>'
                 
                 $("#vipTxt4i").css("display","block")
             }else{
             
                 $("#vipTxt4i").css("display","none")
             }
             if (result.data.rightUrl!=null) {
                 $("#qqxn").css("display","block")
             }else{
                 $("#qqxn").css("display","none")
             }
             if(result.data.groupUrl){
                 $("#zixun").css("display", "block");
             }else{
                 $("#zixun").css("display", "none");
             }
//             $('#qq').attr('href','http://'+result.data.rightUrl);
         }
     });

 })


$(".c_lqzl").click(function(){
 	

    if(vip!=1 && vip!=2 && vip!=3){
        //小能
        NTKF.im_openInPageChat(consultDetail.rightUrl);
    }else{
        //qq
//        document.getElementById('qq').click();
        NTKF.im_openInPageChat(consultDetail.groupUrl);
    }
})




/* 选择课程 */
 
var pos = $("#position-id").val()
console.log(pos)
var title = $(".a_list li[data-id = " + pos +"]").html()
console.log("title",title)
$("#pos_title").text(title)
$("#pos_title").attr("data-id",pos)
/* 选择课程 */ 



$(function(){
    $(".head_login_img").click(function(){
        window.location.href = "/userCenter";
    });
    Util.navbarCss();
});
var vip = $(".body").attr("vip");
var scUrl = $(".head_center").attr("mast")
$.ajax({
    type: "POST",
    url: "/practice/get/url",
    success: function (result) {
        if (result.success) {
            $("#head_window").attr('href',result.data.url1);
        }
    }
});



/* 直播列表鼠标进入事件 */
	
	
	
       
        /*  */

function headScFun() {

    var ms =  $(".body").attr("testMobile")
    if(ms==""||ms==null){Util.User.login(function() {
        location.reload();
    });
        return false;
    }else{
        document.getElementById('head_window').click();
    }
}


  var consultDate={pageNo:2}
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
    document.cookie = cname + "=" + cvalue + "; " + expires
//            +":domain=test2.duia.com: path=/"
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
//  $(".sb-close").click(function(){
//    $(".FloatOn1").css("display","none")
//    setCookie("close_xn_course", "yes", "xn")
//  })
//  $(function(){
//      $(".sb-close").click(function(){
//       /*   $(".FloatOn").css("display","none")*/
//          $(".FloatOn1").css("display","none")
//        setCookie("close_xn_course", "yes", "xn")
//      })
//alert(getCookie("close_xn_course"))
//    if(getCookie("close_xn_course")!="yes"){
//      $(".FloatOn1").css("display","none")
//    }else{
//      console.log(111)
//      if (vip == 1 || vip == 2 || vip == 3) {
//        $(".FloatOn1").css("display","none")
//      }else{
//        var consultDate;
//        var consultDetail;
//        $.ajax({
//          type: "POST",
//          url:'/consult/detail',
//          data:consultDate,
//          success: function(result) {
//            consultDetail=result.data
//            if (result.data.leftUrl!=null && getCookie("close_xn_course")!="yes"&&vip==0) {
//              var t = '<a><img src='+result.data.imgUrl+'></a>'
//              $(".FloatOn").append(t)
//              $(".FloatOn1").css("display","block")
//            }else{
//              $(".FloatOn1").css("display","none")
//            }
//
//          }
//        });
//      }
//    }
//  });


</script>
 
</body>
<script>
window.onload = function () {
	console.log(1)
	var live_list = document.getElementsByClassName("live_info");
	 live_list[1].children[0].children[0].children[2].children[0].style.color =  "#fff";
     live_list[1].children[0].children[0].children[2].children[0].style.backgroundColor =  "#f7d078";
     live_list[1].children[0].children[0].children[0].children[1].style.backgroundImage= 'url("/resources/common/images/tiaodong.gif")'
     live_list[1].style.backgroundColor =  "white";
	function touch_c(index) {
	    for (var i = 0; i < live_list.length; i++) {
	        live_list[i].children[0].children[0].children[2].children[0].style.color = "#f7d078"
	        live_list[i].children[0].children[0].children[2].children[0].style.backgroundColor = "#fff"
	        live_list[i].children[0].children[0].children[0].children[1].style.backgroundImage= 'url("/resources/common/images/wjump.gif")'
	        live_list[i].style.backgroundColor =  "#f7d078";

	    }
	        live_list[index].children[0].children[0].children[2].children[0].style.color =  "#fff";
	        live_list[index].children[0].children[0].children[2].children[0].style.backgroundColor =  "#f7d078";
	        live_list[index].children[0].children[0].children[0].children[1].style.backgroundImage= 'url("/resources/common/images/tiaodong.gif")'
	        live_list[index].style.backgroundColor =  "white";
	}


	var live_list_ul = document.getElementById("live_list_ul");
	live_list_ul.onmouseover = function (e) {
	    
	    if(e.target.tagName == "LI" || e.target.tagName == "IMG" || e.target.className == "top_info" ||e.target.tagName == "DIV") {  

	        touch_c(e.target.dataset.id)
	    }
	   
	   }
}

</script>
</html>