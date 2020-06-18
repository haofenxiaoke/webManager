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
<link href="${pageContext.request.contextPath}/resources/css/cate_tab.css" rel="stylesheet" />
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
					</div>
					<div class="clear">
						<div class="time">
							<span>起始时间</span>
							<input id="startDate" readonly="readonly" style="width:250px;">
							<span>终止时间</span>
							<input id="endDate" readonly="readonly" style="width:250px;">
						</div>
						<div class="time">
							<span>维度</span>
							<select style="width:160px; height: 40px;" id="dimesion">
								<option value="name">销售人员</option>
								<option value="comfrom">渠道</option>
								<option value="person">人员</option>
								<option value="testid">AB测试</option>
							</select>
						</div>
						<div class="time">
							<button class="btn btn-primary btn-lg" id="tj">应用</button>
						</div>
					</div>
					<div id="tBody">
						<table class="table table-bordered">
							<tr>
								<th>维度</th>
								<th>展现次数</th>
								<th>长按次数</th>
								<th>复制次数</th>
							</tr>
							<tbody id="tbody">
							  <!-- 	<tr>
									<td>贡老师</td>
									<td>100</td>
									<td>5</td>
									<td>2</td>
								</tr>  -->
							</tbody>
						</table>

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
		<script src="${pageContext.request.contextPath}/resources/js/commodity/jquery.cxcalendar.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/commodity/jquery.cxcalendar.languages.js"></script>

	<script>
		var type = 0
		/* 初始化 */
		 	init()
			function init(){
		 		$('#startDate').cxCalendar({
		 			endDate:2999
		 		})
		 		$('#endDate').cxCalendar({
		 			endDate:2999
		 		})
		 		var month = new Date().getMonth() + 1
		 		var newDay = new Date().getFullYear() + '/'+ month + '/' + new Date().getDate()
		 		$('#startDate').val(newDay)
		 		$('#endDate').val(newDay)
		 		var dimesion = 'name'
		 		ajaxCount(0,newDay,newDay,dimesion)
			} 

		/* 销售运营切换 */
		$('#xiaoshouBtn').on('click', function() {
			type = 0
			$('#xiaoshouBtn').addClass('btn-primary')
			$('#xiaoshouBtn').removeClass('btn-default')
			$('#yunyingBtn').addClass('btn-default')
			$('#yunyingBtn').removeClass('btn-primary')
			var a = new Date($('#startDate').val())
			var b = new Date($('#endDate').val())
			var dimesion = $('#dimesion').val()
			ajaxCount(type,$('#startDate').val(),$('#endDate').val(),dimesion)
		})
		$('#yunyingBtn').on('click', function() {
			type = 1
			$('#yunyingBtn').addClass('btn-primary')
			$('#yunyingBtn').removeClass('btn-default')
			$('#xiaoshouBtn').addClass('btn-default')
			$('#xiaoshouBtn').removeClass('btn-primary')
			var a = new Date($('#startDate').val())
			var b = new Date($('#endDate').val())
			var dimesion = $('#dimesion').val()
			ajaxCount(type,$('#startDate').val(),$('#endDate').val(),dimesion)
		})
		$('#tj').on('click',function(){
			var a = new Date($('#startDate').val())
			var b = new Date($('#endDate').val())
			if(a > b) {
				alert('时间填写有误')
				return
			}
			var dimesion = $('#dimesion').val()
			ajaxCount(type,$('#startDate').val(),$('#endDate').val(),dimesion)
		})
		function ajaxCount(type,starttime,entime,dimesion){
			starttime = starttime + ' 00:00:00'
			entime = entime + ' 24:00:00'
			$.ajax({
				url:'/wechatData/list',
				data:{
					type:type,
					startTime:starttime,
					endTime:entime,
					dimesion:dimesion
				},
				success:function(res){
					console.log(res)
					renderTable(res.result)
				}
			})
		}
		/* 渲染列表 */
		function renderTable (data){
			let ohtml = ''
			data.forEach(function(ele,index){
				ohtml+='<tr>'+
					'<td>'+ele.head+'</td>'+
					'<td>'+ele.showCount+'</td>'+
					'<td>'+ele.pinCount+'</td>'+
					'<td>'+ele.copyCount+'</td>'+
					'</tr> '
			})
			 $('#tbody').html(ohtml)
		}
	</script>
</body>
</html>
