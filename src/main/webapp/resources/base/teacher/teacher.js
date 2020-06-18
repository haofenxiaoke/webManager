/**
 * Created by on 2016/9/18.
 */

(function(window){

    var form = $('#teacher-detail-form');
    var sexSwitch =  $("#sex").bootstrapSwitch();

    function initBindEvents(){
        //绑定创建课程按钮事件
        $('#createTeacher').click(function () {
            openModal();
        });

        //绑定表单验证器
        form.bootstrapValidator({
            message: 'This value is not valid',
            excluded: [':disabled'],//不加它重新打开模态框时提示不会清除
            fields: {
                num: {
                    validators: {
                        notEmpty: {
                            message: '请输入工号'
                        },
                        stringLength: {
                            max: 4,
                            message: '不能超过4个字'
                        },
                        callback: {
                            message: '该老师已经绑定啦！',
                            callback: function (value, validator) {
                                var flag = true;
                                var type = $('#operation-type').val();
                                if(value && type == 'true') flag = check(value);
                                return flag;
                            }
                        }
                    }
                },
                flowerName: {
                    validators: {
                        notEmpty: {
                            message: '请输入花名'
                        }
                    }
                },
                name : {
                    validators: {
                        notEmpty: {
                            message: '请输入老师名字'
                        },
                        stringLength: {
                            max: 10,
                            message: '不能超过10个字'
                        }
                    }
                },
                imgUrl : {
                    validators: {
                        notEmpty: {
                            message: '请上传老师照片'
                        }
                    }
                },
                introduction : {
                    validators: {
                        notEmpty: {
                            message: '请输入老师介绍'
                        },
                        stringLength: {
                            max: 300,
                            message: '不能超过300个字'
                        }

                    }
                }
            }
        });
    }

    //验证唯一
    function check(val){
        var flag = false;
        $.ajax({
            url: '/teacher/check/',
            type: "post",
            dataType: "json",
            cache: false,
            async: false,
            data: {num: val},
            success: function (data) {
                if (data.code == HttpUtil.success_code) {
                    flag = !(data.result);
                } else {
                    BootstrapDialog.warning('操作失败!');
                }
            }
        });
        return flag;
    }

    //查看
    function view(id){
        $('#m-hide').hide();
        fillData(id);
    }

    //修改、查看填充数据
    function fillData(id){
        $.post('/teacher/entity',{id:id},function (data) {
            if(data.code == HttpUtil.success_code){
                var teacher = data.result;
                $('#num').val(teacher.num);
                $('#flower-name').val(teacher.flowerName);
                $('#name').val(teacher.name);
                var sexFlag = (teacher.sex == "男")?true:false;
                $("#sex").prop("checked",sexFlag);
                sexSwitch.bootstrapSwitch("state",sexFlag);
                $('#preview-image').attr('src',teacher.imgUrl);
                $('#teacher-image-path').val(teacher.imgUrl);
                $('#teacher-introduction').val(teacher.introduction);
                $('#teacher-user-id').val(teacher.teacherUserId);
                $('#teacher-detail-modal').modal('show');
            }
        });
    }

    //重置表单数据
    function restFormDatas(){
        form.bootstrapValidator('resetForm', true);
        form[0].reset();
    }

    //打开创建、修改模态框
    function openModal(id) {
        $('#m-hide').show();
        $('#preview-image').attr('src','');
        restFormDatas();//重置表单
        if(id){//如果传过来的有id说明为点击修改按钮进入的模态框，需要初始化模态框数据
            fillData(id);
            $('#operation-type').val(false);
        }else{
            $('#operation-type').val(true)
            $('#teacher-detail-modal').modal('show');
        }

        $('#ok').unbind('click').click(function () {
            var numVal = $('#num').val();
            if(!numVal){
                BootstrapDialog.warning('请输入工号!');
                return;
            }
            var odata = {num:numVal};
            $.post('/teacher/entity/user',odata,function (data) {
                if (data.code == HttpUtil.success_code){
                    var user = data.result;
                    if(!user) {
                        BootstrapDialog.warning('未找到该用户!');
                        restFormDatas();//重置表单
                        $('#num').val(numVal);
                        return;
                    }
                    $('#flower-name').val(user.flowerName);
                    $('#name').val(user.username);
                    var sexFlag = (user.sex == "男")?true:false;
                    $("#sex").prop("checked",sexFlag);
                    sexSwitch.bootstrapSwitch("state",sexFlag);
                    $('#teacher-user-id').val(user.id);
                }
            });
        });

        $('#save-teacher').unbind('click').click(function () {
            var isChecked = sexSwitch.bootstrapSwitch("state");
            var sex = isChecked?sexSwitch.bootstrapSwitch("onText"):sexSwitch.bootstrapSwitch("offText");
            var pass = form.data('bootstrapValidator').validate().isValid();//表单验证是否通过
            if (pass){
                var data ={
                    userLock:1 ,
                    num  :$.trim($('#num').val()) ,
                    flowerName  :$.trim($('#flower-name').val()) ,
                    name:$.trim($('#name').val()) ,
                    sex:$.trim(sex) ,
                    imgUrl:$.trim($('#teacher-image-path').val()) ,
                    introduction:$.trim($('#teacher-introduction').val()) ,
                    teacherUserId:$.trim($('#teacher-user-id').val())
                }
                var url;
                if (id){
                    url = '/teacher/update';
                    data.id = id;
                }else{
                    url = '/teacher/save';
                }
                $.post(url,data,function (data) {
                    if (data.code == HttpUtil.success_code){
                        $('#teacher-detail-modal').modal('hide');
                        teacherTable.ajax.reload(null,false);
                    } else{
                        BootstrapDialog.alert(data.message);
                    }
                });
            }
        });

    }

    //锁定用户
    function lockUser(obj){
        var status = $(obj).attr("status");//当前状态,ture正常
        var id = $(obj).val();//用户ID
        var message = status == 1?"是否要锁定用户?":"是否要解锁用户?";
        var data ;
        BootstrapDialog.confirm({
            title: '老师账号锁定',
            message: message,
            type: BootstrapDialog.TYPE_WARNING,
            closable: true,
            btnCancelLabel: '取消',
            btnOKLabel: '确认',
            btnOKClass: 'btn-warning',
            callback: function (result) {
                if (result) {
                    if (status == 1) {
                        //锁定用户
                        data = {"id": id, "userLock": 0}
                    } else {
                        //解锁用户
                        data = {"id": id, "userLock": 1}
                    }

                    $.post('/teacher/update',data,function (data) {
                        if (data.code == HttpUtil.success_code){
                            //重新加载下用户表格
                            teacherTable.ajax.reload(null, false);
                        } else{
                            BootstrapDialog.alert('操作失败!');
                        }
                    });
                }
            }
        })
    }

    /**
     * 初始化 jQuery File Upload 上传文件插件
     * @param fileId
     * @param previewId  预览图id
     * @param savePathInputId  保存图片路径的input id
     */
    function initFileupload(fileId,previewId,savePathInputId) {
        $('#'+fileId).fileupload({
            url:'/upload/image?dirName=teacher',
            done: function (e, data) {
                $('#'+previewId).attr('src', '');
                if(data.result.code == HttpUtil.success_code){
                    var path = data.result.result.path;
                    //裁剪上传图片
                    layer.open({
                        type: 2,
                        title: '裁剪图像',
                        shadeClose: true,
                        shade: 0.8,
                        area: ['600px', '450px'],
                        offset:'100px',
                        content: '/upload/preview?imgUrl='+path, //iframe的url
                        btn: ['确定','取消'],
                        yes: function (index) {
                            var imgpath = window["layui-layer-iframe" + index].saveFunc();
                            if (imgpath) {
                                $('#'+previewId).attr('src', imgpath+'?t='+Math.random());
                                $('#'+savePathInputId).val(imgpath);
                                form//上传成功表单验证设置为通过
                                    .data('bootstrapValidator')
                                    .updateStatus('imgUrl', 'NOT_VALIDATED', null)
                                    .validateField('imgUrl');
                            }
                            layer.close(index); //如果设定了yes回调，需进行手工关闭
                        },
                        success: function(layero){
                            layero.find('.layui-layer-btn').css('text-align', 'center')
                        }
                    });
                }else{
                    var alert = BootstrapDialog.alert||window.alert;
                    alert(data.result.msg);
                }
            }
        });
    }

    //需要暴露到global域的API
    window.page ={
        init:function () {

            //初始化各种事件绑定
            initBindEvents();

            //初始化文件上传插件
            initFileupload('imageFile','preview-image','teacher-image-path');

        }, openModal:openModal,view:view,lockUser:lockUser
    }

})(window);
