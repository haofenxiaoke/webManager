<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" contentType="text/html; UTF-8" %>
<%@include file="/WEB-INF/view/include/taglib.jsp" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <title>${pname}管理系统-app轮播图配置</title>
  <link href="${pageContext.request.contextPath}/resources/common/switch/css/bootstrap-switch.min.css" rel="stylesheet" />
  <link href="${path}/resources/assets/plugins/jquery-file-upload/css/jquery.fileupload.css" rel="stylesheet">
  <style>
    .media .media-left img{width:180px;height:258px;overflow:hidden;}
    .media img{width:140px;height:120px;overflow:hidden;}
    .control-label img{width:110px;height:80px;overflow:hidden;}
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
        <h4 class="panel-title">轮播图配置</h4>
      </div>
      <div class="panel-body">
        <div class="form-group">
          <div class="col-md-12"><h3>轮播图配置  <span style="font-size: 12px;color: #666666;display: inline-block;">  仅支持图片格式，图片需要小于1M。</span></h3></div>
          <div class="col-md-12">
            <label class="control-label">
              <div class="widget widget-stats bg-green">
                <div class="stats-info">
                  <img id="preview-image-carousel1"  alt="上传图片" class="img-thumbnail" data-toggle="modal"
                       href="#app-img-alert" src="${appCarousel.carouselUrl1}" data-bgColor="${appCarousel.bgcolor1}"
                       hideData="1#${appCarousel.carouselId1}#${appCarousel.hrefUrl1}#${appCarousel.type1}"/>
                </div>
                <div class="stats-link">
                  <shiro:hasPermission name="appCarousel:delete:0">
                    <a href="javascript:;" onclick="delCarouselImg(${appCarousel.carouselId1});">删除</a>
                  </shiro:hasPermission>
                </div>
              </div>
            </label>
            <label class="control-label">
              <div class="widget widget-stats bg-green">
                <div class="stats-info">
                  <img id="preview-image-carousel2"  alt="上传图片" class="img-thumbnail" data-toggle="modal"
                       href="#app-img-alert" src="${appCarousel.carouselUrl2}" data-bgColor="${appCarousel.bgcolor2}"
                       hideData="2#${appCarousel.carouselId2}#${appCarousel.hrefUrl2}#${appCarousel.type2}"/>
                </div>
                <div class="stats-link">
                  <shiro:hasPermission name="appCarousel:delete:0">
                    <a href="javascript:;" onclick="delCarouselImg(${appCarousel.carouselId2});">删除</a>
                  </shiro:hasPermission>
                </div>
              </div>
            </label>
            <label class="control-label">
              <div class="widget widget-stats bg-green">
                <div class="stats-info">
                  <img id="preview-image-carousel3"  alt="上传图片" class="img-thumbnail" data-toggle="modal"
                       href="#app-img-alert" src="${appCarousel.carouselUrl3}" data-bgColor="${appCarousel.bgcolor3}"
                       hideData="3#${appCarousel.carouselId3}#${appCarousel.hrefUrl3}#${appCarousel.type3}"/>
                </div>
                <div class="stats-link">
                  <shiro:hasPermission name="appCarousel:delete:0">
                    <a href="javascript:;" onclick="delCarouselImg(${appCarousel.carouselId3});">删除</a>
                  </shiro:hasPermission>
                </div>
              </div>
            </label>
            <label class="control-label">
              <div class="widget widget-stats bg-green">
                <div class="stats-info">
                  <img id="preview-image-carousel4"  alt="上传图片" class="img-thumbnail" data-toggle="modal"
                       href="#app-img-alert" src="${appCarousel.carouselUrl4}" data-bgColor="${appCarousel.bgcolor4}"
                       hideData="4#${appCarousel.carouselId4}#${appCarousel.hrefUrl4}#${appCarousel.type4}"/>
                </div>
                <div class="stats-link">
                  <shiro:hasPermission name="appCarousel:delete:0">
                    <a href="javascript:;" onclick="delCarouselImg(${appCarousel.carouselId4});">删除</a>
                  </shiro:hasPermission>
                </div>
              </div>
            </label>
            <label class="control-label">
              <div class="widget widget-stats bg-green">
                <div class="stats-info">
                  <img id="preview-image-carousel5"  alt="上传图片" class="img-thumbnail" data-toggle="modal"
                       href="#app-img-alert" src="${appCarousel.carouselUrl5}" data-bgColor="${appCarousel.bgcolor5}"
                       hideData="5#${appCarousel.carouselId5}#${appCarousel.hrefUrl5}#${appCarousel.type5}"/>
                </div>
                <div class="stats-link">
                  <shiro:hasPermission name="appCarousel:delete:0">
                    <a href="javascript:;" onclick="delCarouselImg(${appCarousel.carouselId5});">删除</a>
                  </shiro:hasPermission>
                </div>
              </div>
            </label>
            <label class="control-label">
              <div class="widget widget-stats bg-green">
                <div class="stats-info">
                  <img id="preview-image-carousel6"  alt="上传图片" class="img-thumbnail" data-toggle="modal"
                       href="#app-img-alert" src="${appCarousel.carouselUrl6}" data-bgColor="${appCarousel.bgcolor6}"
                       hideData="6#${appCarousel.carouselId6}#${appCarousel.hrefUrl6}#${appCarousel.type6}"/>
                </div>
                <div class="stats-link">
                  <shiro:hasPermission name="appCarousel:delete:0">
                    <a href="javascript:;" onclick="delCarouselImg(${appCarousel.carouselId6});">删除</a>
                  </shiro:hasPermission>
                </div>
              </div>
            </label>
          </div>
        </div>
      </div>
    </div>
  </div>
