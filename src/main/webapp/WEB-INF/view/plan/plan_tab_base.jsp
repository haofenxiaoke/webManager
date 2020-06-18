<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" contentType="text/html; UTF-8" %>
<%@include file="/WEB-INF/view/include/taglib.jsp" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <title>${pname}管理系统-定制计划-基本信息</title>
  <link href="${pageContext.request.contextPath}/resources/assets/plugins/DataTables/media/css/dataTables.bootstrap.min.css" rel="stylesheet" />
  <link href="${pageContext.request.contextPath}/resources/assets/plugins/DataTables/extensions/Select/css/select.bootstrap.min.css" rel="stylesheet" />
  <link href="${path}/resources/assets/plugins/bootstrapValidator/css/bootstrapValidator.css" rel="stylesheet">
</head>
<body>
<div>
  <div class="row">
    <div class="col-md-10" style="width:100%;">
      <div class="panel panel-inverse">
        <div class="panel-heading">
          <div class="panel-heading-btn">
            <%--<button type="button" class="btn btn-xs btn-info m-r-5" onclick="javascript:history.back(-1);">返回</button>--%>
              <button type="button" class="btn btn-xs btn-info m-r-5" id="back" >返回</button>
          </div>
          <div class="panel-title">定制计划管理 - ${plan.planDescribe}</div>
        </div>
        <!-- form表单 -->
        <div class="panel-body">
          <nav class="navbar navbar-default" role="navigation">
            <div class="navbar-header" style="width:34%;background: lightseagreen;">
              <a class="navbar-brand" href="#"><button type="button" class="btn btn-default btn-xs m-r-5">1</button>计划基本信息</a>
            </div>
            <div class="navbar-header" style="width:33%;">
              <a class="navbar-brand" href="#"><button type="button" class="btn btn-default btn-xs m-r-5">2</button>选择课程</a>
            </div>
            <div class="navbar-header" style="width:33%;">
              <a class="navbar-brand" href="#"><button type="button" class="btn btn-default btn-xs m-r-5">3</button>课程排序</a>
            </div>
          </nav>
          <form class="form-horizontal" id="planForm" >
            <div class="form-group">
              <div class="col-md-9"><strong><h2>学习基数：</h2></strong></div>
              <div class="col-md-9 row">
                  <div class="col-md-2">
                    <input type="hidden" id="id" name="id" value="${plan.id}">
                    <input type="text" class="form-control" id="stuNum" name="stuNum" value="${plan.stuNum}" />
                  </div>
                  <div class="col-md-1"><h6>人</h6></div>
                  <div class="col-md-2"><h6>当前实际人数${currentCount}人</h6></div>
              </div>
            </div>
            <div class="form-group">
              <div class="col-md-9"><strong><h2>计划标签：</h2></strong></div>
              <div class="col-md-9 row">
                <div class="col-md-2">
                  <input type="hidden" id="orderNum1" name="orderNum1" value="1">
                  <select id="planTag1" name="planTag1" class="form-control">
                    <option value="0">--无--</option>
                  </select>
                </div>
                <div class="col-md-2">
                  <input type="hidden" id="orderNum2" name="orderNum2" value="2">
                  <select id="planTag2" name="planTag2" class="form-control">
                    <option value="0">--无--</option>
                  </select>
                </div>
                <div class="col-md-2">
                  <input type="hidden" id="orderNum3" name="orderNum3" value="3">
                  <select id="planTag3" name="planTag3" class="form-control">
                    <option value="0">--无--</option>
                  </select>
                </div>
              </div>
            </div>
            <div class="form-group">
              <div class="col-md-9"><strong><h2>建议学习月数：</h2></strong></div>
              <div class="col-md-9 row">
                <div class="col-md-2">
                  <input type="text" class="form-control" id="stuMonthNum" name="stuMonthNum" value="${plan.stuMonthNum}"/>
                </div>
              </div>
            </div>
            <shiro:hasPermission name="plan:save:0">
            <div class="form-group">
              <div class="col-md-9 row">
                <div class="col-md-1">
                  <button id="save-base" type="button" class="btn btn-sm btn-primary btn-block">保存</button>
                </div>
              </div>
            </div>
            </shiro:hasPermission>
          </form>
        </div>
        <!-- form表单 -->
      </div>
    </div>
  </div>
