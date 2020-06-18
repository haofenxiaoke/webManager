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
    <script src="${basePath}/resources-sjn/common/js/utils.js"></script>
    <link href="${basePath}/resources/common/css/rest.css" rel="stylesheet">
    <link href="${basePath}/resources/common/css/head.css" rel="stylesheet">
    <link href="${basePath}/resources/common/jquery-file-upload/css/jquery.fileupload.css" rel="stylesheet">

    <link rel="stylesheet" href="${basePath}/resources-sjn/index/css/login.css"/>
    <link rel="stylesheet" href="${basePath}/resources-sjn/index/css/register.css"/>
    <link rel="stylesheet" href="${basePath}/resources-sjn/index/css/password.css"/>
    <link href="${basePath}/resources-sjn/index/css/main.css" rel="stylesheet">
    <style type="text/css">
        #add-app{position: relative;}
        #add-ewm{position: relative;}
        #add-app:hover .addapp-ewm{display: block;}
        #add-ewm:hover .addewm-ewm{display: block;}
        .addewm-ewm{ width: 174px; height: 220px; background: url("/resources-sjn/course/images/wxhG.png") no-repeat; position: absolute; bottom: -220px; left: -52px;z-index: 2; display: none;}
        .addapp-ewm{ width: 174px; height: 220px; background: url("/resources-sjn/index/images/appG.png") no-repeat; position: absolute; bottom: -220px; left: -52px;z-index: 2;display: none;}
        .too-xn em {
            background: url("/resources-sjn/index/images/kjs-gzh.png") no-repeat !important;
        }
        .too-ewm em{background: url("/resources-sjn/index/images/app-ewm.png") no-repeat !important;}
        .FloatOn1{width: 98px; height: 178px; position: fixed;top: 310px;left: 15px; z-index: 98; display: none;}
        .FloatOn{width: 98px; height: 178px; position: fixed;top: 310px;left: 15px; z-index: 98;}
        .FloatOn img{width: 100%; height: 100%;}
        .FloatOn1 .sb-close{ display: block; width: 18px; height: 18px; color: #fff; font-size: 12px; text-align: center;position: absolute; right:2px; top: 0px;
            cursor: pointer; z-index: 100001; }
    </style>
    <sitemesh:write property='head'/>
</head>
<body class="body" testMobile="${SESSION_USER.mobile}" vip="${SESSION_USER.vipId}">

