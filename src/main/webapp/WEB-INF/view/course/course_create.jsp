<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" contentType="text/html; UTF-8" %>
<%@include file="/WEB-INF/view/include/taglib.jsp" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <script>
    var imageUrlPrefix = '<%=com.kjs.common.bean.ParamUtil.imageServicePath %>';
  </script>
  <title>${pname}网管理系统-创建课程</title>
  <style>
    table
    {   border-collapse:   separate;   border-spacing:   10px;   }

  </style>
  <%@include file="/WEB-INF/view/course/course_dialog.jsp" %>
  <link href="${pageContext.request.contextPath}/resources/assets/plugins/DataTables/media/css/dataTables.bootstrap.min.css" rel="stylesheet" />
  <link href="${pageContext.request.contextPath}/resources/assets/plugins/DataTables/extensions/Select/css/select.bootstrap.min.css" rel="stylesheet" />
<%--  <link href="${pageContext.request.contextPath}/resources/assets/plugins/bootstrap-daterangepicker/daterangepicker-bs3.css" rel="stylesheet" />--%>
  <link href="${pageContext.request.contextPath}/resources/common/switch/css/bootstrap-switch.min.css" rel="stylesheet" />
  <link href="${path}/resources/assets/plugins/bootstrapValidator/css/bootstrapValidator.css" rel="stylesheet">
  <link href="${path}/resources/assets/plugins/jquery-file-upload/css/jquery.fileupload.css" rel="stylesheet">

  <script src="${pageContext.request.contextPath}/resources/assets/plugins/bootstrapValidator/js/bootstrapValidator.js"></script>
  <script type="text/javascript" charset="utf-8" src="/resources/ueditor/ueditor.config.js"></script>
  <script type="text/javascript" charset="utf-8" src="/resources/ueditor/ueditor.all.js"></script>
  <script src="${pageContext.request.contextPath}/resources/assets/plugins/DataTables/media/js/jquery.dataTables.js"></script>
  <script src="${pageContext.request.contextPath}/resources/assets/plugins/DataTables/media/js/dataTables.bootstrap.min.js"></script>
  <script src="${pageContext.request.contextPath}/resources/assets/plugins/DataTables/extensions/Select/js/dataTables.select.min.js"></script>
<%--  <script src="${pageContext.request.contextPath}/resources/assets/plugins/bootstrap-daterangepicker/moment.js"></script>
  <script src="${pageContext.request.contextPath}/resources/assets/plugins/bootstrap-datetimepicker/js/bootstrap-datetimepicker.min.js"></script>
  <script  src="${pageContext.request.contextPath}/resources/assets/plugins/bootstrap-datetimepicker/js/locales/bootstrap-datetimepicker.zh-CN.js" charset="UTF-8"></script>--%>
  <script src="${pageContext.request.contextPath}/resources/common/switch/js/bootstrap-switch.min.js"></script>
  <script src="${pageContext.request.contextPath}/resources/common/utils/js/tool.date.js"></script>
  <script src="${pageContext.request.contextPath}/resources/assets/plugins/jquery-file-upload/js/vendor/jquery.ui.widget.js"></script>
  <script src="${pageContext.request.contextPath}/resources/assets/plugins/jquery-file-upload/js/jquery.fileupload.all.js"></script>
  <link href="${pageContext.request.contextPath}/resources/assets/plugins/jquery-file-upload/css/jquery.fileupload.css" rel="stylesheet">
  <link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath}/resources/bootstrap-fileinput-master/css/fileinput.css" />
  <script type="text/javascript" src="${pageContext.request.contextPath}/resources/bootstrap-fileinput-master/js/fileinput.js"></script>
  <script src="${pageContext.request.contextPath}/resources/base/course/coursemanage.js"></script>
  <script src="${pageContext.request.contextPath}/resources/assets/js/jquery.bootstrap.wizard.js"></script>
  <!--建议手动加在语言，避免在ie下有时因为加载语言失败导致编辑器加载失败-->
  <!--这里加载的语言文件会覆盖你在配置项目里添加的语言类型，比如你在配置项目里配置的是英文，这里加载的中文，那最后就是中文-->
  <script type="text/javascript" charset="utf-8" src="/resources/ueditor/lang/zh-cn/zh-cn.js"></script>
  <script src="/resources/base/course/course_create.js"></script>
  <script src="/resources/base/course/new_version.js"></script>
  <script type="text/javascript" src="${pageContext.request.contextPath}/resources/common/layer-v2.3/layer/layer.js"></script>
  <!-- 拖拽排序 start -->
  <link href="/resources/bootstrap-order/css/bootstrap-order.min.css" rel="stylesheet">
  <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
  <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
  <!--[if lt IE 9]>
  <script src="/resources/bootstrap-order/support/html5shiv.min.js"></script>
  <script src="/resources/bootstrap-order/support/respond.min.js"></script>
  <script src="/resources/layer-v2.4/layer/layer.js"></script>


  <![endif]-->
  <!-- 拖拽排序 end -->
  <script src="/resources/common/utils/js/utils.js"></script>
  <style>
    .basediv {
      margin: 30px;
    }
    .nav-pills li{width: 32.6%;height:100%;padding: 0;margin: 0;text-align: center}
    table thead tr td{text-align: center}
  </style>
