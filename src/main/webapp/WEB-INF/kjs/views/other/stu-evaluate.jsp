<%--
  Created by IntelliJ IDEA.
  User: admin
  Date: 2016/7/23
  Time: 17:46
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="zh">
<head>
    <meta charset="UTF-8">
    <title>学员好评-好分课堂</title>
    <link href="${basePath}/resources/common/css/rest.css" rel="stylesheet">
    <link href="${basePath}/resources/userCenter/css/studyGood.css" rel="stylesheet">
    <script src="${basePath}/resources/userCenter/js/rotate.js"></script>
    <style type="text/css">
        #stage a {
            -webkit-touch-callout: none; /* iOS Safari */
            -webkit-user-select: none; /* Chrome/Safari/Opera */
            -khtml-user-select: none; /* Konqueror */
            -moz-user-select: none; /* Firefox */
            -ms-user-select: none; /* Internet Explorer/Edge */
            user-select: none; /* Non-prefixed version, currently
not supported by any browser */
        }
        .arrow{
            -webkit-touch-callout: none; /* iOS Safari */
            -webkit-user-select: none; /* Chrome/Safari/Opera */
            -khtml-user-select: none; /* Konqueror */
            -moz-user-select: none; /* Firefox */
            -ms-user-select: none; /* Internet Explorer/Edge */
            user-select: none; /* Non-prefixed version, currently
not supported by any browser */
        }
    </style>
</head>

<body>
<div class="stuVideo">
    <div class="studV-tit">他们在会计狮学习过所以最有发言权</div>
    <div class="studV-content clearfloat">
        <div class="study-test clearfloat fl">
            <div class="fl study-pic"><img src="${basePath}/resources/userCenter/images/study-pic1.png"> </div>
            <div class="fl study-right">
                <h2>韩蕾</h2>
                <div class="study-tittle">某制造企业<span>会计</span></div>
                <div class="study-content">非常实用的会计实操课程，老师上课真材
                    实例讲解，针对不同岗位职责要求，设计
                    课程内容,非常容易上手。今年刚参加
                    工作，对于会计实操小白的我来说，真的是有很大的帮助。</div>
            </div>
        </div>
        <div class="study-test clearfloat fr">
            <div class="fl study-pic"><img src="${basePath}/resources/userCenter/images/study-pic2.png"></div>
            <div class="fl study-right">
                <h2>黄玲</h2>
                <div class="study-tittle">某外贸公司<span>会计</span></div>
                <div class="study-content">一个报表同事几个小时甚至几十分钟就可以做好，而我却要花上一天的时间还不一定能完全弄对，在同事和领导面前真的是非常的尴尬。不过自从学了会计狮网的实
                    操课程，工作中遇到的难题都迎刃而解了。</div>
            </div>
        </div>
        <div class="study-test clearfloat fl">
            <div class="fl study-pic"><img src="${basePath}/resources/userCenter/images/study-pic3.png"></div>
            <div class="fl study-right">
                <h2>解作圣</h2>
                <div class="study-tittle">某物流公司<span>会计助理</span></div>
                <div class="study-content">会计狮的课程设置真的很不错，岗位职责里的关键点都覆盖到了，我在工作中遇到的棘手问题在会计狮的课程上都得到了解决，老师很负责,解答问题的时候很有耐心，
                    除此之外老师上课给的讲义也非常实用。</div>
            </div>
        </div>
        <div class="study-test clearfloat fr">
            <div class="fl study-pic"><img src="${basePath}/resources/userCenter/images/study-pic4.png"></div>
            <div class="fl study-right">
                <h2>王冕</h2>
                <div class="study-tittle">某建筑业公司<span>出纳</span></div>
                <div class="study-content">嗯，老师讲的真的超棒，简单细致、通俗易懂，对于不太爱学习的我来说也是非常容易理解的，原来不知道还有这么多岗位小技巧，真的是受益匪浅，
                    谢谢老师。</div>
            </div>
        </div>
    </div>
</div>
<div class="stuV-gesse">
    <div class="studV-tit" style="padding-top: 100px;font-size: 48px;">TA为什么选择“会计狮”</div>
    <div class="stud-zs ">
        <!--<div class="stud-zspic clearfloat">
            <div></div>
            <div></div>
            <div></div>
            <div></div>
        </div>
        <div>
            <a><i class="restIcon"></i></a>
            <a><i class="restIcon"></i></a>
            <a><i class="restIcon"></i></a>
            <a><i class="restIcon"></i></a>
        </div>-->
        <div class="internetke clearfloat">
            <div id="phoneCarousel">
                <div unselectable="on" class="previous arrow">&nbsp;</div>
                <div unselectable="on" class="next arrow">&nbsp;</div>
                <div id="stage">
                    <a href="#" unselectable="on" target="_blank" ><img width="300"  src="${basePath}/resources/userCenter/images/studyGod-pic1.jpg" alt="iPhone" id="iphone" class="default" /></a>
                    <a href="#" unselectable="on" target="_blank" ><img width="300"  src="${basePath}/resources/userCenter/images/studyGod-pic2.jpg" alt="Nexus One" id="nexus" /> </a>
                    <a href="#" unselectable="on" target="_blank" ><img width="300"  src="${basePath}/resources/userCenter/images/studyGod-pic3.png" alt="Nokia"  /> </a>
                    <a href="#" unselectable="on" target="_blank" ><img width="300"  src="${basePath}/resources/userCenter/images/studyGod-pic4.png" alt="BlackBerry" id="blackberry" /></a></div>
            </div>

        </div>
    </div>
</div>
<div class="studV-zx" style="background: url('/resources/userCenter/images/stud3-bg.png') no-repeat center;background-size: 100% 100%;filter:progid:DXImageTransform.Microsoft.AlphaImageLoader(src='/resources/userCenter/images/stud3-bg.png',  sizingMethod='scale');">
   <img src="${basePath}/resources/userCenter/images/study-bpic.png">
    <%--<a href="">立即咨询</a>--%>
</div>
<script src="${basePath}/resources/other/js/jquery.lazyload.js"></script>
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
<script>
    var consultDate;
    $(function() {
        $("img").lazyload();
    });
</script>
</body>
</html>
