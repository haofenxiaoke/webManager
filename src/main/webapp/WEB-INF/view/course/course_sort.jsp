<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" contentType="text/html; UTF-8" %>
<%@include file="/WEB-INF/view/include/taglib.jsp" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <title>${pname}管理系统-课程管理</title>
  <link href="${pageContext.request.contextPath}/resources/assets/plugins/DataTables/media/css/dataTables.bootstrap.min.css" rel="stylesheet" />
  <link href="${pageContext.request.contextPath}/resources/assets/plugins/bootstrap-daterangepicker/daterangepicker-bs3.css" rel="stylesheet"/>
  <link href="${pageContext.request.contextPath}/resources/assets/plugins/DataTables/extensions/Select/css/select.bootstrap.min.css" rel="stylesheet" />
  <link href="${pageContext.request.contextPath}/resources/assets/plugins/bootstrap-datetimepicker/css/datetimepicker.css" rel="stylesheet"/>
  <link href="${pageContext.request.contextPath}/resources/common/switch/css/bootstrap-switch.min.css" rel="stylesheet" />
	<link href="${pageContext.request.contextPath}/resources/assets/css/sort.css" rel="stylesheet">
</head>
<body>
<input type="hidden" id="position-id" name="position-id" value="${positionId}">
<input type="hidden" id="direction-id" name="direction-id" value="${directionId}">

<div class="row">
    <div class="col-md-10" style="width:100%;">
      <div class="panel panel-inverse">
        <div class="panel-heading">
          <h4 class="panel-title">课程排序</h4>
        </div>
        <!--分类  -->
        <div class="sort">
        	<div class="kjsCrnum1 clearfloat d" id="direction">
        		  <c:forEach items="${directions}" var="dire">
                        <ul class="list_content">
                            <li class="list_content_tou">${dire.categoryDesc}</li>
                            <c:forEach items="${dire.positions}" var="position">
                            <a href="${basePath}/course/sort?directionId=${dire.id}&positionId=${position.id}" style="color:#9a9e9f;" class="a_list">
								<li class="list_sm" data-id="${position.id}">
							${position.categoryDesc}
							</li>
							</a>
							</c:forEach>
                            
                        </ul>
						</c:forEach>
        </div>
        <!-- 排序 -->
        <div class="panel-body">
        	<table class="table table-striped table-bordered" width="100%" id="tab">
        		<thead>
              		<tr>
              		 <th>课程名</th>
              		 <th>顺序</th>
              		</tr>
              	</thead>
              	<tbody id="tbody">
              		<%--   <c:forEach items="${courses}" var="course"  varStatus="status">
              		 	<tr>
          				<th><img src="${course.coverUrl}"></img></th>
          				<th><button class="up btn btn-info">向上</button><button class="down btn btn-info">向下</button></th>
          				</tr>
      				 </c:forEach>  --%>
              	</tbody>
        	</table>
        	 <button id="baocun" class="btn btn-primary">保存</button>
        </div>
       
       </div>
     </div>
</div>
     


<script src="${pageContext.request.contextPath}/resources/assets/plugins/DataTables/media/js/jquery.dataTables.js"></script>
<script src="${pageContext.request.contextPath}/resources/assets/plugins/DataTables/media/js/dataTables.bootstrap.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/assets/plugins/DataTables/extensions/Select/js/dataTables.select.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/assets/plugins/bootstrap-daterangepicker/moment.js"></script>
<script src="${pageContext.request.contextPath}/resources/assets/plugins/bootstrap-daterangepicker/daterangepicker.js"></script>
<script src="${pageContext.request.contextPath}/resources/assets/plugins/bootstrap-datetimepicker/js/bootstrap-datetimepicker.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/assets/plugins/bootstrap-datetimepicker/js/locales/bootstrap-datetimepicker.zh-CN.js" charset="UTF-8"></script>
<script src="${pageContext.request.contextPath}/resources/common/switch/js/bootstrap-switch.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/common/utils/js/tool.date.js"></script>
<script src="${pageContext.request.contextPath}/resources/base/course/coursemanage.js"></script>
<script src="${pageContext.request.contextPath}/resources/common/utils/js/utils.js"></script>


<script>

	//点击分类变蓝
	var pos = $("#position-id").val()
// 	var dir = $("#direction-id").val()
	console.log(pos)
	
	initclass()
	function initclass () {
		var list_sm = document.getElementsByClassName('list_sm');
		for(var i = 0; i < list_sm.length; i++) {
			list_sm[i].classList.remove('blue');
			if(list_sm[i].dataset.id == pos) {
				list_sm[i].classList.add('blue');
			}
		}	
	}
	
	//上下排序
	var a = new Array()
	var tbody = document.getElementById('tbody');
	tbody.addEventListener('click', click, false);
    //baocun.addEventListener('click',orderIndex,false)
   /*  b = "${courses}"
	 <c:forEach items="${courses}" var="course"  varStatus="status">
	 	var m = {"name": ${course.courseStuNum},"index":${course.lectureNum},"order":${course.id}1}
	 	a.push(m)
	 </c:forEach> */ 
	 
	 
		 $.ajax({
			 url:'/course/findCourseByPositionId',
			 data:{
			 'positionId': pos,
// 			 'direction': dir
			 },
			 contentType: 'application/json;charset=utf-8',
			 type: 'GET',
			 success: function (data) {
				 console.log(data)
				 renderTable(data.result)
				 a = data.result
			 }
		 }) 
  
    
    
    console.log(a)
	function renderTable(datas) {
            var str = ''
            datas.forEach(function (ele, index) {
                str += '<tr>\
                <td>'+ ele.title + '</td>\
               <td><button class="up btn btn-info" data-index='+ index + '>向上</button><button class="down btn btn-info" data-index=' + index + '>向下</button></td>\
            </tr>'
            })
            
            tbody.innerHTML = str
        }

	renderTable(a) 
	
	 function click(e) {
            var index = e.target.getAttribute('data-index');
            var isUp = e.target.className.indexOf('up') > -1
            var isDown = e.target.className.indexOf('down') > -1

            console.log('first', index)
            console.log(isUp)

            if (isUp == true) {
                if (index > 0) {
                  a=upGo(a, index)
                }
                
                renderTable(a)
                console.log(a)
            }
            if (isDown == true) {
                if (index < a.length - 1) {
                   a =  downGo(a, index)
                }
                renderTable(a)
                console.log(a)
       
            }

        }
	
	 function upGo(fieldData, index) {
         if (index != 0) {
             fieldData[index] = fieldData.splice(index - 1, 1, fieldData[index])[0];
             return fieldData
         }
     }

     function downGo(fieldData, index) {
         if (index != fieldData.length - 1) {
             fieldData[index] = fieldData.splice(index*1 + 1, 1, fieldData[index])[0];
             return fieldData

         }

     }
	var b = null
     function orderIndex() {
         a.forEach(function (ele,index) {
             ele.orderIndex = index;
         })
        b = JSON.stringify(a)
         
     }
     
     $('#baocun').click(function(){
    	 orderIndex()
    	 console.log('a',b)
    	 $.ajax({
			 url:'/course/update',
			 traditional:true,
			 data:{
				 course:b 
			 },
			 dataType:'json',
			 type: 'POST',
			 success: function (data) {
				console.log(data)
				if(data.code == 200) {
					alert("修改成功")
				} else {
					alert(data.message)
				}
			 }
		 })  
     })
     
</script>
</body>
</html>
