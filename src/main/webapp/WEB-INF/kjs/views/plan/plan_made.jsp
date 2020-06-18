<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<html lang="zh">
<head>
  <meta charset="UTF-8">
  <title>定制学习计划-好分课堂</title>
  <link rel="stylesheet" href="${basePath}/resources/common/css/rest.css" />
  <link rel="stylesheet" href="${basePath}/resources/course/css/customMade.css" />
  <script src="${basePath}/resources/common/js/jquery-1.9.1.js"></script>
  <script type="text/javascript" src="${basePath}/resources/course/js/respond.js" ></script>
  <script type="text/javascript" src="${basePath}/resources/plan/js/plan.js" ></script>
  <script type="text/javascript" src="${basePath}/resources/course/js/respond.js" ></script>
</head>
<body>
<input type="hidden" id="is-vip" name="is-vip" value="${userStu.isVIP}">
<input type="hidden" id="user-id" name="user-id" value="${userStu.userid}">
<input type="hidden" id="user-center" name="user-center" value="${userCenter}">
<input type="hidden" id="direction-id" name="direction-id"/>
<input type="hidden" id="position-id" name="position-id"/>
<input type="hidden" id="industry-id" name="industry-id"/>
<div class="Made-all">
  <div class="Made-nav">
    <a href="/" style="padding-left: 0px;">首页</a> <img class="old" src="/resources/live/images/jiao2.png"/> <a href="#">课程定制</a>
  </div>
  <div class="Heg content-m-top">
    <div class="Made-bottom">
      <div class="MadeBt">免费定制学习方案，薪资平均增长36%</div>
      <div class="Made-sr">
        <div class="post" id="postShow">
          <input type="text" onmousemove="this.style='cursor:pointer'" style="color:gray" value="选择职位" onfocus="if(this.value=='选择职位'){this.value=''};this.style.color='#666';" onblur="if(this.value==''||this.value=='选择职位'){this.value='选择职位';this.style.color='#333';}"  readonly="true"/>
          <div class="postShow"></div>
        </div>

        <div class="industry" id="industryShow" >
          <input type="text" style="color:gray" onmousemove="this.style='cursor:pointer'" value="选择行业" onfocus="if(this.value=='选择行业'){this.value=''};this.style.color='#666';" onblur="if(this.value==''||this.value=='选择行业'){this.value='选择行业';this.style.color='#333';}" readonly="true"/>
          <div class="industryShow"></div>

        </div>

        <div class="kecheng" id="kecheng">课程定制</div>
      </div>

      <div class="xskPost">
        <c:forEach items="${directions}" var="direction"  varStatus="status">
          <div class="jiaoyu" style=" margin-top: 20px;">
            <p>${direction.categoryDesc}</p>
            <ul>
              <c:forEach items="${positions}" var="position"  varStatus="status">
                <c:if test="${position.directionId == direction.id}">
                  <li  position-id="${position.id}" direction-id="${position.directionId}">${position.categoryDesc}</li>
                </c:if>
              </c:forEach>
            </ul>
          </div>
        </c:forEach>
      </div>
      <div class="sanjiao"></div>
      <div class="sanjiaoBorder"></div>
      <div class="xskIndustry">
        <div class="shangye">
          <ul>
          <c:forEach items="${industrys}" var="industry"  varStatus="status">
            <li industry-id="${industry.id}">${industry.categoryDesc}</li>
          </c:forEach>
          </ul>
        </div>
      </div>
      <div class="xsanjiao"></div>
      <div class="xsanjiaoBorder"></div>
    </div>
  </div>
</div>
<script type="text/javascript" src="${basePath}/resources/course/js/customMade.js" ></script>
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
</script>
</body>
</html>
