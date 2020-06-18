<%@ page pageEncoding="utf-8"  language="java" %>
<link href="${pageContext.request.contextPath}/resources/common/switch/css/bootstrap-switch.min.css" rel="stylesheet" />
<script src="${pageContext.request.contextPath}/resources/common/switch/js/bootstrap-switch.min.js"></script>
<input type="hidden" id="teacher-user-id">
<input type="hidden" id="operation-type" value="true">
<div class="modal fade bs-example-modal-lg" id="teacher-detail-modal" tabindex="-1" role="dialog">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" >老师信息</h4>
            </div>
            <div class="modal-body">

                <form class="form-horizontal" id="teacher-detail-form">
                    <div class="form-group">
                        <label  class="col-md-2 control-label">工号</label>
                        <div class="col-md-9 row">
                            <div class="col-md-4">
                                <input type="text" class="form-control" id="num" name="num" onkeyup="this.value=this.value.replace(/\D/g,'')"/>
                            </div>
                            <button type="button" class="btn btn-sm btn-primary m-r-5" id="ok">确定</button>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-md-2 control-label">花名</label>
                        <div   class="col-md-3"  >
                            <input class="form-control"  type="text" id="flower-name" name="flowerName"/>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-md-2 control-label">姓名</label>
                        <div   class="col-md-3"  >
                            <input class="form-control"  type="text" id="name" name="name" readonly/>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-md-2 control-label">性别</label>
                        <div class="col-md-3">
                            <div class="switch">
                                <input type="checkbox"  id="sex" name="sex" data-on-text="男" data-off-text="女" data-on-color="primary"  data-off-color="info"  checked/>
                            </div>
                        </div>
                    </div>
                    <div class="form-group">
                        <label  class="col-md-2 control-label">照片</label>
                        <div class="col-md-4">
                            <img id="preview-image"  alt="老师照片" class="img-thumbnail"/>
                        </div>
                        <div class="col-md-4">
                           <span class="btn btn-primary btn-sm fileinput-button">
                                <i class="glyphicon glyphicon-plus"></i>
                                <span>上传</span>
                                <input id="imageFile" type="file" name="imageFile">
                            <input type="hidden" id="teacher-image-path" name="imgUrl" value="">
                            </span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label  class="col-md-2 control-label">老师介绍</label>
                        <div class="col-md-6">
                            <textarea  class="form-control" id="teacher-introduction" name="introduction" rows="5" ></textarea>
                        </div>
                    </div>
                    <div class="modal-footer" id="m-hide">
                        <button type="button" id="save-teacher"  class="btn btn-primary">保存</button>
                        <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
                    </div>

                </form>
            </div>
        </div>
    </div>
</div>