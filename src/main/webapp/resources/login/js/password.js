/**
 * 找回密码页面脚本
 * @author 李恒名
 * @date 2016年6月30日
 */
(function ($) {
	$(document).ready(function () {
		validateFormBinds();
		bindClickEvents();
	});

	function bindClickEvents() {
		findByPhone();
		findByEmail()

		/*$(".find-top li").click(function() {
			var t = $(".find-top li").index(this);
			b=t;
			if (t == 0) {
				$(".find-phone").fadeIn(500);
				$(".find-email").fadeOut(500);
				$(this).css("border-bottom", "2px solid #5583db").siblings().css("border-bottom", "2px solid #ffffff")
			} else if (t == 1) {

				$(".find-email").fadeIn(500);
				$(".find-phone").fadeOut(500);
				$(this).css("border-bottom", "2px solid #5583db").siblings().css("border-bottom", "2px solid #ffffff")
			}
			setTimeout(function () {
				$('.code-img img').attr('src', '/captcha/image');
			}, 500);

		});*/
		$(".emailnt-step").click(function(){
			var findreg = /^[a-z0-9]+([._\\-]*[a-z0-9])*@([a-z0-9]+[-a-z0-9]*[a-z0-9]+.){1,63}[a-z0-9]+$/; //邮箱正则
			var findemail = $(".find-emailNumber input").val();
			if(findreg==""){
				$(".find-emailNumber .positioning").text("邮箱格式不正确");
			}else if(!(findreg.test(findemail))){
				$(".find-emailNumber .positioning").text("邮箱格式不正确");
			}else{
				$(".find-emailNumber .positioning").text("");
				$(".center").fadeOut(500);
				$(".reset").fadeIn(500);
			}

		});

	}


	function findByPhone(){
		Util.sendSms('sms-btn', 2);

		$('#find-password-next').click(function () {
			var pass = true;
			$('#find-password-sms-form input').each(function () {
				if ($(this).val() == '' || $(this).val() == $(this).attr('data-tag')) {
					$(this).blur();
					return false;
				}
			});
			$('.positioning').each(function (key, val) {
				if ($(val)[0].innerText != '')
					pass = false;
			});

			if (pass) {
				var data = Util.fromToJson('find-password-sms-form');
				$.post('/user/password/find/validate/sms', data).done(function (result) {
					if (result.success) {
						$(".reset").fadeIn(300);
						$(".center").fadeOut(300);

						$('#reset-btn').click(function () {
							var pass = true;
							$('#reset-password-form input').each(function () {
								if ($(this).val() == '' || $(this).val() == $(this).attr('data-tag')) {
									$(this).blur();
									return false;
								}
							});
							$('.positioning').each(function (key, val) {
								if ($(val)[0].innerText != '')
									pass = false;
							});
							data.password = $('#password').val();
							if (pass) {
								$.post('/user/password/find/modify', data).done(function (result) {
									if (result.success) {
										$(".reset").fadeOut(500);
										$(".succeed").fadeIn(500);
									} else {
										$('#re-password').siblings('.positioning').html(result.message);
									}
								});
							}
						});
					} else {
						alert(result.message);
					}
				});

			}
		});
	}

	function findByEmail(){
		$("#email-btn").click(function (event) {
			var time = 59;
			var $readOnlyBtn = $('#email-btn-readonly');
			var $sendBtn = $(this);
			var $email = $('#email');
			var $imageCaptcha = $('#image-captcha-email');

			var captcha = $.trim($imageCaptcha.val());
			var email = $.trim($email.val());
			if (!/^([a-zA-Z0-9]*[-_]?[a-zA-Z0-9]+)*@([a-zA-Z0-9]*[-_]?[a-zA-Z0-9]+)+[\\.][A-Za-z]{2,3}([\\.][A-Za-z]{2})?$/.test(email)) {
				$email.siblings('.positioning').html('请输入正确的邮箱');
			} else if (captcha == '') {
				$imageCaptcha.siblings('.positioning').html('请输入图形验证码');
			} else {
				$.post('/captcha/email', {imageCaptcha: captcha, email: email}).done(function (result) {
					if (result.success) {
						$sendBtn.hide();
						$readOnlyBtn.html(time + "秒");
						$readOnlyBtn.show();
						var t = setInterval(function () {
							time--;
							$readOnlyBtn.html(time + "秒");
							if (time == 0) {
								clearInterval(t);
								$sendBtn.html('重新获取');
								$('#capt-img').click();
								$readOnlyBtn.hide();
								$sendBtn.show();
							}
						}, 1000);
					} else {
						$imageCaptcha.siblings('.positioning').html(result.message);
					}
				});
			}
		});
		$('#find-password-email-next').click(function () {
			var pass = true;
			$('#find-password-email-form input').each(function () {
				if ($(this).val() == '' || $(this).val() == $(this).attr('data-tag')) {
					$(this).blur();
					return false;
				}
			});
			$('.positioning').each(function (key, val) {
				if ($(val)[0].innerText != '')
					pass = false;
			});

			if (pass) {
				var data = Util.fromToJson('find-password-email-form');
				$.post('/user/password/find/validate/email', data).done(function (result) {
					if (result.success) {
						$(".reset").fadeIn(300);
						$(".center").fadeOut(300);

						$('#reset-btn').click(function () {
							var pass = true;
							$('#reset-password-form input').each(function () {
								if ($(this).val() == '' || $(this).val() == $(this).attr('data-tag')) {
									$(this).blur();
									return false;
								}
							});
							$('.positioning').each(function (key, val) {
								if ($(val)[0].innerText != '')
									pass = false;
							});
							data.password = $('#password').val();
							if (pass) {
								$.post('/user/password/find/modify', data).done(function (result) {
									if (result.success) {
										$(".reset").fadeOut(500);
										$(".succeed").fadeIn(500);
									} else {
										$('#re-password').siblings('.positioning').html(result.message);
									}
								});
							}
						});
					} else {
						alert(result.message);
					}
				});

			}
		});
	}

	function validateFormBinds() {
		validateBind('phone', function (val, tips) {
			if (val == '') {
				tips.html('请输入手机号');
			} else if (!/^(13[0-9]|17[0-9]|14[0-9]|15[0-9]|18[0-9])\d{8}$/.test(val)) {
				tips.html('请输入正确的手机号');
			} else {
				$.getJSON('/user/exists/mobile', {mobile: val}).done(function (exists) {
					if (!exists)tips.html('此手机号尚未绑定会计狮账号');
				})
			}
		});
		validateBind('email', function (val, tips) {
			if (val == '') {
				tips.html('请输入邮箱');
			} else if (!/^([a-zA-Z0-9]*[-_]?[a-zA-Z0-9]+)*@([a-zA-Z0-9]*[-_]?[a-zA-Z0-9]+)+[\\.][A-Za-z]{2,3}([\\.][A-Za-z]{2})?$/.test(val)) {
				tips.html('请输入正确的邮箱');
			} else {
				$.getJSON('/user/exists/username', {username: val}).done(function (exists) {
					if (!exists)tips.html('此邮箱尚未注册');
				})
			}
		});
		validateBind('password', function (val, tips) {
			if (val == '') {
				tips.html('请输入密码');
			} else if (!/^\w{6,18}$/.test(val)) {
				tips.html('密码长度为6~18位');
			}
		});
		$('#password').siblings('input')[0] && $('#password').siblings('input').blur(function () {
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
		validateBind('re-password', function (val, tips) {
			if (val == '') {
				tips.html('请确认密码');
			} else if ($('#password').val() != val) {
				tips.html('两次密码输入不一致');
			}

		});
		$('#re-password').siblings('input')[0] && $('#re-password').siblings('input').blur(function () {
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
		validateBind('image-captcha', function (val, tips) {
			if (val == '') {
				tips.html('请输入图形验证码');
			}
		});
		validateBind('image-captcha-email', function (val, tips) {
			if (val == '') {
				tips.html('请输入验证码');
			}
		});
		validateBind('sms-captcha', function (val, tips) {
			if (val == '') {
				tips.html('请输入短信验证码');
			}
		});
		validateBind('email-captcha', function (val, tips) {
			if (val == '') {
				tips.html('请输入邮箱验证码');
			}
		});
	}
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

$(".find-phoneNumber input").keyup(function(){
	var bs = $(".find-phoneNumber input").val();
	if(bs!=""){
		$(".find-phoneNumber").css("background","#fff");
		$(".find-phoneNumber input").css("background","#fff")
	}
});


$(".Findcode-number input").keyup(function(){
	var bs = $(".Findcode-number input").val();
	if(bs!=""){
		$(".Findcode-number").css("background","#fff");
		$(".Findcode-number input").css("background","#fff")
	}
});

$(".Findnote-number input").keyup(function(){
	var bs = $(".Findnote-number input").val();
	if(bs!=""){
		$(".Findnote-number").css("background","#fff");
		$(".Findnote-number input").css("background","#fff")
	}
})

$(".yes-password input").keyup(function(){
	var bs = $(".yes-password input").val();
	if(bs!=""){
		$(".yes-password").css("background","#fff");
		$(".yes-password input").css("background","#fff")
	}
})

$(".reset-password input").keyup(function(){
	var bs = $(".reset-password input").val();
	if(bs!=""){
		$(".reset-password").css("background","#fff");
		$(".reset-password input").css("background","#fff")
	}
})




$(".emailcode-number input").keyup(function(){
	var bs = $(".emailcode-number input").val();
	if(bs!=""){
		$(".emailcode-number").css("background","#fff");
		$(".emailcode-number input").css("background","#fff")
	}
})




$(".find-emailNumber input").keyup(function(){
	var bs = $(".find-emailNumber input").val();
	if(bs!=""){
		$(".find-emailNumber").css("background","#fff");
		$(".find-emailNumber input").css("background","#fff")
	}
})

$(".Findnote-numberO input").keyup(function(){
	var bs = $(".Findnote-numberO input").val();
	if(bs!=""){
		$(".Findnote-numberO").css("background","#fff");
		$(".Findnote-numberO input").css("background","#fff")
	}
})


$(".Findcode-numberO input").keyup(function(){
	var bs = $(".Findcode-numberO input").val();
	if(bs!=""){
		$(".Findcode-numberO").css("background","#fff");
		$(".Findcode-numberO input").css("background","#fff")
	}
})

$(".code-numberO input").keyup(function(){
	var bs = $(".code-numberO input").val();
	if(bs!=""){
		$(".code-numberO").css("background","#fff");
		$(".code-numberO input").css("background","#fff")
	}
})


/*$(".reset-password input").focus(function() {
	var pasd = $(".reset-password input").val();

	pasd = "";
	if (pasd == "") {
		$(".reset-password input[type='text']").attr('type', 'password')
	}
})
$(".reset-password input").blur(function() {
	var pasd = $(".reset-password input").val();

	if (pasd == "" || pasd == "6~18位") {
		$(".reset-password input").text("6~18位");
		$(".reset-password input").attr('type', 'text')
	}

})*/



/*
$(".yes-password input").focus(function() {
	var pasd = $(".yes-password input").val();

	pasd = "";
	if (pasd == "") {
		$(".yes-password input[type='text']").attr('type', 'password')
	}
})
$(".yes-password input").blur(function() {
	var pasd = $(".yes-password input").val();

	if (pasd == "" || pasd == "确认密码") {
		$(".yes-password input").text("确认密码");
		$(".yes-password input").attr('type', 'text')
	}

})*/

