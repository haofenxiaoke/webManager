<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" contentType="text/html; UTF-8" %>
<%@include file="/WEB-INF/view/include/taglib.jsp" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <title>直播系统-直播课配置</title>
  <link href="${pageContext.request.contextPath}/resources/common/switch/css/bootstrap-switch.min.css" rel="stylesheet" />
  <link href="${path}/resources/assets/plugins/jquery-file-upload/css/jquery.fileupload.css" rel="stylesheet">
  <style>
    .media .media-left img{width:180px;height:258px;overflow:hidden;}
    .media img{width:140px;height:120px;overflow:hidden;}
    div .stats-info{width:180px;height:100px;overflow:hidden;}
    div .liveTitle{width:180px;height:60px;overflow:hidden;font-size:20px;text-align:center}
    #saveHotForm .control-label input{width:132px;}
  </style>
</head>
<body>
<div class="row">

  <div class="col-md-12" style="width:100%;">
    <div class="panel panel-inverse">
      <div class="panel-heading">
        <div class="panel-heading-btn">
        </div>
        <h4 class="panel-title">直播课配置</h4>
      </div>
      <div class="panel-body">
        <div class="form-group">
          <div class="col-md-12"><h3>直播课配置 </h3></div>
          <div class="col-md-12">
            <label class="control-label">
              <div class="widget widget-stats bg-green">
                <div class="stats-info"data-toggle="modal" href="#live-img-alert" data-bgColor="${liveCarousel.bgcolor1}"
                     hideData="1#${liveCarousel.carouselId1}#${liveCarousel.hrefUrl1}#${liveCarousel.type1}#${liveCarousel.categoryId1}#${liveCarousel.courseId1}">
                  <div class="liveTitle">
                      ${liveCarousel.liveTitle1}
                  </div>
                </div>
                <div class="stats-link">
                  <shiro:hasPermission name="liveConfig:delete">
                    <a href="javascript:;" onclick="page.delLiveCarousel(${liveCarousel.carouselId1});">删除</a>
                  </shiro:hasPermission>
                </div>
              </div>
            </label>
            <label class="control-label">
              <div class="widget widget-stats bg-green">
                <div class="stats-info"data-toggle="modal" href="#live-img-alert" data-bgColor="${liveCarousel.bgcolor2}"
                     hideData="2#${liveCarousel.carouselId2}#${liveCarousel.hrefUrl2}#${liveCarousel.type2}#${liveCarousel.categoryId2}#${liveCarousel.courseId2}">
                  <div class="liveTitle">
                        ${liveCarousel.liveTitle2}
                  </div>
                </div>
                <div class="stats-link">
                  <shiro:hasPermission name="liveConfig:delete">
                    <a href="javascript:;"  onclick="page.delLiveCarousel(${liveCarousel.carouselId2});">删除</a>
                  </shiro:hasPermission>
                </div>
              </div>
            </label>
            <label class="control-label">
              <div class="widget widget-stats bg-green">
                <div class="stats-info"data-toggle="modal" href="#live-img-alert" data-bgColor="${liveCarousel.bgcolor3}"
                     hideData="3#${liveCarousel.carouselId3}#${liveCarousel.hrefUrl3}#${liveCarousel.type3}#${liveCarousel.categoryId3}#${liveCarousel.courseId3}">
                  <div class="liveTitle">
                      ${liveCarousel.liveTitle3}
                  </div>
                </div>
                <div class="stats-link">
                  <shiro:hasPermission name="liveConfig:delete">
                    <a href="javascript:;" onclick="page.delLiveCarousel(${liveCarousel.carouselId3});">删除</a>
                  </shiro:hasPermission>
                </div>
              </div>
            </label>
            <label class="control-label">
              <div class="widget widget-stats bg-green">
                <div class="stats-info"data-toggle="modal" href="#live-img-alert" data-bgColor="${liveCarousel.bgcolor4}"
                     hideData="4#${liveCarousel.carouselId4}#${liveCarousel.hrefUrl4}#${liveCarousel.type4}#${liveCarousel.categoryId4}#${liveCarousel.courseId4}">
                  <div class="liveTitle">
                      ${liveCarousel.liveTitle4}
                  </div>
                </div>
                <div class="stats-link">
                  <shiro:hasPermission name="liveConfig:delete">
                    <a href="javascript:;" onclick="page.delLiveCarousel(${liveCarousel.carouselId4});">删除</a>
                  </shiro:hasPermission>
                </div>
              </div>
            </label>
            <label class="control-label">
              <div class="widget widget-stats bg-green">
                <div class="stats-info"data-toggle="modal" href="#live-img-alert" data-bgColor="${liveCarousel.bgcolor5}"
                     hideData="5#${liveCarousel.carouselId5}#${liveCarousel.hrefUrl5}#${liveCarousel.type5}#${liveCarousel.categoryId5}#${liveCarousel.courseId5}">
                  <div class="liveTitle">
                      ${liveCarousel.liveTitle5}
                  </div>
                </div>
                <div class="stats-link">
                  <shiro:hasPermission name="liveConfig:delete">
                    <a href="javascript:;" onclick="page.delLiveCarousel(${liveCarousel.carouselId5});">删除</a>
                  </shiro:hasPermission>
                </div>
              </div>
            </label>
            <div  style="background-color:#ccc;">
              <h4><strong id="data-collect">最近7天观看记录</strong></h4>
            </div>
            <table id="live-table" class="table table-striped table-bordered" width="100%">
              <thead>
                <tr >
                  <td>课程</td>
                  <c:forEach items="${liveTimes}" var="liveTime">
                    <td>${liveTime}</td>
                  </c:forEach>
                </tr>
                <c:if test="${ empty liveIds}">
                  <tr class="odd">
                    <td valign="top" colspan="10" class="dataTables_empty">尚未配置课程</td>
                  </tr>
                </c:if>
                <c:if test="${ !empty liveIds}">
                    <c:forEach items="${liveNumMap.numMap}" var="numById">
                      <tr>
                        <td> ${numById.liveTitle}</td>
                          <c:if test="${ empty numById.numList}">
                            <c:forEach begin="1" end="7" step="1">
                              <td>${0}</td>
                            </c:forEach>
                          </c:if>
                          <c:if test="${!empty numById.numList}">
                              <c:forEach items="${numById.numList}" var="num"  varStatus="var">
                                  <td>${num}</td>
                            </c:forEach>
                          </c:if>
                      </tr>
                    </c:forEach>
                </c:if>
              </thead>
            </table>
          </div>
        </div>
      </div>
    </div>
  </div>
