<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" contentType="text/html; UTF-8" %>
<%@include file="/WEB-INF/view/include/taglib.jsp" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <title>${pname}管理系统-首页设置</title>
  <link href="${pageContext.request.contextPath}/resources/assets/plugins/DataTables/media/css/dataTables.bootstrap.min.css" rel="stylesheet" />
  <link href="${pageContext.request.contextPath}/resources/assets/plugins/DataTables/extensions/Select/css/select.bootstrap.min.css" rel="stylesheet" />
  <link href="${pageContext.request.contextPath}/resources/assets/plugins/bootstrap-daterangepicker/daterangepicker-bs3.css" rel="stylesheet" />
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
        <h4 class="panel-title">首页设置</h4>
      </div>
      <div class="panel-body">
        <div class="form-group">
          <form id="saveHotForm" class="form-horizontal">
            <div class="col-md-12"><h3>搜索框热词配置：</h3></div>
            <div class="col-md-12">
              <label class="control-label">
                <input type="text" class="form-control" id="hot1" name="hot1" value="${homeSet.hot1}" maxlength="6"/>
              </label>
              <label class="control-label">
                <input type="text" class="form-control" id="hot2" name="hot2" value="${homeSet.hot2}" maxlength="6"/>
              </label>
              <label class="control-label">
                <input type="text" class="form-control" id="hot3" name="hot3" value="${homeSet.hot3}" maxlength="6"/>
              </label>
              <label class="control-label">
                <input type="text" class="form-control" id="hot4" name="hot4" value="${homeSet.hot4}" maxlength="6"/>
              </label>
              <label class="control-label">
                <input type="text" class="form-control" id="hot5" name="hot5" value="${homeSet.hot5}" maxlength="6"/>
              </label>
              <label class="control-label">
                <input type="text" class="form-control" id="hot6" name="hot6" value="${homeSet.hot6}" maxlength="6"/>
              </label>
              <shiro:hasPermission name="homeSet:save:0">
              <label class="control-label">
                <a id="saveHot"  href="javascript:;" class="btn btn-sm btn-success m-r-5">保存</a>
              </label>
              </shiro:hasPermission>
            </div>
          </form>
        </div>
        <div class="form-group">
          <div class="col-md-12"><h3>轮播图配置 jpg小于2M：</h3></div>
          <div class="col-md-12">
            <label class="control-label">
              <div class="widget widget-stats bg-green">
                <div class="stats-info">
                  <img id="preview-image-carousel1"  alt="上传图片" class="img-thumbnail" data-toggle="modal"
                       href="#homeSet-img-alert" src="${carouse.carouselUrl1}" data-bgColor="${carouse.bgcolor1}" hideData="1#${carouse.carouselId1}#${carouse.hrefUrl1}"/>
                </div>
                <div class="stats-link">
                  <shiro:hasPermission name="homeSet:delete:0">
                    <a href="javascript:;" onclick="delCarouselImg(${carouse.carouselId1});">删除</a>
                  </shiro:hasPermission>
                </div>
              </div>
            </label>
            <label class="control-label">
              <div class="widget widget-stats bg-green">
                <div class="stats-info">
                  <img id="preview-image-carousel2"  alt="上传图片" class="img-thumbnail" data-toggle="modal"
                       href="#homeSet-img-alert" src="${carouse.carouselUrl2}" data-bgColor="${carouse.bgcolor2}" hideData="2#${carouse.carouselId2}#${carouse.hrefUrl2}"/>
                </div>
                <div class="stats-link">
                  <shiro:hasPermission name="homeSet:delete:0">
                    <a href="javascript:;" onclick="delCarouselImg(${carouse.carouselId2});">删除</a>
                  </shiro:hasPermission>
                </div>
              </div>
            </label>
            <label class="control-label">
              <div class="widget widget-stats bg-green">
                <div class="stats-info">
                  <img id="preview-image-carousel3"  alt="上传图片" class="img-thumbnail" data-toggle="modal"
                       href="#homeSet-img-alert" src="${carouse.carouselUrl3}" data-bgColor="${carouse.bgcolor3}" hideData="3#${carouse.carouselId3}#${carouse.hrefUrl3}"/>
                </div>
                <div class="stats-link">
                  <shiro:hasPermission name="homeSet:delete:0">
                    <a href="javascript:;" onclick="delCarouselImg(${carouse.carouselId3});">删除</a>
                  </shiro:hasPermission>
                </div>
              </div>
            </label>
            <label class="control-label">
              <div class="widget widget-stats bg-green">
                <div class="stats-info">
                  <img id="preview-image-carousel4"  alt="上传图片" class="img-thumbnail" data-toggle="modal"
                       href="#homeSet-img-alert" src="${carouse.carouselUrl4}" data-bgColor="${carouse.bgcolor4}" hideData="4#${carouse.carouselId4}#${carouse.hrefUrl4}"/>
                </div>
                <div class="stats-link">
                  <shiro:hasPermission name="homeSet:delete:0">
                    <a href="javascript:;" onclick="delCarouselImg(${carouse.carouselId4});">删除</a>
                  </shiro:hasPermission>
                </div>
              </div>
            </label>
            <label class="control-label">
              <div class="widget widget-stats bg-green">
                <div class="stats-info">
                  <img id="preview-image-carousel5"  alt="上传图片" class="img-thumbnail" data-toggle="modal"
                       href="#homeSet-img-alert" src="${carouse.carouselUrl5}" data-bgColor="${carouse.bgcolor5}" hideData="5#${carouse.carouselId5}#${carouse.hrefUrl5}"/>
                </div>
                <div class="stats-link">
                  <shiro:hasPermission name="homeSet:delete:0">
                    <a href="javascript:;" onclick="delCarouselImg(${carouse.carouselId5});">删除</a>
                  </shiro:hasPermission>
                </div>
              </div>
            </label>
            <label class="control-label">
              <div class="widget widget-stats bg-green">
                <div class="stats-info">
                  <img id="preview-image-carousel6"  alt="上传图片" class="img-thumbnail" data-toggle="modal"
                       href="#homeSet-img-alert" src="${carouse.carouselUrl6}" data-bgColor="${carouse.bgcolor6}" hideData="6#${carouse.carouselId6}#${carouse.hrefUrl6}"/>
                </div>
                <div class="stats-link">
                  <shiro:hasPermission name="homeSet:delete:0">
                    <a href="javascript:;" onclick="delCarouselImg(${carouse.carouselId6});">删除</a>
                  </shiro:hasPermission>
                </div>
              </div>
            </label>
          </div>
        </div>
      <!-- 财务管理配置 -->
        <c:forEach var="s" items="${setList}">
          <div class="form-group">
          <div class="col-md-12">
            <label class="control-label"  >
              <input name="isEnabled" type="checkbox" hideData="${s.is_enabled}#${s.id}#${s.directionId}"
                     <c:if test="${s.is_enabled == 1}">checked</c:if>/>
            </label>
            <label class="control-label"><h3>${s.category_desc}配置：</h3></label>
          </div>
          <div class="col-md-12">
              <div class="media media-sm">
                <div class="media-left">
                  <img id="preview-image1" alt="图片 jpg小于2M" data-toggle="modal" href="#homeSet-config-alert"
                       src="${s.left_module}" hideData="${s.directionId}#leftModule#${s.id}" dataType="${s.left_href}"/>
                </div>
                <div class="media-body">
                  <div class="media">
                    <img id="preview-image2"  alt="图片" class="img-thumbnail" data-toggle="modal" href="#homeSet-course-alert"
                        <c:forEach var="course" items="${courseList}">
                          <c:if test="${course.id == s.module1}">
                            src="${course.cover_url}"
                          </c:if>
                        </c:forEach>
                         hideData="${s.directionId}#module1#${s.id}"/>
                    <img id="preview-image3"  alt="图片" class="img-thumbnail" data-toggle="modal" href="#homeSet-course-alert"
                          <c:forEach var="course" items="${courseList}">
                            <c:if test="${course.id == s.module2}">
                              src="${course.cover_url}"
                            </c:if>
                          </c:forEach>
                         hideData="${s.directionId}#module2#${s.id}"/>
                    <img id="preview-image4"  alt="图片" class="img-thumbnail" data-toggle="modal" href="#homeSet-course-alert"
                          <c:forEach var="course" items="${courseList}">
                            <c:if test="${course.id == s.module3}">
                              src="${course.cover_url}"
                            </c:if>
                          </c:forEach>
                         hideData="${s.directionId}#module3#${s.id}"/>
                    <img id="preview-image5"  alt="图片" class="img-thumbnail" data-toggle="modal" href="#homeSet-course-alert"
                          <c:forEach var="course" items="${courseList}">
                            <c:if test="${course.id == s.module4}">
                              src="${course.cover_url}"
                            </c:if>
                          </c:forEach>
                         hideData="${s.directionId}#module4#${s.id}"/>
                  </div>
                  <div class="media">
                    <img id="preview-image6"  alt="图片" class="img-thumbnail" data-toggle="modal" href="#homeSet-course-alert"
                          <c:forEach var="course" items="${courseList}">
                            <c:if test="${course.id == s.module5}">
                              src="${course.cover_url}"
                            </c:if>
                          </c:forEach>
                         hideData="${s.directionId}#module5#${s.id}"/>
                    <img id="preview-image7"  alt="图片" class="img-thumbnail" data-toggle="modal" href="#homeSet-course-alert"
                          <c:forEach var="course" items="${courseList}">
                            <c:if test="${course.id == s.module6}">
                              src="${course.cover_url}"
                            </c:if>
                          </c:forEach>
                         hideData="${s.directionId}#module6#${s.id}"/>
                    <img id="preview-image8"  alt="图片" class="img-thumbnail" data-toggle="modal" href="#homeSet-course-alert"
                          <c:forEach var="course" items="${courseList}">
                            <c:if test="${course.id == s.module7}">
                              src="${course.cover_url}"
                            </c:if>
                          </c:forEach>
                         hideData="${s.directionId}#module7#${s.id}"/>
                    <img id="preview-image9"  alt="图片" class="img-thumbnail" data-toggle="modal" href="#homeSet-course-alert"
                          <c:forEach var="course" items="${courseList}">
                            <c:if test="${course.id == s.module8}">
                              src="${course.cover_url}"
                            </c:if>
                          </c:forEach>
                         hideData="${s.directionId}#module8#${s.id}"/>
                  </div>
                </div>
              </div>
          </div>
        </div>
        </c:forEach>
      </div>
    </div>
  </div>
