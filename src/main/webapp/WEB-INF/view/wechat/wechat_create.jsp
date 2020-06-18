<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"
	contentType="text/html; UTF-8"%>
<%@include file="/WEB-INF/view/include/taglib.jsp"%>
<!DOCTYPE html>
<html lang="en">
<head>
<title>${pname}管理系统-课程管理</title>
<link
	href="${pageContext.request.contextPath}/resources/assets/plugins/DataTables/media/css/dataTables.bootstrap.min.css"
	rel="stylesheet" />
<link
	href="${pageContext.request.contextPath}/resources/assets/plugins/bootstrap-daterangepicker/daterangepicker-bs3.css"
	rel="stylesheet" />
<link
	href="${pageContext.request.contextPath}/resources/assets/plugins/DataTables/extensions/Select/css/select.bootstrap.min.css"
	rel="stylesheet" />
<link
	href="${pageContext.request.contextPath}/resources/assets/plugins/bootstrap-datetimepicker/css/datetimepicker.css"
	rel="stylesheet" />
<link
	href="${pageContext.request.contextPath}/resources/common/switch/css/bootstrap-switch.min.css"
	rel="stylesheet" />
<link href="${pageContext.request.contextPath}/resources/css/wx.css"
	rel="stylesheet">
<link href="${pageContext.request.contextPath}/resources/css/creat.css"
	rel="stylesheet">
	<link
	href="${path}/resources/assets/plugins/bootstrapValidator/css/bootstrapValidator.css"
	rel="stylesheet">
<link
	href="${path}/resources/assets/plugins/jquery-file-upload/css/jquery.fileupload.css"
	rel="stylesheet">

