<%@ page import="com.kjs.common.util.ParamUtil" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>定制学习计划-设计牛</title>
  <link rel="stylesheet" href="${basePath}/resources/common/css/rest.css" />
  <link rel="stylesheet" href="${basePath}/resources/course/css/customMade.css" />
  <link rel="stylesheet" href="${basePath}/resources-sjn/plan/css/plan_made.css" />
  <script type="text/javascript" src="${basePath}/resources/course/js/respond.js" ></script>
  <script type="text/javascript" src="${basePath}/resources/plan/js/plan.js" ></script>
</head>
<body>
<input type="hidden" id="product-id" name="product-id" value="<%=ParamUtil.PRODUCT_ID%>"/>
<input type="hidden" id="is-vip" name="is-vip" value="${userStu.isVIP}">
<input type="hidden" id="user-id" name="user-id" value="${userStu.userid}">
<input type="hidden" id="user-center" name="user-center" value="${userCenter}">
<input type="hidden" id="direction-id" name="direction-id"/>
<input type="hidden" id="position-id" name="position-id"/>
<input type="hidden" id="industry-id" name="industry-id"/>
<div class="Made-all">
  <div class="Made-nav">
    <a href="/" style="padding-left: 0px;">首页</a> > <a href="#">课程定制</a>
  </div>
  <div class="Heg content-m-top">
    <div class="Made-bottom">
      <div class="MadeBt">免费定制学习方案，薪资平均增长36%</div>
      <div class="Made-sr">
        <div class="post" id="postShow">
          <input type="text" onmousemove="this.style='cursor:pointer'" style="color:gray" value="选择方向" onfocus="if(this.value=='选择方向'){this.value=''};this.style.color='#666';" onblur="if(this.value==''||this.value=='选择方向'){this.value='选择方向';this.style.color='#333';}"  readonly="true"/>
          <div class="postShow"></div>
        </div>

        <div class="industry" id="industryShow" >
          <input type="text" style="color:gray" onmousemove="this.style='cursor:pointer'" value="选择分类" onfocus="if(this.value=='选择分类'){this.value=''};this.style.color='#666';" onblur="if(this.value==''||this.value=='选择分类'){this.value='选择分类';this.style.color='#333';}" readonly="true"/>
          <div class="industryShow"></div>

        </div>

        <div class="kecheng" id="kecheng">课程定制</div>
      </div>

      <div class="xskPost">
        <div class="jiaoyu" style="border:0px;">
          <ul>
            <c:forEach items="${directions}" var="direction"  varStatus="status">
              <li direction-id="${direction.id}">${direction.categoryDesc}</li>
            </c:forEach>
          </ul>
        </div>
        <%--<c:forEach items="${directions}" var="direction"  varStatus="status">
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
        </c:forEach>--%>
      </div>
      <div class="sanjiao"></div>
      <div class="sanjiaoBorder"></div>
      <div class="xskIndustry">
        <div class="shangye">
          <ul>
          <c:forEach items="${positions}" var="position"  varStatus="status">
            <li position-id="${position.id}">${position.categoryDesc}</li>
          </c:forEach>
          </ul>
        </div>
      </div>
      <div class="xsanjiao"></div>
      <div class="xsanjiaoBorder"></div>
    </div>
  </div>
</div>
<script type="text/javascript" src="${basePath}/resources-sjn/course/js/customMade.js" ></script>
</body>
</html>
