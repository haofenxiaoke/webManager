<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<c:set var="path" value="${pageContext.request.contextPath}"/>
<c:set var="pid" value="<%=com.kjs.common.bean.ParamUtil.PRODUCT_ID %>"/>
<c:set var="pname" value="<%=com.kjs.common.bean.ParamUtil.PRODUCT_NAME %>"/>
<c:set var="cate1" value="<%=com.kjs.common.bean.ParamUtil.CATE_1 %>"/>
<c:set var="cate2" value="<%=com.kjs.common.bean.ParamUtil.CATE_2 %>"/>
<c:set var="cate3" value="<%=com.kjs.common.bean.ParamUtil.CATE_3 %>"/>
<%-- 浏览器兼容问题 --%>