</div>
<script src="${pageContext.request.contextPath}/resources/assets/plugins/DataTables/media/js/jquery.dataTables.js"></script>
<script src="${pageContext.request.contextPath}/resources/assets/plugins/DataTables/media/js/dataTables.bootstrap.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/assets/plugins/DataTables/extensions/Select/js/dataTables.select.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/common/utils/js/tool.date.js"></script>
<script src="${pageContext.request.contextPath}/resources/assets/plugins/bootstrapValidator/js/bootstrapValidator.js"></script>
<script src="${pageContext.request.contextPath}/resources/base/plan/plan.js"></script>
<script>
  $(document).ready(function() {
    //标签列表
    var selectUrl = '/tag/plan/list/${plan.directionId}';
    $.get(selectUrl).done(function (data) {
      if (data.code == HttpUtil.success_code){
        var options = '';
        $.each(data.result,function (index,tag) {
          options+='<option value="'+tag.id+'">'+tag.content+'</option>';
        })
        $("#planTag1").append(options);
        $("#planTag2").append(options);
        $("#planTag3").append(options);
       /* $("#planTag4").append(options);
        $("#planTag5").append(options);
        $("#planTag6").append(options);*/
        $("#planTag1").val(${tagMap.planTag1});
        $("#planTag2").val(${tagMap.planTag2});
        $("#planTag3").val(${tagMap.planTag3});
       /* $("#planTag4").val(${tagMap.planTag4});
        $("#planTag5").val(${tagMap.planTag5});
        $("#planTag6").val(${tagMap.planTag6});*/
      }else{
        BootstrapDialog.alert(data.msg);
      }
    });

    <shiro:hasPermission name="plan:find:0">

    //验证表单信息
    var reg = /^([1-9]\d*)$/; // /^([1-9]\d*|[0])$/ 包含0
    var regMsg ="必须是数字,且为正整数";
    var planForm = $('#planForm');
    planForm.bootstrapValidator({
      excluded: [':disabled'],//不加它重新打开模态框时提示不会清除
      fields: {
       planTag1: {
          validators: {
            different: {
              field: 'planTag2,planTag3',
              message: '标签不能重复'
            },
            callback: {
              message: '计划标签不能为空',
              callback: function(value, validator) {
                return value!=0;
              }
            }
          }
        },
        planTag2: {
          validators: {
            different: {
              field: 'planTag1,planTag3',
              message: '标签不能重复'
            },
            callback: {
              message: '计划标签不能为空',
              callback: function (value, validator) {
                return value != 0;
              }
            }
          }
        },
        planTag3: {
          validators: {
            different: {
              field: 'planTag1,planTag2',
              message: '标签不能重复'
            },
            callback: {
              message: '计划标签不能为空',
              callback: function(value, validator) {
                return value!=0;
              }
            }
          }
        },
        stuNum: {
          validators: {
            notEmpty: {
              message: '学习基数不能为空!'
            },
            regexp: {
              regexp:reg,
              message: regMsg
            }
          }
        },
        stuMonthNum: {
          validators: {
            notEmpty: {
              message: '学习月数不能为空!'
            },
            regexp: {
              regexp:reg,
              message: regMsg
            }
          }
        }
      }
    });
    </shiro:hasPermission>
    //返回
    $('#back').unbind('click').click(function () {
      window.location.href = "/plan/manager";
    })
    //保存
    $('#save-base').unbind('click').click(function () {

      var t1 = $('#planTag1').val();
      var t2 = $('#planTag2').val();
      var t3 = $('#planTag3').val();

      if(t1==t2 | t1==t3 | t2==t3){
        BootstrapDialog.warning('标签重复,请重新选择');
        return;
      }

      var pass = planForm.data('bootstrapValidator').validate().isValid();//表单验证是否通过

      if(pass){
        $.ajax({
          url:"/plan/updatePlan",
          type:"post",
          dataType:"json",
          cache: false,
          data :planForm.serializeArray(),
          success: function (datas){
            if(datas.code == HttpUtil.success_code){
              window.location.href = "/plan/selectCourse/"+${plan.id};
            }
          }
        });
      }
    });

  });
</script>
</body>
</html>