</div>
<!-- 弹出框 -->
<div class="modal fade" id="app-img-alert">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="panel panel-inverse">
        <div class="panel-heading">
          <div class="panel-heading-btn">
            <button type="button" class="btn btn-xs btn-icon btn-circle btn-danger" data-dismiss="modal" aria-hidden="true"><i class="fa fa-times"></i></button>
          </div>
          <div class="panel-title">图片配置</div>
        </div>
      </div>
      <div class="panel-body">
        <form id="appImgForm" class="form-horizontal">
          <div class="form-group">
            <label  class="col-md-2 control-label">图片</label>
            <div class="col-md-4">
              <img id="preview-image"  alt="图片" class="img-thumbnail" />
              <span class="btn btn-primary btn-sm fileinput-button">
                <i class="glyphicon glyphicon-plus"></i>
                <span>上传</span>
                <input type="file" id="imageFile" name="imageFile">
                <input type="hidden" id="image-path" name="carouseImage" value="">
              </span>
            </div>
          </div>
          <div class="form-group">
            <label  class="col-md-2 control-label">类型</label>
            <div class="col-md-4">
                <label class="checkbox-inline">
                  <input type="radio"  name="type" id="optionsRadios1" value="1" checked /> 链接
                </label>
                <label class="checkbox-inline">
                  <input type="radio"  name="type" id="optionsRadios2" value="2" /> 功能
                </label>
            </div>
          </div>
          <div class="form-group">
            <input type="hidden" id="imageId" name = "id"/>
            <input type="hidden" id="imageOrderNum" name = "orderNum"/>
            <input type="hidden" class="form-control" id="pathUrl" name="pathUrl">
            <div style="display: none;" id="type-href">
              <label  class="col-md-2 control-label">链接地址</label>
              <div class="col-md-4">
                <input type="text" class="form-control" id="hrefUrl" name="hrefUrl" style="width:440px;" value="" >
                <ul  class="parsley-errors-list filled">
                  <li name="ErrorTip" class="parsley-required"></li>
                </ul>
              </div>
              
            </div>
            <div style="display: none;" id="type-code">
              <label  class="col-md-2 control-label">功能名称</label>
              <div class="col-md-4">
                <select id="code-type" name="hrefUrl" class="form-control" style="width: 200px;">
                  <option value="1">开通会员</option>
                  <c:if test="${pid == 'kjs'}">
                    <option value="2">直播测试</option>
                  </c:if>
                </select>
              </div>
            </div>
          </div>
        </form>
      </div>
      <div class="modal-footer">
        <shiro:hasPermission name="appCarousel:save:0">
        <a id="appCarouselSave"  href="javascript:;" class="btn btn-sm btn-success">确定</a>
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
<script src="${pageContext.request.contextPath}/resources/base/appCarousel/appCarousel.js"></script>
<script>
  $(document).ready(function() {
    //初始化文件上传插件
    initFileupload('imageFile','preview-image','course-image-path');

    $("input[name='type']").bind("click",function(){
      var svalue = $(this).val();
      var href = $('#type-href');
      var code = $('#type-code');
      href.css('display','none');
      code.css('display','none');
      if (svalue == 1)
        href.css('display','block');
      else
        code.css('display','block');
    });
  });
</script>
</body>
</html>