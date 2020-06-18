<%@ page pageEncoding="utf-8"  language="java" %>
<%-- 新增分类方向 --%>
<input type="hidden" id="paramType" value="cate">
<div class="modal fade" id="cate-create-alert">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="panel panel-inverse">
                <div class="panel-heading">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                    <h4 class="panel-title">添加学院</h4>
                </div>
            </div>
            <div class="panel-body">
                <form id="cateForm" class="form-horizontal form-bordered" data-parsley-validate="true">
                    <div class="form-group">
                        <label class="col-md-3 control-label">学院描述*</label>
                            <div class="col-md-9">
                            <input id="name" type="text" class="form-control" />
                            <ul  class="parsley-errors-list filled">
                                <li name="ErrorTip" class="parsley-required"></li>
                            </ul>
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <a id="close" href="javascript:;" class="btn btn-sm btn-info" data-dismiss="modal">关闭</a>
                <a id="saveCate"  href="javascript:;" class="btn btn-sm btn-success">保存</a>
            </div>
        </div>
    </div>
</div>

<%-- 改名 --%>
<div class="modal fade" id="cate-update-alert">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="panel panel-inverse">
                <div class="panel-heading">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                    <h4 class="panel-title">修改学院描述</h4>
                </div>
            </div>
            <div class="panel-body">
                <form id="updateCateForm" class="form-horizontal form-bordered" data-parsley-validate="true">
                    <input type="hidden" id="id">
                    <div class="form-group">
                        <label class="col-md-3 control-label">学院描述*</label>
                        <div class="col-md-9">
                            <input id="update_name" type="text" class="form-control" />
                            <ul  class="parsley-errors-list filled">
                                <li name="ErrorTip" class="parsley-required"></li>
                            </ul>
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <a id="update_close" href="javascript:;" class="btn btn-sm btn-info" data-dismiss="modal">关闭</a>
                <a id="update_saveCate"  href="javascript:;" class="btn btn-sm btn-success">保存</a>
            </div>
        </div>
    </div>
</div>