<header>
    <div class="headerBg">
        <div class="head_center">
            <div class="head_logo">
               <a href="${basePath}/" style="float: left; width: 140px; height: 46px;"> <img src="${basePath}/resources-sjn/index/images/sjn_logo.png" alt=""/></a>
            </div>
            <div class="head_menu">
                <span><a href="${basePath}/">首页</a></span>
                <span id="course"><a href="${basePath}/course">课程</a></span>
                <span id="live"><a href="${basePath}/live">直播</a></span>
                <span id="stu-evaluate"><a href="${basePath}/stu-evaluate">学员好评</a></span>
                <span id="vip"><a href="${basePath}/vip">开通会员</a></span>
                <span id="add-app"><a>下载APP</a><div class="addapp-ewm"></div></span>
                <span id="add-ewm"><a>关注微信</a><div class="addewm-ewm"></div></span>
            </div>
            <div class="head_search">
                <div class="head_search_in">
                    <a id="search-btn"><img src="${basePath}/resources/common/images/courseInfo_search.png" height="20"
                                            alt=""/></a>
                    <input id="search-word" style="color:#999" type="text" data-tag="你希望学习什么？" value="你希望学习什么？" onfocus="if(this.value=='你希望学习什么？'){this.value=''};this.style.color='#333';" onblur="if(this.value==''||this.value=='你希望学习什么？'){this.value='你希望学习什么？';this.style.color='#999';}"/>
                </div>
                <script>
                    //搜索按钮点击事件
                    $('#search-btn').click(function () {
                        var word = $.trim($('#search-word').val());
                        if (word){
                            location.href = '/search?word=' + word;
                        } else{
                            layer.alert('请输入搜索内容!', {
                                title: '温馨提示',
                                end:function () {
                                    $('#search-word').focus();
                                },
                                offset:'150px'
                            });
                        }
                    });
                    $('#search-word').focus(function () {
                        Util.onEnter(function () {
                            $('#search-btn').click();
                        });
                    });
                </script>
                <shiro:guest>
                    <div class="head_login">
                        <a href="http://www.duia.com" target="_blank">去对啊网</a>&nbsp;|&nbsp;
                        <a href="javascript:void(0)" onclick="Util.User.login(function() {
                                 location.reload();
                                });">登录</a>&nbsp;|&nbsp;<a href="javascript:void(0)"
                                                           onclick="Util.Modal.show('${basePath}/resources-sjn/modal/register.html')">注册</a>
                    </div>
                </shiro:guest>
                <shiro:user>
                    <div class="head_login" style="margin-top: 10px;">
                        <div class="head_login_img">
                            <img src="${(SESSION_USER.imgurl == '' || SESSION_USER.imgurl == null)?'/resources/common/images/photo.jpg':SESSION_USER.imgurl}" alt="" width="30" height="30" />
                        </div>
                        <div style="margin-top: 0px;">
                            <a href="${basePath}/logout" style="color: #ffffff;font-size: 12px;text-decoration: none;">退出</a>&nbsp;|&nbsp;
                            <a href="http://www.duia.com" target="_blank" style="font-size: 12px;">去对啊网</a>
                        </div>
                    </div>
                </shiro:user>
            </div>
        </div>
    </div>
</header>
<sitemesh:write property='body'/>
<div class="toolbar">
    <c:choose>
        <c:when test="${SESSION_USER.vipId==1||SESSION_USER.vipId==2||SESSION_USER.vipId==3}">
            <a class="too-consult" id="zixun" href="javascript:void(0)"><i class="reUse"></i><em style="display: none;" ></em></a>
        </c:when>
        <c:otherwise>
            <a class="too-consult " id="qqxn"><i class="re"></i><em style="display: none;" ></em></a>
        </c:otherwise>
    </c:choose>
    <a class="too-ewm"><i class="res"></i><em style="display: none;" data-end="1"></em></a>
    <a class="too-xn"><i class="resq"></i><em style="display: none;"></em></a>
    <a class="too-userDc" target="_blank" href="${basePath}/help?m=2"><i class="restIcon endyou"></i></a>
    <a class="too-scrollT" id="top"><i class="restIcon"></i></a>
</div>
<div class="FloatOn1">
    <span class="sb-close">x</span>
    <div class="FloatOn">

    </div>
