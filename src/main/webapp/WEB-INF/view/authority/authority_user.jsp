<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" contentType="text/html; UTF-8" %>
<%@include file="/WEB-INF/view/include/taglib.jsp" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>${pname}管理系统-用户管理</title>
    <link href="${pageContext.request.contextPath}/resources/assets/plugins/DataTables/media/css/dataTables.bootstrap.min.css" rel="stylesheet" />
    <link href="${pageContext.request.contextPath}/resources/assets/plugins/DataTables/extensions/Select/css/select.bootstrap.min.css" rel="stylesheet" />
    <link href="${pageContext.request.contextPath}/resources/assets/plugins/bootstrap-daterangepicker/daterangepicker-bs3.css" rel="stylesheet" />
    <link href="${pageContext.request.contextPath}/resources/common/switch/css/bootstrap-switch.min.css" rel="stylesheet" />
    <link href="${path}/resources/assets/plugins/bootstrapValidator/css/bootstrapValidator.css" rel="stylesheet">
    <style>
        .help-block {color: #ff5b57;}
    </style>
</head>
<body>
<div>
    <div class="row">
        <div class="col-md-10" style="width:100%;">
            <div class="panel panel-inverse">
                <div class="panel-heading">
                    <div class="panel-heading-btn">
                        <%--     <a href="javascript:;" class="btn btn-xs btn-icon btn-circle btn-default" data-click="panel-expand"><i class="fa fa-expand"></i></a>
                             <a href="javascript:;" class="btn btn-xs btn-icon btn-circle btn-warning" data-click="panel-collapse"><i class="fa fa-minus"></i></a>--%>
                    </div>
                    <h4 class="panel-title">用户列表</h4>
                </div>
                <div class="panel-body">
                    <form class="form-inline">
                        <div class="form-group m-r-10">
                            <input type="text" class="form-control"  style="width:220px;" id="userEmail" placeholder="用户邮箱" />
                        </div>
                        <div class="form-group m-r-10">
                            <input type="text" class="form-control" style="width:220px;" id="userMobile" placeholder="用户手机" />
                        </div>
                        <div class="form-group m-r-10">
                            <input type="text" class="form-control"  style="width:220px;"  id="userNum" placeholder="用户工号" />
                        </div>
                        <div class="form-group  m-r-10" >
                            <div class="input-group">
                                <input  readonly="readonly" class="form-control" style="width:220px;" id="createDate" placeholder="创建日期">
                                <%--<span class="input-group-btn">
                                   <button id="showCreateBtn" class="btn btn-default" type="button"><i class="fa fa-calendar"></i></button>
                                </span>--%>
                            </div>
                        </div>
                        <div class="form-group m-r-10">
                            <select id="userStatus" class="form-control">
                                <option value="-1">--用户状态--</option>
                                <option value="1">启用</option>
                                <option value="0">停用</option>
                            </select>
                        </div>
                        <shiro:hasPermission name="user:find:0">
                            <button type="button" class="btn btn-sm btn-info m-r-5" id="find">查询</button>
                        </shiro:hasPermission>
                        <shiro:hasPermission name="user:save:0">
                            <button type="button" data-toggle="modal" href="#user-create-alert"  class="btn btn-sm btn-primary m-r-5" id="createUser">新增</button>
                        </shiro:hasPermission>
                    </form>
                    <div class="table-responsive">
                        <table id="user-table" class="table table-striped table-bordered" width="100%">
                            <thead>
                            <tr>
                                <th>序号</th>
                                <th>编号</th>
                                <th>姓名</th>
                                <th>邮箱</th>
                                <th>手机</th>
                                <th>工号</th>
                                <th>职位</th>
                                <th>性别</th>
                                <th>花名</th>
                                <th>启用状态</th>
                                <th>修改人</th>
                                <th>修改时间</th>
                                <th>最后登录时间</th>
                                <th>操作</th>
                            </tr>
                            </thead>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<%@include file="/WEB-INF/view/authority/user_dialog.jsp" %>
<script src="${pageContext.request.contextPath}/resources/assets/plugins/DataTables/media/js/jquery.dataTables.js"></script>
<script src="${pageContext.request.contextPath}/resources/assets/plugins/DataTables/media/js/dataTables.bootstrap.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/assets/plugins/DataTables/extensions/Select/js/dataTables.select.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/assets/plugins/bootstrap-daterangepicker/moment.js"></script>
<script src="${pageContext.request.contextPath}/resources/assets/plugins/bootstrap-daterangepicker/daterangepicker.js"></script>
<script src="${pageContext.request.contextPath}/resources/common/switch/js/bootstrap-switch.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/common/utils/js/tool.date.js"></script>
<script src="${pageContext.request.contextPath}/resources/base/auth/js/user.js"></script>
<script src="${pageContext.request.contextPath}/resources/assets/plugins/bootstrapValidator/js/bootstrapValidator.js"></script>
<script>
    var userTable ;
    var addForm = $('#userForm');
    var updateForm = $('#updateUserForm');
    $(document).ready(function() {
        <shiro:hasPermission name="user:find:0">
        userTable =  $('#user-table').DataTable({
            bDestroy: true,
            searching:false,
            processing: true,
            serverSide: true,
            ordering:false, //排序
            ajax:{
                "url":"/user/serach",
                "type": "POST",
                "dataType":"json",
                "data":function(d){
                    d.mobile=$("#userMobile").val();
                    d.email=$("#userEmail").val();
                    d.num=$("#userNum").val();
                    d.createDatetime=$("#createDate").val();
                    d.userStatus=$("#userStatus").val();
                }
            },
            columns: [
                { "data": null},
                { "data": "id","visible":false},//visible 隐藏或显示
                { "data": "username"},
                { "data": "email"},
                { "data": "mobile"},
                { "data": "num" },
                { "data": "job" },
                { "data": "sex" },
                {"data":"flowerName"},
                { "data": "userStatus", "render":function(data,type,row,meta){
                    return data == 1?"启用":"停用";
                }
                },
                { "data": "lastModifyUserEmail"},
                { "data": "lastModifyDatetime"},
                { "data": "lastLoginDatetime"},
                { "data": null,"render":function(data,type,row,meta){
                    if(null!=data){
                        var btn = "" ;
                        <shiro:hasPermission name="user:update:0">
                        btn+='<button class="btn btn-sm btn-info m-r-5 m-b-5" onclick="updateUserDialog('+row.id+');"  data-toggle="modal"   href="#user-update-alert"    type="button">修改</button>';
                        </shiro:hasPermission>
                        <shiro:hasPermission name="user:lock:0">
                        if(data.userLock == 1){
                            //当前没有被锁定
                            btn+='<button onclick="lockUser(this);" class="btn btn-sm btn-danger m-r-5 m-b-5"  type="button" value="'+row.id+'" status = "'+row.userLock+'"/>锁定</button>';
                        }else{
                            //当前已被锁定
                            btn+='<button onclick="lockUser(this);" class="btn btn-sm btn-danger m-r-5 m-b-5" type="button" value="'+row.id+'" status = "'+row.userLock+'" checked>解锁</button>';
                        }
                        </shiro:hasPermission>
                        return btn;
                    }
                }},
            ],
            columnDefs:[
                {className: "dt-body-center", "targets": "_all"},
                {
                    "targets": [11,12],
                    "render":function(data,type,row,meta){
                        if(data == null){
                            return "无登录";
                        }
                        return TimeObjectUtil.formatterDateTime(new Date(data))
                    }
                }
            ],
            language:{
                lengthMenu: "每页 _MENU_ 条记录",//下拉框文字
                info:"第 _PAGE_ 页 ( 总共 _PAGES_ 页 ,共 _TOTAL_ 项)",//左下角显示文字
                infoEmpty:"",//当查询没有数据时左下角显示文字
                sEmptyTable:"没有数据..",//当查询没有数据时表格中间显示文字
                paginate:{                          //分页
                    first:"首页",
                    last:"尾页",
                    next:"下一页",
                    previous:"上一页"
                }
            },
            //设置第一列为自增列
            drawCallback: function(settings){
                n = this.api().page.info().start;
                this.api().column(0).nodes().each(function(cell,i){
                    cell.innerHTML = ++n;
                    // cell.style.width = "20px";
                })
            }
        });
        </shiro:hasPermission>

        $("#find").click(function(){
            userTable.ajax.reload();
        });

        //绑定表单验证器
        addForm.bootstrapValidator({
            message: 'This value is not valid',
            excluded: [':disabled'],//不加它重新打开模态框时提示不会清除
            fields: {
                email: {
                    validators : {
                        notEmpty: {
                            message: '不能为空'
                        },
                        callback: {
                            message: '请填写正确邮箱格式',
                            callback: function (value, validator) {
                                return value ? IsEmail(value) : true;
                            }
                        }
                    }
                },
                mobile : {
                    validators: {
                        notEmpty: {
                            message: '不能为空'
                        },
                        regexp: {
                            regexp: /^1[3,4,5,7,8]\d{9}$/,
                            message: '请填写正确的手机号'
                        }
                    }
                },
                name : {
                    validators: {
                        notEmpty: {
                            message: '姓名不能为空'
                        },
                        stringLength: {
                            max: 10,
                            message: '不能超过10个字'
                        }
                    }
                },
                flowerName : {
                    validators: {
                        notEmpty: {
                            message: '花名不能为空'
                        },
                        stringLength: {
                            max: 30,
                            message: '不能超过30个字'
                        }
                    }
                },
                num : {
                    validators: {
                        notEmpty: {
                            message: '工号不能为空'
                        },
                        stringLength: {
                            max: 4,
                            message: '不能超过4个字'
                        },
                        callback: {
                            message: '工号已经存在',
                            callback: function (value, validator) {
                                var data =  {
                                    "num": value
                                };
                                return value ? checkNum(data) : true;
                            }
                        }
                    }
                },
                job : {
                    validators: {
                        notEmpty: {
                            message: '职位不能为空'
                        },
                        stringLength: {
                            max: 30,
                            message: '职位输入过长，最多为30字符'
                        }
                    }
                }
            }
        });
        updateForm.bootstrapValidator({
            message: 'This value is not valid',
            excluded: [':disabled'],//不加它重新打开模态框时提示不会清除
            fields: {
                mobile : {
                    validators: {
                        notEmpty: {
                            message: '不能为空'
                        },
                        regexp: {
                            regexp: /^1[3,4,5,7,8]\d{9}$/,
                            message: '请填写正确的手机号'
                        }
                    }
                },
                name : {
                    validators: {
                        notEmpty: {
                            message: '姓名不能为空'
                        },
                        stringLength: {
                            max: 10,
                            message: '不能超过10个字'
                        }
                    }
                },
                flowerName : {
                    validators: {
                        notEmpty: {
                            message: '花名不能为空'
                        },
                        stringLength: {
                            max: 30,
                            message: '不能超过30个字'
                        }
                    }
                },
                num : {
                    validators: {
                        notEmpty: {
                            message: '工号不能为空'
                        },
                        stringLength: {
                            max: 4,
                            message: '不能超过4个字'
                        }
                    }
                },
                job : {
                    validators: {
                        notEmpty: {
                            message: '职位不能为空'
                        },
                        stringLength: {
                            max: 30,
                            message: '职位输入过长，最多为30字符'
                        }
                    }
                },
                password : {
                    validators: {
                        regexp: {
                            regexp: /^.{6,18}$/,
                            message: '密码长度为6~18位'
                        },
                    }
                },
                rpassword : {
                    validators: {
                        regexp: {
                            regexp: /^.{6,18}$/,
                            message: '密码长度为6~18位'
                        },
                        identical: {
                            field: 'password',
                            message: '两次输入密码不一致'
                        }
                    }
                }
            }
        });
    });
</script>
</body>
</html>