</div>
<!-- 弹出框 -->
<div class="modal fade" id="homeSet-course-alert">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="panel panel-inverse">
        <div class="panel-heading">
          <div class="panel-heading-btn">
            <button type="button" class="btn btn-xs btn-icon btn-circle btn-danger" data-dismiss="modal" aria-hidden="true"><i class="fa fa-times"></i></button>
          </div>
          <div class="panel-title">视频配置</div>
        </div>
      </div>
      <div class="panel-body">
        <form class="form-horizontal">
          <div class="form-group">
            <label  class="col-md-2 control-label">方向</label>
            <div class="col-md-4">
              <select id="directionId" class="form-control">
                <option value="-1">--方向--</option>
              </select>
            </div>
          </div>
          <div class="form-group">
            <label  class="col-md-2 control-label">课程</label>
            <div class="col-md-4">
              <select id="courseId" class="form-control">
                <option value="-1">--课程--</option>
              </select>
            </div>
          </div>
        </form>
        <input type="hidden" id="setColumn" name = "setColumn"/>
        <form id="homeSetForm" class="form-horizontal">
          <input type="hidden" id="setId" name = "id"/>
          <input type="hidden" id="setType" name = "directionId"/>
          <div id="htmlContent"></div>
        </form>
      </div>
      <div class="modal-footer">
        <shiro:hasPermission name="homeSet:save:0">
        <a id="saveSet"  href="javascript:;" class="btn btn-sm btn-success">确定</a>
        <a id="close" href="javascript:;" class="btn btn-sm btn-info" data-dismiss="modal">取消</a>
        </shiro:hasPermission>
      </div>
    </div>
  </div>
