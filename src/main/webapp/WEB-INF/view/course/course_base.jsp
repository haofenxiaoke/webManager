<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2016/5/26 0026
  Time: 下午 3:32
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" contentType="text/html; UTF-8" %>
<%@include file="/WEB-INF/view/include/taglib.jsp" %>
<%@include file="/WEB-INF/view/course/course_dialog.jsp" %>
<link href="${path}/resources/assets/plugins/bootstrapValidator/css/bootstrapValidator.css" rel="stylesheet">
<link href="${path}/resources/assets/plugins/jquery-file-upload/css/jquery.fileupload.css" rel="stylesheet">
<script src="${pageContext.request.contextPath}/resources/assets/plugins/bootstrapValidator/js/bootstrapValidator.js"></script>
<script src="${pageContext.request.contextPath}/resources/assets/plugins/jquery-file-upload/js/jquery.fileupload.all.js"></script>
<div>
<div class="row">
    <div class="col-md-10">
      <div class="panel panel-inverse">
        <div class="panel-body">
          <form id="course"  class="form-horizontal" role="form" >
            <div class="form-group">
              <label class="col-md-3 control-label">方向：</label>
              <div class="col-md-9">
                <input type="hidden"  name="courseId" id="id" value="${courseId}"/>
                <input type="hidden"  name="courseId" id="courseId" value="${course.id}"/>
                <select style="width: 200px;height:30px;" name="directionId" id="directionId" class="form-control">
                  <option value="-1">--方向--</option>
                </select>
              </div>
            </div>
            <div class="form-group">
              <label class="col-md-3 control-label">职位：</label>
              <div class="col-md-9">
                <select id="positionId" name="positionId" onfocus="getPosition()" style="width: 200px;height:30px;" class="form-control">
                  <option value="">请选择职位</option>
                </select>
              </div>
            </div>
            <div class="form-group">
              <label class="col-md-3 control-label">行业：</label>
              <div class="col-md-9">
                <ul id="industry" class="list-group"></ul>
              </div>
            </div>
            <div class="form-group">
              <label class="col-md-3 control-label"></label>
              <div class="col-md-9">
                <button class="btn btn-info m-r-5 m-b-5" data-toggle="modal"  onclick="getIndustry($('#directionId').val());" href="#industry_dialog"  type="button" style="background-color: lightseagreen">添加行业</button>

              </div>
            </div>
            <div class="form-group">
              <label class="col-md-3 control-label">标题：</label>
              <div class="col-md-9">
                <input type="text" name="title" id="title" value="${course.title}" class="form-control" style="width: 200px;">

              </div>
            </div>
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
                <textarea style="width: 360px;height: 100px" name="LearningIdeas" id="LearningIdeas"  >${course.learningIdeas}</textarea>
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
                <input type="text"  id="dayLength" name="dayLength"  value="${course.dayLength}" class="form-control" style="width: 200px; float: left !important;"> <div style="width: auto; height:34px; line-height: 34px;padding-left: 10px;">&nbsp;天</div>
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
                  <button type="button" class="btn btn-default" id="save-down" style="background-color: lightseagreen" >下一步</button>
                </shiro:hasPermission>
              </div>
            </div>
          </form>
      </div>
    </div>
  </div>
</div>
</div>


<style>
  table
  {   border-collapse:   separate;   border-spacing:   10px;   }
  .tdleft{text-align: right;width: 160px;}
