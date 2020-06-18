<%@ page language="java" pageEncoding="UTF-8" contentType="text/html; UTF-8" import="com.kjs.common.util.ParamUtil" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<%
    String contextPath = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + contextPath + "/";
%>
<html>
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=8,IE=9,chrome=1">
    <title>
        <sitemesh:write property='title'/>
    </title>
    <script src="${basePath}/resources/common/js/jquery-1.9.1.js"></script>
    <script src="${basePath}/resources/common/layer-v2.3/layer/layer.js"></script>
    <script src="${basePath}/resources/common/jquery-file-upload/js/vendor/jquery.ui.widget.js"></script>
    <script src="${basePath}/resources/common/jquery-file-upload/js/jquery.fileupload.all.js"></script>
    <script src="${basePath}/resources/common/js/jquery.cookie.js"></script>
    <script src="${basePath}/resources/common/js/utils.js"></script>
    <link href="${basePath}/resources/common/css/rest.css" rel="stylesheet">
    <script>document.write("<link rel='stylesheet' href='/resources/common/css/head.css?time="+Math.random()+"'>")</script>
    <%-- <link href="${basePath}/resources/common/css/head.css" rel="stylesheet"> --%>
    <link href="${basePath}/resources/common/jquery-file-upload/css/jquery.fileupload.css" rel="stylesheet">
    <link href="/resources/common/css/nav.css" rel="stylesheet">
    <link href="/resources/common/css/index.css" rel="stylesheet">
    <sitemesh:write property='head'/>
    <style type="text/css">
        #add-app{position: relative;}
        #add-ewm{position: relative;}
        #add-app:hover .addapp-ewm{display: block;}
        #add-ewm:hover .addewm-ewm{display: block;}
        .addewm-ewm{ width: 170px; height: 220px; background: url("/resources/course/images/wxhG.png") no-repeat; position: absolute; bottom: -220px; left: -52px;z-index: 2; display: none;}
        .addapp-ewm{ width: 170px; height: 220px; background: url("/resources/course/images/appG.png") no-repeat; position: absolute; bottom: -220px; left: -52px;z-index: 2;display: none;}
        .FloatOn1{ position: fixed;top: 310px;left: 15px; z-index: 98;display: none;}
        .FloatOn{ position: fixed;top: 310px;left: 15px; z-index: 98;}
        .FloatOn img{width: 100%;}
        .FloatOn1 .sb-close{ display: block; width: 24px !important; height: 24px !important; background: url("/resources/index/images/close_xn.png") no-repeat !important;text-align: center;position: absolute; right:-160px !important; top: 63px !important;
            cursor: pointer; z-index: 100001; }
        .flexpaper_initloader{z-index: 1 !important;}
        .kjs-f-about a{
        	font-size: 12px;
        }
        .kjs-f-bq a {
        	font-size: 12px;
        }
        
        .kjs-f-bq span {
        font-size: 12px;
        } 
        .kjs-f-bq div a {
        font-size: 12px;
        }
    </style>
</head>
<body class="body" testMobile="${SESSION_USER.mobile}" vip="${SESSION_USER.vipId}">
<header>
    <div class="headerBg">
        
            <!-- 导航栏 -->
            <div class="top" style="background-color: rgba(52, 54, 53, 1)">
        <div class="top-wrap">
            <!-- 左边图片 -->
            <div class="title_img">
                <a href="${basePath}/"><img src="/resources/common/images/u138.png" alt=""></a>
            </div>
            <!-- 右边分类 -->
            <div class="title_nav">
                <!-- 选择课程 -->
                <div class="nav_text" id="chose_title" style="color: #fff;">选择课程
                    <img src="/resources/common/images/baiv.png" alt="">
                    <div class="wrapw" >
                    <div class="top_list" id="top_list">
                    	<c:forEach items="${directions}" var="dire">
                        <ul class="list_content">
                            <li class="list_content_tou">${dire.categoryDesc}</li>
                            <c:forEach items="${dire.positions}" var="position">
								<li class="list_sm">
							<a href="${basePath}/course?directionId=${dire.id}&positionId=${position.id}" style="color:#9a9e9f; font-size: 14px;">${position.categoryDesc}</a>
							</li>
							</c:forEach>
                            
                        </ul>
						</c:forEach>
                    </div>
                </div>
                </div>
                <div class="nav_text" style="color: #fff;">公众号
                	<div class="ewm ewm_hidd">
                    	<div class="erweima ewm1">
                    		<img src="/resources/common/images/kuaiji_ewm.jpg">
                    		<div class="ewm_title" style="color: #171717">会计资料信息库</div>
                    	</div>
                    	<div class="erweima ewm2">
                    		<img src="/resources/common/images/jiaozi_ewm.jpg">
                    		<div class="ewm_title" style="color: #171717">教师资格信息资料库</div>
                    	</div>
                    </div>
                </div>
                <div class="nav_text" style="color: #fff;">小程序
                 <div class="erweima_xcx ewm_hidd erweima">
                 	<img src="/resources/common/images/xcx_yuan.jpg">
                 	<div class="ewm_title" style="color: #171717">好分小课</div>
                 </div> 

                </div>
                <div class="nav_text" style="color: #fff;">APP
                   <div class="erweima erweima_xcx ewm_hidd" style="margin-left: -36px">
                   		<div style="text-align: center;color: #171717;">敬请期待！</div>
                   </div> 

                </div>
                <div class="nav_text"><a a href="${basePath}/vip" style="color: #fff;">会员</a></div>
                <shiro:guest>
                <div class="nav_text"><a onclick="Util.User.login(function() { location.reload();});">登录</a></div>
                </shiro:guest>
                <shiro:user>
                	<div class="head_login">
                        <div class="head_login_img">
                            <img src="${(SESSION_USER.imgurl == '' || SESSION_USER.imgurl == null)?'/resources/common/images/photo.jpg':SESSION_USER.imgurl}" alt="" width="40" height="40" />
                        </div>
                        <div style="margin-left: 45px; line-height: 80px; height: 80px;">
                            <a href="${basePath}/logout" style="color: #ffffff;font-size: 12px;text-decoration: none;">退出</a>
 
                        </div>
                    </div>
                </shiro:user>
            </div>

        </div>
    </div>

