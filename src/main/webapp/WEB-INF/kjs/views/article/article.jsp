<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ page import="java.util.Date"%>
<%@ page import="com.kjs.common.bean.Constants"%>
<%@ page import="com.kjs.orm.model.UserStu"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html lang="en">

	<head>
		<meta charset="UTF-8">
		<meta name="viewport" content="width=device-width, initial-scale=1.0">
		<title>Document</title>
		<style>
			* {
				margin: 0;
				padding: 0;
			}

			.msg {
				margin: 20px;
			}

			.msg_title {
				width: 100%;
				font-size: 26px;
				text-align: center;
				margin-top: 20px;
			}

			.msg_time {
				font-size: 14px;
			}

			.msg_body {
				margin-top: 30px;
			}
		</style>
	</head>

	<body>
		<div class="msg" id="msg">
			<!-- <div class="msg_title">
				考试资讯
			</div>
			<div class="msg_time">
				2020年10月20日
			</div>
			<div class="msg_body">

			</div> -->
		</div>
		<script src="${basePath}/resources/common/js/jquery-1.9.1.js"></script>
		<script>
			$.ajax({
				url:"/article/articleBody",
				data:{id:window.location.search.split('=')[1]},
				success:function(res){
					console.log(res)
					renderMsg(res.data)
				}
			})
			function renderMsg(data) {
				var ohtml = ''
				data.forEach(function(ele, index) {
					console.log(ele.saveTime)
					ohtml += '<div class="msg_title">'+ele.title+'</div>' +
						'<div class="msg_time">'+ele.saveTime.split(" ")[0]+'</div>' +
						'<div class="msg_body">'+ele.body+'</div>'
						document.title = ele.title
				})
				document.getElementById('msg').innerHTML = ohtml
			}
		</script>
	</body>

</html>
