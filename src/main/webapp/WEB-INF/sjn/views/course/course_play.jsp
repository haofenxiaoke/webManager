<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<%request.setAttribute("vEnter", "\n");%>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>${course.title}-设计牛</title>
    <link rel="stylesheet" href="${basePath}/resources/common/css/rest.css" />
    <link rel="stylesheet" href="${basePath}/resources/course/css/videoPlay.css" />
    <link rel="stylesheet" href="${basePath}/resources-sjn/course/css/course_play.css" />
    <script type="text/javascript" src="${basePath}/resources/course/js/answer.js"></script>
    <script type="text/javascript" src="${basePath}/resources/course/js/respond.js"></script>

    <!--兼容IE6-8@media勿删-->
    <style type="text/css">
        .Down1-ewm{background: url("/resources-sjn/course/images/wxh.png") no-repeat !important; width: 174px !important;}

    </style>
</head>

<body>
<input type="hidden" id="is-vip" name="is-vip" value="${userStu.isVIP}">
<input type="hidden" id="user-id" name="user-id" value="${userStu.id}">
<input type="hidden" id="lecture-id" name="lecture-id" value="${lectureId}"/>
<input type="hidden" id="course-id" name="course-id" value="${courseId}"/>
<input type="hidden" id="letv_id" name="letv_id" value="${videoUnique}"/>
<input type="hidden" id="isvipVideo" name="isvipVideo" value="${isvipVideo}"/>
<input type="hidden" id="is-user-play" name="is-user-play" value="${isUserPlay}"/>
<input type="hidden" id="record-id" name="record-id"/>
<input type="hidden" id="last-watch-node" name="last-watch-node"/>
<input type="hidden" id="isScore" name="isScore"/>
<input type="hidden" id="playType" value="${videoType}"/>
<input type="hidden" id="ccPlayId" value="${ccVideoUnique}"/>
<div class="video-all">
    <div class="Made-nav">
        <a href="/" style="padding-left: 0px;">首页</a> > <a href="${basePath}/course">全部课程</a> > <a href="${basePath}/course?directionId=${direction.id}"> ${direction.categoryDesc}</a> >
        <a href="${basePath}/course?directionId=${direction.id}&positionId=${position.id}">${position.categoryDesc}</a> > <a href="${basePath}/course/detail/${course.id}">${course.title}</a>
    </div>
    <div class="video-play content-m-top">
        <c:choose>
            <c:when test="${userStu.vipId==1||userStu.vipId==2||userStu.vipId==3}">

            </c:when>
            <c:otherwise>
                <div class="so-all">
                    <div class="reminder">
                        你可以试听前三节课，开通会员后免费观看所有课程
                    </div>
                    <a class="dredge" href="${basePath}/vip">立即开通</a>
                    <span class="reminder-close"></span>
                </div>
            </c:otherwise>
        </c:choose>
        <div class="video-list">
            <div class="listLeft">
                <div class="qiehuan"></div>
            </div>
            <div class="listRight" id="listRight">
                <div class="lr-top">
                    <ul>
                        <li style="border-bottom: 2px solid #e62c3a; color: #e62c3a; ">目录</li>
                        <li style="margin-left: 20px;">资料</li>
                    </ul>
                </div>
                <div class="lr-bottom">
                    <ul id="video-id">
                        <c:forEach items="${courseLectures}" var="courseLecture">
                            <c:if test="${userStu.isVIP == true}">
                                <a title="${courseLecture.lectureName}" id="ls-${courseLecture.id}">
                                    <li <c:if test="${lectureId != courseLecture.id}">style="color: #666666;"</c:if>
                                        <c:if test="${lectureId == courseLecture.id}">style="color: #FFFFFF;"</c:if>
                                        courseId="${course.id}" lectureId="${courseLecture.id}" videoId="${courseLecture.videoUnique}" isvipVideo="${courseLecture.isvipVideo}">
                                        <c:if test="${fn:length(courseLecture.lectureName)>15 }">${ fn:substring( courseLecture.lectureName ,0,15)}...</c:if>
                                        <c:if test="${fn:length(courseLecture.lectureName)<=15 }">${courseLecture.lectureName}</c:if>
                                    </li>
                                </a>
                            </c:if>
                            <c:if test="${userStu.isVIP == false}">
                                <c:if test="${courseLecture.isvipVideo == 1}">
                                    <a title="${courseLecture.lectureName}" id="ls-${courseLecture.id}">
                                        <li <c:if test="${lectureId != courseLecture.id}">style="color: #666666;"</c:if>
                                            <c:if test="${lectureId == courseLecture.id}">style="color: #FFFFFF;"</c:if>
                                            courseId="${course.id}" lectureId="${courseLecture.id}" videoId="${courseLecture.videoUnique}" isvipVideo="${courseLecture.isvipVideo}">
                                            <c:if test="${fn:length(courseLecture.lectureName)>15 }">${ fn:substring( courseLecture.lectureName ,0,15)}...</c:if>
                                            <c:if test="${fn:length(courseLecture.lectureName)<=15 }">${courseLecture.lectureName}</c:if>
                                            <span class="lr-bottominput">试听</span>
                                        </li>
                                    </a>
                                </c:if>
                                <c:if test="${courseLecture.isvipVideo == 0}">
                                    <a title="${courseLecture.lectureName}" id="ls-${courseLecture.id}">
                                        <li <c:if test="${lectureId == courseLecture.id}">style="color: #33ff00;"</c:if>
                                            courseId="${course.id}" lectureId="${courseLecture.id}" isvipVideo="${courseLecture.isvipVideo}">
                                            <c:if test="${fn:length(courseLecture.lectureName)>15 }">${ fn:substring( courseLecture.lectureName ,0,15)}...</c:if>
                                            <c:if test="${fn:length(courseLecture.lectureName)<=15 }">${courseLecture.lectureName}</c:if>
                                        </li>
                                    </a>
                                </c:if>
                            </c:if>
                        </c:forEach>
                    </ul>
                    <!-- 讲义 -->
                    <ul style="display: none;" id="data-id">
                        <c:forEach items="${courseLectures}" var="courseLecture">
                            <c:if test="${userStu.isVIP == true && !empty courseLecture.lecturePptUrl}">
                                <a href="${basePath}/download?filePath=${courseLecture.lecturePptUrl}" title="${courseLecture.fileTitle}">
                                    <li style="color: #FFFFFF;">
                                        <c:choose>
                                            <c:when test="${fn:endsWith(courseLecture.lecturePptUrl,'.rar')}">
                                                <img src="${basePath}/resources-sjn/index/images/biaoqian.png"/>
                                            </c:when>
                                            <c:otherwise>
                                                <img src="${basePath}/resources-sjn/index/images/nono.png"/>
                                            </c:otherwise>
                                        </c:choose>
                                        <c:choose>
                                            <c:when test="${fn:length(courseLecture.fileTitle)>14 }">
                                                ${ fn:substring( courseLecture.fileTitle ,0,14)}...
                                            </c:when>
                                            <c:otherwise>
                                                ${courseLecture.fileTitle}
                                            </c:otherwise>
                                        </c:choose>
                                        <span class="lr-bottominput">下载</span>
                                    </li>
                                </a>
                            </c:if>
                            <c:if test="${userStu.isVIP == false && !empty courseLecture.lecturePptUrl}">
                                <c:if test="${courseLecture.isvipVideo == 1}">
                                    <a href="${basePath}/download?filePath=${courseLecture.lecturePptUrl}" title="${courseLecture.fileTitle}">
                                        <li style="color: #FFFFFF;">
                                            <c:choose>
                                                <c:when test="${fn:endsWith(courseLecture.lecturePptUrl,'.rar')}">
                                                    <img src="${basePath}/resources-sjn/index/images/biaoqian.png"/>
                                                </c:when>
                                                <c:otherwise>
                                                    <img src="${basePath}/resources-sjn/index/images/nono.png"/>
                                                </c:otherwise>
                                            </c:choose>
                                            <c:choose>
                                                <c:when test="${fn:length(courseLecture.fileTitle)>14 }">
                                                    ${ fn:substring( courseLecture.fileTitle ,0,14)}...
                                                </c:when>
                                                <c:otherwise>
                                                    ${courseLecture.fileTitle}
                                                </c:otherwise>
                                            </c:choose>
                                            <span class="lr-bottominput">下载</span>
                                        </li>
                                    </a>
                                </c:if>
                                <c:if test="${courseLecture.isvipVideo == 0 && !empty courseLecture.lecturePptUrl}">
                                    <a title="${courseLecture.fileTitle}">
                                        <li isUpWin=true>
                                            <c:choose>
                                                <c:when test="${fn:endsWith(courseLecture.lecturePptUrl,'.rar')}">
                                                    <img src="${basePath}/resources-sjn/index/images/biaoqian.png"/>
                                                </c:when>
                                                <c:otherwise>
                                                    <img src="${basePath}/resources-sjn/index/images/nono.png"/>
                                                </c:otherwise>
                                            </c:choose>
                                            <c:choose>
                                                <c:when test="${fn:length(courseLecture.fileTitle)>14 }">
                                                    ${ fn:substring( courseLecture.fileTitle ,0,14)}...
                                                </c:when>
                                                <c:otherwise>
                                                    ${courseLecture.fileTitle}
                                                </c:otherwise>
                                            </c:choose>
                                        </li>
                                    </a>
                                </c:if>
                            </c:if>
                        </c:forEach>
                    </ul>
                </div>

            </div>
        </div>
        <c:if test="${videoType==0}">
            <div class="video" id="playerswf"> </div>
        </c:if>
        <c:if test="${videoType==1}">
            <div class="video" id="a1"></div>
        </c:if>
    </div>
    <div class="share">
        <div class="Down">
            <div class="Downimg"></div>
            <div class="Downcontent">下载APP</div>
            <div class="Down-ewm"></div>
        </div>
        <div class="xian"></div>
        <div class="Down1">
            <div class="DownOimg"></div>
            <div class="DownOcontent">关注微信</div>
            <div class="Down1-ewm"></div>
        </div>
            <div class="xian"></div>
        <div class="fxtb">
            <div class="Ico"></div>
            <div class="fxfx">分享</div>
            <div class="duihua">
                <a>
                     <div class="weixin">
                         <script type="text/javascript">
                         (function(){
                             var p = {
                                 url:location.href, /*获取URL，可加上来自分享到QQ标识，方便统计*/
                                 desc:'', /*分享理由(风格应模拟用户对话),支持多分享语随机展现（使用|分隔）*/
                                 title:'我正在设计牛学习《${course.title}》，干货满满！你也来学吧！', /*分享标题(可选)*/
                                 summary:'${courseSummary}', /*分享摘要(可选)*/
                                 pics:'${course.coverUrl}', /*分享图片(可选)*/
                                 flash: '', /*视频地址(可选)*/
                                 site:'QQ分享', /*分享来源(可选) 如：QQ分享*/
                                 style:'202',
                                 width:24,
                                 height:24
                             };
                             var s = [];
                             for(var i in p){
                                 s.push(i + '=' + encodeURIComponent(p[i]||''));
                             }
                             document.write(['<a class="qcShareQQDiv" href="http://connect.qq.com/widget/shareqq/index.html?',s.join('&'),'" target="_blank">分享到QQ</a>'].join(''));
                         })();
                     </script>
                         <script src="http://connect.qq.com/widget/loader/loader.js" widget="shareqq" charset="utf-8"></script>
                     </div>
                 </a>
                 <a>
                     <div class="kongjian">
                         <script src="http://qzonestyle.gtimg.cn/qzone/app/qzlike/qzopensl.js#jsdate=20111201" charset="utf-8"></script>
                         <script type="text/javascript">
                             document.write(['<a href="http://sns.qzone.qq.com/cgi-bin/qzshare/cgi_qzshare_onekey?pics=${course.coverUrl}&summary=${courseSummary}&url=',
                                 encodeURIComponent(location.href),'&title=','我正在设计牛学习《${course.title}》，干货满满！你也来学吧！','" ' +
                                 'target="_blank"  title="分享到QQ空间">' +
                                 '<img src="http://qzonestyle.gtimg.cn/ac/qzone_v5/app/app_share/qz_logo.png" width="24" height="24" alt="分享到QQ空间" /><\/a>'].join(''));
                         </script>
                     </div>
                 </a>
            </div>
        </div>
        <div class="xian"></div>
        <div class="pftb">
            <div class="PIco"></div>
            <div class="pfpf">评分</div>
        </div>
        <div class="share-right">
            <span>${course.coursePlayNumber}</span>次播放
        </div>

    </div>

    <!-- <div class="answer">
        <div class="answer-nav">
            <ul>
                <li style="margin-left: 18px;">岗位职责</li>
                <li>课程简介</li>
                <li>老师介绍</li>
                <li style=" border-bottom: 2px solid #5583DB; color: #5583DB;">老师答疑</li>
            </ul>
        </div>
        <div class="answer-all">
            <div class="answer-xx" style="display: none;">${courseText.jobDuty}</div>
            <div class="answer-xx" style="display: none;">${courseText.summary}</div>
            <div class="answer-xx" style="display: none;">${teacher.introduction}</div>
            <div class="answer-xx">
                <div class="xx-one">
                    <div class="xxone-right">
                       <%-- <c:if test="${isShow == true}">
                            <div class="onerightTop">热门消息</div>
                            <div class="xsxiaoxi"><img src="${basePath}/resources/login/images/sihai_03.png"/></div>
                        </c:if>--%>
                        <div class="like">大家都在看</div>
                        <c:forEach items="${hotVideos}" var="hotVideo">
                            <div class="like-nr">
                                <div class="nr-start">
                                    <div class="stratLeft">
                                        <a href="${basePath}/course/detail/${hotVideo.courseId}"><img src="${hotVideo.coverUrl}" /></a>
                                    </div>
                                    <div class="startRight">
                                        <span class="btbt">
                                            <c:if test="${fn:length(hotVideo.title)>10 }">${ fn:substring(hotVideo.title,0,11)}...</c:if>
                                            <c:if test="${fn:length(hotVideo.title)<=10 }">${ hotVideo.title}</c:if>
                                        </span>
                                        <p>
                                            <img src="${basePath}/resources/login/images/sihai_11.png" />
                                            <span style="margin-right: 25px;">${hotVideo.playNumber}</span>
                                            <img src="${basePath}/resources/login/images/sihai_13.png" />
                                            <span>${hotVideo.commentNum}</span>
                                        </p>
                                    </div>
                                </div>
                            </div>
                        </c:forEach>
                        <c:if test="${null==hotVideos||hotVideos.isEmpty()}" >
                            <div class="like-nr">
                                <div class="zanwu" style="display: none;">
                                    <img src="${basePath}/resources/course/images/zanwu_03.png" />
                                    <p>暂无视频</p>
                                </div>
                            </div>
                        </c:if>
                    </div>
                    <div class="xxone-left">
                        <div class="oneleftTop" id="answer-num">提问（<span>0</span>条）</div>
                        <div class="onesrk" >
								<textarea style="resize:none;" placeholder="有问必答，等你来问"
                                          oninput="openMsg('#answer-textarea','#textareaLength');" id="answer-textarea"></textarea>
                            <p><span id="textareaLength">0</span>/200</p>
                        </div>
                        <div class="one-tw">
                            <div class="one-an" id="onesrk">发表提问</div>
                        </div>

                        <div id="answers-id"></div>
                    </div>

                </div>
            </div>

        </div>
    </div>-->
    <div class="curriculum-teach">
        <div class="xuanxiangka">
            <div class="xxk">
                <ul>
                    <li class="crouse_l_nav"><a>课程介绍</a></li>

                    <li><a>老师答疑</a></li>

                    <div class="members_Li">
                        <c:if test="${userStu.isVIP == false}">
                            <button class="members" id="members-1">购买会员</button>
                        </c:if>
                        <c:if test="${userStu.isVIP == true}">
                            <button class="members" id="members-2">听课</button>
                        </c:if>
                    </div>
                </ul>

            </div>
            <div class="chi">
                <div class="one" name="jieshao">
                    <div class="brief">
                        <p class="firstb"><span class="firsts">简</span>介</p>
                        <div class="lastb">${courseText.summary}</div>
                        <div class="cle"></div>
                    </div>
                   <%-- <div class="brief brieff">
                        <p class="firstb">岗位职责</p>
                        <div class="lastb">${courseText.jobDuty}</div>
                        <div class="cle"></div>
                    </div>--%>
                    <div class="brief brieF brieff">
                        <p class="firstb">老师介绍</p>
                        <div class="lastb">
                            <p class="briefImg"><img src='${teacher.imgUrl}'></p>
                            <div class="teach">
                                <p class="teachD">${teacher.flowerName}</p>
                                <p class="teaDuction">${fn:replace(teacher.introduction,vEnter,'<br />') }</p>
                            </div>
                            <div class="cle"></div>
                        </div>
                        <div class="cle"></div>
                    </div>
                </div>
                <div class="one" style="display: none;">
                    <div class="xxone-left" style="margin-right: 0px;padding: 40px 30px;">
                        <div class="oneleftTop" id="answer-num">提问（<span>0</span>条）</div>
                        <div class="onesrk"  style="width: auto;">
								<textarea style="resize:none;" placeholder="有问必答，等你来问"
                                          oninput="openMsg('#answer-textarea','#textareaLength');" id="answer-textarea"></textarea>
                            <p><span id="textareaLength">0</span>/200</p>
                        </div>
                        <div class="one-tw">
                            <div class="one-an" id="onesrk">发表提问</div>
                        </div>

                        <div id="answers-id"></div>
                    </div>
                   <!-- <ul class="catalog" id="catalog">
                        <c:forEach items="${courseLectures}" var="courseLecture">
                            <li value="${courseLecture.id}" type="${courseLecture.isvipVideo}">
                                <p>
                                    <img src="${basePath}/resources/course/images/sign.png">
                                    <span>${courseLecture.lectureName}<span>（<fmt:formatNumber type="number" value="${courseLecture.videoLength/60}" maxFractionDigits="0"/>分钟）</span></span>
                                    <c:if test="${userStu.isVIP == true}"><button>听课</button></c:if>
                                    <c:if test="${userStu.isVIP == false}">
                                        <c:if test="${courseLecture.isvipVideo == 1}"><button>试听</button></c:if>
                                    </c:if>
                                </p>
                            </li>
                        </c:forEach>
                    </ul>-->
                </div>
               <!-- <div class="one" style="display: none;" id="teacher-commen">
                    <ul class="commen" id="commen">
                        <li>
                            <div><img src="${basePath}/images/header.png"><span>史密斯</span></div>
                            <ul>
                                <li class="xing">
                                    <span></span>
                                    <span></span>
                                    <span></span>
                                    <span></span>
                                    <span class="anxing"></span>
                                </li>
                                <li class="lastLi">课程讲得非常详细，感觉自己要学的东西太多了，以后要经常来听课学习。</li>
                            </ul>
                            <span class="date">2016-08-30</span>
                        </li>
                    </ul>
                    <div class="no_Spe">
                        <div class='no_Img'><img src="${basePath}/images/norepeat.png"></div>
                        <p>暂无学员评论</p>
                    </div>
                </div>
            -->
            </div>
        </div>
        <div style="width: 372px;float: right;">
            <div class="flock">
                <span class="flock-title">加群学习</span>
                <div class="flock-content">
                    <div class="flock-left">
                        <img src="/resources-sjn/course/images/xiaoqie.png"/>
                    </div>
                    <div class="flock-right">
                        <a target="_blank" href="//shang.qq.com/wpa/qunwpa?idkey=dbf7c1bb9d9a7de20222e1c6f9ba460fb1566755e3ab495f4911dea8e39b5eb9"><p style="margin-top: 1px;color: #333333;">设计牛实战训练群</p></a>
                        <p style="color: #666;">群号：558686941</p>
                        <p style="color: #999;">老师全程服务，学习更有效</p>
                    </div>
                </div>
            </div>
            <div class="allsee">
                <div class="like">大家都在看</div>
                <c:forEach items="${hotVideos}" var="hotVideo">
                    <div class="like-nr">
                        <div class="nr-start">
                            <div class="stratLeft">
                                <a href="${basePath}/course/detail/${hotVideo.courseId}"><img src="${hotVideo.coverUrl}" /></a>
                            </div>
                            <div class="startRight">
                                <span class="btbt">
                                    <c:if test="${fn:length(hotVideo.title)>10 }">${ fn:substring(hotVideo.title,0,11)}...</c:if>
                                    <c:if test="${fn:length(hotVideo.title)<=10 }">${ hotVideo.title}</c:if>
                                </span>
                                <p>
                                    <img src="${basePath}/resources/login/images/sihai_11.png" />
                                    <span style="margin-right: 25px;">${hotVideo.playNumber}</span>
                                    <img src="${basePath}/resources/login/images/sihai_13.png" />
                                    <span>${hotVideo.commentNum}</span>
                                </p>
                            </div>
                        </div>
                    </div>
                </c:forEach>
                <c:if test="${null==hotVideos||hotVideos.isEmpty()}" >
                    <div class="like-nr">
                        <div class="zanwu">
                            <img src="${basePath}/resources/course/images/zanwu_03.png" />
                            <p>暂无视频</p>
                        </div>
                    </div>
                </c:if>
            </div>
        </div>
    </div>

    <!--评分弹窗-->
    <div class="grade-bj">
        <div class="grade">
            <div class="grade-bt">
                <span>评分</span><div class="gb"></div>
            </div>
            <div class="grade-jdt">
                <ul>
                    <li>
                        <div class="jdt-left">内容清晰：</div>
                        <div class="jdt-right">
                            <ul>
                                <li></li>
                                <li></li>
                                <li></li>
                                <li></li>
                                <li></li>
                            </ul>
                            <p><span>0</span>分</p>
                        </div>
                    </li>
                    <li>
                        <div class="jdt-left">演讲风趣：</div>
                        <div class="jdt-rightone">
                            <ul>
                                <li></li>
                                <li></li>
                                <li></li>
                                <li></li>
                                <li></li>
                            </ul>
                            <p><span>0</span>分</p>
                        </div>
                    </li>
                    <li>
                        <div class="jdt-left">视频流畅：</div>
                        <div class="jdt-righttwo">
                            <div class="fxk"><input type="radio" name="playradio" value="5">流畅不卡顿</div>
                            <div class="fxk"><input type="radio" name="playradio" value="3">偶尔卡顿</div>
                            <div class="fxk"><input type="radio" name="playradio" value="1">卡顿无法上课</div>
                        </div>
                    </li>
                </ul>
                <div class="suggest">
                    <div class="suggest-top">
                        <span class="suggestTop-l">其他建议（选填）</span><span class="suggestTop-r">可输入&nbsp;&nbsp;<span id="suggest-id">0</span>/200字</span>
                    </div>
                    <div class="suggest-bottom">
                        <textarea style="resize:none;" oninput="openMsg('#suggest-textarea','#suggest-id');" id="suggest-textarea"></textarea>
                    </div>
                </div>

            </div>
            <div>
                <div id="pfmsg" style="text-align:center;margin-top: 5px; color: red;"></div>
                <input type="submit" value="评分" class="pftj">
            </div>
        </div>
    </div>
    <!--评分弹窗-->
    <!--回复弹窗-->
    <div class="reply">
        <div class="reply-win">
            <div class="replyWin-top">
                <span>回复</span><div class="hf-gb"></div>
            </div>
            <div class="replyWin-bottom">
                <textarea></textarea>
                <div class="jinzhi"><span>0</span>/200</div>
            </div>
            <div><input type="submit" class="hftj"></div>
        </div>
    </div>
    <!--回复弹窗-->
    <!--会员弹窗-->
    <div class="hytc" style="display:none;" id="vip-video">
        <div class="tcnr">
            <div class="tcnr-top">
                <div class="tcnrgb"></div>
            </div>
            <div class="tctx">该视频需要<span id="kthy" style="cursor: pointer;">开通会员</span>才可以观看</div>
            <div class="kthy"><input type="submit" class="hytj" value="开通会员"></div>
        </div>
    </div>
    <div class="hytc" style="display:none;" id="vip-data">
        <div class="tcnr">
            <div class="tcnr-top">
                <div class="tcnrgb"></div>
            </div>
            <div class="tctx">该资料需要<span id="data-kthy" style="cursor: pointer;">开通会员</span>才可以下载</div>
            <div class="kthy"><input type="submit" class="hytj" value="开通会员"></div>
        </div>
    </div>
    <!--会员弹窗-->
    <!--成功弹窗-->
    <div class="fxtc" style="display: none;">
        <div class="undefined">
            <a><img src="/resources-sjn/index/images/bd_yes.png" /><span>分享成功</span></a>
        </div>
    </div>
    <div class="fxtc" style="display: none;" id="pfcg">
        <div class="undefined">
            <a><img src="/resources-sjn/index/images/bd_yes.png" /><span>评论成功</span></a>
        </div>
    </div>
    <div class="fxtc" style="display: none;" id="ypfcg">
        <div class="undefined">
            <a><img src="/resources-sjn/index/images/bd_yes.png" /><span>已经评过分啦</span></a>
        </div>
    </div>
    <!--成功弹窗-->