</head>
<body>
<script>
  var pid  = '${pid}';
  var cate3 = '${cate3}';
</script>
<input type="hidden" id="pid" value="${pid}">
<input type="hidden" id="operationType" name="operationType" value="${operationType}">
<input type="hidden"  name="courseId" id="courseId" value="${courseId}"/>
<input type="hidden" name="coursePositionId" id="coursePositionId" value="${course.positionId}">
<input type="hidden" name="courseDirectionId" id="courseDirectionId" value="${course.directionId}">
<div id="rootwizard">
  <div class="panel panel-inverse">
    <div class="panel-heading">
      <div class="panel-heading-btn">
        <button type="button" class="btn btn-xs btn-info m-r-5" onclick="javascript:history.back(-1);">返回</button>
      </div>
      <div class="panel-title">创建课程</div>
    </div>
  </div>

  <ul class="nav nav-pills" style="margin: 0px">
    <li ><a href="#course-base" data-toggle="tab" id="base-href">课程基本信息</a></li>
    <li ><a href="#course-brief" data-toggle="tab" id="brief-href">课程介绍</a></li>
    <li><a href="#course-config" data-toggle="tab" id="config-href">课程设置</a></li>
  </ul>
  <div class="tab-content" style="min-height:900px">

    <div class="tab-pane" id="course-base">
      <div>
        <div class="row">
          <div class="col-md-10">
            <div class="panel panel-inverse">
              <div class="panel-body">
                <form id="course"  class="form-horizontal" role="form" >
                  <input type="hidden"  name="checkCourseId" id="checkCourseId" value="${courseId}"/>
                  <div class="form-group">
                    <label class="col-md-3 control-label">学院：</label>
                    <div class="col-md-9">
                      <select style="width: 200px;height:30px;" name="directionId" id="directionId" class="form-control">
                        <option value="">--学院--</option>
                      </select>
                    </div>
                  </div>
                  <div class="form-group">
                    <label class="col-md-3 control-label">${cate3}：</label>
                    <div class="col-md-9">
                      <select id="positionId" name="positionId" onfocus="getPosition()" style="width: 200px;height:30px;" class="form-control">
                        <option value="">请选择${cate3}</option>
                      </select>
                    </div>
                  </div>
                  <!-- 课程顺序 -->
