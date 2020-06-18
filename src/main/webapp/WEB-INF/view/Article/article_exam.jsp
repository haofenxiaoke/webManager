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
<link href="${pageContext.request.contextPath}/resources/css/guanli.css"
	rel="stylesheet">

</head>
<body>
	<input type="hidden" id="position-id" name="position-id"
		value="${positionId}">
	<input type="hidden" id="direction-id" name="direction-id"
		value="${directionId}">

	<div class="row">
		<div class="col-md-10" style="width: 1600px">
			<div class="panel panel-inverse">
				<div class="panel-heading">
					<h4 class="panel-title">课程管理</h4>
				</div>
				<div class="wrap">
					<div class="clear">
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
					<div id="tBody">
						<!-- <div class="msg">
							<div class="msg_img">
								<img src="http://www.haofenxiaoke.com/resources/common/images/xcx_yuan.jpg"></img>
							</div>
							<div class="msg_content">
								<div class="cont_title cont">标题</div>
								<div class="cont_name cont">项目名称</div>
								<div class="cont_time cont">2020年11月3日</div>
								<div class="cont_text cont">
									正文
									<img src="http://www.haofenxiaoke.com/resources/common/images/indexgif.gif"></img>
								</div>
							</div>
							<div class="msg_guanli">
								<button class="edit btn btn-primary guanli" data-id="1">编辑</button>
								<button class="del btn btn-primary guanli" data-id="1">删除</button>
							</div>
						</div> -->
					</div>
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

	<script>
		directionChange()
		$.ajax({
			url:'/article/list',
			success:function(res){
				renderTable(res.data)
			}
		})
		function directionChange() {
			/*方向选择框change事件*/
			$("#directionId")
					.change(
							function() {
								/*清空职位*/
								$("#positionId").empty();
								var firstOption = $("<option value='' selected=\"selected\">"
										+ "-" + '职位' + "-" + "</li>");
								$("#positionId").append(firstOption);
								$
										.ajax({
											url : '/position/positionList',
											type : 'POST',
											data : {
												directionId : $('#directionId')
														.val()
											},
											success : function(res) {
												console.log(res)
												phtml = "";
												res.result
														.forEach(function(ele,
																index) {
															phtml += '<option value='+ ele.id +'>'
																	+ ele.categoryDesc
																	+ '</option>'
														})
												$('#positionId').append(phtml)
											}
										})
							})
		}
		var ohtml = ''
		var phtml = ''
		$.ajax({
			url : "/cate/list/addcourse/save",
			success : function(res) {
				ohtml = ''
				res.result.forEach(function(ele, index) {

					ohtml += '<option value='+ ele.id +'>' + ele.categoryDesc
							+ '</option>'
				})
				$('#directionId').append(ohtml)

			}
		})

		function directionChange() {
			/*方向选择框change事件*/
			$("#directionId")
					.change(
							function() {
								/*清空职位*/
								$("#positionId").empty();
								var firstOption = $("<option value='' selected=\"selected\">"
										+ "-" + '职位' + "-" + "</li>");
								$("#positionId").append(firstOption);
								$
										.ajax({
											url : '/position/positionList',
											type : 'POST',
											data : {
												directionId : $('#directionId')
														.val()
											},
											success : function(res) {
												console.log(res)
												phtml = "";
												res.result
														.forEach(function(ele,
																index) {
															phtml += '<option value='+ ele.id +'>'
																	+ ele.categoryDesc
																	+ '</option>'
														})
												$('#positionId').append(phtml)
											}
										})
							})
		}
		document.getElementById('tBody').addEventListener('click', function(e) {
			tbodyClick(e)
		})
		
		
		//管理事件
		function tbodyClick(e) {
			console.log(e.target.tagName.toLowerCase())
			var tagName = e.target.tagName.toLowerCase();
			// console.log(tagName)
			if (tagName != 'button') {
				return false;
			}
			var isEdit = e.target.className.indexOf('edit') > -1;
			var isDel = e.target.className.indexOf('del') > -1;
			var index = e.target.getAttribute('data-id');
			if (isDel) {
				var delConfirm = confirm('确认删除？');
				if (delConfirm) {
					$.ajax({
						url : '/article/deleteArticle',
						data : {
							id : index
						},
						type : 'post',
						success : function(res) {
							console.log(res)
							$.ajax({
				url:'/article/list',
				data:{positionId:$("#positionId").val()},
				success:function(res){
					console.log(res.data)
					renderTable(res.data)
				}
			})
							
						}
					})
				}
			} else {

				
						window.location.href = '/article/create?id='+index	
				

			}
		}
		
		//渲染数据
		$("#positionId").change(function(){
			$.ajax({
				url:'/article/list',
				data:{positionId:$("#positionId").val()},
				success:function(res){
					console.log(res.data)
					renderTable(res.data)
				}
			})
		})
		function renderTable(data){
			var ohtm = '';	
			data.forEach(function(ele,index){
				console.log(ele.body)
				ohtm+='<div class="msg">'+
				/* '<div class="msg_img">'+
					'<img src='+ ele.coverUrl +'></img>'+
				'</div>'+ */
				'<div class="msg_content">'+
					'<div class="cont_title cont">'+ ele.title +'</div>'+
					'<div class="cont_name cont">'+ $('#positionId').find("option:selected").text() + '</div>'+
					'<div class="cont_time cont">' + ele.createTime.replace(/\.0/g,'')+'</div>'+
					 '<div class="cont_text cont">链接地址：http://mobile.haofenxiaoke.com/article?id='+ele.id +'</div>'+ 
				'</div>'+
				'<div class="msg_guanli">'+
					'<button class="edit btn btn-primary guanli" data-id='+ele.id+'>编辑</button>'+
					'<button class="del btn btn-primary guanli" data-id='+ele.id+'>删除</button>'+
				'</div>'+
			'</div>'
			})
			
			$('#tBody').html(ohtm)
		}
	</script>
</body>
</html>