</div>

<script src="${basePath}/resources/common/swfobject/swfobject.js"></script>
<%--cc--%>
<script src="${basePath}/resources/common/js/md5.min.js"></script>
<script src="${basePath}/resources/common/js/tools1.js"></script>
<script src="${basePath}/resources/common/js/duia_util.js"></script>
<script src="${basePath}/resources/common/js/duia-des.js"></script>
<script src="${basePath}/resources/ccvideo/js/ckplayer.js"></script>
<script src="http://common.duia.com/resource/otherCcvideo/js/ccVideo.js" type="text/javascript"></script>
<script type="text/javascript" src="${basePath}/resources-sjn/course/js/videoPlay.js" ></script>
<script src="${basePath}/resources-sjn/course/js/le_yun.js"></script>
<script type="text/javascript">
    var consultDate ={pageNo:4};
    var courseId = $('#course-id').val();
    $(function(){
        $(".fxtb").hover(function(){
            $(".duihua").show();
        },function(){
            $(".duihua").hide();
        });
    });
</script>

<script type="text/javascript">
    $(function () {
        $(".xxk li").on('click', function () {
            $(".xxk li").removeClass('crouse_l_nav');
            $(this).addClass('crouse_l_nav');
            $(this).parent().parent().next().find(">div").hide().eq($(this).index()).show();

        });
        $(".reminder-close").click(function(){
            $(".so-all").css("display","none")
        })
        setTimeout(function(){
            $(".so-all").stop().animate({"bottom":"0px"},500)
        },5000)

        $("#playerswf").hover(function(){
            $(".so-all").stop().animate({"bottom":"48px"},500)
            settime = setTimeout(function(){
                $(".so-all").stop().animate({"bottom":"0px"},500)

            },7000)
        },function(){
            $(".so-all").stop().animate({"bottom":"0px"},500)
            clearTimeout(settime)
        })

        $(".so-all").hover(function(){
            $(".so-all").stop().animate({"bottom":"48px"},500)
//           settime = setTimeout(function(){
//                $(".so-all").stop().animate({"bottom":"0px"},500)
//
//            },7000)
        },function(){
//            $(".so-all").stop().animate({"bottom":"0px"},500)
//            clearTimeout(settime)
        })
    })

</script>
</body>

</html>