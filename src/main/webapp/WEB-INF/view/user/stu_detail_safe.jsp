<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" contentType="text/html; UTF-8" %>
<%@include file="/WEB-INF/view/include/taglib.jsp" %>
<div>
  <div class="row">
    <div class="col-md-10">
      <div class="panel panel-inverse">
        <!-- form表单 -->
        <div class="panel-body">
          <form class="form-horizontal" id="safeForm">
            <div class="form-group">
              <label class="col-md-3 control-label">修改密码：</label>
              <div class="col-md-9">
                <input type="hidden" id="id" name="id" value="${user_id}">
                <input id="password" name= "password" type="password" class="form-control" style="width: 200px;" autocomplete="off"/>
              </div>
            </div>
            <div class="form-group">
              <label class="col-md-3 control-label">再次输入：</label>
              <div class="col-md-9">
                <input id="rpassword" name="rpassword" type="password" class="form-control" style="width: 200px;" autocomplete="off"/>
              </div>
            </div>
            <div class="form-group">
              <label class="col-md-3 control-label">答疑权限：</label>
              <div >
                <label class="checkbox-inline">
                  <input type="radio"  name="isAnswer" id="optionsRadios1" value="1" checked> 启用
                </label>
                <label class="checkbox-inline">
                  <input type="radio"  name="isAnswer" id="optionsRadios2" value="0"> 禁用
                </label>
              </div>
            </div>
            <shiro:hasPermission name="stu:save:0">
            <div class="form-group">
              <div class="col-sm-offset-2 col-sm-10">
                <button type="button" class="btn btn-sm btn-primary m-r-5 btn-lg" onclick="updateSafe()" style="width: 80px;">保存</button>
              </div>
            </div>
            </shiro:hasPermission>
            <div class="modal fade" id="safe-alert">
              <div class="modal-dialog">
                <div class="modal-content">
                  <div class="panel panel-inverse">
                    <div class="panel-heading">
                      <div class="panel-heading-btn">
                        <button type="button" class="btn btn-xs btn-icon btn-circle btn-danger" data-dismiss="modal" aria-hidden="true"><i class="fa fa-times"></i></button>
                      </div>
                        <div class="panel-title">提示</div>
                    </div>
                  </div>
                  <div class="panel-body">
                    <div class="form-group">
                      <div id="htmlContent">
                        密码修改成功!
                      </div>
                    </div>
                  </div>
                </div>
              </div>
            </div>
          </form>
        </div>
        <!-- end -->
      </div>
    </div>
  </div>
</div>
<script src="${pageContext.request.contextPath}/resources/base/user/stu.js"></script>
<script>
  var safeForm = $("#safeForm");
  var safeAlert = $("#safe-alert");
  $(document).ready(function() {
    <shiro:hasPermission name="stu:find:0">
    //验证表单信息
    safeForm.bootstrapValidator({
      fields: {
        password: {
          validators: {
            notEmpty: {
              message: '密码不能为空!'
            },
            regexp: {
              regexp:/^.{6,18}$/,
              message: '密码长度为6~18位'
            }
          }
        },
        rpassword: {
          validators: {
            notEmpty: {
              message: '密码重复不能为空!'
            },
            regexp: {
              regexp: /^.{6,18}$/,
              message: '密码长度为6~18位'
            },
            identical: {
              field: 'password',
              message: '两次密码不同请重新输入'
            }
          }
        }
      }
    });

    </shiro:hasPermission>
  });

</script>