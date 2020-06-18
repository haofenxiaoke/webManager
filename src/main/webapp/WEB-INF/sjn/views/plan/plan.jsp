<%@ page import="com.kjs.common.util.ParamUtil" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>确认学习计划-设计牛</title>
  <link rel="stylesheet" href="${basePath}/resources/common/css/rest.css" />
  <link rel="stylesheet" href="${basePath}/resources/course/css/plan.css" />
  <link rel="stylesheet" href="${basePath}/resources/common/layer-v2.3/layer/skin/layer.css">
  <link rel="stylesheet" href="${basePath}/resources-sjn/plan/css/plan.css" />
  <script src="${basePath}/resources/common/layer-v2.3/layer/layer.js"></script>
  <script type="text/javascript" src="${basePath}/resources/plan/js/plan.js" ></script>
  <script type="text/javascript" src="${basePath}/resources/course/js/respond.js" ></script>
  <style>
    .play-close{position: absolute;right: 10px;top:10px;cursor: pointer;}
    .play-tc{display:block;width:450px;height:260px;background: #fff;border-radius: 3px;position: fixed;top:0;left:0;bottom:0;right:0;margin:auto;z-index: 1000;}
    .play-black{width: 100%;height: 100%;background: url(${basePath}/resources/userCenter/images/kjs-tcBg.png) repeat;
      position: fixed;z-index: 999;top:0;left:0;display:block;}
    .play-tc-tittle{width: 160px;margin:0 auto;text-align: center;position: relative;top:60px;}
    .play-tc-tittle span{font-size: 18px;padding: 0 10px;background: #fff;position: relative;z-index: 2;color:#333;}
    .play-tc-tittle p{width: 160px;border-bottom:1px solid #ccc;position: absolute;z-index: 1;top:12px;}
    .play-tc ul{width: 240px;margin: 80px auto 0 auto;}
    .play-tc li{font-size: 16px;line-height: 16px; color:#666;position: relative;margin-bottom: 10px;}
    .play-tc ul span{display: block;width: 5px;height: 5px;background: #333333;border-radius: 100px;position: absolute;top:5px;left: -10px;}
  </style>
</head>
<body>
<input type="hidden" id="product-id" name="product-id" value="<%=ParamUtil.PRODUCT_ID%>"/>
<input type="hidden" id="is-vip" name="is-vip" value="${userStu.isVIP}">
<input type="hidden" id="user-id" name="user-id" value="${userStu.userid}">
<input type="hidden" id="direction-id" name="direction-id" value="${directionId}">
<input type="hidden" id="industry-id" name="industry-id" value="${industryId}">
<input type="hidden" id="position-id" name="position-id" value="${positionId}">
<input type="hidden" id="cate-id" name="position-id" value="${positionId}">
<div class="buy-all">
  <div class="buy-nav">
    <a href="${basePath}/" style="padding-left: 0px;">首页</a> > <a onclick="javascript:history.back(-1);">课程定制</a> > <a>学习计划</a>
  </div>
  <div class="plan-top">
    <ul>
      <c:forEach items="${plantags}" var="plantag"  varStatus="status">
        <li>
          <div class="quyu">
            <p class="xinsui">${plantag.content}</p>
          </div>
        </li>
      </c:forEach>
      <li>
        <div class="xuexitime" style="border-right: 0px;">
          <p class="">当前学习人数：
            <span>
              <small>
                <c:if test="${planDto.courseStuNum >= planInfo.currentStuNum}">
                  ${planDto.courseStuNum}
                </c:if>
                <c:if test="${planDto.courseStuNum < planInfo.currentStuNum}">
                  ${planInfo.currentStuNum}
                </c:if>
              </small>
            </span>
          </p>
          <p class="">每天平均学习时长：<span><small>${planInfo.dayStuHour}</small>小时</span>
          </p>
        </div>
      </li>
    </ul>
    <div class="dw-plan">
        ${position.categoryDesc}
    </div>
  </div>

  <div class="plan-bottom">
    <div class="plan-nr">
      <c:forEach items="${planDetails}" var="planDetail"  varStatus="status">
        <c:if test="${status.count % 2 != 0}">
          <div class="bottomnrLeft">
            <div class="kcjd">
              <div class="kcjd-top">
                <a href="${basePath}/course/detail/${planDetail.courseId}" target="_blank"><img src="${planDetail.coverUrl}" /></a>
              </div>
              <div class="kcjd-bottom">
                <div class="jdtxiaojie">
                  <c:if test="${userStu.isVIP == true}">
                    <div class="xiaojie-left">
                      <div class="jdt-bj" style="width: ${(planDetail.finishLectureNum/planDetail.lectureNum)*100}%;"></div>
                    </div>
                    <div class="xiaojie-right">
                      学习了<span style="color: #e62c3a;">${planDetail.finishLectureNum}</span>/<span>${planDetail.lectureNum}</span>课程小节
                    </div>
                  </c:if>
                </div>
                <div class="xueyuan">
                  <div class="kjsPfx clearfloat">
                    <div class="xueyuan-right">
                   <div class="xueyuan-bj" style="width: ${planDetail.courseScore*20}%;"></div>
                    <%--<a class="restIcon"></a>
                    <a class="restIcon"></a>
                    <a class="restIcon"></a>
                    <a class="restIcon"></a>
                    <a class="restIcon"></a>--%>
                      </div>
                  </div>
                  <div class="xueyuan-left">学员：<span>${planDetail.courseStuNum}</span>人</div>

                </div>
              </div>
            </div>
            <div class="dengji">
              <div class="dengji-nr">
                <div class="dengjiBt">
                  <c:if test="${fn:length(planDetail.title)>11 }">${ fn:substring(planDetail.title,0,11)}...</c:if>
                  <c:if test="${fn:length(planDetail.title)<=11 }">${ planDetail.title}</c:if>
                </div>
                <div class="shichang">时长：<span>${planDetail.planDay}</span>天</div>
                <div class="scxj">
                  <div class="xijie">
                    <p class="xijieBt">每天</p>
                    <p><span>${planDetail.stageHour}</span>小时</p>
                  </div>

                  <div class="xijie">
                    <p class="xijieBt">听课</p>
                    <p><span>${planDetail.stageLectureNode}</span>节</p>
                  </div>

                  <div class="xijie">
                    <p class="xijieBt">资料</p>
                    <p><span>${planDetail.stageDataNode}</span>节</p>
                  </div>
                </div>
                <div class="chakan">
                  <c:if test="${planDetail.learningIdeas!=null}">
                    <p style="display: none">${planDetail.learningIdeas}</p>
                   <c:if test="${fn:length(planDetail.learningIdeas)>25 }"><a>学习方法</a></c:if>
                  </c:if>
                </div>
              </div>
            </div>
            <div class="fudong">
              第${planDetail.planStage}阶段
            </div>
          </div>
        </c:if>
        <c:if test="${status.count % 2 == 0}">
          <div class="bottomnrRight">
            <div class="kcjd">
              <div class="kcjd-top">
               <a href="${basePath}/course/detail/${planDetail.courseId}" target="_blank"> <img src="${planDetail.coverUrl}" /></a>
              </div>
              <div class="kcjd-bottom">
                <div class="jdtxiaojie">
                  <c:if test="${userStu.isVIP == true}">
                    <div class="xiaojie-left">
                      <div class="jdt-bj" style="width: ${(planDetail.finishLectureNum/planDetail.lectureNum)*100}%;"></div>
                    </div>
                    <div class="xiaojie-right">
                      学习了<span style="color: #e62c3a;">${planDetail.finishLectureNum}</span>/<span>${planDetail.lectureNum}</span>课程小节
                    </div>
                  </c:if>
                </div>
                <div class="xueyuan">
                  <div class="kjsPfx clearfloat">
                  <div class="xueyuan-right">
                    <div class="xueyuan-bj" style="width: ${planDetail.courseScore*20}%;"></div>
                   <%-- <a class="sjn_restBG kjsXxcur"></a>
                    <a class="restIcon"></a>
                    <a class="restIcon"></a>
                    <a class="restIcon"></a>
                    <a class="restIcon"></a>--%>
                   </div>

                  </div>
                  <div class="xueyuan-left">学员：<span>${planDetail.courseStuNum}</span>人</div>

                </div>
              </div>
            </div>
            <div class="dengji">
              <div class="dengji-nr">
                <div class="dengjiBt">
                  <c:if test="${fn:length(planDetail.title)>11 }">${ fn:substring(planDetail.title,0,11)}...</c:if>
                  <c:if test="${fn:length(planDetail.title)<=11 }">${ planDetail.title}</c:if>
                </div>
                <div class="shichang">时长：<span>${planDetail.planDay}</span>天</div>
                <div class="scxj">
                  <div class="xijie">
                    <p class="xijieBt">每天</p>
                    <p><span>${planDetail.stageHour}</span>小时</p>
                  </div>

                  <div class="xijie">
                    <p class="xijieBt">听课</p>
                    <p><span>${planDetail.stageLectureNode}</span>节</p>
                  </div>

                  <div class="xijie">
                    <p class="xijieBt">资料</p>
                    <p><span>${planDetail.stageDataNode}</span>节</p>
                  </div>
                </div>
                <div class="chakan">
                  <c:if test="${planDetail.learningIdeas!=null}">
                    <p style="display: none">${planDetail.learningIdeas}</p>
                    <c:if test="${fn:length(planDetail.learningIdeas)>25 }"><a>学习方法</a></c:if>
                  </c:if>
                </div>
              </div>
            </div>
            <div class="fudong">
              第${planDetail.planStage}阶段
            </div>
          </div>
        </c:if>
      </c:forEach>
      <div class="goumai">
        <p class="qixian">消耗计划数：<span>1</span></p>
        <div>
          <c:if test="${userStu.isVIP == false}">
            <input type="button" value="确定" class="consume" id="vip-no" datatype="${vipInfo.id}">
          </c:if>
          <c:if test="${userStu.isVIP == true}">
            <input type="button" value="确定" class="consume" id="vip-ok">
          </c:if>
        </div>
      </div>
    </div>

  </div>
  <div class="play-tc js-tc" id="ideas" style="display: none">
    <%--<img src="${basePath}/resources/userCenter/images/play-close.png" class="play-close js-close" />--%>
    <div class="close-btn" id="ideas-close"></div>
    <div class="play-tc-tittle">
      <p></p>
      <span>学习方法</span>
    </div>
    <ul id="ideas-ul">
    </ul>
  </div>
  <div class="play-black js-black" style="display: none" ></div>

</div>
</body>
</html>
