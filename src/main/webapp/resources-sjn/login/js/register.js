/**
 * 注册页面脚本
 * @author 李恒名
 * @date 2016年6月28日
 */
(function ($) {


    $(document).ready(function () {
        bindEvents();
    })


    //表单字段验证bind util
    function validateBind(id, callback) {
        $('#' + id).blur(function () {
            var tips = $(this).siblings('.positioning');
            var val = $.trim($(this).val());
            if (val == $(this).attr('data-tag')){
                val = '';
            }
            if (val != '') {
                tips.html('');
            }
            callback(val, tips);
        });
    }



    function onRegisterSuccess(){
        $('#container').html('');
        $('#register-success-btn').click(function () {
            onRegisterSuccessAfter();
        });
        $(".succeed").fadeIn(500,function () {
            var time = 3;
            var task = setInterval(function () {
                if (time > 0){
                    $('#register-success-btn').val('确定('+time+')');
                }else{
                    clearInterval(task);
                    onRegisterSuccessAfter();
                }
                time--;
            }, 1000);
        });
    }

    function onRegisterSuccessAfter() {

        if (location.href.indexOf('/plan') != -1) {
            goBuy();
        } else {
            location.href = location.href.indexOf('?') == -1 ? location.href : (location.href.substring(0, location.href.indexOf('?')));
        }
    }
    //绑定各种事件
    function bindEvents() {
        Util.onEnter(function () {
            $("#phone-register-btn").click();
        });
        $(".register-top li").click(function () {
            $(this).css("border-bottom", "2px solid #5583db").siblings().css("border-bottom", "2px solid #ffffff")
            var ka = $(this).index();
            if (ka == 0) {
                $(document).unbind('onkeydown');
                Util.onEnter(function () {
                    $("#phone-register-btn").click();
                });
                $(".phong-Control").fadeIn(500)
                $(".email-Control").fadeOut(100)
                $(".alert").css("height", "450px")
            } else if (ka == 1) {
                $(document).unbind('onkeydown');
                Util.onEnter(function () {
                    $("#email-register-btn").click();
                });
                $(".email-Control").fadeIn(500)
                $(".phong-Control").fadeOut(100)
                $(".alert").css("height", "400px")
            }
            //切换注册方式时刷新验证码
           /* setTimeout(function () {
                $('.code-img img').attr('src', '/captcha/image');
            }, 200);*/
        });

        validateFormBinds();

        $('.user-protocol').click(function () {
                if ($(this).prop('checked')){
                    $(this).siblings('.positioning').html('');
                }else{
                    $(this).siblings('.positioning').html('请确认您已阅读并同意该协议');
                }
        });

        $("#phone-register-btn").click(function () {

            $('#phone-form input').each(function () {
                if ($(this).val() == '' || $(this).val() == $(this).attr('data-tag')) {
                    $(this).blur();
                    return false;
                }
            });
            var pass = true;
            $('#phone-form .positioning').each(function (key, val) {
                if ($(val)[0].innerText != '')
                    pass = false;
            });
            if (!$('#user-protocol-phone').prop('checked')){
                $('#user-protocol-email').siblings('.positioning').html('请确认您已阅读并同意该协议');
                pass = false;
            }
            if (pass) {
                var data = Util.fromToJson('phone-form');
                data.isPhone = true;
                $.post('/user/register', data).done(function (result) {
                    if (result.success) {
                        onRegisterSuccess();
                    } else {
                        $('#sms-captcha').siblings('.positioning').html(result.message);
                    }
                })
            }
        });
        $("#email-register-btn").click(function () {
            var pass = true;
            $('#email-form input').each(function () {
                if ($(this).val() == '' || $(this).val() == $(this).attr('data-tag')) {
                    $(this).blur();
                    return false;
                }
            });
            $('#email-form .positioning').each(function (key, val) {
                if ($(val)[0].innerText != '')
                    pass = false;
            });
            if (!$('#user-protocol-email').prop('checked')){
                $('#user-protocol-email').siblings('.positioning').html('请确认您已阅读并同意该协议');
                pass = false;
            }
            if (pass) {
                var data = Util.fromToJson('email-form');
                data.isPhone = false;
                $.post('/user/register', data).done(function (result) {
                    if (result.success) {
                        onRegisterSuccess();
                    } else {
                        $('#email-image-captcha').siblings('.positioning').html(result.message);
                    }
                })
            }

        })

        Util.sendSms('sms-btn', 1);

        function validateFormBinds() {
            validateBind('phone', function (val, tips) {
                if (val == '') {
                    tips.html('请输入手机号');
                } else if (!/^(13[0-9]|17[0-9]|14[0-9]|15[0-9]|18[0-9])\d{8}$/.test(val)) {
                    tips.html('请输入有效的手机号');
                } else {
                    $.getJSON('/user/exists/username', {username: val}).done(function (exists) {
                        if (exists)tips.html('该手机号已被注册');
                    })
                }
            });
            validateBind('email-username', function (val, tips) {
                if (val == '') {
                    tips.html('请输入邮箱');
                } else if (!/^([a-zA-Z0-9]*[-_]?[a-zA-Z0-9]+)*@([a-zA-Z0-9]*[-_]?[a-zA-Z0-9]+)+[\\.][A-Za-z]{2,3}([\\.][A-Za-z]{2})?$/.test(val)) {
                    tips.html('请输入有效的邮箱');
                } else {
                    $.getJSON('/user/exists/username', {username: val}).done(function (exists) {
                        if (exists)tips.html('该邮箱已被注册');
                    })
                }
            });
            //其他浏览器
            validateBind('phone-password', function (val, tips) {
                if (val == '') {
                    tips.html('请输入密码');
                } else if (!/^.{6,18}$/.test(val)) {
                    tips.html('密码长度为6~18位');
                }
            });

            //IE8情况下使用Placeholder插件绑定实际的INPUT
            $('#phone-password').siblings('input')[0] && $('#phone-password').siblings('input').blur(function () {
                var tips = $(this).siblings('.positioning');
                var val = $.trim(this.value);
                if (val == '') {
                    tips.html('请输入密码');
                } else if (!/^.{6,18}$/.test(val)) {
                    tips.html('密码长度为6~18位');
                }else{
                    tips.html('');
                }
            });
            validateBind('email-password', function (val, tips) {
                var val = $.trim(this.value);
                if (val == '') {
                    tips.html('请输入密码');
                } else if (!/^.{6,18}$/.test(val)) {
                    tips.html('密码长度为6~18位');
                }
            });
            validateBind('image-captcha', function (val, tips) {
                if (val == '') {
                    tips.html('请输入验证码');
                }
            });
            validateBind('email-image-captcha', function (val, tips) {
                if (val == '') {
                    tips.html('请输入验证码');
                }
            });
            validateBind('sms-captcha', function (val, tips) {
                if (val == '') {
                    tips.html('请输入验证码');
                }
            });
        }

    }


})(jQuery)
$(".phone-number input").keyup(function(){
    var bs = $(".phone-number input").val();
    if(bs!=""){
        $(".phone-number").css("background","#fff");
        $(".phone-number input").css("background","#fff")
    }
});
$(".password-number input").keyup(function(){
    var bs = $(".password-number input").val();
    if(bs!=""){
        $(".password-number").css("background","#fff");
        $(".password-number input").css("background","#fff")
    }
});
$(".code-number input").keyup(function(){
    var bs = $(".code-number input").val();
    if(bs!=""){
        $(".code-number").css("background","#fff");
        $(".code-number input").css("background","#fff")
    }
});

$(".note-number input").keyup(function(){
    var bs = $(".note-number input").val();
    if(bs!=""){
        $(".note-number").css("background","#fff");
        $(".note-number input").css("background","#fff")
    }
});

$(".email input").keyup(function(){
    var bs = $(".email input").val();
    if(bs!=""){
        $(".email").css("background","#fff");
        $(".email input").css("background","#fff")
    }
});

$(".email-pass input").keyup(function(){
    var bs = $(".email-pass input").val();
    if(bs!=""){
        $(".email-pass").css("background","#fff");
        $(".email-pass input").css("background","#fff")
    }
});

$(".code-numberO input").keyup(function(){
    var bs = $(".code-numberO input").val();
    if(bs!=""){
        $(".code-numberO").css("background","#fff");
        $(".code-numberO input").css("background","#fff")
    }
})