</style>
<script>

  /**
   * 初始化 jQuery File Upload 上传文件插件
   * @param fileId
   * @param previewId  预览图id
   * @param savePathInputId  保存图片路径的input id
   */
  function initFileupload(fileId,previewId,savePathInputId) {
    $('#'+fileId).fileupload({
      url:'/upload/image',
      done: function (e, data) {
        if(data.result.code == HttpUtil.success_code){
          var path = data.result.result.path;
          $('#'+previewId).attr('src', path);
          $('#'+savePathInputId).val(path);
          $('#course')//上传成功表单验证设置为通过
                  .data('bootstrapValidator')
                  .updateStatus('coverUrl', 'NOT_VALIDATED', null)
                  .validateField('coverUrl');
        }else{
          var alert = BootstrapDialog.alert||window.alert;
          alert(data.result.msg);
        }
      }
    });
  }
  $(document).ready(function() {

    var course = $("#course");

    <shiro:hasPermission name="course:find:0">
    //验证表单信息
    course.bootstrapValidator({
      fields: {
        directionId: {
          validators: {
            notEmpty: {
              message: '方向不能为空!'
            }
          }
        },
        positionId: {
          validators: {
            notEmpty: {
              message: '职位不能为空!'
            }
          }
        }, title: {
          validators: {
            notEmpty: {
              message: '标题不能为空!'
            },stringLength: {
              max: 100,
              message: '课程标题不能超过100个字'
            },regexp: {
               regexp: /^[\u4e00-\u9fa5a-zA-Z0-9]+$/,
            message: '只能输入汉字、数字和字母！'
  }
          }
        }, LearningIdeas1: {
          validators: {
            notEmpty: {
              message: '学习思路不能为空!'
            },stringLength: {
              max: 20,
              message: '学习思路过长，不能超过20个字'
            }
          }
        }, LearningIdeas2: {
          validators: {
            notEmpty: {
              message: '学习思路不能为空!'
            },stringLength: {
              max: 20,
              message: '学习思路过长，不能超过20个字'
            }
          }
        }, LearningIdeas13:{
          validators: {
            notEmpty: {
              message: '学习思路不能为空!'
            },stringLength: {
              max: 20,
              message: '学习思路过长，不能超过20个字'
            }
          }
        }, courseStuNum: {
          validators: {
            notEmpty: {
              message: '购买基数不能为空!'
            },regexp: {
              regexp: /^[1-9][0-9]*$/,
              message: '只能输入数字！'
            }
          }
        }, scoreNum: {
          validators: {
            notEmpty: {
              message: '评分人数基数不能为空!'
            },regexp: {
              regexp:/^[1-9][0-9]*$/,
              message: '只能输入数字！'
            }
          }
        }, score: {
          validators: {
            notEmpty: {
              message: '评分基数不能为空!'
            },regexp: {
              regexp:/^[0-5]$/,
              message: '只能输入0-5的数字！'
            }
          }
        }, dayLength: {
          validators: {
            notEmpty: {
              message: '建议学习天数不能为空!'
            },regexp: {
              regexp:/^\d+(\.\d+)?$/,
              message: '只能输入数字！'
            }
          }
        },dayHours: {
          validators: {
            notEmpty: {
              message: '建议每天学习小时数不能为空!'
            },regexp: {
              regexp: /^[1-9][0-9]*$/,
              message: '只能输入数字！'
            }
          }
        },dayLecture: {
          validators: {
            notEmpty: {
              message: '建议每天听课节数不能为空!'
            },regexp: {
              regexp: /^[1-9][0-9]*$/,
              message: '只能输入数字！'
            }
          }
        },dayNode: {
          validators: {
            notEmpty: {
              message: '建议资料数不能为空!'
            },regexp: {
              regexp:/^[1-9][0-9]*$/,
              message: '只能输入数字！'
            }
          }
        },coverUrl: {
          validators: {
            notEmpty: {
              message: '课程图片不能为空!'
            }
          }
        }
      }
    });

    </shiro:hasPermission>

    <shiro:hasPermission name="addcourse:save:0">
    $('#save-down').unbind('click').click(function () {
      var liReg=true;
      var courseImage
      if($("#industry").children().length==0 ||$("#advantages").children().length==0||$("#suitables").children().length==0 ){
             liReg=false;
      }
      var pass=$('#course').data('bootstrapValidator').validate().isValid();//表单验证是否通过
      if(pass){
        if(!liReg){
          BootstrapDialog.warning('请选择课程所属行业、课程优势、适合对象');
          return;
        }
        var courseImage=$("#course-image-path").val();
        if(courseImage==null || courseImage==''){
          BootstrapDialog.warning('请选择课程图片！');
          return;
        }
        var idCourse='${courseId}';
        if(!idCourse){
          idCourse=0;
        }
        $.ajax({
          url:"/course/saveBase/${operType}/"+idCourse,
          type:"post",
          dataType:"json",
          cache: false,
          data :$("#course").serializeArray(),
          success: function (datas){
            if(datas.code == HttpUtil.success_code){
              window.location.href = "/course/course_brief/"+datas.result+"/${operType}";
              //$.post('/course/course_brief',{courseId:datas.result});

            }
          }
        });
      }

    });
    </shiro:hasPermission>
    <shiro:hasPermission name="cate:find:0">
    /*方向选择框change事件*/
    $("#directionId").change(function(){
      /*清空职位*/
      $("#positionId").empty();
      /*清空行业*/
      $("#industry").find("li").remove();
      /*清空适合对象*/
      $("#suitables").find("li").remove();
      /*清空课程优势*/
      $("#advantages").find("li").remove();

    })
    //获取放向下拉菜单数据
    var  condition;
    condition= '${course.directionId}';
    var  resCode='addcourse';
    var operCode='save';
    var url = '/cate/list/' + resCode + '/'+operCode;
    $.get(url).done(function (data) {
      if (data.code == HttpUtil.success_code){
        var options = '';
        $.each(data.result,function (index,cate) {
          if(condition){
            if(cate.id=='${course.directionId}'){
              options+='<option value="'+cate.id+'" selected=\"selected\">'+cate.categoryDesc+'</option>';
            }else{
              options+='<option value="'+cate.id+'">'+cate.categoryDesc+'</option>';
            }
          }else{
            options+='<option value="'+cate.id+'">'+cate.categoryDesc+'</option>';
          }

        })
        $("#directionId").append(options);
        getPosition();
      }else{
        BootstrapDialog.alert(data.msg);
      }
    });
    </shiro:hasPermission>

        var courseId=${course.id}+'';
        if(courseId!=null && courseId!=''){
          /*回写课程优势*/
          advantageWriteBack(courseId,2);
          /*回写适合对象*/
          suitableWriteBack(courseId,1);
          /*回写课程行业*/
          getCourseIndustry(courseId);
    }
    //初始化文件上传插件
    initFileupload('imageFile','preview-image','course-image-path');

  })

  /*回写课程优势的方法 */
  function  advantageWriteBack(courseId,type){
    var data={type:type,courseId:courseId};
    //获取课程优势下拉菜单数据
    $.ajax({
      url:"/tag/courseAdvantageTagList",
      type: "post",
      dataType: "json",
      cache: false,
      async: false,
      data: data,
      success: function (datas) {
        var result = datas.result;
        var ul = $("#advantages");
        ul.innerHTML = '';
        $.each(result, function (n, obj) {
          var id=  obj.id;
          var content = obj.content;
          if (courseId != null && courseId != '') {
            var advantageNum = $("#advantageNum");
            var li = document.createElement("li");
            //设置 li 属性，如 id
            li.setAttribute("id", "advantageTagId" + advantageNum.val());
            li.setAttribute("class", "list-group-item");
            li.setAttribute("style", "padding:10px");
            var inner = "<input type='hidden' name='advantageTagId' style='border:0;' value=" + id + ">" + content + "&nbsp;&nbsp;<button type='button' class='btn btn-default' onclick='advantagedelbtn(this.parentNode.id)' style='background-color: red'>删除</button>";
            li.innerHTML = inner;
            ul.append(li);
            advantageNum.val(parseInt(advantageNum.val()) + 1);
          }
        });
      }
    })
  }
  /*回写适合对象的方法 */
  function  suitableWriteBack(courseId,type){
    var data={type:type,courseId:courseId};
    //获取课程优势下拉菜单数据
    $.ajax({
      url:"/tag/courseSuitableTagList",
      type: "post",
      dataType: "json",
      cache: false,
      async: false,
      data: data,
      success: function (datas) {
        var result = datas.result;
        var ul = $("#suitables");
        ul.innerHTML = '';
        $.each(result, function (n, obj) {
          var id=  obj.id;
          var content = obj.content;
          if (courseId != null && courseId != '') {
            var advantageNum = $("#suitableNum");
            var li = document.createElement("li");
            //设置 li 属性，如 id
            li.setAttribute("id", "suitableTagId" + advantageNum.val());
            li.setAttribute("class", "list-group-item");
            li.setAttribute("style", "padding:10px");
            var inner = "<input type='hidden' name='suitableTagId' style='border:0;' value=" + id + ">" + content + "&nbsp;&nbsp;<button type='button' class='btn btn-default' onclick='suitabledelbtn(this.parentNode.id)' style='background-color: red'>删除</button>";
            li.innerHTML = inner;
            ul.append(li);
            advantageNum.val(parseInt(advantageNum.val()) + 1);
          }
        });
      }
    })

  }

  /*根据课程id回写行业标签*/
    /*获取某课程行业的下拉列表*/
    function getCourseIndustry(courseId){
      var data={courseId:courseId};
      if(courseId==null ||courseId==''){
        return false;
      }
      <shiro:hasPermission name="cate:find:0">
      //获取放向下的行业下拉菜单数据
      $.ajax({
        url: "/industry/courseIndustry",
        type: "post",
        dataType: "json",
        cache: false,
        async: false,
        data: data,
        success: function (datas) {
          var result = datas.result;
          $("#industryids").find("option").remove();
          $.each(result,function(n,obj) {
            var id=  obj.id;
            var categoryDesc = obj.categoryDesc;
            var industryNum=$("#industryNum");
            var li = document.createElement("li");
            //设置 li 属性，如 id
            li.setAttribute("id", "industryId"+industryNum.val());
            li.setAttribute("class","list-group-item");
            li.setAttribute("style","padding:10px");
            var inner="<input type='hidden' name='industryId' style='border:0;' value="+id+">"+categoryDesc +"&nbsp;&nbsp;<button type='button' class='btn btn-default' onclick='industrydelbtn(this.parentNode.id)' style='background-color:red'>删除</button>";
            li.innerHTML =inner;
            var ul=$("#industry");
            ul.append(li);
            industryNum.val(parseInt(industryNum.val())+1);

          });
        }
      })

      </shiro:hasPermission>

    };
    /*获取方向下的职位列表*/
    function getPosition(){
      /*获取方向下职位的下拉列表*/
    <shiro:hasPermission name="cate:find:0">
      var directionId=$("#directionId").val();
      if(directionId==null ||directionId==''){
        return false;
      }
      var data={directionId:directionId};
      //获取放向下的职位下拉菜单数据
      $.ajax({
        url: "/position/positionList",
        type: "post",
        dataType: "json",
        cache: false,
        async: false,
        data: data,
        success: function (datas) {
          var result = datas.result;
          $("#positionId").find("option").remove();
          var coursePositionId=${course.positionId}+"";
          $.each(result,function(n,obj) {
            var id=  obj.id;
            var categoryDesc = obj.categoryDesc;

            if(coursePositionId!=null && coursePositionId!=""){
              if(id==coursePositionId){
                var option = $("<option value='"+id+"' selected=\"selected\">"+categoryDesc+"</li>");
              }else{
                var option = $("<option value='"+id+"'>"+categoryDesc+"</li>");
              }
              $("#positionId").append(option);
            }else{
              var option = $("<option value='"+id+"'>"+categoryDesc+"</li>");
              $("#positionId").append(option);
            }

          });
        }


      })

      </shiro:hasPermission>
    };



</script>



