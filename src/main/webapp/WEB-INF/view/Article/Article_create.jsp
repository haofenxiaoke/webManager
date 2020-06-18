<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"
	contentType="text/html; UTF-8"%>
<%@include file="/WEB-INF/view/include/taglib.jsp"%>
<!DOCTYPE html>
<html lang="en">
<head>
<title>${pname}管理系统-文章管理</title>
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
	<input type="hidden" name="coursePositionId" id="coursePositionId"
		value="">
	<input type="hidden" name="msgId" id="msgId" value="">
	<div class="row">
		<form>
			<div class="col-md-10" style="width: 100%;">
				<div class="panel panel-inverse " id="course">
					<div class="panel-heading">
						<h4 class="panel-title">课程排序</h4>
					</div>
					<div class="wrap">
						<div class="clear">
							<div class="ceBar">文章标题：</div>
							<input class="form-control" style="width: 80%;" id="title"></input>
						</div>
						<div class="clear">
							<div class="ceBar">分类：</div>
							<!-- <input class="form-control" style="width:10%; float:left; margin-right:30px;"></input> -->
							<div style="float: left; margin-right: 20px">
								<select style="width: 160px" name="directionId" id="directionId"
									class="form-control">
									<option value>请选择课程</option>
								</select>
							</div>
							<div>
								<select style="width: 160px" name="positionId" id="positionId"
									class="form-control">

								</select>
							</div>
						</div>

						<div class="clear form-group">
							<div class="ceBar">封面：</div>
							<div class="col-md-4">
								<span class="btn btn-primary btn-sm fileinput-button"
									id="shangchuan"> <i class="glyphicon glyphicon-plus"></i>
									<span>上传</span>

								</span> <input id="imageFile" type="file" name="imageFile"> <input
									type="hidden" id="course-image-path" name="coverUrl"
									<c:if test="${not empty course.coverUrl}"> value="${course.coverUrl}"</c:if>>
								<div class="col-md-4">
									<img id="preview-image" alt="课程图片" class="img-thumbnail"
										<c:if test="${not empty course.coverUrl}"> src="${course.coverUrl}"</c:if> />
								</div>
							</div>
						</div>

						<div class="clear">
							<div class="ceBar">正文：</div>
							<div id="htmlEditor"></div>
						</div>
						<div class="clear">
							<button id="tijiao" class="btn btn-primary">提交</button>
						</div>
					</div>
				</div>
			</div>
		</form>
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
	var url = window.location.search
	var urlId = url.split('=')[1]
	console.log(urlId)
	var data = null

	//渲染分类
	directionChange()
	var ohtml = ''
	var phtml = ''
		$.ajax({
			url:"/cate/list/addcourse/save",
			success:function (res) {
				ohtml = ''
				res.result.forEach(function(ele, index) {
					
					ohtml += '<option value='+ ele.id +'>' + ele.categoryDesc
					+ '</option>'
		})
		$('#directionId').append(ohtml)
	 		console.log(ohtml)
			}
		})
		
		
		
		function directionChange (data){
    /*方向选择框change事件*/
    	$("#directionId").change(function(){
	        /*清空职位*/
	        $("#positionId").empty();
	        var firstOption = $("<option value='' selected=\"selected\">"+"-"+'职位'+"-"+"</li>");
	        $("#positionId").append(firstOption);
	    	$.ajax({
				url:'/position/positionList',
				type:'POST',
				data:{directionId:$('#directionId').val()},
				success:function(res) {
					console.log(res)
					phtml = "";
					res.result.forEach(function(ele,index){
						phtml +='<option value='+ ele.id +'>' + ele.categoryDesc
						+ '</option>'
					})
					$('#positionId').append(phtml)
					if(data){
						$('#positionId').val(data)
					}
					}
				})
    	})
	}
	
	function call (data) {
		$('#positionId').val(data.positionId)
	}
	if(urlId){
		$.ajax({
			url:'/article/scanArticle/'+ urlId,
			success:function(res){
				
				 data = res.result
				console.log(data)
				$('#title').val(data.title)
				$('#msgId').val(data.id)
			 	 $('#directionId').val(data.directionId) 
			 	 $.ajax({
				url:'/position/positionList',
				type:'POST',
				data:{directionId:data.directionId},
				success:function(res) {
					console.log(res)
					phtml = "";
					res.result.forEach(function(ele,index){
						phtml +='<option value='+ ele.id +'>' + ele.categoryDesc
						+ '</option>'
					})
					$('#positionId').append(phtml)
					$('#positionId').val(data.positionId)
					}
				})
			 	 
			 	/* document.getElementById('directionId').value = data.directionId */
			 	console.log(document.getElementById('directionId').value)
				$('#course-image-path').val(data.coverUrl)
				editor.txt.html(data.body)
			}
		})
	}
	

		//渲染富文本编辑器
		var data = {}
		var E = window.wangEditor;
		var editor = new E(document.getElementById('htmlEditor'));
		editor.customConfig.uploadFileName = 'imageFile'
		editor.customConfig.uploadImgServer = '/upload/image'
		editor.customConfig.uploadImgHooks = {
			success : function(xhr, editor, result) {
				console.log('success', result.result.path)
			},
			fail : function(xhr, editor, result) {
				console.log(result.result.path, xhr)
				console.log(editor)
			},
			customInsert : function(insertImg, result, editor) {
				console.log(result.result.path, '11')
				//要把假图片改成真图片最后 改成result.path !!!!!
				insertImg(result.result.path)
			}
		}

		editor.create();

		var wenben = null
		$('#tijiao').on('click', function() {
			console.log(editor.txt.html())
		})

	

		//封面
		$('#shangchuan').click(function() {
			$('#imageFile').click()
			console.log(1)
		})

		function initFileupload(fileId, previewId, savePathInputId) {
			$('#' + fileId).fileupload(
					{
						url : '/upload/image',
						done : function(e, data) {
							if (data.result.code == HttpUtil.success_code) {
								var path = data.result.result.path;
								$('#' + previewId).attr('src', path);
								$('#' + savePathInputId).val(path);
								$('#course')//上传成功表单验证设置为通过
								.data('bootstrapValidator').updateStatus(
										'coverUrl', 'NOT_VALIDATED', null)
										.validateField('coverUrl');
							} else {
								var alert = BootstrapDialog.alert
										|| window.alert;
								alert(data.result.msg);
							}
						}
					});
		}
		initFileupload('imageFile', 'preview-image', 'course-image-path');
		
		//提交
		var msg = null
		$('#tijiao').click(function(e){
			e.preventDefault();
			if(!$('#title').val() || !$('#positionId').val() ||!$("#course-image-path").val() ||!editor.txt.html()){
				console.log($("#course-image-path").val())
				alert("部分数据未填写，请填写完成后提交")
				return
			}
			if(urlId){
				console.log(urlId)
				msg = {
						id:$('#msgId').val(),
						title: $('#title').val(),
						positionId:$('#positionId').val(),
						coverUrl:$("#course-image-path").val(),
						body:editor.txt.html(),
						directionId:$('#directionId').val()
				} 
				var articleBase = JSON.stringify(msg)
				$.ajax({
					url:'/article/ReSubmit',
					type:"POST",
					data: {articleBase:articleBase},
					success:function(res){
						console.log(res)
						if(res.code == 200) {
							alert('提交成功')
						}else {
							alert('提交失败')
						}
					}
				})
			} else {
				msg = {
						title: $('#title').val(),
						positionId:$('#positionId').val(),
						coverUrl:$("#course-image-path").val(),
						body:editor.txt.html(),
						directionId:$('#directionId').val()
				}
				var articleBase = JSON.stringify(msg)
				$.ajax({
					url:'/article/submitArticle',
					type:"POST",
					data: {articleBase:articleBase},
					success:function(res){
						console.log(res)
						if(res.code == 200) {
							alert('提交成功')
						} else {
							alert('提交失败')
						}
					}
				})
			}
			
			
			
		})
		
		
		
		//验证是否为空
		var course = $('#course')
		course.bootstrapValidator({
			fields : {
				coverUrl : {
					validators : {
						notEmpty : {
							message : '封面不能为空!'
						}
					}
				}
			}
		})
	</script>
</body>
</html>
