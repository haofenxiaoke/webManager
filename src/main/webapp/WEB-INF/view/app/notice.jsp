<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2016/12/22 0022
  Time: 下午 6:30
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="/WEB-INF/view/include/taglib.jsp" %>
<html>
<head>a
    <title>管理系统-app消息推送</title>
    <link href="${pageContext.request.contextPath}/resources/assets/plugins/DataTables/media/css/dataTables.bootstrap.min.css" rel="stylesheet" />
    <link href="${pageContext.request.contextPath}/resources/assets/plugins/bootstrap-daterangepicker/daterangepicker-bs3.css" rel="stylesheet"/>
    <link href="${pageContext.request.contextPath}/resources/assets/plugins/DataTables/extensions/Select/css/select.bootstrap.min.css" rel="stylesheet" />
    <link href="${pageContext.request.contextPath}/resources/assets/plugins/bootstrap-datetimepicker/css/datetimepicker.css" rel="stylesheet"/>
    <link href="${pageContext.request.contextPath}/resources/common/switch/css/bootstrap-switch.min.css" rel="stylesheet" />
    <script src="${pageContext.request.contextPath}/resources/common/switch/js/bootstrap-switch.min.js"></script>
    <link href="${pageContext.request.contextPath}/resources/jedate/skin/jedate.css" rel="stylesheet"/>
    <script src="${pageContext.request.contextPath}/resources/jedate/jedate.js"></script>
</head>
<body>
<div class="panel panel-inverse">
    <div class="panel-heading">
        <h4 class="panel-title">消息推送</h4>
    </div>
    <div class="panel-body">
        <form  id="search-form" class="form-inline">
            <div class="form-group ">
                <div class="input-group">
                    <input readonly="readonly" class="form-control" id="send-date"
                           placeholder="发送时间">
                </div>
            </div>
            <div class="form-group ">
                <shiro:hasPermission name="appNotice:find">
                    <button type="button" class="btn btn-sm btn-primary" id="search">搜索</button>
                </shiro:hasPermission>
                <shiro:hasPermission name="appNotice:save:0">
                    <button type="button" id="send-modal-bth" class="btn btn-sm btn-primary"  >添加</button>
                </shiro:hasPermission>
            </div>
        </form>
    </div>
    <div class="panel-body">
        <table id="notice-table" class="table table-striped table-bordered" width="100%">
            <thead>
            <tr>
                <th></th>
                <th>消息标题</th>
                <th>发送时间</th>
                <th>失效时间</th>
                <th>阅读量</th>
                <th>操作</th>
            </tr>
            </thead>
        </table>
    </div>
</div>

<!-- Modal -->
<div class="modal fade bs-example-modal-lg" id="send-msg-modal" tabindex="-1" role="dialog">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" >发布消息</h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal" id="send-notice-form">
                    <div class="form-group">
                        <label  class="col-md-2 control-label">消息标题</label>
                        <div class="col-md-9">
                            <input type="text" class="form-control" id="msg-title" name="title" >
                        </div>
                    </div>
                    <div class="form-group">
                        <label  class="col-md-2 control-label">消息链接</label>
                        <div class="col-md-9">
                            <%--  <div id="msg-content" name="content" style="height: 250px;"></div>--%>
                            <input class="form-control" id="msg-content" name="content"/>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-md-2 control-label">图片</label>
                        <div class="col-md-4" style="width: 150px;height: 150px;">
                            <img id="preview-image" class="img-thumbnail" src="" style="width: 150px;height: 150px;">
                        </div>
                        <div class="col-md-4">
                            <input id="imageFile" type="file" name="imageFile" style="display: none">
                            <button type="button" class="btn btn-primary" onclick="$('#imageFile').click()" ><i class="glyphicon glyphicon-plus"></i>上传</button>
                            <input type="hidden" id="notice-image-path" name="imgurl" >
                            <small class="help-block" data-bv-validator="notEmpty" data-bv-for="imgUrl" data-bv-result="NOT_VALIDATED" style="display: none;">请上传消息图片</small>
                        </div>

                    </div>
                    <div class="form-group">
                        <label  class="col-md-2 control-label">发布类型</label>
                        <div class="col-md-4">
                            <select class="form-control" id="send-object-select" name="type">
                                <option value="0">立即发布</option>
                                <option value="1">定时发布</option>
                            </select>
                        </div>
                        <input class="form-control"  type="text" id="sendTime" name="sendTime" style="display: none;width:30%;" placeholder="请选择发布时间"/>
                    </div>
                    <div class="form-group">
                        <label  class="col-md-2 control-label">失效时间</label>
                        <div class="col-md-4">
                            <input  class="form-control" id="expiryTime" name="expiryTime"
                                    placeholder="请选择失效时间">
                        </div>
                    </div>
                    <div class="modal-footer">
                        <shiro:hasPermission name="appNotice:save">
                            <button type="button" id="send-btn" class="btn btn-primary" >发布</button>
                        </shiro:hasPermission>
                        <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>