</div>
<div class="modal fade" id="homeSet-config-alert">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="panel panel-inverse">
        <div class="panel-heading">
          <div class="panel-heading-btn">
            <button type="button" class="btn btn-xs btn-icon btn-circle btn-danger" data-dismiss="modal" aria-hidden="true"><i class="fa fa-times"></i></button>
          </div>
          <div class="panel-title">广告配置</div>
        </div>
      </div>
      <div class="panel-body">
        <form id="homeSetImgForm-config" class="form-horizontal">
          <div class="form-group">
            <label  class="col-md-2 control-label">图片</label>
            <div class="col-md-4">
              <img id="preview-image-config"  alt="图片" class="img-thumbnail" />
                  <span class="btn btn-primary btn-sm fileinput-button">
                  <i class="glyphicon glyphicon-plus"></i>
                  <span>上传</span>
                  <input type="file" id="imageFile-config" name="imageFile">
                  <input type="hidden" id="course-image-path-config" name="carouseImage" value="">
                  </span>
            </div>
          </div>
          <div class="form-group">
            <label  class="col-md-2 control-label">链接地址</label>
            <div class="col-md-4">
              <input type="text" class="form-control" id="leftHref-config" name="leftHref" style="width:440px;">
              <ul  class="parsley-errors-list filled">
                <li name="ErrorTip" class="parsley-required"></li>
              </ul>
            </div>
            <input type="hidden" class="form-control" id="setImgColumn-config" name = "setColumn"/>
            <input type="hidden" class="form-control" id="imgId-config" name="id">
            <input type="hidden" class="form-control" id="imgType-config" name="directionId">
            <div id="htmlContent-img-config"></div>
          </div>
        </form>
        <div class="modal-footer">
          <shiro:hasPermission name="homeSet:save:0">
            <a id="saveImg-config"  href="javascript:;" class="btn btn-sm btn-success">确定</a>
            <a id="close-img-config" href="javascript:;" class="btn btn-sm btn-info" data-dismiss="modal">取消</a>
          </shiro:hasPermission>
        </div>
      </div>
    </div>
  </div>