</div>
<footer>
    <div class="kjs-fotter">
        <div class="kjs-f-con">
            <div class="kjs-f-text clearfloat">
                <img src="${basePath}/resources-sjn/index/images/cow.png" class="kjs-f-l">
                <div class="kjs-f-c">
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
                    <div class="kjs-f-bq">
                        <span>Copyright@2016</span>
                        <span>北京入行教育科技有限公司版权所有</span>
                        <a href="http://www.miit.gov.cn/" target="_blank" style="margin-right: 20px; color: #ddd;"> 京ICP备1601120号-7</a>
                        <a href="http://www.miit.gov.cn/" target="_blank" style="margin-right: 20px; color: #ddd;"> 京ICP证160803号</a>
                        <img style="margin-top: -3px;" src="/resources-sjn/index/images/picWb.png"/>
                        <a target="_blank" href="http://www.beian.gov.cn/portal/registerSystemInfo?recordcode=11030102010209" style="color: #dddddd;"><span>京公网安备11030102010209号</span></a>
                    </div>
                    <div style="color: #ddd;margin: 12px 8px 10px 9px;">
                        <a href="http://xwgdj.beijing.gov.cn/" target="_blank" style="color: #ddd;">出版物经营许可证（批发）新出发京批字第直170038号</a>
                    </div>
                </div>
            <%-- <img src="${basePath}/resources/common/images/foter-ewm.png" class="kjs-f-r">--%>
            </div>
            <%--<div class="sjn-ewm">
                 <img src="${basePath}/resources-sjn/index/images/ewmWB.png" class="sjn_wb">
                 <img src="${basePath}/resources-sjn/index/images/ewmWX.png" class="sjn_wx">
            </div>--%>
            <%--<img src="${basePath}/resources-sjn/index/images/bot_title.png" class="kjs-fo-tittle">--%>
            <%--<a class="kjs-fo-tittle"style="top: 0px;" key ="57a7f329efbfb00b583282a1"  logo_size="124x47"  logo_type="realname"  href="http://www.anquan.org" ><script src="//static.anquan.org/static/outer/js/aq_auth.js"></script></a>--%>
            <a logo_size="124x47" style="position:absolute;top:0;right:0;" logo_type="realname" href="http://www.anquan.org" ><script src="http://static.anquan.org/static/outer/js/aq_auth.js"></script></a>
        </div>
    </div>
    <%--<div style="text-align: center;width: 100%; margin-top: 20px;">
        <script src="http://kxlogo.knet.cn/seallogo.dll?sn=e17010611011566150zwak000000&size=0"></script>
        <%--<a logo_size="124x47" logo_type="realname" href="http://www.anquan.org" ><script src="http://static.anquan.org/static/outer/js/aq_auth.js"></script></a>--%>
        <%--<div style="margin-top: 20px;"></div>--%>
    <%--</div>--%>
</footer>
<a style="display:none" id="head_window" target="_blank"></a>
<a id="qq" style="display:none;" target="_blank"></a>
<script>Util.rightFloat();</script>
<script type="text/javascript">
    $(function(){
        $(".head_login_img").click(function(){
            window.location.href = "/userCenter";
        });
        Util.navbarCss();
    });

    $(".wx_ewm").hover(function(){
        $(".wx_left").css("display","block")
    },function(){
        $(".wx_left").css("display","none")
    })
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
    })
    function headScClick() {
        document.getElementById('head_window').click();
    }
    function headScFun() {
        if (vip == 1 || vip == 2 || vip == 3) {
            headScClick();
        } else {
            if (getCookie("taxAuth") != null && getCookie("taxAuth") != '') {
                if (getCookie("taxDays") != null && getCookie("taxDays") != '') {
                    headScClick();
                } else {
                    $(".index-shadeO").css("display", "block")
                }
            } else {
                setCookie("taxAuth", 1, 30);
                setCookie("taxDays", 1, 1);
                headScClick();
            }
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
        document.cookie = cname + "=" + cvalue + "; " + expires+":domain=test2.duia.com: path=/"
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
                    $(".FloatOn").append(t)
                    $(".FloatOn1").css("display","block")
                }else{
                    $(".FloatOn1").css("display","none")
                }
                if (result.data.rightUrl!=null) {
                    $("#qqxn").css("display","block")
                    $(".qqxn").css("display","block")
                }else{
                    $("#qqxn").css("display","none")
                    $(".qqxn").css("display","none")
                }
                if(result.data.groupUrl){
                    $("#zixun").css("display", "block");
                    $(".zixun").css("display", "block");
                }else{
                    $("#zixun").css("display", "none");
                    $(".zixun").css("display", "none");
                }
                $('#qq').attr('href','http://'+result.data.groupUrl);
            }
        });

    })

    $(".too-consult").click(function(){

        if(vip!=1 && vip!=2 && vip!=3){
            //小能
            NTKF.im_openInPageChat(consultDetail.rightUrl);
        }else{
            //qq
            document.getElementById('qq').click();

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
//        setCookie("close_xn_index", "yes", "xn")
    })





</script>
</body>
</html>