<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"
	contentType="text/html; UTF-8"%>
<%@include file="/WEB-INF/view/include/taglib.jsp"%>
<!DOCTYPE html>
<head>
<title>对啊网管理系统-个人</title>

<link
	href="${path}/resources/assets/plugins/bootstrapValidator/css/bootstrapValidator.css"
	rel="stylesheet">
<link
	href="${pageContext.request.contextPath}/resources/css/cate_tab.css"
	rel="stylesheet" />
</head>
<body>

	<div>
		<div class="row">
			<%--密码修改--%>
			<div class="col-md-6">
				<div class="panel panel-inverse">
					<div class="panel-heading">
						<div class="panel-heading-btn">
							<a href="javascript:;"
								class="btn btn-xs btn-icon btn-circle btn-default"
								data-click="panel-expand"><i class="fa fa-expand"></i></a> <a
								href="javascript:;"
								class="btn btn-xs btn-icon btn-circle btn-warning"
								data-click="panel-collapse"><i class="fa fa-minus"></i></a>
						</div>
						<h4 class="panel-title">修改密码</h4>
					</div>
					<div class="panel-body">
						<form id="passwordForm" class="form-horizontal form-bordered">
							<div class="form-group">
								<label class="col-md-3 control-label">原密码*</label>

								<div class="col-md-9">
									<input id="oldPassWord" name="oldPassWord" type="password"
										class="form-control" />
								</div>
							</div>
							<div class="form-group">
								<label class="col-md-3 control-label">新密码*</label>

								<div class="col-md-9">
									<input id="newPassWord" name="newPassWord" type="password"
										class="form-control" />
								</div>
							</div>
							<div class="form-group">
								<label class="col-md-3 control-label">确认密码*</label>

								<div class="col-md-9">
									<input id="againPassWord" name="againPassWord" type="password"
										class="form-control" />
								</div>
							</div>

						</form>
					</div>
					<div class="modal-footer">
						<button id="clearBtn" type="button" class="btn btn-sm btn-info">重置</button>
						<button id="savePassWord" type="button"
							class="btn btn-sm btn-success">保存</button>
					</div>
				</div>
			
				<div class="panel panel-inverse" id="wx_">
					<div class="panel-heading">
						<h4 class="panel-title">微信</h4>
					</div>
					<div class="panel-body">
						<from id="wxFrom" name="wxFrom"
							class="form-horizontal form-bordered">
						<div class="col-xs-10 col-sm-10 col-md-10">
							<div class="form-group">
								<label class="col-md-3 control-label">开启/关闭*</label>

								<div class="col-md-9">
									<input class="switch-btn switch-btn-animbg form-control"
										type="checkbox" checked id="wx_open" name="wx_open">
								</div>
							</div>
						</div>

						<div class="col-xs-10 col-sm-10 col-md-10">
							<div class="form-group">
								<label class="col-md-3 control-label">微信号*</label>

								<div class="col-md-9">
									<input type="text" class="form-control"  id="wx_name" name="wx_name" value="${user.wechatDi}"/>
								</div>
							</div>
						</div>
						<div class="col-xs-10 col-sm-10 col-md-10">
							<div class="form-group">
								<label class="col-md-3 control-label">微信二维码*</label>

								<div class="col-md-9" style="display: flex;">
									<img id="preview-image" alt="课程图片" class="erwewima"
										style="width: 100px; height: 100px; border: 1px solid black;"
										src="${user.wechatUrl}" /> <span
										class="btn btn-primary btn-sm fileinput-button"
										id="shangchuan" style="height: 30px; margin: 30px 0 0 20px;">
										<i class="glyphicon glyphicon-plus"></i> <span>上传</span>

									</span> <input id="imageFile" type="file" name="imageFile"
										style="display: none;"> <input type="hidden"
										id="course-image-path" name="coverUrl" value="${user.wechatUrl}">
								</div>
							</div>
						</div>
						</from>

					</div>
					<div class="modal-footer">
						<button class="btn btn-sm btn-success" id="baocun">保存</button>
					</div>
					
				</div>
			</div>


			<div class="col-md-6">
				<div class="panel panel-inverse">
					<div class="panel-heading">
						<div class="panel-heading-btn">
							<a href="javascript:;"
								class="btn btn-xs btn-icon btn-circle btn-default"
								data-click="panel-expand"><i class="fa fa-expand"></i></a> <a
								href="javascript:;"
								class="btn btn-xs btn-icon btn-circle btn-warning"
								data-click="panel-collapse"><i class="fa fa-minus"></i></a>
						</div>
						<h4 class="panel-title">个人信息</h4>
					</div>
					<div class="panel-body">
						<form id="userInfoForm" class="form-horizontal form-bordered"
							data-parsley-validate="true">
							<div class="col-xs-2 col-sm-2 col-md-2">
								<div class="form-group">
									<img src="${pageContext.request.contextPath}/${user.bigImg}" />
								</div>

							</div>
							<div class="col-xs-10 col-sm-10 col-md-10">
								<div class="form-group">
									<label class="col-md-3 control-label">用户名</label>

									<div class="col-md-9">
										<input type="text" class="form-control" readonly="readonly"
											value="${user.username}" />
									</div>
								</div>
								<div class="form-group">
									<label class="col-md-3 control-label">工号</label>

									<div class="col-md-9">
										<input type="text" class="form-control" readonly="readonly"
											value="${user.num}" />
									</div>
								</div>
								<div class="form-group">
									<label class="col-md-3 control-label">职位</label>

									<div class="col-md-9">
										<input type="text" class="form-control" readonly="readonly"
											value="${user.job}" />
									</div>
								</div>
								<div class="form-group">
									<label class="col-md-3 control-label">手机号</label>

									<div class="col-md-9">
										<input type="text" class="form-control" readonly="readonly"
											value="${user.mobile}" />
									</div>
								</div>

								<div class="form-group">
									<label class="col-md-3 control-label">电子邮箱</label>

									<div class="col-md-9">
										<input type="text" class="form-control" readonly="readonly"
											value="${user.email}" />
									</div>
								</div>
								<div class="form-group">
									<label class="col-md-3 control-label">性别</label>

									<div class="col-md-9">
										<input type="text" class="form-control" readonly="readonly"
											value="${user.sex}" />
									</div>
								</div>
							</div>
						</form>
					</div>
				</div>
			</div>
		</div>

	</div>
	<script
		src="${pageContext.request.contextPath}/resources/assets/plugins/bootstrapValidator/js/bootstrapValidator.js"></script>
		<script
		src="${pageContext.request.contextPath}/resources/assets/plugins/jquery-file-upload/js/jquery.fileupload.all.js"></script>
	<script
		src="${pageContext.request.contextPath}/resources/assets/plugins/bootstrapValidator/js/bootstrapValidator.js"></script>
	
	<script>
		
		//dom对象外提 定义一次减少重复查询
		var form = $("#passwordForm");
		var opw = form.find("#oldPassWord");
		var npw = form.find("#newPassWord");
		var apw = form.find("#againPassWord");

		//值置空
		$(document).ready(function() {
			initBindEvents();
		});
		//初始化各种事件绑定
		function initBindEvents() {

			//重置数据
			$("#clearBtn").unbind().bind("click", function() {
				restFormDatas();
			});

			//修改保存
			$("#savePassWord")
					.unbind()
					.bind(
							"click",
							function() {
								var pass = form.data('bootstrapValidator')
										.validate().isValid();//表单验证是否通过
								if (pass) {

									var data = {
										oldPassWord : opw.val(),
										newPassWord : npw.val()
									}

									$
											.post(
													'/user/updatePassWord',
													data,
													function(datas) {
														if (datas.code == HttpUtil.success_code) {
															BootstrapDialog
																	.success(datas.msg);
															restFormDatas();
														} else {
															BootstrapDialog
																	.alert(datas.msg);
														}
													});
								}
							});

			//绑定表单验证器
			form
					.bootstrapValidator({
						message : 'This value is not valid',
						excluded : [ ':disabled' ],//不加它重新打开模态框时提示不会清除
						fields : {
							oldPassWord : {
								validators : {
									notEmpty : {
										message : '原密码不能为空!'
									}
								}
							},
							newPassWord : {
								validators : {
									notEmpty : {
										message : '请输入新密码!'
									},
									regexp : {
										regexp : /^(?!([a-zA-Z]+|\d+)$)[a-zA-Z\d]{8,12}$/,
										message : '密码格式为字母和数字组合至少8位!'
									}
								}
							},
							againPassWord : {
								validators : {
									notEmpty : {
										message : '请再次输入新密码'
									},
									identical : {
										field : 'newPassWord',
										message : '两次密码不同请重新输入'
									}
								}
							}
						}
					});
		}

		//重置表单数据
		function restFormDatas() {
			form.bootstrapValidator('resetForm', true);
			form[0].reset();
		}

	//微信
	$('#shangchuan').click(function() {
		$('#imageFile').click()
	})
	//渲染数据
	/* data={
		role_id:"adfsjfk97",
		weichat_status:1,
		wechat_di:"fasfas",
		wechat_url:"http://localhost:88/resources/base/system/images/user-12.jpg"
	} */
	var wechatStatus = ${user.wechatStatus}
		 var weId = ${id}
		 var weRoleId = ${roleId}
	 if(weRoleId.indexOf(97) != -1){
		 document.getElementById("wx_").style.display = "block";
		if(wechatStatus == 1){
			 document.getElementById('wx_open').checked = true
			 $("#wx_name").removeAttr("disabled")
				$("#imageFile").removeAttr("disabled")

		} else {
			 document.getElementById('wx_open').checked = false
				$("#wx_name").attr("disabled","true")
				$("#imageFile").attr("disabled","true")
		}
		
		
	} else {
		
		document.getElementById("wx_").style.display = "none";
	} 
	//上传图片
	function initFileupload(fileId, previewId, savePathInputId) {
		console.log(fileId)
			$('#' + fileId).fileupload(
					{
						url : '/upload/image',
						done : function(e, data) {
							console.log(data)
							if (data.result.code == HttpUtil.success_code) {
								var path = data.result.result.path;
								$('#' + previewId).attr('src', path);
								$('#' + savePathInputId).val(path);
							} else {
								var alert = BootstrapDialog.alert
										|| window.alert;
								alert(data.result.msg);
							}
						}
					});
		}
	initFileupload('imageFile', 'preview-image', 'course-image-path');
	//开关控制
	$("#wx_open").click(function(){
		if(document.getElementById('wx_open').checked == false ){
			$("#wx_name").attr("disabled","true")
			$("#imageFile").attr("disabled","true")
		} else {
			$("#wx_name").removeAttr("disabled")
			$("#imageFile").removeAttr("disabled")
		}
	})
	// 保存
	
	$("#baocun").click(function(){
		var status = document.getElementById('wx_open').checked
		if(status == true){
			status = 1;
			if(!$("#wx_name").val() || !$("#course-image-path").val()){
				alert("部分数据未填写")
				return
			}
		} else {
			status = 0
		}
		var datas= {
				id:weId,
				wechatStatus:status,
				wechatDi:$("#wx_name").val(),
				wechatUrl:$("#course-image-path").val()
			}
		console.log(datas)
		$.ajax({
			url:'/user/savewechat',
			data:datas,
			success:function(res){
				 console.log(res) 
				 if(res.code == 200) {
					 alert("修改完成")
				 }
			}
		})
	})
	</script>
</body>

</html>
