<%@ page import="java.util.Date" %>
<%@ page import="com.kjs.common.bean.Constants" %>
<%@ page import="com.kjs.orm.model.UserStu" %><%--
  Created by IntelliJ IDEA.
  User: lihengming
  Date: 2016/6/20
  Time: 14:53
  To change this template use File | Settings | File Templates.
--%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path;
    request.setAttribute("realPath",request.getServerName());
%>

<!DOCTYPE html>
<html lang="zh">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=8,IE=9,chrome=1">
    <meta name="description" content="好分小课-对啊旗下学习平台,会计初级,CPA注册会计,会计中级,教师资格证,自考学历,金融课程在线学习平台。"/>
   
    <meta name="keywords" content="好分小课,会计初级,初级会计,会计中级,注册会计,教师资格证,免费课程"/>
    <title>好分小课|对啊网旗下学习平台</title>
    
    <link href="${basePath}/resources/common/css/rest.css" rel="stylesheet">
    <link href="${basePath}/resources/common/css/index.css" rel="stylesheet">
    <link href="${basePath}/resources/index/css/kjs-index.css" rel="stylesheet">
    <link rel="stylesheet" href="${basePath}/resources/login/css/touxiang.css"/>
    <link rel="stylesheet" href="${basePath}/resources/userCenter/css/studyGood.css"/>
    <script src="${basePath}/resources/common/js/jquery-1.9.1.js"></script>
    <script src="${basePath}/resources/common/layer-v2.3/layer/layer.js"></script>
    <script src="${basePath}/resources/common/js/jquery.cookie.js"></script>
    <script src="${basePath}/resources/common/js/utils.js"></script>
    <script src="${basePath}/resources/common/js/jquery-latest.min.js"></script>
    <script src="${basePath}/resources/common/js/unslider.js"></script>
    <script src="${basePath}/resources/common/layer-v2.3/layer/layer.js"></script>
    <script src="${basePath}/resources/common/js/move.js"></script>
    <script src="${basePath}/resources/index/js/jqeryLB.js"></script>
    <script src="${basePath}/resources/common/js/yundong.js"></script>

    <style type="text/css">
        .kjsZyflr a{position: relative;}
        .wx-cc{position: absolute; display: block; padding:0px 3px; background:#f7f9fa;border: 1px solid #ccc; z-index: 96; bottom: -10px;left:27px; display: none; border-radius: 3px;color: #333 !important;
            opacity: 1 !important; color: #666666;}
        .kjsZyflr a:hover .wx-cc{display: block;}
        .kjsDlBtn{ margin: 40px 0px 35px 0px;}
        .kjsDlBtn .kjsDlbtn2{ width:80px;}
        #add-app{position: relative;}
        #add-ewm{position: relative;}
        #add-app:hover .addapp-ewm{display: block;}
        #add-ewm:hover .addewm-ewm{display: block;}
        .addewm-ewm{ width: 170px; height: 220px; background: url("/resources/course/images/wxhG.png") no-repeat; position: absolute; bottom: -220px; left: -35px;z-index:99; display: none;}
        .addapp-ewm{ width: 170px; height: 220px; background: url("/resources/course/images/appG.png") no-repeat; position: absolute; bottom: -220px; left: -35px;z-index: 99;display: none;}
        @media screen and (max-width: 1226px) {
           .kjsBotPic{width: 1226px; margin: 0 auto;}
            .kjs-fotter{width: 100%;    min-width: 1648px; margin: 0 auto;}
        }
        body .toolbar .too-consult{ width: 50px !important; height: 84px !important;display: none;}
        
        .head_login_img{
        	    margin-right: 10px;
		    	cursor: pointer;
		    	border-radius: 100%;
        }
        
        .head_login_img img{
    border-radius: 30px;
   	float: left;
	margin-top: 20px;
}
        
    </style>
</head>
<body class="body" testMobile="${SESSION_USER.id}">
	<% System.out.println("counter= " + pageContext.findAttribute("SESSION_USER") ); %>
	<% System.out.println("liveSets= " + pageContext.findAttribute("liveSets") ); %>
	 <div class="top">
        <div class="top-wrap">
            <!-- 左边图片 -->
            <div class="title_img">
                <a href="${basePath}/"><img src="/resources/common/images/u138.png" alt=""></a>
            </div>
            <!-- 右边分类 -->
            <div class="title_nav">
                <!-- 选择课程 -->
                <div class="nav_text" id="chose_title" style="color: #f8ac08;">选择课程
                    <img src="/resources/common/images/yellow_v.png" alt="">
                    <div class="wrapw">
                    <div class="top_list" id="top_list">
                    	<c:forEach items="${directions}" var="dire">
                        <ul class="list_content">
                            <li class="list_content_tou">${dire.categoryDesc}</li>
                            <c:forEach items="${dire.positions}" var="position">
                            <a href="${basePath}/course?directionId=${dire.id}&positionId=${position.id}" style="color:#9a9e9f;">
								<li class="list_sm">
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
                   <div class="erweima erweima_xcx ewm_hidd" style="margin-left: -36px;">
                   	<div style="text-align: center;">敬请期待！</div>
                   </div> 

                </div>
                <div class="nav_text"><a a href="${basePath}/vip" style="color:#343635">会员</a></div>
                <shiro:guest>
                <div class="nav_text"><a onclick="Util.User.login(function() { location.reload();});" style="color: #171717">登录</a></div>
                </shiro:guest>
                <shiro:user>
                	<div class="head_login" style="margin-left: 65px;">
                        <div class="head_login_img">
                            <a href="/userCenter"><img src="${(SESSION_USER.imgurl == '' || SESSION_USER.imgurl == null)?'/resources/common/images/photo.jpg':SESSION_USER.imgurl}" alt="" width="40" height="40" /></a></a>
                        </div>
                        <div style=" margin-left: 45px; line-height: 80px; ">
                            <a href="${basePath}/logout" style="color: #171717;font-size: 12px;text-decoration: none;font-size: 16px;">退出</a>
 
                        </div>
                    </div>
                </shiro:user>
            </div>

        </div>
    </div>
	
	<!-- 中间内容 -->
	
        <div class="swiper sw1" id="sw1">
            <div class="menu_list">
                <div class="kuozhan">
                    <c:forEach items="${directions}" var="dire">
                    <c:if test="${fn:length(dire.positions) != 1}">
                    <div class="kuaiji kj_t">${dire.categoryDesc}
                        <img src="/resources/common/images/yellowv.png" alt="">
                        <div class="caidan caidan1 caidan3">
                        <c:forEach items="${dire.positions}" var="position"  varStatus="positionStatus">
                        
                         <div data-id="${fn:length(dire.positions) }"><a href="${basePath}/course?directionId=${dire.id}&positionId=${position.id}" style="color: #171717; width:120px; height:40px">${position.categoryDesc}</a></div>
                        
                        </c:forEach>
                        </div>
                    </div>
                    </c:if>
                    <c:if test="${fn:length(dire.positions) == 1}">
                    <div class="kuaiji kj_t">${dire.categoryDesc}
                        <img src="/resources/common/images/yellowv.png" alt="">
                        <div class="caidan caidan1 caidan3" style="margin-top:-71px;">
                        <c:forEach items="${dire.positions}" var="position"  varStatus="positionStatus">
                        
                         <div data-id="${fn:length(dire.positions) }"><a href="${basePath}/course?directionId=${dire.id}&positionId=${position.id}" style="color: #171717; width:120px; height:40px">${position.categoryDesc}</a></div>
                        
                        </c:forEach>
                        </div>
                    </div>
                    </c:if>
                    </c:forEach>
                    
                  
                    
                    
                    
                </div>
            </div>
        </div>
        <!-- 小程序介绍 -->
        <div class="swiper sw2" id="sw2">
 
                <div class="xcx_title" id="xcx_title">扫码关注微信小程序直接观看免费视频</div>
                <div class="xcx_yellow"></div>
                <div class="free_all" id="free_all"">
                <div class="free_cont">
                	<div class="hongdian"></div>
                	免费视频
                </div>
                <div class="free_cont">
                	<div class="hongdian"></div>
                	免费资料
                </div>
                <div class="free_cont">
                	<div class="hongdian"></div>
                	免费更新
                </div>
                </div>
                <!-- 二维码 -->
                    <div class="xcx_pic" id="xcx_pic"></div>
				<!-- 底块 -->
				<div class="xcx_dikuai" id="xcx_dikuai"></div>
				
           
        </div>
        <!-- 微信公众号介绍 -->
        <div class="swiper sw3" id="sw3">
            <!-- 二维码 -->
                <div class="gzh_pic" id="gzh_pic"></div>
            <!-- 底块 -->
            	<div class="gzh1_dikuai" id="gzh1_dikuai"></div>
                <div class="gzh_content">
                    <div class="gzh_yuan"></div>
                    <div class="content_info" id="content_info">
                    <div class="yuan_kuaiji"></div>
                        <div class="xinxiku">【会计资料信息库】</div>
                        <div class="feilei">
                            <div class="feilei_index"><div class="hongdian mr_8"></div>会计政策</div>
                            <div class="feilei_index"><div class="hongdian mr_8"></div>考试资讯</div>
                            <div class="feilei_index"><div class="hongdian mr_8"></div>学霸笔记</div>
                            <div class="feilei_index" style="clear: left; margin-top: 20px;"><div class="hongdian mr_8"></div>报考科普</div>
                            <div class="feilei_index" style="margin-top: 20px;"><div class="hongdian mr_8" ></div>备考经验</div>
                        </div>
                    </div> 
                </div>
        </div>
        <!-- 微信公众号2介绍 -->
        <div class="swiper sw4" id="sw4">
         		<div class="jiaoshi_dizi"></div>
                <div class="gzh2_left" id="gzh2_left">
                <div class="yuan_jiaozi"></div>
                    <div class="jiaoshi_title">【教师资料信息资料库】</div>
                  	<div class="xcx2_jieshao">
                  		<div class="xcx2_jieshao_index" style="margin-right:20px;+"><div class="hongdian"></div><div style="margin-left: 30px;">专业教资指导</div></div>
                  		<div class="xcx2_jieshao_index"><div class="hongdian"></div><div style="margin-left: 30px;">教师招聘考试介绍</div></div>
                  		<div class="xcx2_jieshao_index"><div class="hongdian"></div><div style="margin-left: 30px;">特岗考试信息发布</div></div>
                  		<div class="xcx2_jieshao_index"><div class="hongdian"></div><div style="margin-left: 30px;">笔试资料，面试攻略</div></div>
                  	</div>  
                  
                </div>
                <div class="wai_yuan">
                     <div class="yuan2"></div>
	                <div class="yuan2"></div>
	                <div class="yuan2"></div>
	                </div>
                <div class="nei_yuan"></div>
                <div class="gzh2_pic" id="gzh2_pic"></div>
               
                

        </div>


   
   <div class="kjs-fotter" style="border 1px solid black; min-width:1902px;">
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
   
    

	<!-- 右侧内容 -->
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

	
<a id="window" style="display:none;" target="_blank"></a>
<a id="qq" style="display:none;" target="_blank"></a>
<script>

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


<script>Util.rightFloat();</script>

<script>

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
//                 $('#qq').attr('href','http://'+result.data.rightUrl);
             }
         });

     })

  
 $(".c_lqzl").click(function(){
 	

     if(vip!=1 && vip!=2 && vip!=3){
         //小能
         NTKF.im_openInPageChat(consultDetail.rightUrl);
     }else{
         //qq
//         document.getElementById('qq').click();
         NTKF.im_openInPageChat(consultDetail.groupUrl);
     }
 })
    
    //设置cookie
    function setCookie(cname, cvalue, exdays) {
        var tme = new Date();
        var ty = tme.getFullYear(); //获取完整的年份(4位,1970-????)
        var tm = tme.getMonth()+1; //获取当前月份(0-11,0代表1月)
        var td = tme.getDate();
        var thour = tme.getHours();
        var tmin= tme.getMinutes();
        var tmiao = tme.getSeconds();
        var ttt=exdays*(86400-(thour*60*60+tmin*60+tmiao))*1000;
        var d = new Date();
        if(exdays == "xn"){
            d.setTime(d.getTime() + 60*1000);
        }else{
            d.setTime(d.getTime() + ttt);
        }
        var expires = "expires="+d.toUTCString();
        document.cookie = cname + "=" + cvalue + "; " + expires
//                +":domain=test2.duia.com: path=/"
    }
    //获取cookie
    function getCookie(name)
    {
        var arr,reg=new RegExp("(^| )"+name+"=([^;]*)(;|$)");

        if(arr=document.cookie.match(reg))

            return (arr[2]);
        else
            return null;
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
    $(".scClose").click(function(){
        $(".index-shadeO").css("display","none")
    });
    $(".endClose").click(function(){
        $(".index-shade").css("display","none")
    });
</script>


 
	
</body>
</html>