</header>
<sitemesh:write property='body'/>
<%-- <div class="toolbar" style="z-index: 9999;">
    <c:choose>
        <c:when test="${SESSION_USER.vipId==1||SESSION_USER.vipId==2||SESSION_USER.vipId==3}">
            <a class="too-consult" style="display: block;" id="zixun" href="javascript:void(0)"><i class="reUse"></i><em style="display: none;" ></em></a>
        </c:when>
        <c:otherwise>
            <a class="too-consult" style="display: block;" id="qqxn"><i class="re"></i><em style="display: none;" ></em></a>
        </c:otherwise>
    </c:choose>
    <a class="too-ewm"><i class="res"></i><em style="display: none;" data-end="1"></em></a>
    <a class="too-xn"><i class="resq"></i><em style="display: none;"></em></a>
    <a class="too-userDc" target="_blank" href="${basePath}/help?m=2"><i class="restIcon endyou"></i></a>
    <a class="too-scrollT" id="top"><i class="restIcon"></i></a>
</div> --%>

<div class="index-shadeO" >
    <div class="scSeeO">
        <span class="scClose"></span>
        <p class="scSee-topO">实操做账为<span>会员专享</span><div style="text-align: center; margin-top: 10px; font-size: 14px; color: #666;">你已经体验过一次,开通会员后继续学习</div></p>
        <a href="${basePath}/vip" target="_blank">立即开通</a>
    </div>
</div>
<footer>
    <div class="kjs-fotter">
        <div class="kjs-f-con">
            <div class="kjs-f-text clearfloat">
                <img src="${basePath}/resources/common/images/foter-logo.png" class="kjs-f-l" style="width:48px; height:48px;">
                <div class="kjs-f-c"  >
                    <div class="kjs-f-about">
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
                        <a href="http://www.miit.gov.cn/" target="_blank" style="margin-right: 20px; color: #fff; font-size: 12px"> 京ICP备16011120号-10</a>
                        <a href="http://www.miit.gov.cn/" target="_blank" style="margin-right: 20px; color: #fff; font-size: 12px"> 京ICP证160803号</a>
                        <img style="margin-top: -3px; height: 20px; width: 20px;" src="/resources/index/images/picWb.png"/>
                        <a target="_blank" href="http://www.beian.gov.cn/portal/registerSystemInfo?recordcode=11030102010060" style="color: #fff; font-size: 12px"><span>京公网安备11030102010060号</span></a>
                    </div>
                    <div style="color: #ddd;margin: 12px 8px 10px 9px;">
                        <a href="http://xwgdj.beijing.gov.cn/" target="_blank" style="color: #fff; font-size: 12px">出版物经营许可证（批发）新出发京批字第直170038号</a>
                    </div>
                </div>
               <%-- <img src="${basePath}/resources/common/images/foter-ewm.png" class="kjs-f-r">--%>
            </div>
           <%-- <img src="${basePath}/resources/common/images/foter-wa.png" class="kjs-fo-tittle">--%>
            <%--<a class="kjs-fo-tittle"style="top: 0px;" key ="57a7f329efbfb00b583282a1"  logo_size="124x47"  logo_type="realname"  href="http://www.anquan.org" ><script src="//static.anquan.org/static/outer/js/aq_auth.js"></script></a>--%>
        </div>
    </div>
</footer>

<a style="display:none" id="head_window" target="_blank"></a>
<a id="qq" style="display:none;" target="_blank"></a>

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
//                $('#qq').attr('href','http://'+result.data.rightUrl);
            }
        });

    })

    $(".too-consult").click(function(){

        if(vip!=1 && vip!=2 && vip!=3){
            //小能
            NTKF.im_openInPageChat(consultDetail.rightUrl);
        }else{
            //qq
//            document.getElementById('qq').click();
            NTKF.im_openInPageChat(consultDetail.groupUrl);
        }
    })
    $(".FloatOn").click(function(){
       /* var datas ={pageNo:1};*/
        $.ajax({
            type: "POST",
            url:'/consult/detail',
            data:consultDate,
            success: function(result) {
                if (result.success) {
                    NTKF.im_openInPageChat(result.data.leftUrl);
                }
            }
        });

    })
    $(".sb-close").click(function(){
        $(".FloatOn1").css("display","none")
    })





</script>
</body>
</html>