<div class="modal fade bs-example-modal-lg" id="look-msg-modal" tabindex="-1" role="dialog">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" >查看通知</h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal" >
                    <div class="form-group">
                        <label  class="col-md-2 control-label">标题</label>
                        <div class="col-md-9">
                            <input type="text" class="form-control" id="title-look" >
                        </div>
                    </div>
                    <div class="form-group">
                        <label  class="col-md-2 control-label">内容</label>
                        <div class="col-md-9">
                            <div id="content-look" name="content"></div>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-md-2 control-label">图片</label>
                        <div class="col-md-4" style="width: 150px;height: 150px;">
                            <img id="preview-image-look"alt="图片" class="img-thumbnail" src="" style="width: 150px;height: 150px;">
                        </div>
                        <div class="col-md-4">
                            <input id="imageFile-look" type="file" name="imageFile" style="display: none">
                            <button type="button" class="btn btn-primary" onclick="$('#imageFile-look').click()" ><i class="glyphicon glyphicon-plus"></i>上传</button>
                            <small class="help-block" data-bv-validator="notEmpty" data-bv-for="imgUrl" data-bv-result="NOT_VALIDATED" style="display: none;">请上传消息图片</small>
                            <input type="hidden" id="notice-image-path-look" name="imgurl" >
                        </div>
                    </div>
                    <div class="form-group">
                        <label  class="col-md-2 control-label">发布类型</label>
                        <div class="col-md-4">
                            <select class="form-control" id="send-object-select-look" name="type">
                                <option value="0">立即发布</option>
                                <option value="1">定时发布</option>
                            </select>
                        </div>
                        <input class="form-control"  type="text" id="sendTime-look" name="sendTime" style="display: none;width:30%;" placeholder="请选择发布时间"/>
                    </div>
                    <div class="form-group">
                        <label  class="col-md-2 control-label">失效时间</label>
                        <div class="col-md-4">
                            <input  class="form-control" id="expiryTime-look" name="expiryTime"
                                    placeholder="请选择失效时间">
                        </div>
                    </div>
                    <div class="modal-footer">
                        <shiro:hasPermission name="appNotice:save">
                            <button type="button" id="send-btn-look" class="btn btn-primary" >发布</button>
                        </shiro:hasPermission>
                        <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>
<div id="button-1" style="display: none">
    <shiro:hasPermission name="appNotice:find">
        <button type="button" class="btn btn-sm btn-primary" id="look-btn" onclick="page.look('#id')">编辑</button>
    </shiro:hasPermission>
</div>
<div id="button-2" style="display: none">
    <shiro:hasPermission name="appNotice:delete">
        <button type="button" class="btn btn-sm btn-danger " id="delete-btn" onclick="page.delete('#id')">删除</button>
    </shiro:hasPermission>
</div>

<script src="${pageContext.request.contextPath}/resources/assets/plugins/DataTables/media/js/jquery.dataTables.js"></script>
<script src="${pageContext.request.contextPath}/resources/assets/plugins/DataTables/media/js/dataTables.bootstrap.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/assets/plugins/bootstrap-daterangepicker/moment.js"></script>
<script src="${pageContext.request.contextPath}/resources/assets/plugins/bootstrap-daterangepicker/daterangepicker.js"></script>
<script src="${pageContext.request.contextPath}/resources/common/utils/js/tool.date.js"></script>
<script src="${pageContext.request.contextPath}/resources/assets/plugins/bootstrapValidator/js/bootstrapValidator.js"></script>
<%--<script type="text/javascript" charset="utf-8" src="/resources/ueditor/ueditor.config.js"></script>
<script type="text/javascript" charset="utf-8" src="/resources/ueditor/ueditor.all.js"></script>--%>
<!--这里加载的语言文件会覆盖你在配置项目里添加的语言类型，比如你在配置项目里配置的是英文，这里加载的中文，那最后就是中文-->
<%--<script type="text/javascript" charset="utf-8" src="/resources/ueditor/lang/zh-cn/zh-cn.js"></script>--%>
<script src="${pageContext.request.contextPath}/resources/assets/plugins/jquery-file-upload/js/jquery.fileupload.all.js"></script>
<script src="${pageContext.request.contextPath}/resources/base/notice/notice.js"></script>
<script>
    //注释掉创建页和查看页中的富文本编辑器
    $(function () {
        jeDate({
            dateCell: '#sendTime',
            format:"YYYY-MM-DD hh:mm:ss",
            isTime:true,
            isinitVal:false, //是否初始化时间
            minDate: jeDate.now(0) //0代表今天，-1代表昨天，-2代表前天，以此类推
            // maxDate: jeDate.now(1) //1代表明天，2代表后天，以此类推 });
        })
        jeDate({
            dateCell: '#expiryTime',
            format:"YYYY-MM-DD hh:mm:ss",
            isTime:true,
            isinitVal:false,
            minDate:jeDate.now(0) /*moment($('#sendTime').val()).format('YYYY-MM-DD HH:mm:ss ') *///0代表今天，-1代表昨天，-2代表前天，以此类推
            // maxDate: jeDate.now(1) //1代表明天，2代表后天，以此类推 });
        })
        page.init();
    })
</script>
</body>
</html>
