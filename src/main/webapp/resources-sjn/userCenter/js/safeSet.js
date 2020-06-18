/**
 * 初始化 jQuery File Upload 上传文件插件
 * @param fileId
 * @param previewId  预览图id
 * @param savePathInputId  保存图片路径的input id
 */
function initFileupload(fileId, previewId, savePathInputId) {
    $('#' + fileId).fileupload({
        url: '/upload/image',
        done: function (e, result) {
            if (result._response.result.success = true) {
                var map = result._response.result.data;
                if (map['path'] != null && map['path'] != '') {
                    var path = map['path'];
                    //裁剪上传图片
                    layer.open({
                        type: 2,
                        title: '更换图像',
                        shadeClose: true,
                        shade: 0.8,
                        //area: ['27%', '49%'],
                        area: ['600px', '450px'],
                        offset: '100px',
                        content: '/upload/preview?imgUrl=' + path, //iframe的url
                        btn: ['确定', '取消'],
                        yes: function (index) {
                            var res = window["layui-layer-iframe" + index].saveFunc();
                            if (res) {
                                $('#' + previewId).attr('src', path);
                                $('#' + savePathInputId).val(path);
                                /* $('#course')//上传成功表单验证设置为通过
                                 .data('bootstrapValidator')
                                 .updateStatus('coverUrl', 'NOT_VALIDATED', null)
                                 .validateField('coverUrl');*/
                            }
                            layer.close(index); //如果设定了yes回调，需进行手工关闭
                        },
                        success: function (layero) {
                            layero.find('.layui-layer-btn').css('text-align', 'center')
                        }
                    });
                }

            } else {
                /* var alert = BootstrapDialog.alert||window.alert;*/
                alert(result.message + '上传失败');
            }
        }
    });
}
String.prototype.trim = function() { return this.replace(/^\s+/, '').replace(/\s+$/, ''); }//解决ie8不支持trim函数的问题
$(function () {
    var vipId = $("#vipid").val() + '';
    var level = 'userLt-name';
    if (vipId != null && vipId != '') {
        if (vipId == '1') {
            level += "-month"
        }
        if (vipId == '2') {
            level += "-season"
        }
        if (vipId == '3') {
            level += "-year"
        }
        var vipLevel = $("#vipLevel")
        vipLevel.attr("class", level);
    }

    /*进入页面禁用所有空间*/
    //$("#userInfo-update-form")
    disableForm('userInfo-update-form', true);
    var userid = $("#userid").val();
    //省份json
    $.each(provinceJson, function (k, p) {
        var option = "<option value='" + p.id + "'>" + p.province + "</option>";
        $("#userProvince").append(option);
    });
    $.each(cityJson, function (k, p) {
        var option = "<option value='" + p.id + "'>" + p.city + "</option>";
        $("#userAddress").append(option);
    });

    //选择省份后级联城市
    $("#userProvince").change(function () {
        var selValue = $(this).val();
        $("#userAddress option:gt(0)").remove();
        $.each(cityJson, function (k, p) {
            // 直辖市处理.|| p.parent == selValue，直辖市为当前自己
            if (p.id == selValue || p.parent == selValue) {
                var option = "<option value='" + p.id + "'>" + p.city + "</option>";
                $("#userAddress").append(option);
            }
        });
    });
    var canPass=false;
    $("#oldPassword").blur(function () {
        var dataCheck = {username: userid, oldPassword: $("#oldPassword").val()};
        var checkUrl = '/user/password/check';
        $.post(checkUrl, dataCheck).done(function (result) {
            if (result.success) {
                $("#password").attr('disabled',false);
                $("#rePassword").attr('disabled',false);
                canPass=true;
            } else {
                layer.alert('原始密码输入错误');
                $("#password").attr('disabled',true);
                $("#rePassword").attr('disabled',true);
                $("#password").val('');
                $("#rePassword").val('');
                canPass=false;
                return false;
            }
        });
    })
    /*个人中心  修改密码*/
    $("#pwd-update-btn").click(function () {
        var pass = true;
        $('#pwd-update-form input').each(function () {
            if ($(this).val() == '') {
                /* $(this).blur();*/
                pass = false;
                return false;
            }
        });
        if(canPass==false){
            layer.alert("原始密码输入错误");
            return false;
        }
        /*修改前验证*/
        var old = $("#oldPassword").val();
        var pass = $("#password").val();
        var pass2 = $("#rePassword").val();
        if(old==''|| old.length<1){
            layer.alert('请输入原始密码！')
        }else if (pass != pass2) {
            layer.alert('两次输入的密码不一致');
        }else if(pass.length==0){
            layer.alert('请设置新密码');
            return;
        }else if(pass2.length==0){
            layer.alert('请确认新密码');
            return false;
        } else if (!/^.{6,18}$/.test(pass)) {
            layer.alert("密码长度必须为6-18位");
        } else {
            var dataCheck = {username: userid, oldPassword: old};
            var checkUrl = '/user/password/check';
            $.post(checkUrl, dataCheck).done(function (result) {
                if (result.success) {
                    var data = {password: pass, oldPassword: old, username: userid};
                    $.post('/user/password/modify', data).done(function (result) {
                        if (result.success) {
                            $('#passSucMsg').html(result.message);
                            $('#passTip').css('display','block');
                            var tiaozhuan= setInterval(function () {
                                $('#passTip').css('display','none');
                                $('#page-right').load("/userCenter/right/safeSet");
                            }, 3000);
                            $(document).click(function(){
                                $("#passTip").css('display','none');
                                $(document).unbind();
                                $('#page-right').load("/userCenter/right/safeSet");
                                clearInterval(tiaozhuan);
                            });

                        } else {
                            layer.alert(result.message);
                        }
                    })
                } else {
                    layer.alert(result.message);
                }
            });

        }

    })

    initFileupload('imageFile', 'preview-image', 'head-image-path');
});


