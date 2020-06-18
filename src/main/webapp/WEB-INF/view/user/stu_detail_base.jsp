<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" contentType="text/html; UTF-8" %>
<%@include file="/WEB-INF/view/include/taglib.jsp" %>
<div>
  <div class="row">
    <div class="col-md-10">
      <div class="panel panel-inverse">
        <!-- form表单 -->
        <div class="panel-body">
          <form class="form-horizontal" id="thresholdForm" >
            <div class="form-group">
              <label class="col-md-3 control-label">昵称：</label>
              <div class="col-md-9">
                <input type="hidden" id="id" name="id" value="${user_id}">
                <input id="username" name="username" type="text" class="form-control" style="width: 200px;"/>
              </div>
            </div>
            <div class="form-group">
              <label class="col-md-3 control-label">付费状态：</label>
              <div class="col-md-9">
                <div id="paystate" name="paystate" class="form-control-static"  style="width: 200px;"></div>
              </div>
            </div>
            <div class="form-group" id="expire" style="display:none;">
              <label class="col-md-3 control-label">到期时间：</label>
              <div class="col-md-9">
                <div id="duetime" name="duetime" class="form-control-static" style="width: 200px;"></div>
              </div>
            </div>
            <div class="form-group">
              <label class="col-md-3 control-label">注册时间：</label>
              <div class="col-md-9">
                <div id="registTime"  name="registTime" class="form-control-static" style="width: 200px;"></div>
              </div>
            </div>
            <div class="form-group">
              <label class="col-md-3 control-label">性别：</label>
              <div >
                <label class="checkbox-inline">
                  <input type="radio"  name="sex" id="optionsRadios1" value="0" checked> 男
                </label>
                <label class="checkbox-inline">
                  <input type="radio"  name="sex" id="optionsRadios2" value="1"> 女
                </label>
              </div>
            </div>
            <div class="form-group">
              <label class="col-md-3 control-label">生活地区：</label>
              <label class="col-md-3 control-label">
                  <select id="userProvince" name="userProvince" class="form-control" style="width: 200px;">
                    <option value="0">--请选择省份--</option>
                  </select>
              </label>
                 --城市--
              <label class="control-label">
                   <select id="userAddress" name="userAddress" class="form-control" style="width: 200px;" >
                     <option value="0">--请选择城市--</option>
                   </select>
              </label>
            </div>
            <div class="form-group">
              <label class="col-md-3 control-label">最高学历：</label>
              <div class="col-md-9">
                <select id="education" name="education" class="form-control" style="width: 200px;">
                  <option value="-1">--学历--</option>
                  <option value="1">本科</option>
                  <option value="2">专科</option>
                  <option value="3">高中</option>
                </select>
              </div>
            </div>
            <div class="form-group">
              <label class="col-md-3 control-label">职业：</label>
              <div class="col-md-9">
                <input id="profession" name="profession" type="text" class="form-control" style="width: 200px;"/>
              </div>
            </div>
            <div class="form-group">
              <label class="col-md-3 control-label">课程基础：</label>
              <div class="col-md-9">
                <select id="courseBasis" name="courseBasis" class="form-control" style="width: 200px;">
                  <option value="-1">--工作经验--</option>
                  <option value="0" selected>无经验</option>
                  <option value="1">1年经验</option>
                  <option value="2">3年经验</option>
                  <option value="3">3年以上</option>
                </select>
              </div>
            </div>
            <div class="form-group">
              <label class="col-md-3 control-label">QQ号：</label>
              <div class="col-md-9">
                <input id="qqNum" name="qqNum" type="text" class="form-control" style="width: 200px;"/>
              </div>
            </div>
            <div class="form-group">
              <label class="col-md-3 control-label">在线时长：</label>
              <div class="col-md-9">
                <label id="onlineTime"  name="onlineTime"  class="form-control-static" >33.5</label>
                <label>小时</label>
              </div>
            </div>
            <shiro:hasPermission name="stu:save:0">
            <div class="form-group">
              <div class="col-sm-offset-2 col-sm-10">
                <button id="save-base" type="button" class="btn btn-sm btn-primary m-r-5 btn-lg"  style="width: 80px;">保存</button>
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
<script src="${pageContext.request.contextPath}/resources/base/user/stu.js"></script>
<script src="${pageContext.request.contextPath}/resources/common/utils/js/china_area.js"></script>
<script>
  $(document).ready(function() {
    <shiro:hasPermission name="stu:find:0">

    //省份json
    $.each(provinceJson, function(k, p) {
      var option = "<option value='" + p.id + "'>" + p.province + "</option>";
      $("#userProvince").append(option);
    });

    //选择省份后级联城市
    $("#userProvince").change(function() {
      var selValue = $(this).val();
      $("#userAddress option:gt(0)").remove();
      $.each(cityJson, function(k, p) {
        // 直辖市处理.|| p.parent == selValue，直辖市为当前自己
        if (p.id == selValue || p.parent == selValue) {
          var option = "<option value='" + p.id + "'>" + p.city + "</option>";
          $("#userAddress").append(option);
        }
      });
    });
    ///加载用户信息
    $.ajax({
      url:"/stu/entity",
      type:"post",
      dataType:"json",
      cache: false,
      data :{id:${user_id}},
      success: function (datas){
        if(datas.code == HttpUtil.success_code){
          var selValue = datas.result.userProvince;
          $.each(cityJson, function(k, p) {
            // 直辖市默认值处理
            if (p.id == selValue || p.parent == selValue) {
              var option = "<option value='" + p.id + "'>" + p.city + "</option>";
              $("#userAddress").append(option);
            }
          });
          //填充form表单信息
          $.each(datas.result,function (aid,value) {
            $("#"+aid).val(value);
          })
          //性别
          $("input[type=radio][value="+datas.result.sex+"]").attr("checked",'checked');
          //付费状态
          $("#paystate").html(datas.result.isVIP?'已付费':'未付费');
          //到期时间
          if (datas.result.isVIP){
            $("#duetime").html(TimeObjectUtil.formatterDateTime(new Date(datas.result.vipExpireTime)));
            $('#expire').show();
          }
          //注册时间
          $("#registTime").html(TimeObjectUtil.formatterDateTime(new Date(datas.result.registTime)));
          //在线时长
          $("#onlineTime").html(parseInt(datas.result.onlineTime /(1000 *60 *60)));
        }
      }
    })

    //验证表单信息
    $('#thresholdForm').bootstrapValidator({
      fields: {
        username: {
          validators: {
            notEmpty: {
              message: '昵称不能为空!'
            }
          }
        },
        sex: {
          // which user cannot type in, such as radio, checkbox, select, etc.
          validators: {
            notEmpty: {
              message: '性别不能为空!'
            }
          }
        },
        userAddress: {
          validators: {
            notEmpty: {
              message: '所属地区不能为空!'
            }
          }
        },
        education: {
          validators: {
            notEmpty: {
              message: '教育程度不能为空!'
            }
          }
        },
        courseBasis: {
          validators: {
            notEmpty: {
              message: '课程基础不能为空!'
            }
          }
        },
        profession: {
          validators: {
            notEmpty: {
              message: '职位不能为空!'
            }
          }
        },
        qqNum: {
          validators: {
            notEmpty: {
              message: 'QQ号码不能为空!'
            },
            regexp: {
              regexp: /^[0-9]*$/,
              message: '格式错误'
            }
          }
        }
      }
    });
    </shiro:hasPermission>

    $('#save-base').unbind('click').click(function () {
      var pass = $('#thresholdForm').data('bootstrapValidator').validate().isValid();//表单验证是否通过
      if (pass){
          $.ajax({
            url:"/stu/update",
            type:"post",
            dataType:"json",
            cache: false,
            data :$('#thresholdForm').serializeArray(),
            success: function (datas){
              if(datas.code == HttpUtil.success_code){
                window.location.reload();
              }
            }
          })
      }
    });

  });
</script>