<%--
  Created by IntelliJ IDEA.
  User: admin
  Date: 2016/7/23
  Time: 17:46
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>学员好评-设计牛</title>
    <link href="${basePath}/resources/common/css/rest.css" rel="stylesheet">
    <link href="${basePath}/resources/userCenter/css/studyGood.css" rel="stylesheet">
    <link href="${basePath}/resources-sjn/course/css/evaluate.css" rel="stylesheet">
    <script src="${basePath}/resources/userCenter/js/rotate.js"></script>
</head>
<body>
<div class="stuVideo">
    <div class="studV-tit">他们在设计牛学习过所以最有发言权</div>
    <div class="studV-content clearfloat">
        <div class="study-test clearfloat fl">
            <div class="fl study-pic"><img src="${basePath}/resources-sjn/userCenter/images/study-pic1.png"> </div>
            <div class="fl study-right">
                <h2>鲍亚龙</h2>
                <div class="study-tittle">某互联网公司<span>UI设计师</span></div>
                <div class="study-content">我来自内蒙古赤峰，到北京后做过很多种工作，有网络技术、运营专员等。在朋友推荐下学习了设计牛的UI设计课，感觉老师们教的非常棒，对我帮助很大。现在工作过程中如鱼得水，感谢设计牛的老师们。</div>
            </div>
        </div>
        <div class="study-test clearfloat fr">
            <div class="fl study-pic"><img src="${basePath}/resources-sjn/userCenter/images/study-pic2.png"></div>
            <div class="fl study-right">
                <h2>董洁</h2>
                <div class="study-tittle">某广告公司<span>设计师</span></div>
                <div class="study-content">设计牛的老师们讲课好有耐心，远比大学的老师认真负责，而且内容也是实实在在工作中用到的，没有“假、大、空”形而上学那些套路。希望能够早日学完我的课程，尽快提升自我，加油！</div>
            </div>
        </div>
        <div class="study-test clearfloat fl">
            <div class="fl study-pic"><img src="${basePath}/resources-sjn/userCenter/images/study-pic3.png"></div>
            <div class="fl study-right">
                <h2>李照煜</h2>
                <div class="study-tittle">某装饰公司<span>室内设计师</span></div>
                <div class="study-content">大学里学的就是环境艺术设计，只可惜毕业后缺乏工作经验，图纸做的都不好。在设计牛学习了几门课，老师讲的比较透彻，基本上我是听了一轮就掌握了，现在我做的作品很受客户的喜欢，开始找到自信了，感谢设计牛。</div>
            </div>
        </div>
        <div class="study-test clearfloat fr">
            <div class="fl study-pic"><img src="${basePath}/resources-sjn/userCenter/images/study-pic4.png"></div>
            <div class="fl study-right">
                <h2>王宇萌</h2>
                <div class="study-tittle">淘宝某小店<span>店主</span></div>
                <div class="study-content">自己平日里经营着淘宝小店，常常遇到不会处理的产品图片，没有美工怎么可能让自己的宝贝美美的呢，每逢节假日，遇到活动就头疼，花钱找人做banner图，现在一切都好了，学会这些技术后再也不用担心了。一句话：感谢设计牛。</div>
            </div>
        </div>
    </div>
</div>
<div class="stuV-gesse">
    <div class="studV-tit" style="padding-top: 100px;font-size: 48px;">TA为什么选择“设计牛”</div>
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
                <div class="previous arrow">&nbsp;</div>
                <div class="next arrow">&nbsp;</div>
                <div id="stage">
                    <a href="#" target="_blank" ><img width="300"  src="${basePath}/resources-sjn/other/images/01.jpg" alt="iPhone" id="iphone" class="default" /></a>
                    <a href="#" target="_blank" ><img width="300"  src="${basePath}/resources-sjn/other/images/02.jpg" alt="Nexus One" id="nexus" /> </a>
                    <a href="#" target="_blank" ><img width="300"  src="${basePath}/resources-sjn/other/images/03.jpg" alt="Nokia"  /> </a>
                    <a href="#" target="_blank" ><img width="300"  src="${basePath}/resources-sjn/other/images/04.jpg" alt="BlackBerry" id="blackberry"></a></div>
            </div>

        </div>
    </div>
</div>
<div class="studV-zx1" style="background: url('/resources-sjn/userCenter/images/stud3-bg.png') no-repeat center;background-size: 100% 100%;filter:progid:DXImageTransform.Microsoft.AlphaImageLoader(src='/resources-sjn/userCenter/images/stud3-bg.png',  sizingMethod='scale');">
    <%--<a href="">立即咨询</a>--%>

</div>
<script src="${basePath}/resources/other/js/jquery.lazyload.js"></script>
<script>
    $(function() {
        $("img").lazyload();
    });
</script>
</body>
</html>