/*禁用表单*/
function disableForm(formId, isDisabled) {
    var attr = true;
    if (!isDisabled) {
        attr = false;
    }
    $("form[id='" + formId + "'] :text").attr("disabled", attr);
    $("form[id='" + formId + "'] textarea").attr("disabled", attr);
    $("form[id='" + formId + "'] select").attr("disabled", attr);
    $("form[id='" + formId + "'] :radio").attr("disabled", attr);
    $("form[id='" + formId + "'] :checkbox").attr("disabled", attr);

}

/*解除禁用*/
function enableForm(formId) {
    $('#upload-span').show();
    $("form[id='" + formId + "'] :text").attr("disabled", false);
    $("form[id='" + formId + "'] textarea").attr("disabled", false);
    $("form[id='" + formId + "'] select").attr("disabled", false);
    $("form[id='" + formId + "'] :radio").attr("disabled", false);
    $("form[id='" + formId + "'] :checkbox").attr("disabled", false);
}

function btnClick(btn) {
    enableForm('userInfo-update-form', false);//第一次点击 解除禁用
    $("#userInfo-update-btn1").css("display", "block");
    $("#userInfo-update-btn").css("display", "none");
    $("#username").focus();
    /*获得焦点后将焦点定位到文本框最后，并改变样式*/
    var usernameInput = $("#username");
    $.fn.setCursorPosition = function (position) {
        if (this.lengh == 0) return this;
        return $(this).setSelection(position, position);
    }
    $.fn.setSelection = function (selectionStart, selectionEnd) {
        if (this.lengh == 0) return this;
        input = this[0];
        if (input.createTextRange) {
            var range = input.createTextRange();
            range.collapse(true);
            range.moveEnd('character', selectionEnd);
            range.moveStart('character', selectionStart);
            range.select();
        } else if (input.setSelectionRange) {
            input.focus();
            input.setSelectionRange(selectionStart, selectionEnd);
        }
        return this;
    }
    $.fn.focusEnd = function () {
        this.setCursorPosition(this.val().length);
    }
    usernameInput.focusEnd();
    usernameInput.parent().css("background", "#fff");
    document.title = '账户管理';
}
/*提示*/
function alertmsg(content) {
    layer.open({
        title: '提示信息'
        , offset: '150px'
        , shadeClose: true
        , content: content
    });
}
function updateInfo() {
    var pass = true;
    var message = '';
    /* if($("#head-image-path").val()==null || $("#head-image-path").val()==''){
     message='请上传头像';
     alertmsg(message);
     return false;
     }*/
    var username = $("#username").val();
    /*  if(username.length<=0){
     message='用户名不能为空';
     alertmsg(message);
     return false;
     }*/
    if (username.length > 12) {
        message = '用户名不能超过12个字符';
        alertmsg(message);
        return false;
    }
    var profession = $("#profession").val();
    if (profession != '' && profession.length > 10) {
        message = '职位不能超过10个字符!';
        alertmsg(message);
        return false
    }
    var reg=/^[1-9]\d{4,12}$/;
    if ($("#qqNum").val().length > 0 && !reg.test($("#qqNum").val().trim())) {
        message = '请输入正确的QQ号码!';
        alertmsg(message);
        return false
    }
    if (pass) {
        var data = Util.fromToJson('userInfo-update-form');
        $.post('/userCenter/saveUserInfo', data).done(function (result) {
            if (result.success) {
                $('#sucMessage').html(result.message);
                $('#upInfoTip').css("display",'block');
                var tiaozhuan= setInterval("successUpdate()",3000);
                $(document).click(function(){
                    $("#upInfoTip").css('display','none');
                    $(document).unbind();
                    window.location.href = "/userCenter?t="+(new Date).valueOf()+"#safeSet";
                    clearInterval(tiaozhuan);
                });


            } else {
                alertmsg(result.message);
            }
        })
    }
}

function successUpdate(){
    $('#upInfoTip').css('display','none');
    window.location.href = "/userCenter?t="+(new Date).valueOf()+"#safeSet";

}