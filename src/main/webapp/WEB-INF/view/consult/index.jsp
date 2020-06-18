<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" contentType="text/html; UTF-8" %>
<%@include file="/WEB-INF/view/include/taglib.jsp" %>
<!DOCTYPE html>
<html lang="en">
<html>
<head>
    <title>${pname}管理系统-咨询配置管理</title>
    <link href="${pageContext.request.contextPath}/resources/common/switch/css/bootstrap-switch.min.css" rel="stylesheet" />
    <link href="${path}/resources/assets/plugins/bootstrapValidator/css/bootstrapValidator.css" rel="stylesheet">
    <link href="${path}/resources/assets/plugins/jquery-file-upload/css/jquery.fileupload.css" rel="stylesheet">
</head>
<body>
<div class="row">
    <div class="col-md-10" style="width:100%;">
        <div class="panel panel-inverse">
            <div class="panel-heading">
                <h4 class="panel-title">咨询配置管理</h4>
            </div>
            <ul id="myTab" class="nav nav-tabs">
                <li class="active"><a href="#tab_1" data-type="1" data-toggle="tab">售前咨询配置</a></li>
                <li><a href="#tab_2" data-type="2" data-toggle="tab">售后咨询配置</a></li>
            </ul>
            <div id="myTabContent" class="tab-content">
                <div class="tab-pane fade in active" id="tab_1">
                    <!-- 左侧咨询start-->
                    <fieldset>
                        <legend contenteditable="false">左侧咨询</legend>
                        <form id="form1" class="form-horizontal">
                            <input type="hidden" name="id" value=""/>
                            <div class="form-group">
                                <label  class="col-md-2 control-label">总开关</label>
                                <div class="col-md-2">
                                    <input type="checkbox" name="isSwitch" data-on-text="开" data-off-text="关" data-on-color="info" checked />
                                </div>
                            </div>
                            <div class="form-group">
                                <label  class="col-md-2 control-label">页面开关</label>
                                <div class="col-md-2">
                                    <label>
                                        <input type="checkbox" name="pageSwitch" value="1">首页
                                    </label>
                                    <label>
                                        <input type="checkbox" name="pageSwitch" value="2" >课程
                                    </label>
                                    <label>
                                        <input type="checkbox" name="pageSwitch" value="3" >课程详情
                                    </label>
                                    <label>
                                        <input type="checkbox" name="pageSwitch" value="4" >视频播放
                                    </label>
                                    <label>
                                        <input type="checkbox" name="pageSwitch" value="5" >直播列表
                                    </label>
                                    <label>
                                        <input type="checkbox" name="pageSwitch" value="6" >直播间
                                    </label>
                                    <label>
                                        <input type="checkbox" name="pageSwitch" value="7" >个人中心
                                    </label>
                                </div>
                            </div>
                            <div class="form-group">
                                <label  class="col-md-2 control-label">图片</label>
                                <div class="col-md-2">
                                    <img id="preview-image" name="previewImage" alt="小能图片" class="img-thumbnail"/>
                                    <span class="btn btn-primary btn-sm fileinput-button">
                                        <i class="glyphicon glyphicon-plus"></i>
                                        <span>上传</span>
                                        <input id="imageFile" type="file" name="imageFile">
                                        <input type="hidden" id="image-path" name="imgUrl" value="">
                                    </span>
                                </div>
                            </div>
                            <div class="form-group">
                                <label  class="col-md-2 control-label">小能key</label>
                                <div class="col-md-2">
                                    <input type="text" class="form-control" name="consultUrl">
                                </div>
                                <shiro:hasPermission name="consult:save">
                                    <button type="button" class="btn btn-sm btn-info m-r-5" onclick="page.submit('#form1',1)">保存</button>
                                </shiro:hasPermission>
                            </div>
                        </form>
                    </fieldset>
                    <!-- 左侧咨询end-->
                    <!-- 右侧咨询start-->
                    <fieldset>
                        <form class="form-horizontal" role="form" id="form2">
                            <input type="hidden" name="id" value=""/>
                            <legend contenteditable="false">右侧咨询</legend>
                            <div class="form-group">
                                <label  class="col-md-2 control-label">开关</label>
                                <div class="col-md-2">
                                    <input type="checkbox" id="switch2" name="isSwitch" data-on-text="开" data-off-text="关" data-on-color="info" checked />
                                </div>
                            </div>
                            <div class="form-group">
                                <label  class="col-md-2 control-label">小能key</label>
                                <div class="col-md-2">
                                    <input type="text" class="form-control" name="consultUrl"/>
                                </div>
                                <shiro:hasPermission name="consult:save">
                                    <button type="button" class="btn btn-sm btn-info m-r-5" onclick="page.submit('#form2',2)">保存</button>
                                </shiro:hasPermission>
                            </div>
                        </form>
                    </fieldset>
                    <!-- 右侧咨询end-->
                </div>
                <div class="tab-pane fade" id="tab_2">
                    <!-- 售后咨询start-->
                    <fieldset>
                        <form class="form-horizontal" role="form" id="form3">
                            <input type="hidden" name="id" value=""/>
                            <div class="form-group">
                                <label  class="col-md-2 control-label">开关</label>
                                <div class="col-md-2">
                                    <input type="checkbox" name="isSwitch" data-on-text="开" data-off-text="关" data-on-color="info" checked />
                                </div>
                            </div>
                            <div class="form-group">
                                <label  class="col-md-2 control-label">小能key</label>
                                <div class="col-md-2">
                                    <input type="text" class="form-control" name="consultUrl"/>
                                </div>
                                <shiro:hasPermission name="consult:save">
                                    <button type="button" class="btn btn-sm btn-info m-r-5" onclick="page.submit('#form3',3)">保存</button>
                                </shiro:hasPermission>
                            </div>
                        </form>
                    </fieldset>
                    <!-- 售后咨询end-->
                </div>
            </div>
        </div>
    </div>
</div>
<script src="${pageContext.request.contextPath}/resources/assets/plugins/DataTables/media/js/jquery.dataTables.js"></script>
<script src="${pageContext.request.contextPath}/resources/assets/plugins/DataTables/media/js/dataTables.bootstrap.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/common/switch/js/bootstrap-switch.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/assets/plugins/bootstrapValidator/js/bootstrapValidator.js"></script>
<script src="${pageContext.request.contextPath}/resources/assets/plugins/jquery-file-upload/js/jquery.fileupload.all.js"></script>
<script src="${pageContext.request.contextPath}/resources/base/consult/consult.js"></script>
<script>
    page.init();

</script>
</body>
</html>
