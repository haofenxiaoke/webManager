<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"
	contentType="text/html; UTF-8"%>
<%@include file="/WEB-INF/view/include/taglib.jsp"%>
<!DOCTYPE html>
<html lang="en">
<head>
<title>${pname}管理系统-文章管理</title>
<meta http-equiv="Content-Type"
	content="multipart/form-data; charset=utf-8" />
<link
	href="${pageContext.request.contextPath}/resources/assets/plugins/DataTables/media/css/dataTables.bootstrap.min.css"
	rel="stylesheet" />
<link href="${pageContext.request.contextPath}/resources/css/guanli.css"
	rel="stylesheet">
<link
	href="${pageContext.request.contextPath}/resources/css/goods_manage.css"
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
		<div class="col-md-10" style="width: 1600px">
			<div class="panel panel-inverse">
				<div class="panel-heading">
					<h4 class="panel-title">电商销售</h4>
				</div>
				<div class="wrap">
					<div class="clear">
						<div style="float: left; margin-right: 20px">
							<select style="width: 160px" name="directionId" id="directionId"
								class="form-control">
								<option value>请选择课程</option>
							</select>
						</div>
						<div style="float: left; margin-right: 20px">
							<select style="width: 160px" name="positionId" id="positionId"
								class="form-control">
							</select>
						</div>
						<div style="float: left; margin-right: 20px">
							<select style="width: 160px" name="status" id="status"
								class="form-control">
								
								<option value="0">已上架</option>
								<option value="1">未上架</option>
							</select>
						</div>
						<div class="add" id="add">创建商品</div>
					</div>
					<table class="table table-bordered m-t">
						<tr>
							<th>图片</th>
							<th>名称</th>
							<th>项目</th>
							<th>类型</th>
							<th>价格</th>
							<th>当前库存</th>
							<th>状态</th>
							<th>操作</th>
						</tr>
						<tbody id="tbody">
						<!-- <tr>
							<td><img
								src="http://www.haofenxiaoke.com/resources/common/images/indexgif.gif"></img>
							</td>
							<td>初级思维导图</td>
							<td>初级会计</td>
							<td>电子资料</td>
							<td>200</td>
							<td><span>100</span>
								<div class="caozuo" style="float: right; width: 80px;"
									id="add_goods">添加</div></td>
							<td><label class="switch" style="margin-top: 30px;">
									<input type="checkbox" checked>
									<div class="slider round"></div>
							</label> <span style="float: right; margin-right: 30px;">上架</span></td>
							<td><div class="caozuo">编辑</div></td>
						</tr> -->
						</tbody>
					</table>
				</div>
			</div>
		</div>


	</div>
	<!-- 弹出层 -->
	<div class="mask">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="panel panel-inverse">
					<div class="panel-heading">
						<button type="button" class="close" data-dismiss="modal"
							aria-hidden="true">×</button>
						<h4 class="panel-title">添加库存</h4>
					</div>
				</div>
				<div class="panel-body">
					<form id="cateForm" class="form-horizontal form-bordered"
						data-parsley-validate="true">
						<div class="form-group">
							<label class="col-md-3 control-label">当前库存*</label>
							<div class="col-md-9">
								<input id="name" type="number" class="form-control" />
								<ul class="parsley-errors-list filled">
									<li name="ErrorTip" class="parsley-required"></li>
								</ul>
							</div>
								<input id="goodId" type="hidden">
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

	<script>
		//获取商品列表
		$.ajax({
			url:"/goods/List",
			data:{
				deleted:$("#status").val()
			},
			success:function(res){
				console.log(res)
				 positionName(res.result,renderTable)
				/* setTimeout(function(){
					renderTable(data)
				},0) */
				
			}
		})
	
	
		//课程分类
		directionChange()
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
			$("#directionId").change(
				function() {
				/*清空职位*/
					$("#positionId").empty();
					var firstOption = $("<option value='' selected=\"selected\">"
						+ "-" + '职位' + "-" + "</li>");
						$("#positionId").append(firstOption);
					$.ajax({
							url : '/position/positionList',
							type : 'POST',
							data : {
							directionId : $('#directionId').val()
									},
							success : function(res) {
								console.log(res)
								phtml = "";
								res.result.forEach(function(ele,index) {
										phtml += '<option value='+ ele.id +'>'
											+ ele.categoryDesc
											+ '</option>'
										})
								$('#positionId').append(phtml)
							}
					})
			})
		}
		
		//课程变化 渲染数据
		$("#positionId").change(function(){
			$.ajax({
				url:'/goods/List',
				data:{positionId:$("#positionId").val(),deleted:$("#status").val()},
				success:function(res){
					 positionName(res.result,renderTable)
				}
			})
		})
		//根据状态变化 渲染数据
		$("#status").change(function(){
			$.ajax({
				url:'/goods/List',
				data:{
						positionId:$("#positionId").val(),
						deleted:$("#status").val()
				},				success:function(res){
					 positionName(res.result,renderTable)
				}
			})
		})
		//弹出框函数
		$("#close").on("click", function() {
			$(".mask").css("display", "none")
		})
		$(".close").on("click", function() {
			$(".mask").css("display", "none")
		})

		//添加库存 弹出框 编辑跳转
		var otbody = document.getElementById("tbody")
		otbody.addEventListener('click',function(e){
			var num = e.target.getAttribute('data-num')
			var id = e.target.getAttribute('data-id')
			console.log(e)
			if(e.target.className.indexOf('add') != -1) {
				$(".mask").css("display", "block")
				$("#name").val(num)
				$("#goodId").val(id)
			}
			if(e.target.className.indexOf('edit') != -1) {
				window.location.href = "/goods/create?id="+id
			}
			if(e.target.id.indexOf('shangjia') != -1) {
				console.log($('#'+e.target.id).val())
				var check = null
				if($('#'+e.target.id).prop("checked") == true) {
					check = 0
				} else {
					check = 1
				}
				 $.ajax({
				url:'/goods/deleteGoods',
				data:{
					id:e.target.getAttribute('data-id'),
					deleted:check
					},
					success:function(res){
						console.log(res)
					}
				}) 
			}
		},false)

		//创建商品 跳转页面
		$("#add").on("click", function() {
			window.open("/goods/create") 
		})
		
		//保存库存
		$("#saveCate").on('click',function(e){
			$.ajax({
				url:"/goods/addRemain",
				data:{
					id:$("#goodId").val(),
					newRemain:$("#name").val()
				},
				success:function(res){
					console.log(res.result)
					$('#remain'+ $("#goodId").val()).text($("#name").val())
					$('#close').click()
				}
			})
		})
		
	
		//商品列表渲染
		function positionName(data,callback){
			var a = ""
			data.forEach(function(ele,index){
				if(ele.directionId){
				$.ajax({
					url : '/position/positionList',
					type : 'POST',
					async: false,
					data : {
					directionId : ele.directionId
							},
					success : function(res) {
						console.log(res)
						 a = res.result.filter(function(eles,index){
							return eles.id == ele.positionId
						})
						console.log(a[0].categoryDesc)
						ele.positionId = a[0].categoryDesc
					}
				})
			  } else {
				  ele.positionId=""
			  }
				
		   })
		   callback(data)
	     }	
		
 		function renderTable(data){
			var ohtml = ""
			var checked
			data.forEach(function(ele,index){
				if(ele.deleted == 0) {
					checked = "checked"
				} else {
					checked = ''
				}
				if(ele.type == 0) {
					ele.type = '打包资料'
				}
				if(ele.type == 1) {
					ele.type = 'vip'
				}
				if(ele.type == 2) {
					ele.type = '电子资料'
				}
				if(ele.type == 3) {
					ele.type = '直播课程'
				}
				if(ele.type == 4) {
					ele.type = '实体商品'
				}
				 ohtml+='<tr><td><img src="'+ele.coverUrl+'"></img></td>'+
					'<td>'+ ele.name +'</td>'+
					'<td>'+ ele.positionId +'</td>'+
					'<td>'+ele.type+'</td>'+
					'<td>'+ele.price+'</td>'+
					'<td><span id="remain'+ele.id+'">'+ele.remain+'</span>'+
						'<button class="caozuo add_goods add" style="float: right; width: 80px;" data-id='+ele.id+' data-num='+ele.remain+'>添加</button></td>'+
					'<td><label class="switch" style="margin-top: 30px;" data-id='+ele.id+'>'+
							'<input type="checkbox" '+ checked +'  data-id='+ele.id+' id="shangjia'+ele.id+'">'+
							'<div class="slider round"></div>'+
					'</label> <span style="float: right; margin-right: 30px;">上架</span></td>'+
					'<td><button class="caozuo edit" data-id='+ele.id+'>编辑</button></td></tr>'
			})
				  $('#tbody').html(ohtml)
 		} 
		
		
		
	</script>
</body>
</html>
