<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<html lang="en">
<head>
  <meta charset="UTF-8">

  <title>全部课程-设计牛</title>
  <link href="${basePath}/resources/common/css/rest.css" rel="stylesheet">
  <link href="${basePath}/resources/course/css/gap.css" rel="stylesheet"/>
  <link href="${basePath}/resources/index/css/kjs-index.css" rel="stylesheet">
  <link href="${basePath}/resources-sjn/course/css/course.css" rel="stylesheet">
  <script src="${basePath}/resources-sjn/course/js/course.js"></script>
</head>
<body>
<input type="hidden" id="is-vip" name="is-vip" value="${userStu.isVIP}">
<input type="hidden" id="industry-id" name="industry-id" value="${industryId}">
<input type="hidden" id="position-id" name="position-id" value="${positionId}">
<div class="kjsCrWid">
  <div>
    <div class="Made-nav">
      <a href="/" style="padding-left: 0;">首页</a> > <a href="/course">全部课程</a>
    </div>
    <div class="kjsCrmoure content-m-top">
      <div class="kjsCrnum1 clearfloat d" id="direction">
        <label class="fl">方向：</label>
        <a class="fl all"
           <c:if test="${directionId == null}">style="border: 1px solid #cccccc;"</c:if>
           select=<c:if test="${directionId != null}">true</c:if>>全部</a>
        <div class="kjs-a">
        <c:forEach items="${directions}" var="direction"  varStatus="status">
          <c:if test="${directionId == direction.id}">
            <a dataType="1" dataValue="${direction.id}" style="border: 1px solid #cccccc;" select=true>${direction.categoryDesc}<p class="wx-bb">${direction.categoryDesc}</p></a>
          </c:if>
          <c:if test="${directionId != direction.id}">
            <a dataType="1" dataValue="${direction.id}">
              <c:choose>
                <c:when test="${direction.categoryDesc.length()>6}">
                  ${fn:substring(direction.categoryDesc,0,5)}...
                </c:when>
                <c:otherwise>
                  ${direction.categoryDesc}
                </c:otherwise>
              </c:choose>
              <p class="wx-bb">${direction.categoryDesc}</p>
            </a>
          </c:if>
        </c:forEach>
        </div>
      </div>
      <%--<div class="kjsCrnum1 clearfloat" id="industry">
        <label class="fl">行业：</label>
        <a class="fl all" style="color: #333333;" select=<c:if test="${industryId != null}">true</c:if>>全部</a>
        <div id="industry-content" class="kjs-a clearfloat">
          <c:forEach items="${industrys}" var="industry"  varStatus="status">
            <a dataType="2" dataValue="${industry.categoryDesc}" <c:if test="${industryId == industry.id}">style="color: #333333;" select=true</c:if>>${industry.categoryDesc}</a>
          </c:forEach>
        </div>
        <span class="fr kjsmore" id="i-more" <c:if test="${industryMore == false}">style="display: none;"</c:if > dataType="2" more=true>更多</span>
        <div id="industry-more" class="loding-a clearfloat"></div>
      </div>--%>
      <div class="kjsCrnum1 clearfloat" id="position">
        <label class="fl">分类：</label>
        <a class="fl all"
           <c:if test="${positionId == null}">style="border: 1px solid #cccccc;"</c:if>
           select=<c:if test="${positionId != null}">true</c:if>>全部</a>
        <div id="position-content" class="kjs-a clearfloat">
          <c:forEach items="${positions}" var="position"  varStatus="status">
            <c:if test="${positionId == position.id}">
              <a dataType="3" dataValue="${position.id}" style="border: 1px solid #cccccc;" select=true>${position.categoryDesc}<p class="wx-bb">${position.categoryDesc}</p></a>
            </c:if>
            <c:if test="${positionId != position.id}">
              <a dataType="3" dataValue="${position.id}">

                <c:choose>
                  <c:when test="${position.categoryDesc.length()>6}">
                    ${fn:substring(position.categoryDesc,0,5)}...
                  </c:when>
                  <c:otherwise>
                    ${position.categoryDesc}
                  </c:otherwise>
                </c:choose>
                <p class="wx-bb">${position.categoryDesc}</p>
              </a>

            </c:if>
          </c:forEach>
        </div>
        <span class="fr kjsmore" id="p-more" <c:if test="${positionMore == false}">style="display: none;"</c:if> dataType="3" more=true>展开</span>
        <div id="position-more" class="loding-a clearfloat"></div>
      </div>
    </div>
  </div>
  <div class="nav" style="margin: 20px 0;">
    <div class="kjsPx fl">
      <label>排序：</label>
      <a dataType="create_Date">最新</a>
      <a dataType="course_stu_num">最热</a>
    </div>
    <div class="nav-right"><a>免费定制 >></a></div>
    <p class="nav-rightleft">量身定制学习方案，薪资平均增长36%</p>
  </div>
  <div class="kjsCrouse" id="main">
    <ul class="clearfloat">
      <c:if test="${null==courses||courses.isEmpty()}" >
        <li style="text-align: center;width: 1224px;height: auto;color:#999;padding-bottom: 100px;">
          <div style="margin: 100px 0 50px 0;"><img src="/resources/course/images/zanwu_03.png"></div>
          课程正在准备中，敬请期待...
        </li>
      </c:if>
      <c:forEach items="${courses}" var="course"  varStatus="status">
        <c:if test="${status.count % 5 == 4}">
          <li>
            <div class="kjsCimg"><a href="${basePath}/course/detail/${course.id}" target="_blank"><img src="${course.coverUrl}"> </a></div>
            <div class="kjsCTwo">
              <div class="clearfloat">
                <c:if test="${userStu.isVIP == true}">
                  <div class="kjsJd">
                    <div style="width: ${(course.finishLectureNum/course.lectureNum)*100}%;"></div>
                  </div>
                  <div class="kjsSmallj">学习了<span>${course.finishLectureNum}</span>/${course.lectureNum}课程小节</div>
                </c:if>
                <c:if test="${userStu.isVIP == false}">
                  <p class="fl kjsSttext">会员免费</p>
                  <div class="HoverRight">
                    <a href="${basePath}/course/play/${course.id}" style="display:inline-block; " target="_blank">
                      <p class="kjs_index_txt_sj">
                        <span class="dbX">试听</span>
                      </p>
                      <div class="qieh"></div>
                    </a>
                  </div>
                </c:if>
              </div>
              <div class="kjsStar">
                <div class='starNum'>学员:${course.courseStuNum}人</div>
                <div class="kjsPf clearfloat">
                  <c:if test="${course.score >= 5}">
                    <c:forEach var="x" begin="1" end="5" step="1">
                      <a class="sjn_restBG kjsXxcur"></a>
                    </c:forEach>
                  </c:if>
                  <c:if test="${course.score < 5}">
                    <c:forEach var="x" begin="1" end="${course.score}" step="1">
                      <a class="sjn_restBG kjsXxcur"></a>
                    </c:forEach>
                    <c:forEach var="x" begin="1" end="${5 - course.score}" step="1">
                      <a class="restIcon"></a>
                    </c:forEach>
                  </c:if>
                </div>
              </div>
            </div>
          </li>
        </c:if>
        <c:if test="${status.count % 5 == 3}">
          <li>
            <div class="kjsCimg"><a href="${basePath}/course/detail/${course.id}" target="_blank"><img src="${course.coverUrl}"> </a></div>
            <div class="kjsCTwo">
              <div class="clearfloat">
                <c:if test="${userStu.isVIP == true}">
                  <div class="kjsJd">
                    <div style="width: ${(course.finishLectureNum/course.lectureNum)*100}%;"></div>
                  </div>
                  <div class="kjsSmallj">学习了<span>${course.finishLectureNum}</span>/${course.lectureNum}课程小节</div>
                </c:if>
                <c:if test="${userStu.isVIP == false}">
                  <p class="fl kjsSttext">会员免费</p>
                  <div class="HoverRight">
                    <a href="${basePath}/course/play/${course.id}" style="display:inline-block; " target="_blank">
                      <p class="kjs_index_txt_sj">
                        <span class="dbX">试听</span>
                      </p>
                      <div class="qieh"></div>
                    </a>
                  </div>
                </c:if>
              </div>
              <div class="kjsStar">
                <div class='starNum'>学员:${course.courseStuNum}人</div>
                <div class="kjsPf clearfloat">
                  <c:if test="${course.score >= 5}">
                    <c:forEach var="x" begin="1" end="5" step="1">
                      <a class="sjn_restBG kjsXxcur"></a>
                    </c:forEach>
                  </c:if>
                  <c:if test="${course.score < 5}">
                    <c:forEach var="x" begin="1" end="${course.score}" step="1">
                      <a class="sjn_restBG kjsXxcur"></a>
                    </c:forEach>
                    <c:forEach var="x" begin="1" end="${5 - course.score}" step="1">
                      <a class="restIcon"></a>
                    </c:forEach>
                  </c:if>
                </div>
              </div>
            </div>
          </li>
        </c:if>
        <c:if test="${status.count % 5 == 2}">
          <li>
            <div class="kjsCimg"><a href="${basePath}/course/detail/${course.id}" target="_blank"><img src="${course.coverUrl}" ></a></div>
            <div class="kjsCTwo">
              <div class="clearfloat">
                <c:if test="${userStu.isVIP == true}">
                  <div class="kjsJd">
                    <div style="width: ${(course.finishLectureNum/course.lectureNum)*100}%;"></div>
                  </div>
                  <div class="kjsSmallj">学习了<span>${course.finishLectureNum}</span>/${course.lectureNum}课程小节</div>
                </c:if>
                <c:if test="${userStu.isVIP == false}">
                  <p class="fl kjsSttext">会员免费</p>
                  <div class="HoverRight">
                    <a href="${basePath}/course/play/${course.id}" style="display:inline-block; " target="_blank">
                      <p class="kjs_index_txt_sj">
                        <span class="dbX">试听</span>
                      </p>
                      <div class="qieh"></div>
                    </a>
                  </div>
                </c:if>
              </div>
              <div class="kjsStar">
                <div class='starNum'>学员:${course.courseStuNum}人</div>
                <div class="kjsPf clearfloat">
                  <c:if test="${course.score >= 5}">
                    <c:forEach var="x" begin="1" end="5" step="1">
                      <a class="sjn_restBG kjsXxcur"></a>
                    </c:forEach>
                  </c:if>
                  <c:if test="${course.score < 5}">
                    <c:forEach var="x" begin="1" end="${course.score}" step="1">
                      <a class="sjn_restBG kjsXxcur"></a>
                    </c:forEach>
                    <c:forEach var="x" begin="1" end="${5 - course.score}" step="1">
                      <a class="restIcon"></a>
                    </c:forEach>
                  </c:if>
                </div>
              </div>
            </div>
          </li>
        </c:if>
        <c:if test="${status.count % 5 == 1}">
          <li>
            <div class="kjsCimg"><a href="${basePath}/course/detail/${course.id}" target="_blank"><img src="${course.coverUrl}"> </a></div>
            <div class="kjsCTwo">
              <div class="clearfloat">
                <c:if test="${userStu.isVIP == true}">
                  <div class="kjsJd">
                    <div style="width: ${(course.finishLectureNum/course.lectureNum)*100}%;"></div>
                  </div>
                  <div class="kjsSmallj">学习了<span>${course.finishLectureNum}</span>/${course.lectureNum}课程小节</div>
                </c:if>
                <c:if test="${userStu.isVIP == false}">
                  <p class="fl kjsSttext">会员免费</p>
                  <div class="HoverRight">
                    <a href="${basePath}/course/play/${course.id}" style="display:inline-block; " target="_blank">
                      <p class="kjs_index_txt_sj">
                        <span class="dbX">试听</span>
                      </p>
                      <div class="qieh"></div>
                    </a>
                  </div>
                </c:if>
              </div>
              <div class="kjsStar">
                <div class='starNum'>学员:${course.courseStuNum}人</div>
                <div class="kjsPf clearfloat">
                  <c:if test="${course.score >= 5}">
                    <c:forEach var="x" begin="1" end="5" step="1">
                      <a class="sjn_restBG kjsXxcur"></a>
                    </c:forEach>
                  </c:if>
                  <c:if test="${course.score < 5}">
                    <c:forEach var="x" begin="1" end="${course.score}" step="1">
                      <a class="sjn_restBG kjsXxcur"></a>
                    </c:forEach>
                    <c:forEach var="x" begin="1" end="${5 - course.score}" step="1">
                      <a class="restIcon"></a>
                    </c:forEach>
                  </c:if>
                </div>
              </div>
            </div>
          </li>
        </c:if>
        <c:if test="${status.count % 5 eq 0 || status.count eq 5}">
          <li>
            <div class="kjsCimg"><a href="${basePath}/course/detail/${course.id}" target="_blank"><img src="${course.coverUrl}"> </a></div>
            <div class="kjsCTwo">
              <div class="clearfloat">
                <c:if test="${userStu.isVIP == true}">
                  <div class="kjsJd">
                    <div style="width: ${(course.finishLectureNum/course.lectureNum)*100}%;"></div>
                  </div>
                  <div class="kjsSmallj">学习了<span>${course.finishLectureNum}</span>/${course.lectureNum}课程小节</div>
                </c:if>
                <c:if test="${userStu.isVIP == false}">
                  <p class="fl kjsSttext">会员免费</p>
                  <div class="HoverRight">
                    <a href="${basePath}/course/play/${course.id}" style="display:inline-block; " target="_blank">
                      <p class="kjs_index_txt_sj">
                        <span class="dbX">试听</span>
                      </p>
                      <div class="qieh"></div>
                    </a>
                  </div>
                </c:if>
              </div>
              <div class="kjsStar">
                <div class='starNum'>学员:${course.courseStuNum}人</div>
                <div class="kjsPf clearfloat">
                  <c:if test="${course.score >= 5}">
                    <c:forEach var="x" begin="1" end="5" step="1">
                      <a class="sjn_restBG kjsXxcur"></a>
                    </c:forEach>
                  </c:if>
                  <c:if test="${course.score < 5}">
                    <c:forEach var="x" begin="1" end="${course.score}" step="1">
                      <a class="sjn_restBG kjsXxcur"></a>
                    </c:forEach>
                    <c:forEach var="x" begin="1" end="${5 - course.score}" step="1">
                      <a class="restIcon"></a>
                    </c:forEach>
                  </c:if>
                </div>
              </div>
            </div>
          </li>
        </c:if>
      </c:forEach>
    </ul>
  </div>
</div>
<script type="text/javascript">
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
  </script>
</body>
</html>