</head>
<body>
	<input type="hidden" id="position-id" name="position-id"
		value="${positionId}">
	<input type="hidden" id="direction-id" name="direction-id"
		value="${directionId}">

	<div class="row">
		<div class="col-md-10" style="width: 1400px">
			<div class="panel panel-inverse">
				<div class="panel-heading">
					<h4 class="panel-title">微信管理</h4>
				</div>
				<div class="wrap">
					<div class="clear">
						<button class="btn btn-primary btn-lg w_150"
							style="float: left; margin-right: 20px;" id="xiaoshouBtn">
							销售</button>
						<button class="btn btn-default btn-lg w_150" id="yunyingBtn">
							运营</button>

						<button class="btn btn-info btn-lg w_150"
							style="float: right; margin-right: 70px;" id="add">添加</button>
					</div>
					<div id="tBody">
						<table class="table table-bordered">
							<tr>
								<th>姓名</th>
								<th>微信号</th>
								<th>二维码</th>
								<th>状态</th>
								<th>操作</th>
							</tr>
							<tbody id="tbody">
								<!-- <tr>
									<td>贡老师</td>
									<td>gonglaoshi</td>
									<td><image src="/resources/base/system/images/user-12.jpg" /></td>
									<td>开启</td>
									<td>
										<button class="btn btn-primary btn-lg edit"
											style="margin-right: 25px;" data-id="1">编辑</button>
										<button class="btn btn-primary btn-lg del" data-id="1">删除</button>
									</td>
								</tr> -->
							</tbody>
						</table>

					</div>
				</div>
			</div>
		</div>
	</div>
	<!-- 弹出层 -->
	<div class="mask" >
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="panel panel-inverse">
					<div class="panel-heading">
						<button type="button" class="close" data-dismiss="modal"
							aria-hidden="true">×</button>
						<h4 class="panel-title">管理</h4>
					</div>
				</div>
				<div class="panel-body">
					<form id="cateForm" class="form-horizontal form-bordered"
						data-parsley-validate="true">
						<div class="form-group">
							<label class="col-md-3 control-label">姓名*</label>
							<div class="col-md-9">
								<input id="name" class="form-control" />
							</div>
						</div>
						<div class="form-group">
							<label class="col-md-3 control-label">开关*</label>
							<div class="col-md-9">

								<label class="switch"> <input
									type="checkbox" id="shangjia">
									<div class="slider round"></div>
								</label>
							</div>
						</div>
						<div class="form-group">
							<label class="col-md-3 control-label">微信号*</label>
							<div class="col-md-9">
								<input id="wxId" class="form-control" />
							</div>
						</div>
						<div class="form-group">
							<label class="col-md-3 control-label">二维码*</label>
							<div class="col-md-9">
								<span class="btn btn-primary btn-sm fileinput-button"
									id="shangchuan"> <i class="glyphicon glyphicon-plus"></i>
									<span>上传</span>

								</span> <input id="imageFile" type="file" name="imageFile"> <input
									type="hidden" id="course-image-path" name="coverUrl">
								<div class="col-md-4">
									<img id="preview-image" alt="课程图片" class="img-thumbnail" />
								</div>
							</div>
						</div>
						<div class="form-group" style="display:none;">
							<label class="col-md-3 control-label">id*</label>
							<div class="col-md-9">
								<input id="ID" class="form-control" />
							</div>
						</div>
					</form>
				</div>
				<div class="modal-footer">
					<a id="close" href="javascript:;" class="btn btn-sm btn-info"
						data-dismiss="modal">关闭</a> <a id="saveCate" href="javascript:;"
						class="btn btn-sm btn-success">保存</a>
				</div>
			</div>
		</div>
	</div>

	<script
		src="${pageContext.request.contextPath}/resources/assets/plugins/DataTables/media/js/jquery.dataTables.js"></script>
	<script
		src="${pageContext.request.contextPath}/resources/assets/plugins/DataTables/media/js/dataTables.bootstrap.min.js"></script>
	<script
		src="${pageContext.request.contextPath}/resources/assets/plugins/DataTables/extensions/Select/js/dataTables.select.min.js"></script>
	<script
		src="${pageContext.request.contextPath}/resources/assets/plugins/bootstrap-daterangepicker/moment.js"></script>
	<script
		src="${pageContext.request.contextPath}/resources/assets/plugins/bootstrap-daterangepicker/daterangepicker.js"></script>
	<script
		src="${pageContext.request.contextPath}/resources/assets/plugins/bootstrap-datetimepicker/js/bootstrap-datetimepicker.min.js"></script>
	<script
		src="${pageContext.request.contextPath}/resources/assets/plugins/bootstrap-datetimepicker/js/locales/bootstrap-datetimepicker.zh-CN.js"
		charset="UTF-8"></script>
	<script
		src="${pageContext.request.contextPath}/resources/common/switch/js/bootstrap-switch.min.js"></script>
	<script
		src="${pageContext.request.contextPath}/resources/common/utils/js/tool.date.js"></script>
	<script
		src="${pageContext.request.contextPath}/resources/base/course/coursemanage.js"></script>
	<script
		src="${pageContext.request.contextPath}/resources/common/utils/js/utils.js"></script>
	<script
		src="${pageContext.request.contextPath}/resources/js/wangEditor.js"></script>
		<script
		src="${pageContext.request.contextPath}/resources/assets/plugins/jquery-file-upload/js/jquery.fileupload.all.js"></script>
	<script
		src="${pageContext.request.contextPath}/resources/assets/plugins/bootstrapValidator/js/bootstrapValidator.js"></script>

	<script>
		/* 初始化 */
		var xiaoshouArr = []
		var yunyingArr = []
		var type = 0
		init()
		function init(){
			$.ajax({
				url:'/wechat/List',
				success:function(res){
					console.log(res)
					res.result.forEach(function(ele,index){
						if(ele.type == 0) {
							xiaoshouArr.push(ele)
						}
						if(ele.type == 1) {
							yunyingArr.push(ele)
						}
					}) 
					renderTable(xiaoshouArr)
				} 
			})
		}
	
	
		/* 销售运营切换 */
		$('#xiaoshouBtn').on('click', function() {
			type = 0
			$('#xiaoshouBtn').addClass('btn-primary')
			$('#xiaoshouBtn').removeClass('btn-default')
			$('#yunyingBtn').addClass('btn-default')
			$('#yunyingBtn').removeClass('btn-primary')
			renderTable(xiaoshouArr)
		})
		$('#yunyingBtn').on('click', function() {
			type = 1
			$('#yunyingBtn').addClass('btn-primary')
			$('#yunyingBtn').removeClass('btn-default')
			$('#xiaoshouBtn').addClass('btn-default')
			$('#xiaoshouBtn').removeClass('btn-primary')
			renderTable(yunyingArr)
		})
		
		/* 添加按钮 */
		$('#add').on('click',function(){
			$('.mask').css('display','block')
			 $('#name').val('')
				$("#wxId").val('')
				$('#preview-image').attr('src','')
				$('#course-image-path').val('') 
				$("#ID").val('') 
				$('#shangjia').attr('checked',false)
		})
		/* 删除按钮 */
		$('#tBody').on('click',function(e){
			
			if(e.target.className.indexOf('del') != -1){
				var r = confirm('确定删除吗')
				if(r) {
					var id = e.target.getAttribute('data-id')
					$.ajax({
						url:'/wechat/deleteWechat',
						data:{
							id:id
						},
						success:function(res){
							console.log(res)
							location.reload()
						}
					})
				}
				
			}
		})
		/* 编辑按钮 */
		$('#tBody').on('click',function(e){
			if(e.target.className.indexOf('edit') != -1){
				$('.mask').css('display','block')
				var id = e.target.getAttribute('data-id')
				$.ajax({
					url:'/wechat/scanWechat',
					data:{
						id:id
					},
					success:function(res){
						console.log(res) 
						if(res.result.status == 0) {
							$('#shangjia').attr('checked',false)
						}
						if(res.result.status == 1){
							$('#shangjia').attr('checked',true)
						}
						 $('#name').val(res.result.name)
						$("#wxId").val(res.result.wechat)
						$('#preview-image').attr('src',res.result.url)
						$('#course-image-path').val(res.result.url) 
						$("#ID").val(res.result.id) 
					}
				})
				
			}
		})
		/* 编辑,添加后保存 */
		$('#saveCate').on('click',function(){
			var status = ''
			if($('#shangjia').prop('checked')){
				status = 1
			} else {
				status = 0
			}
			if(!$('#name').val() || !$('#wxId').val() || !$('#course-image-path').val()) {
				alert('部分数据未填写！')
				return
			}
			var wechatBase = {
				name:$('#name').val(),
				status:status,
				wechat:$('#wxId').val(),
				url:$('#course-image-path').val(),
				type:type
			}
			
			var a = $('#ID').val()
			console.log(a)
			if(a){
				wechatBase.id =a
				wechatBase = JSON.stringify(wechatBase)
				$.ajax({
					url:'/wechat/ReSubmit',
					type:'POST',
					data:{wechatBase:wechatBase},
					success:function(res){
						console.log(res)
						$('#close').click()
						location.reload()
					}
				})
			} else {
				wechatBase = JSON.stringify(wechatBase)
				$.ajax({
					url:'/wechat/submitWechat',
					type:'POST',
					data:{wechatBase:wechatBase},
					success:function(res){
						console.log(res)
						$('#close').click()
						location.reload()
					}
				})
			}
		})
		/* 关闭弹窗 */
		$('.close').on('click',function(e){
			$('.mask').css('display','none')
		})
		$('#close').on('click',function(e){
			$('.mask').css('display','none')
		})
		/* 渲染列表 */
		function renderTable (data){
			let ohtml = ''
			data.forEach(function(ele,index){
				if(ele.status == 1){
					ele.status = '开启'
				} 
				if(ele.status == 0){
					ele.status = '关闭'
				}
				ohtml +='<tr>'+
				'<td>'+ ele.name +'</td>'+
				'<td>'+ ele.wechat +'</td>'+
				'<td><image src="'+ ele.url +'" /></td>'+
				'<td>'+ ele.status +'</td>'+
				'<td>'+
					'<button class="btn btn-primary btn-lg edit"style="margin-right: 25px;" data-id="'+ele.id+'">编辑</button>'+
					'<button class="btn btn-primary btn-lg del" data-id="'+ele.id+'">删除</button>'+
				'</td>'+
			'</tr>'
			})
			 $('#tbody').html(ohtml)
			 
		}
		/* 上传图片 */
		$('#shangchuan').click(function() {
			$('#imageFile').click()
		})
		function initFileupload(fileId, previewId, savePathInputId) {
			$('#' + fileId).fileupload({
				url : '/upload/image',
				done : function(e, data) {
							if (data.result.code == HttpUtil.success_code) {
								var path = data.result.result.path;
								$('#' + previewId).attr('src', path);
								$('#' + savePathInputId).val(path);
								$('#course')//上传成功表单验证设置为通过
							} else {
								var alert = BootstrapDialog.alert
										|| window.alert;
								alert(data.result.msg);
							}
				}
			});
		}
		initFileupload('imageFile', 'preview-image', 'course-image-path');
		
	</script>
</body>
</html>