<!--                      <div class="form-group">  -->
<!--                     <label class="col-md-3 control-label">课程顺序</label> -->
<!--                     <div class="col-md-9"> -->
<!--                        <input type="text"  id="orderIndex" name="orderIndex"  class="form-control" style="width: 200px; ">                    -->
<!--                     </div> -->
<!--                   </div>  -->
					<div class="form-group">
                    <label class="col-md-3 control-label">课程顺序：</label>
                    <div class="col-md-9">
                      <input type="text"  id="orderIndex" name="orderIndex" value="${course.orderIndex}" class="form-control" style="width: 200px; float: left !important;">
                    </div>
                  </div>
                  <!-- 课程顺序 -->
                  <c:if test="${pid=='kjs'}">
                    <div class="form-group">
                      <label class="col-md-3 control-label">版本：</label>
                      <div class="col-md-9">
                        <ul id="industry" class="list-group"></ul>
                      </div>
                    </div>
                    <div class="form-group">
                      <label class="col-md-3 control-label"></label>
                      <div class="col-md-9">
                        <button class="btn btn-info m-r-5 m-b-5" data-toggle="modal"  onclick="getIndustry($('#directionId').val());" href="#industry_dialog"  type="button" style="background-color: lightseagreen">添加版本</button>
                      </div>
                    </div>
                  </c:if>
                  <div class="form-group">
                    <label class="col-md-3 control-label">创建类型：</label>
                    <div class="col-md-9">
                      <input type="radio" name="createType" value="1" href="#createCourse_dialog">&nbsp;创建新课程<input type="radio" name="createType" style="margin-left: 45px" value="2" href="#updateCourse_dialog">&nbsp;课程版本更新
                    </div>
                  </div>
                  <div class="form-group">
                    <label class="col-md-3 control-label">课程标题：</label>
                    <div class="col-md-9">
                      <input type="text" name="title" id="title" value="${course.title}"  class="form-control" style="width: 200px;float: left !important;border: none" readonly><div style="width: 230px; height:34px; line-height: 34px;padding-left: 10px;cursor:pointer" onclick="updateTitle()">&nbsp;修改</div>
                    </div>
                  </div>
                  <div class="form-group">
                    <label class="col-md-3 control-label">版本号：</label>
                    <div class="col-md-9">
                      <input type="text" name="versionShow" id="versionShow"  readonly class="form-control" style="width: 200px;border: none"<c:if test="${empty course.version}">value="第一版"</c:if>>
                      <input type="hidden" name="version" id="version" readonly class="form-control" style="width: 200px;border: none" <c:if test="${not empty course.version}">value="${course.version}"</c:if> <c:if test="${empty course.version}">value="1"</c:if>>
                      <input type="hidden"  name="preCourseId" id="preCourseId"<c:if test="${not empty course.preCourseId}">value="${course.preCourseId}"</c:if> <c:if test="${empty course.preCourseId}">value="0"</c:if> />
                    </div>
                  </div>
                  <script>
                    var versionNo=${course.version}+'';
                    if(versionNo!=''){
                      var courseVersion= numberUpperCase.init(versionNo.toString());
                      var chinaVersion=numberUpperCase.pri_ary();
                      $('#versionShow').val('第'+chinaVersion+'版');
                    }
                  </script>
                  <div class="form-group">
                    <label class="col-md-3 control-label">课程优势：</label>
                    <div class="col-md-9">
                      <ul id="advantages" class="list-group"></ul>
                    </div>
                  </div>
                  <div class="form-group">
                    <label class="col-md-3 control-label"></label>
                    <div class="col-md-9">
                      <button class="btn btn-info m-r-5 m-b-5" data-toggle="modal"  onclick="getCourseAdvantage(${course.id}+'',2);" href="#advantage_dialog"  type="button" style="background-color: lightseagreen">添加标签</button>
                    </div>
                  </div>
                  <div class="form-group">
                    <label class="col-md-3 control-label">适合对象：</label>
                    <div class="col-md-9">
                      <ul id="suitables" class="list-group"></ul>
                    </div>
                  </div>
                  <div class="form-group">
                    <label class="col-md-3 control-label"></label>
                    <div class="col-md-9">
                      <button class="btn btn-info m-r-5 m-b-5" data-toggle="modal"  onclick="getCourseSuitable(${course.id}+'',1);" href="#suitable_dialog"  type="button" style="background-color: lightseagreen">添加标签</button>
                    </div>
                  </div>
                  <div class="form-group">
                    <label class="col-md-3 control-label">学习思路：</label>
                    <div class="col-md-9">
                        <input type="text"  id="learningIdeas1" name="learningIdeas1"  class="form-control" style="width: 200px; ">
                    </div>
                  </div>
                  <div class="form-group">
                    <label class="col-md-3 control-label"></label>
                    <div class="col-md-9" >
                      <input type="text"  id="learningIdeas2" name="learningIdeas2"  class="form-control" style="width: 200px; ">
                    </div>
                  </div>
                  <div class="form-group">
                    <label class="col-md-3 control-label"></label>
                    <div class="col-md-9">
                      <input type="text"  id="learningIdeas3" name="learningIdeas3"  class="form-control" style="width: 200px; ">
                    </div>
                  </div>
                  <div class="form-group">
                    <label class="col-md-3 control-label">购买基数：</label>
                    <div class="col-md-9">
                      <input type="text"  id="courseStuNum" name="courseStuNum" value="${course.courseStuNum}" class="form-control" style="width: 200px; float: left !important;"> <div style="width: auto; height:34px; line-height: 34px;padding-left: 10px;">&nbsp;人数</div>
                    </div>
                  </div>
                  <div class="form-group">
                    <label class="col-md-3 control-label">评分基数：</label>
                    <div class="col-md-9">
                      <input type="text"  id="score" name="score" value="${course.score}" class="form-control" style="width: 200px; float: left !important;"> <div style="width: auto; height:34px; line-height: 34px;padding-left: 10px;">&nbsp;分</div>
                    </div>
                  </div>
                  <div class="form-group">
                    <label class="col-md-3 control-label">评分人数基数：</label>
                    <div class="col-md-9">
                      <input type="text"  id="scoreNum" name="scoreNum" value="${course.scoreNum}" class="form-control" style="width: 200px; float: left !important;"> <div style="width: auto; height:34px; line-height: 34px;padding-left: 10px;">&nbsp;人</div>
                    </div>
                  </div>
                  <div class="form-group">
                    <label class="col-md-3 control-label">建议学习天数：</label>
                    <div class="col-md-9">
                      <input type="text"  id="dayLength" name="dayLength" value="<fmt:formatNumber value="${course.dayLength}" type="number"/>" class="form-control" style="width: 200px; float: left !important;"> <div style="width: auto; height:34px; line-height: 34px;padding-left: 10px;">&nbsp;天</div>
                    </div>
                  </div>
                  <div class="form-group">
                    <label class="col-md-3 control-label">建议每天小时数：</label>
                    <div class="col-md-9">
                      <input type="text"  id="dayHours" name="dayHours" value="${course.dayHours}" class="form-control" style="width: 200px; float: left !important;"> <div style="width: auto; height:34px; line-height: 34px;padding-left: 10px;">&nbsp;小时</div>
                    </div>
                  </div>
                  <div class="form-group">
                    <label class="col-md-3 control-label">建议每天听课节数：</label>
                    <div class="col-md-9">
                      <input type="text"  id="dayLecture" name="dayLecture" value="${course.dayLecture}" class="form-control" style="width: 200px; float: left !important;"> <div style="width: auto; height:34px; line-height: 34px;padding-left: 10px;">&nbsp;节</div>
                    </div>
                  </div>
                  <div class="form-group">
                    <label class="col-md-3 control-label">建议资料数：</label>
                    <div class="col-md-9">
                      <input type="text"  id="dayNode" name="dayNode" value="${course.dayNode}" class="form-control" style="width: 200px; float: left !important;"> <div style="width: auto; height:34px; line-height: 34px;padding-left: 10px;">&nbsp;小时</div>
                    </div>
                  </div>
                  <div class="form-group">
                    <label class="col-md-3 control-label">实操课程ID：</label>
                    <div class="col-md-9">
                      <input type="text" class="form-control" id="practice-sid" name="practiceSid" value="${course.practiceSid}"  placeholder="" style="width: 200px; float: left !important;">
                    </div>
                  </div>
                  <div class="form-group">
                    <label  class="col-md-3 control-label">课程图片</label>
                    <div class="col-md-1">
                      <img id="preview-image"  alt="课程图片" class="img-thumbnail"   <c:if test="${not empty course.coverUrl}"> src="${course.coverUrl}"</c:if> />
                    </div>
                    <div class="col-md-4">
                   <span class="btn btn-primary btn-sm fileinput-button">
                        <i class="glyphicon glyphicon-plus"></i>
                        <span>上传</span>
                        <input id="imageFile" type="file" name="imageFile">
                    <input type="hidden" id="course-image-path" name="coverUrl" <c:if test="${not empty course.coverUrl}"> value="${course.coverUrl}"</c:if> >
                    </span>
                    </div>
                  </div>
                  <div class="form-group">
                    <label class="col-md-3 control-label"></label>
                    <div class="col-md-9">
                      <shiro:hasPermission name="addcourse:save">
                        <button id="base-next" type="button" class="btn btn-default"  style="background-color: lightseagreen" >下一步</button>
                      </shiro:hasPermission>
                    </div>
                  </div>
                </form>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
    <div class="tab-pane" id="course-brief">
      <div>
        <div class="row">
          <div class="col-md-10" style="width:100%;">
            <div class="panel panel-inverse">
              <form id="config" method="post" class="form-horizontal" role="form">
                <c:if test="${pid=='kjs'}">
                  <div class="basediv">
                    <h2>岗位职责</h2>
                    <hr style="height:1px;border:none;border-top:1px solid #555555;"/>
                    <div id="job_duty" name="jobDuty"></div>
                  </div>
                </c:if>
                <div class="basediv">
                  <h2>课程简介</h2>
                  <hr style="height:1px;border:none;border-top:1px solid #555555;"/>
                  <div id="course_brief" name="summary"></div>
                </div>
                <div class="basediv">
                  <h2>老师介绍</h2>
                  <hr style="height:1px;border:none;border-top:1px solid #555555;"/>
                  <div id="teacher_brief" name="teacherBriefDiv">
                    <div class="form-group">
                      <label class="col-md-3 control-label" style="width: 10%" >老师姓名：</label>
                      <div class="col-md-9">
                        <select style="width: 150px;height:30px;" name="teacherId" id="teacherId" class="form-control">
                          <option value="">--请选择老师--</option>
                        </select>
                      </div>
                    </div>
                    <div class="form-group" id="teacherFlowerNameDiv" style="display: none">
                      <label class="col-md-3 control-label" style="width: 10%">老师花名：</label>
                      <div class="col-md-9"  id="teacherFlowerName">
                        <%-- <input type="text" style="width: 150px;height:30px;" name="teacherFlowerName" id="teacherFlowerName" class="form-control"/>--%>
                      </div>
                    </div>
                    <div class="form-group"  id="teacherImgUrlDiv" style="display: none">
                      <label class="col-md-3 control-label" style="width: 10%">老师头像：</label>
                      <div class="col-md-9">
                        <img class="media-object rounded-corner" style="width:100px;height:100px;"  id="teacherImgUrl" <%--src="http://tu.kuaijishizi.com/userImg/20160815/e92dbd28-17dc-4e8d-af72-b5253f8bfa7a.jpg"--%>/>
                      </div>
                    </div>
                    <div class="form-group"  id="teacherBriefDiv" style="display: none">
                      <label class="col-md-3 control-label" style="width: 10%">老师介绍：</label>
                      <div class="col-md-9" style="padding-top: 7px;" id="teacherBriefContent">

                      </div>
                    </div>
                  </div>
                </div>
                <div style="text-align: center;">
                  <button type="button" class="btn btn-sm btn-info m-r-5 btn-lg" id="brief-back">上一步</button>
                  <button type="button" class="btn btn-sm btn-info m-r-5 btn-lg" id="brief-next">下一步</button>
                  <c:if test="${pid=='kjs'}">
                    <button type="button" class="btn btn-sm btn-info m-r-5 btn-lg" id="teacher_preview" onclick="editor_preview(UE.getEditor('job_duty').getContent(),UE.getEditor('course_brief').getContent(),$('#teacherId').val())">预览</button>
                  </c:if>
                  <c:if test="${pid=='sjn'}">
                    <button type="button" class="btn btn-sm btn-info m-r-5 btn-lg" id="teacher_preview" onclick="editor_preview(null,UE.getEditor('course_brief').getContent(),$('#teacherId').val())">预览</button>
                  </c:if>
                </div>
              </form>
            </div>
          </div>
        </div>
      </div>
    </div>
    <c:if test="${not empty course.learningIdeas}">
      <script>
        var learningIdeas=${course.learningIdeas};
        if(learningIdeas!=null && learningIdeas!=''){
          $('#learningIdeas1').val(learningIdeas.learningIdeas1);
          $('#learningIdeas2').val(learningIdeas.learningIdeas2);
          $('#learningIdeas3').val(learningIdeas.learningIdeas3);
        }
      </script>
    </c:if>
    <script>
      window.onload=function(){
        $('#rootwizard').bootstrapWizard();
        var jobDuty = '${courseText.jobDuty}' + "";
        var summary = '${courseText.summary}' + "";
        var teacherId = '${courseText.teacherId}' + "";
        if($('#pid').val()=='kjs'){
          var job_duty = UE.getEditor('job_duty');
          job_duty.ready(function () {
            if (jobDuty != null && jobDuty != '') {
              this.setContent(jobDuty);
            } else {
              this.setContent("请填写岗位职责");
            }

          });
        }
        var course_brief = UE.getEditor('course_brief');
        course_brief.ready(function(){
          if(summary!=null && summary!=''){
            this.setContent(summary);
          }else{
            this.setContent("请填写课程简介");
          }

        });
        <%--<shiro:hasPermission name="teacher:find">--%>
        //获取老师下拉列表
        $.ajax({
          url:"/teacher/teacherList",
          type: "post",
          dataType: "json",
          cache: false,
          async: false,
          success: function (datas) {
            var result = datas.result;
            // $("#teacherId").find("option").remove();
            $.each(result,function(n,teacher) {
              var id=  teacher.id;
              var name = teacher.name;
              var option = "<option value='"+id+"'>"+name+"</option >";
              if(teacherId!='' && teacherId!=0){
                if(teacherId==teacher.id){
                  $('#teacherId').val(teacher.id);
                  $('#teacherFlowerName').html(teacher.flowerName);
                  $('#teacherImgUrl').attr("src",teacher.imgUrl);
//                   $('#teacherImgUrl').src=teacher.imgUrl;
                  $('#teacherBriefContent').html(teacher.introduction);
                  $('#teacherFlowerNameDiv').css("display","block");
                  $('#teacherImgUrlDiv').css("display","block");
                  $('#teacherBriefDiv').css("display","block");
                  option = "<option value='"+id+"'selected='selected'>"+name+"</option >";

                }
              }
              $("#teacherId").append(option);
            });
          }
        })

        //老师下拉列表变化时的响应
        $('#teacherId').change(function () {
                  $.ajax({
                    url:"/teacher/entity",
                    type: "post",
                    dataType: "json",
                    cache: false,
                    async: false,
                    data:{id:$('#teacherId option:selected') .val()},
                    success: function (datas) {
                      var result = datas.result;
                      $('#teacherId').val(result.id);
                      $('#teacherFlowerName').html(result.flowerName);
//                $('#teacherImgUrl').css("src",result.imgUrl);
                      $('#teacherImgUrl').attr("src",result.imgUrl);
                      $('#teacherBriefContent').html(result.introduction);
                      $('#teacherFlowerNameDiv').css("display","block");
                      $('#teacherImgUrlDiv').css("display","block");
                      $('#teacherBriefDiv').css("display","block");
                    }
                  })
                }
        );
        <%--</shiro:hasPermission>--%>
      }
    </script>
    <div class="tab-pane" id="course-config">
      <div>
        <div>
          <div class="row">
            <div class="col-md-10" style="width:100%;">
              <div class="panel panel-inverse">
                <div class="panel-body">
                  <table id="lecture_table"  class="table table-striped table-bordered" width="100%">
                    <thead>
                    <tr>
                      <th width="10%">节次</th>
                      <th width="20%">标题</th>
                      <th width="20%">乐视ID</th>
                      <th width="20%">CC视频ID</th>
                      <%--<th>分钟数</th>--%>
                      <th width="20%">资料名</th>
                      <th width="20%">上传资料</th>
                      <th width="10%">试听&nbsp;<button id="all-btn" class="btn btn-xs btn-info" onclick="allAudition()">全选</button></th>
                      <c:if test="${operationType!=0}"><th width="70px">视频时长</th></c:if>
                    </tr>
                    </thead>
                  </table>
                  <shiro:hasPermission name="addcourse:save">
                    <button  class="btn btn-info"  onclick="rowadd()" >增加一节</button>
                    <button  id="delRow" class="btn btn-danger"   >删除一节</button>
                    <button  id="sort" class="btn btn-info"  onclick="showSort();" >排序</button>
                  </shiro:hasPermission>
                </div>
                <div id="myTabContent" class="tab-content">
                  <div style="text-align: center;width: 85%">
                    <button class="btn btn-info"  id="config-back" >上一步</button>&nbsp;&nbsp;
                    <c:choose>
                      <c:when test="${operationType== '0'}">
                        <button onclick="submitForm(0)" type="button" class="btn btn-info" >提交审核</button>
                      </c:when>
                      <c:when test="${operationType== '1'}">
                      </c:when>
                      <c:when test="${operationType== '3'}">
                        <button onclick="submitForm(0)" type="button" class="btn btn-info"  >提交审核</button>
                      </c:when>
                      <c:otherwise>
                        <button onclick="examCourse(this)" type="button" class="btn btn-info" >审核通过</button>
                        <button onclick="examCourseFailed(this)" type="button" class="btn btn-info"  >审核不通过</button>
                      </c:otherwise>
                    </c:choose>
                  </div>
                  <!-- tab页面end-->
                </div>

              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</div>
<!-- 拖拽排序 start -->
<script src="/resources/bootstrap-order/js/bootstrap-order.min.js"></script>
<!-- 拖拽排序 end -->
</body>

</html>