</div>

<!-- 弹出框 -->
<div class="modal fade" id="live-img-alert">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="panel panel-inverse">
        <div class="panel-heading">
          <div class="panel-heading-btn">
            <button type="button" class="btn btn-xs btn-icon btn-circle btn-danger" data-dismiss="modal" aria-hidden="true"><i class="fa fa-times"></i></button>
          </div>
          <div class="panel-title">直播课配置</div>
        </div>
      </div>
      <div class="panel-body">
        <form id="live-config-form" class="form-horizontal">
          <input type="hidden" name="orderNum" id="live-search-orderNum" value="">
          <input type="hidden" name="courseId" id="live-search-id" value="">
          <input type="hidden" name="courseId" id="live-search-cate" value="">
          <input type="hidden" name="courseId" id="live-search-course" value="">
          <div class="form-group">
            <label class="col-md-2 control-label">方向</label>
            <div class="col-md-4">
              <select class="form-control" id="cate-select-find" name="categoryId">
                <option value="" selected>请选择方向</option>
              </select>
            </div>
          </div>
          <div class="form-group">
            <label  class="col-md-2 control-label">类型</label>

                <label class="checkbox-inline">
                  <input type="radio"  name="type" id="optionsRadios1" value="0" checked /> 会员直播课
                </label>
                <label class="checkbox-inline">
                  <input type="radio"  name="type" id="optionsRadios2" value="1" /> 公开课
                </label>
            </div>

          <div class="form-group">
            <label class="col-md-2 control-label">课程</label>
            <div class="col-md-4">
              <select class="form-control" id="course-select-find" name="courseId">
                <option value="" selected>请选择课程</option>
              </select>
            </div>
          </div>
        </form>
      </div>
      <input type="hidden" name="categoryId" id="cate-search-id" value="">
      <input type="hidden" name="type" id="live-search-type" value="">
      <div class="modal-footer">
        <shiro:hasPermission name="liveConfig:save">
        <a id="liveCarouselSave"  href="javascript:;" class="btn btn-sm btn-success">确定</a>
        <a id="close-img" href="javascript:;" class="btn btn-sm btn-info" data-dismiss="modal">取消</a>
        </shiro:hasPermission>
      </div>
    </div>
  </div>

</div>
<!-- end -->
<script src="${pageContext.request.contextPath}/resources/common/switch/js/bootstrap-switch.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/assets/plugins/jquery-file-upload/js/jquery.fileupload.all.js"></script>
<script src="${pageContext.request.contextPath}/resources/assets/plugins/bootstrapValidator/js/bootstrapValidator.js"></script>
<script src="${pageContext.request.contextPath}/resources/base/course/live_config.js"></script>
<script>
    $(function () {
        page.init();
    })
</script>
</body>
</html>