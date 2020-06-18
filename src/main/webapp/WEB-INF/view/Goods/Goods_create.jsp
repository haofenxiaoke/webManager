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
<style>
.ceBar {
	line-height: 34px;
	width: 90px;
}

.danwei {
	font-size: 16px;
	height: 50px;
	line-height: 34px;
	width: 50px;
	float: left;
	text-align: center;
	margin-right: 20px;
}

input::-webkit-outer-spin-button, input::-webkit-inner-spin-button {
	-webkit-appearance: none;
}

input[type="number"] {
	-moz-appearance: textfield;
}

.xian {
	width: 100%;
	border: 1px solid black;
	margin-bottom: 80px;
}

#ziGoods{
	display:none;
}
</style>
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
		<form enctype="multipart/form-data">
			<div class="col-md-10" style="width: 100%;">
				<div class="panel panel-inverse " id="course">
					<div class="panel-heading">
						<h4 class="panel-title">课程排序</h4>
					</div>
					<div class="wrap">
						<div class="clear">
							<div class="ceBar">名称：</div>
							<input class="form-control" style="width: 90%;" id="title"
								maxlength="60"></input>
						</div>
						<div class="clear">
							<div class="ceBar">类型：</div>
							<select style="width: 160px" name="type" id="type"
								class="form-control">
								<option value="2">电子资料</option>
								<option value="1">vip</option>
								<option value="4">实体商品</option>
								<option value="0">打包资料</option>
								<option value="3">直播课程</option>
							</select>
						</div>
						<div class="clear" id="days" style="display: none;">
							<div class="ceBar">天数：</div>
							<input class="form-control" type="number"
								style="width: 10%; float: left; margin-right: 30px;" id="day"></input>
						</div>
						<div class="clear" id="xueyuan">
							<div class="ceBar">学院：</div>
							<!-- <input class="form-control" style="width:10%; float:left; margin-right:30px;"></input> -->
							<div style="float: left; margin-right: 20px">
								<select style="width: 160px" name="directionId" id="directionId"
									class="form-control">
									<option value>请选择课程</option>
								</select>
							</div>
							<div style="float: left; margin-right: 20px"">
								<div class="ceBar">项目：</div>
								<select style="width: 160px" name="positionId" id="positionId"
									class="form-control">

								</select>
							</div>

						</div>

						<div class="clear">
							<div class="ceBar">价格：</div>
							<input class="form-control" style="width: 100px; float: left;"
								id="pr" type="number"></input>
							<div class="danwei">分贝</div>
							<div class="ceBar">库存：</div>
							<input class="form-control"
								style="width: 100px; float: left; margin-right: 20px;"
								id="remain" type="number"></input>
							<div class="ceBar">分享：</div>
							<select style="width: 160px; margin-right: 20px; float: left;"
								name="share" id="share" class="form-control">
								<option value="0">0</option>
								<option value="2">2</option>
								<option value="3">3</option>
								<option value="5">5</option>
								<option value="0">10</option>
							</select>
							<div class="ceBar">兑换人数：</div>
							<input class="form-control"
								style="width: 100px; float: left; margin-right: 20px;"
								id="count" type="number"></input>
						</div>
						<div class="clear form-group" id="word">
							<div class="ceBar">电子文档：</div>
							<span class="btn btn-primary btn-sm fileinput-button"
								id="scWendang"> <i class="glyphicon glyphicon-plus"></i>
								<span>上传</span>
								
							</span> <input id="pdfFile" type="file" name="pdfFile"> <input
								type="hidden" id="lecturePptUrl" name="lecturePptUrl" value="">
							<input type="hidden" id="lectureConverswfUrl"
								name="lectureConverswfUrl" value=""> <input
								type="hidden" id="filelength" name="fileLength" value="">
							<!-- <input type="hidden" name="id" id="id" /> -->
							<span id="lujing"></span>
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
						<div class="xian"></div>
						<div class="clear  form-group" id="ziGoods">
							<div class="ceBar">子商品：</div>
							<div>
								<table class="table table-bordered m-t" style="width:0;">
						<tr>
							<th>图片</th>
							<th>名称</th>
							<th>项目</th>
							<th>类型</th>
							<th>价格</th>
							<th>操作</th>
						</tr>
						<tbody id="obody">
						
							
						</tbody>
					</table>
							</div>
							<div class="caozuo" id="add">添加</div>
							
						</div>
						<div class="clear  form-group">
							<div class="ceBar">兑换规则：</div>
							<textarea name="" id="rule" cols="100" rows="10" maxlength="300"></textarea>
						</div>
						<div class="clear">
							<div class="ceBar">商品详情：</div>
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
	
	<!-- 弹出框 -->
		<div class="mask">
		<div class="modal-dialog" style="width:1200px;">
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
						<div class="form-group" style="height: 500px;overflow: scroll;">
							<table class="table table-bordered m-t">
						<tr>
							<th>图片</th>
							<th>名称</th>
							<th>项目</th>
							<th>类型</th>
							<th>价格</th>
							<th>操作</th>
						</tr>
						<tbody id="tbody">
						
						</tbody>
					</table>
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
	var url = window.location.search
	var urlId = url.split('=')[1]
	console.log(urlId)
	var Alldata = [] //所有商品
	var sonData = null //所有子商品的东西
	var checkID=[] //选中子商品id
	var checkArr=[] //子商品列表
	$('#saveCate').on('click',function(e){
		addClick(e)
	})
	$("#obody").on('click',function(e){
		delClick(e)
	})
	//初始化加载所有的数据
	$.ajax({
			url:'/goods/List',
			success:function(res){
				console.log(res.result)
				Alldata = res.result
				
				// 编辑
				if(urlId){
					$.ajax({
						url:'/goods/scanGoods/?id='+ urlId,
						success:function(res){
							data = res.result
							console.log(data)
							//
							if(data.type == 2) {
								$("#word").css("display","block")
							} else {
								$("#word").css("display","none")
							}
							if(data.type == 1 || data.type == 4) {
								$("#xueyuan").css("display", "none")
								 $("#directionId").val(null) 
								$("#positionId").val(null) 
							} else {
								$("#xueyuan").css("display", "block")
							}
						
							if(data.type == 1) {
								$("#days").css("display", "block")
								$("#day").val(data.days)
							} else {
								$("#days").css("display", "none")
							}
							if(data.type == 0) {
								$('#ziGoods').css('display','block')
							} else {
								$('#ziGoods').css('display','none')
							}
							//
							$('#title').val(data.name)
							$('#type').val(data.type)
							$('#pr').val(data.price)
						 	 $('#directionId').val(data.directionId) 
						 	 $('#remain').val(data.remain)
						 	 $("#share").val(data.share)
						 	 $("#count").val(data.count)
						 	 $("#course-image-path").val(data.coverUrl)
						 	 $("#preview-image").attr('src',data.coverUrl)
						 	  $("#rule").val(data.rule)
						 	   editor.txt.html(data.discript)
						 	  console.log(data.son)
						 	  if(data.son){
						 		 checkID = data.son.split(',')
						 		ziTable(checkID)	
						 	  }
						 	 	
						 	  
						 	   if(!data.directionId){
						 		   return
						 	   }
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
						}
					})
				}
				
			}
	})
	
	//点击添加 显示弹出框
	$("#add").on("click",function(){
		$('.mask').css('display','block')
			var data = Alldata.filter(function(ele,index){
					return ele.type != 0
				})
				
			 sonData = data.filter(function(ele,index){
					return ele.deleted == 0
				})
				console.log(sonData)
				positionName(sonData,tanchuTable)
				
		
	})
	$("#close").on("click", function() {
			$(".mask").css("display", "none")
		})
		$(".close").on("click", function() {
			$(".mask").css("display", "none")
		})
	//弹出的样式
	function tanchuTable (data){
		var ohtml = ""
		data.forEach(function(ele,index){
			var checked = null
			if(checkID.indexOf(ele.id.toString()) != -1){
				checked = 'checked'
				
			} else {
				checked = ""
				console.log(ele.id)
			}
			ohtml+='<tr data-id='+ele.id +'>'+
				'<td><img src="'+ele.coverUrl+'"></img></td>'+
			'<td>'+ ele.name +'</td>'+
			'<td>'+ele.positionId+'</td>'+
			'<td>'+$("#type").find("option:eq("+ele.type+")").text()  +'</td>'+
			'<td>'+ele.price+'</td>'+
			'<td><input class=" add" type="checkbox"'+ checked+' value='+ele.id+' style="height:25px;width:25px;"></input></td>'+
		'</tr>'
		})
		$("#tbody").html(ohtml)
	}
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
					console.log(ele.positionId)
					 a = res.result.filter(function(eles,index){
						return eles.id == ele.positionId
					})
					console.log(a)
					ele.positionId = a[0].categoryDesc
				}
			})
		  } else {
			  ele.positionId=""
		  }
			
	   })
	   callback(data)
     }	
	
	//点击弹窗中的保存 添加到子商品上
	function addClick (){
		checkID = []
		checkArr= []
		$("input:checked").each(function(i){//把所有被选中的复选框的值存入数组
            checkID[i] =$(this).val();
        }); 
	   console.log(checkID);
	   $('#close').click()
	   ziTable(checkID)
	   
	   
	}
	
	//选中的id 渲染到子商品
	function ziTable(data){
		console.log(Alldata)
		checkID.forEach(function(ele,index){
			var a =Alldata.filter(function(item,index){
				return item.id == ele
			})
			checkArr.push(a[0])
		})
		console.log(checkArr)
		renderZi(checkArr)
		
	}
	function renderZi(data){
		ohtml=""
		data.forEach(function(ele,index){
			ohtml+='<tr><td><img src="'+ele.coverUrl+'"></img></td>'+
				'<td>'+ele.name+'</td>'+
				'<td>'+ele.positionId+'</td>'+
				'<td>'+$("#type").find("option:eq("+ele.type+")").text()  +'</td>'+
				'<td>'+ele.price+'</td>'+
				'<td><div class="caozuo del" style="background-color:red;" data-id='+ele.id+'>删除</div></td>'+
				'</tr>'
			})
			$('#obody').html(ohtml)
		
	}
	
	//删除
	function delClick(e){
		if(e.target.className.indexOf('del') != -1){
			var id = e.target.getAttribute("data-id")
			checkID = checkID.filter(function(ele,index){
				return ele != id
			})
			checkArr = checkArr.filter(function(ele,index){
				return ele.id != id
			})
			renderZi(checkArr)
		}
		
	}
	
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
	
		//电子文档显示
		$('#type').change(function(){
			if($('#type').val() == 2) {
				$("#word").css("display","block")
			} else {
				$("#word").css("display","none")
			}
			if($('#type').val() == 1 || $('#type').val() == 4) {
				$("#xueyuan").css("display", "none")
				 $("#directionId").val(null) 
				$("#positionId").val(null) 
			} else {
				$("#xueyuan").css("display", "block")
			}
			
			if($('#type').val() == 1) {
				$("#days").css("display", "block")
			} else {
				$("#days").css("display", "none")
			}
		 	if($('#type').val() == 0) {
				$('#ziGoods').css('display','block')
			} else {
				$('#ziGoods').css('display','none')
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
	
	//上传文件
	
	function initPDFFileupload(fileId,savePathInputId) {
		console.log(1)
    //清空
    var nullVal = '';
    var fileLength = $('#filelength');
    var pdfPath = $('#'+savePathInputId);
    var swfPath = $('#lectureConverswfUrl');
    var url='';
    console.log(fileLength)
    $('#'+fileId).fileupload({
        url:'/upload/goodspdf',
        done: function (e, data) {
        	console.log(data)
            fileLength.val(nullVal);
            pdfPath.val(nullVal);swfPath.val(nullVal);
            
            if(data.result.code == HttpUtil.success_code){
            var filelength=data.result.result.fileLength;
            pdfPath.val(data.result.result.path);
            swfPath.val(data.result.result.swfPath);
            console.log(data.result.result.path)
            console.log(data.result.result.swfPath)
            fileLength.val(filelength);
            console.log(fileLength)
            BootstrapDialog.success('上传资料成功!');
            $('#lujing').html(data.result.result.path)
            $("#btn").hide();
            var delBtn=$("#delBtn");
            }else{
                var alert = BootstrapDialog.warning||window.alert;
                alert(data.result.msg );
            }
        }
    });
}
	
initPDFFileupload("pdfFile","lecturePptUrl");

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
				console.log(result, '11')
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
		})
		
	$('#scWendang').click(function() {
			$('#pdfFile').click()
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
			var file = $("#lecturePptUrl").val()
			e.preventDefault();
			var directionId = $("#directionId").val() 
			var positionId = $("#positionId").val() 
			var days = $("#days").val()
			if(!$('#title').val()||!$("#course-image-path").val() ||!editor.txt.html() ||!$("#type").val() ||!$("#pr").val()||!$("#remain").val()||!$("#share").val()||!$("#count").val() ||!$("#rule").val()){
				console.log($("#course-image-path").val())
				alert("部分数据未填写，请填写完成后提交")
				return
			}
			
			if($("#type").val() != 1) {
				days = null
			} else {
				if(!$('#day').val()) {
					alert("部分数据未填写，请填写完成后提交")
					return
				}
				days = $('#day').val()
			}
			
		
			
		 	if($("#type").val() == 2){
				if(file == null) {
					console.log(1)
					alert("部分数据未填写，请填写完成后提交")
					return 
				}
			} else {
				file = null
			}
		 	if($('#type').val() == 1 || $('#type').val() == 4) {
		 		directionId = null 
		 		positionId = null
			} else {
				if(!$('#positionId').val()){
					alert("部分数据未填写，请填写完成后提交")
					return
				}
				
			}
		 	
		 	if($('#type').val() == 0) {
		 		var son = checkID.toString()
		 		if(checkID.length == 0) {
		 			alert('没有选子商品')
		 			return
		 		}
		 	} else{
		 		checkID = null
		 	}
		 	
			if(urlId){
				console.log(urlId)
				msg = {
						id:urlId,
						name: $('#title').val(),
						positionId:positionId,
						type:$("#type").val(),
						price:$("#pr").val(),
						remain:$("#remain").val(),
						share:$("#share").val(),
						count:$("#count").val(),
						rule:$("#rule").val(), 
						url:file, 
						days:days,
						coverUrl:$("#course-image-path").val(),
						discript:editor.txt.html(),
						directionId:directionId,
						son:son
				} 
				console.log(msg)
				var articleBase = JSON.stringify(msg)
				$.ajax({
					url:'/goods/ReSubmit',
					type:"POST",
					data: {goodsBase:articleBase},
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
						name: $('#title').val(),
						positionId:positionId,
						type:$("#type").val(),
						price:$("#pr").val(),
						remain:$("#remain").val(),
						share:$("#share").val(),
						count:$("#count").val(),
						rule:$("#rule").val(), 
						url:file, 
						days:days,
						coverUrl:$("#course-image-path").val(),
						discript:editor.txt.html(),
						directionId:directionId,
						son:son
				}
				console.log(msg)
				var goods = JSON.stringify(msg)
				$.ajax({
					url:'/goods/submitGoods',
					type:"POST",
					data: {goodsBase:goods},
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
