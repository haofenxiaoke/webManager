<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" contentType="text/html; UTF-8" %>
<%@include file="/WEB-INF/view/include/taglib.jsp" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <title>${pname}管理系统-会员定价</title>
  <link href="${pageContext.request.contextPath}/resources/assets/plugins/DataTables/media/css/dataTables.bootstrap.min.css" rel="stylesheet" />
  <link href="${pageContext.request.contextPath}/resources/assets/plugins/DataTables/extensions/Select/css/select.bootstrap.min.css" rel="stylesheet" />
  <link href="${pageContext.request.contextPath}/resources/assets/plugins/bootstrap-daterangepicker/daterangepicker-bs3.css" rel="stylesheet" />
  <link href="${pageContext.request.contextPath}/resources/common/switch/css/bootstrap-switch.min.css" rel="stylesheet" />
  <link href="${path}/resources/assets/plugins/bootstrapValidator/css/bootstrapValidator.css" rel="stylesheet">
</head>
<body>
<div>
  <div class="row">
    <div class="col-md-10" style="width:100%;">
      <div class="panel panel-inverse">
        <div class="panel-heading">
          <div class="panel-heading-btn">
            <%--     <a href="javascript:;" class="btn btn-xs btn-icon btn-circle btn-default" data-click="panel-expand"><i class="fa fa-expand"></i></a>
                 <a href="javascript:;" class="btn btn-xs btn-icon btn-circle btn-warning" data-click="panel-collapse"><i class="fa fa-minus"></i></a>--%>
          </div>
          <h4 class="panel-title">会员定价</h4>
        </div>
        <div class="panel-body">
          <form id="saveForm" class="form-horizontal form-bordered" data-parsley-validate="true" method="post">
            <table id="vip-table" class="table table-striped table-bordered" width="100%">
              <thead>
              <tr>
                <th width="100"><div id="describle1">1个月</div></th>
                <th width="200">
                  <div class="form-group">
                    <input type="text"  class="form-control" id="name1" name="name1" placeholder="请输入金额" />
                    <input type="hidden" id="id1" name="id1">
                  </div>
                </th>
                <th>元</th>
              </tr>
              <tr>
                <th><div id="describle2">3个月</div></th>
                <th>
                  <div class="form-group">
                    <input type="text" class="form-control" id="name2" name="name2" placeholder="请输入金额"/>
                    <ul  class="parsley-errors-list filled">
                      <li name="ErrorTip" class="parsley-required"></li>
                    </ul>
                    <input type="hidden" id="id2" name="id2">
                  </div>
                </th>
                <th>元</th>
              </tr>
              <tr>
                <th ><div id="describle3">12个月</div></th>
                <th >
                  <div class="form-group">
                    <input type="text"  class="form-control" id="name3" name="name3" placeholder="请输入金额"/>
                    <input type="hidden" id="id3" name="id3">
                  </div>
                </th>
                <th>元</th>
              </tr>
              <shiro:hasPermission name="vip:save:0">
              <tr>
                <th colspan="3">
                  <div class="form-group">
                      <button type="button" data-toggle="modal" href="#user-create-alert"  class="btn btn-sm btn-primary m-r-5 btn-lg" id="saveVip" style="width: 80px;">确定</button>
                  </div>
                </th>
              </tr>
              </shiro:hasPermission>
              </thead>
            </table>
          </form>
        </div>

      </div>
    </div>
  </div>
</div>
<script src="${pageContext.request.contextPath}/resources/assets/plugins/DataTables/media/js/jquery.dataTables.js"></script>
<script src="${pageContext.request.contextPath}/resources/assets/plugins/DataTables/media/js/dataTables.bootstrap.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/assets/plugins/DataTables/extensions/Select/js/dataTables.select.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/assets/plugins/bootstrap-daterangepicker/moment.js"></script>
<script src="${pageContext.request.contextPath}/resources/assets/plugins/bootstrapValidator/js/bootstrapValidator.js"></script>
<script>
  //查询vip对应的价格
  $(document).ready(function() {
    $.ajax({
      url:"/vip/list",
      type:"post",
      dataType:"json",
      cache: false,
      success: function (datas){
        if(datas.code == HttpUtil.success_code){
          var result = datas.result;
          $.each(result,function(n,obj) {
            if(obj.days == 30){
              if(checkNotNull(obj.describle)){
                $('#describle1').html(obj.describle);
              }
              $("#id1").val(obj.id);
              $("#name1").val(obj.price);
            }
            if(obj.days == 90){
              if(checkNotNull(obj.describle)){
                $('#describle2').html(obj.describle);
              }
              $("#id2").val(obj.id);
              $("#name2").val(obj.price);
            }
            if(obj.days == 360){
              if(checkNotNull(obj.describle)){
                $('#describle3').html(obj.describle);
              }
              $("#id3").val(obj.id);
              $("#name3").val(obj.price);
            }
          });
        }
        if (datas.code == HttpUtil.error_code) {

        }
      }
    })
    //保存
    var saveForm = $("#saveForm");
    $("#saveVip").click(function() {
      var d = {};
      var pass = saveForm.data('bootstrapValidator').validate().isValid();//表单验证是否通过
      if (pass) {
        $.ajax({
          url: "/vip/save",
          type: "post",
          dataType: "json",
          cache: false,
          data: saveForm.serializeArray(),
          success: function (datas) {
            if (datas.code == HttpUtil.success_code) {
              window.location.reload();//刷新当前页面.
            }
          }
        })
      }
    });
      //验证是否为空
      function checkNotNull(obj){
        var flag = false;
        if(obj) flag =  true;
        return flag;
      }

    var emptyMsg ="不能为空";
    var reg = /^([1-9]\d*)$/; // /^([1-9]\d*|[0])$/ 包含0
    var regMsg ="必须是数字,且为正整数";
    saveForm.bootstrapValidator({
      fields: {
        name1: {
          validators: {
            notEmpty: {
              message: emptyMsg
            },
            regexp: {
              regexp:reg,
              message: regMsg
            }
          }
        },
        name2: {
          validators: {
            notEmpty: {
              message: emptyMsg
            },
            regexp: {
              regexp:reg,
              message: regMsg
            }
          }
        },
        name3: {
          validators: {
            notEmpty: {
              message: emptyMsg
            },
            regexp: {
              regexp:reg,
              message: regMsg
            }
          }
        }
      }
    });

  });
</script>
</body>
</html>