</div>
<div class="modal fade" id="homeSet-img-alert">
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
        <form id="homeSetImgForm" class="form-horizontal">
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
            <label  class="col-md-2 control-label">链接地址</label>
            <div class="col-md-4">
              <input type="hidden" id="imageId" name = "id"/>
              <input type="hidden" id="imageOrderNum" name = "orderNum"/>
              <input type="hidden" class="form-control" id="pathUrl" name="pathUrl">
              <input type="text" class="form-control" id="hrefUrl" name="hrefUrl" style="width:440px;" >
              <ul  class="parsley-errors-list filled">
                <li name="ErrorTip" class="parsley-required"></li>
              </ul>
            </div>
          </div>
          <div class="form-group">
            <label  class="col-md-2 control-label">背景色</label>
            <div class="col-md-4">
              <input type="text" class="form-control" id="bgcolor" name="bgcolor" style="width:440px;" >
            </div>
          </div>
        </form>
      </div>
      <div class="modal-footer">
        <shiro:hasPermission name="homeSet:save:0">
        <a id="saveImg"  href="javascript:;" class="btn btn-sm btn-success">确定</a>
        <a id="close-img" href="javascript:;" class="btn btn-sm btn-info" data-dismiss="modal">取消</a>
        </shiro:hasPermission>
      </div>
    </div>
  </div>
</div>
<!-- end -->
<script src="${pageContext.request.contextPath}/resources/assets/plugins/DataTables/media/js/jquery.dataTables.js"></script>
<script src="${pageContext.request.contextPath}/resources/assets/plugins/DataTables/media/js/dataTables.bootstrap.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/assets/plugins/DataTables/extensions/Select/js/dataTables.select.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/assets/plugins/bootstrap-daterangepicker/moment.js"></script>
<script src="${pageContext.request.contextPath}/resources/common/switch/js/bootstrap-switch.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/assets/plugins/jquery-file-upload/js/jquery.fileupload.all.js"></script>
<script src="${pageContext.request.contextPath}/resources/assets/plugins/bootstrapValidator/js/bootstrapValidator.js"></script>
<script src="${pageContext.request.contextPath}/resources/base/homeSet/homeSet.js"></script>
<script>
  $(document).ready(function() {
    //启用首页配置对应的方向
    $('input[name="isEnabled"]').unbind('click').click(function () {
      var url,datas,isEnabled;
      var hideData = $(this).attr('hideData');
      if(hideData){
        var arr = hideData.split('#');
        if(arr[0] == 1) isEnabled = 0;
        else isEnabled = 1;

        if(arr[1]){
          datas = {id:arr[1],isEnabled:isEnabled,directionId:arr[2]};
          url = "/homeSet/update";
        }else{
          datas = {isEnabled:isEnabled,directionId:arr[2]};
          url = "/homeSet/save";
        }
        $.post(url,datas,function(datas){
          if (datas.code == HttpUtil.success_code) {
            window.location.reload();
          }else{
            var alert = BootstrapDialog.alert||window.alert;
            alert(data.result.msg);
          }
        })
      }
    });
    //初始化方向分类下拉框
    var directionObj = $('#directionId');
    var directionConfigObj = $('#directionId-config');
    initCateSelect(directionObj,'homeSet','find');
    initCateSelect(directionConfigObj,'homeSet','find');
    //c
    directionObj.change(function() {
      initCourseSelect($('#courseId'),$(this).val());
    });

    directionConfigObj.change(function() {
      initCourseSelect($('#courseId-config'),$(this).val());
    });

    //初始化文件上传插件
    initFileupload('imageFile','preview-image','course-image-path');
    initFileuploadConfig('imageFile-config','preview-image-config','course-image-path-config');

    //验证表单信息
    var reg = /^[\u4e00-\u9fa5a-zA-Z0-9]+$/;
    var regmessage = "只能输入中文、字母、数字";
    $('#saveHotForm').bootstrapValidator({
      fields: {
        hot1: {
          validators: {
            regexp: {
              regexp: reg,
              message: regmessage
            }
          }
        },
        hot2: {
          validators: {
            regexp: {
              regexp: reg,
              message: regmessage
            }
          }
        },
        hot3: {
          validators: {
            regexp: {
              regexp: reg,
              message: regmessage
            }
          }
        },
        hot4: {
          validators: {
            regexp: {
              regexp: reg,
              message: regmessage
            }
          }
        },
        hot5: {
          validators: {

          }
        },
        hot6: {
          validators: {
            regexp: {
              regexp: reg,
              message: regmessage
            }
          }
        }
      }
    });

  });
</script>
</body>
</html>