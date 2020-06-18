
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="/WEB-INF/view/include/taglib.jsp" %>
<html>
<head>
    <title>视频接口选择</title>
</head>
<body>
<form class="form-horizontal">
    <div class="form-group">
        <label class="col-md-3 control-label">视频播放配置</label>
        <c:if test="${option==0+''}">
            <div class="col-md-9">
                <label class="radio-inline">
                    <input name="option" value="0" checked type="radio">
                    乐视
                </label>
                <label class="radio-inline">
                    <input name="option" value="1" type="radio">
                   CC视频
                </label>
            </div>
        </c:if>
        <c:if test="${option==1+''}">
            <div class="col-md-9">
                <label class="radio-inline">
                    <input name="option" value="0" type="radio">
                    乐视
                </label>
                <label class="radio-inline">
                    <input name="option" value="1" checked  type="radio">
                    CC视频
                </label>
            </div>
        </c:if>
    </div>
</form>
<div class="form-group">
    <label class="col-md-3 control-label labelWidth"></label>
    <div class="col-md-9">
        <a id="menuSubmit"  class="btn btn-success m-r-5 m-b-5">提交</a>
    </div>
</div>
<script src="${pageContext.request.contextPath}/resources/base/operation/videoConfig.js"></script>
<script>
    $(function () {
        page.init();
    })
</script>
</body>
</html>
