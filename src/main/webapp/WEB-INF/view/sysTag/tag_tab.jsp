<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" contentType="text/html; UTF-8" %>
<%@include file="/WEB-INF/view/include/taglib.jsp" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <title>${pname}管理系统-标签管理Tab选项卡</title>
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
            <button type="button" class="btn btn-xs btn-info m-r-5" onclick="javascript:history.back(-1);">返回</button>
          </div>
          <h4 class="panel-title">标签管理-${cateDesc}</h4>
        </div>
       <%--tab页面start--%>
        <ul id="myTab" class="nav nav-tabs">
          <li class="active"><a href="#tab_1" data-type="1" data-toggle="tab">适合对象</a></li>
          <li><a href="#tab_2" data-type="2" data-toggle="tab">课程优势</a></li>
          <li><a href="#tab_3" data-type="3" data-toggle="tab"><c:choose><c:when test="${pid == 'kjs'}">会计</c:when><c:when test="${pid == 'sjn'}">设计</c:when></c:choose>薪资</a></li>
        </ul>
        <div id="myTabContent" class="tab-content">
          <div class="panel-body">
            <form class="form-inline">
              <shiro:hasPermission name="tag:save:0">
              <button type="button" data-toggle="modal" href="#tag-create-alert"  class="btn btn-sm btn-info m-r-5" id="create_position">增加标签</button>
              </shiro:hasPermission>
            </form>
          </div>
          <div class="panel-body">
            <table id="tag-tab-table" class="table table-striped table-bordered" width="100%">
              <thead>
              <tr>
                <th></th>
                <th></th>
                <th>名称</th>
                <th>关联课程</th>
                <th>操作</th>
              </tr>
              </thead>
            </table>
          </div>
          <!-- tab页面end-->
        </div>
      </div>
    </div>
  </div>
</div>
<!-- 弹框 -->
<div class="modal fade" id="tag-create-alert">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="panel panel-inverse">
        <div class="panel-heading">
          <div class="panel-heading-btn">
            <button type="button" class="btn btn-danger btn-xs" data-dismiss="modal" aria-hidden="true">×</button>
          </div>
          <div class="panel-title">添加标签</div>
        </div>
      </div>
      <div class="panel-body">
        <form id="tagForm" class="form-horizontal">
          <div class="form-group">
            <label class="col-md-2 control-label">标签名称*</label>
            <div class="col-md-9">
              <input name="content1" type="text" class="form-control" maxlength="20"/>
            </div>
          </div>
          <div class="form-group">
            <label class="col-md-2 control-label">标签名称*</label>
            <div class="col-md-9">
              <input name="content2" type="text" class="form-control" maxlength="20"/>
            </div>
          </div>
          <div class="form-group">
            <label class="col-md-2 control-label">标签名称*</label>
            <div class="col-md-9">
              <input name="content3" type="text" class="form-control" maxlength="20"/>
            </div>
          </div>
          <div class="form-group">
            <label class="col-md-2 control-label">标签名称*</label>
            <div class="col-md-9">
              <input name="content4" type="text" class="form-control" maxlength="20"/>
            </div>
          </div>
          <div class="form-group">
            <label class="col-md-2 control-label">标签名称*</label>
            <div class="col-md-9">
              <input name="content5" type="text" class="form-control" maxlength="20"/>
            </div>
          </div>
          <div class="form-group">
            <label class="col-md-2 control-label">标签名称*</label>
            <div class="col-md-9">
              <input name="content6" type="text" class="form-control" maxlength="20"/>
            </div>
          </div>
          <div class="form-group">
            <label class="col-md-2 control-label">标签名称*</label>
            <div class="col-md-9">
              <input name="content7" type="text" class="form-control" maxlength="20"/>
            </div>
          </div>
          <div class="form-group">
            <label class="col-md-2 control-label">标签名称*</label>
            <div class="col-md-9">
              <input name="content8" type="text" class="form-control" maxlength="20"/>
            </div>
          </div>
          <div class="form-group">
            <label class="col-md-2 control-label">标签名称*</label>
            <div class="col-md-9">
              <input name="content9" type="text" class="form-control" maxlength="20"/>
            </div>
          </div>
          <div class="form-group">
            <label class="col-md-2 control-label">标签名称*</label>
            <div class="col-md-9">
              <input name="content10" type="text" class="form-control" maxlength="20"/>
            </div>
          </div>
        </form>
      </div>
      <div class="modal-footer">
        <a id="close" href="javascript:;" class="btn btn-sm btn-info" data-dismiss="modal">关闭</a>
        <a id="saveTag"  href="javascript:;" class="btn btn-sm btn-success">保存</a>
      </div>
    </div>
  </div>
</div>
<div class="modal fade" id="tag-update-alert">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="panel panel-inverse">
        <div class="panel-heading">
          <div class="panel-heading-btn">
            <button type="button" class="btn btn-danger btn-xs" data-dismiss="modal" aria-hidden="true">×</button>
          </div>
          <div class="panel-title">改名</div>
        </div>
      </div>
      <div class="panel-body">
        <form id="updateTagForm" class="form-horizontal">
          <input type="hidden" id="id">
          <div class="form-group">
            <label class="col-md-3 control-label">标签名称*</label>
            <div class="col-md-9">
              <input id="update_content" type="text" class="form-control" maxlength="20"/>
              <ul  class="parsley-errors-list filled">
                <li name="ErrorTip" class="parsley-required"></li>
              </ul>
            </div>
          </div>
        </form>
      </div>
      <div class="modal-footer">
        <a id="update_close" href="javascript:;" class="btn btn-sm btn-info" data-dismiss="modal">关闭</a>
        <a id="update_saveTag"  href="javascript:;" class="btn btn-sm btn-success">保存</a>
      </div>
    </div>
  </div>
</div>
<!-- 弹框 -->
<%@include file="/WEB-INF/view/sysTag/tag_tab_dialog.jsp" %>
<script src="${pageContext.request.contextPath}/resources/assets/plugins/DataTables/media/js/jquery.dataTables.js"></script>
<script src="${pageContext.request.contextPath}/resources/assets/plugins/DataTables/media/js/dataTables.bootstrap.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/assets/plugins/DataTables/extensions/Select/js/dataTables.select.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/assets/plugins/bootstrap-daterangepicker/moment.js"></script>
<script src="${pageContext.request.contextPath}/resources/assets/plugins/bootstrap-daterangepicker/daterangepicker.js"></script>
<script src="${pageContext.request.contextPath}/resources/assets/plugins/bootstrapValidator/js/bootstrapValidator.js"></script>
<script src="${pageContext.request.contextPath}/resources/common/switch/js/bootstrap-switch.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/common/utils/js/tool.date.js"></script>
<script src="${pageContext.request.contextPath}/resources/base/sysTag/tag.js"></script>
<script>
  var tagTable ;
  var directionId = ${directionId};
  var tagType = $('#myTab a:first').attr("data-type");//默认的类型
  //Tab页切换
  $(function(){
    //初始化 默认第1项
    $('#myTab a:first').tab('show');
    loadDataGrid();
    $('a[data-toggle="tab"]').on('show.bs.tab', function (e) {
      $("form input").val("");
      tagType = $(this).attr("data-type");
      tagTable.ajax.reload();
    });

    //验证表单信息
    var reg = /^[\u4e00-\u9fa5a-zA-Z0-9]+$/;
    var regmessage = "只能输入中文、字母、数字";
    var difregmessage = "标签名称不能重复";
    var callbackMessage = "此标签已存在！";
    $('#tagForm').bootstrapValidator({
      fields: {
        content1: {
          validators: {
            /*notEmpty: {
              message: '不能为空'
            },*/
            regexp: {
              regexp: reg,
              message: regmessage
            },
            callback: {
              callback: function(value, validator) {
                var parm = {"content": value,"directionId":directionId};
                var flag = checkDesc(parm);
                if(!value) flag = true;
                console.log(flag+"-"+value);
                return flag;
              },
              message: callbackMessage
            },
            different:{
              field: 'content2,content3,content4,content5,content6,content7,content8,content9,content10',
              message: difregmessage
            }
          }
        },
        content2: {
          validators: {
            regexp: {
              regexp: reg,
              message: regmessage
            },
            callback: {
              callback: function(value, validator) {
                var flag = true;
                if(value) {
                  var parm = {"content": value,"directionId":directionId};
                  flag = checkDesc(parm);
                }
                console.log(flag+"-"+value);
                return flag;
              },
              message: callbackMessage
            },
            different:{
              field: 'content1,content3,content4,content5,content6,content7,content8,content9,content10',
              message: difregmessage
            }
          }
        },
        content3: {
          validators: {
            regexp: {
              regexp: reg,
              message: regmessage
            },
            callback: {
              callback: function(value, validator) {
                var flag = true;
                if(value) {
                  var parm = {"content": value,"directionId":directionId};
                  flag = checkDesc(parm);
                }
                console.log(flag+"-"+value);
                return flag;
              },
              message: callbackMessage
            },
            different: {
              field: 'content1,content2,content4,content5,content6,content7,content8,content9,content10',
              message: difregmessage
            }
          }
        },
        content4: {
          validators: {
            regexp: {
              regexp: reg,
              message: regmessage
            },
            callback: {
              callback: function(value, validator) {
                var flag = true;
                if(value) {
                  var parm = {"content": value,"directionId":directionId};
                  flag = checkDesc(parm);
                }
                console.log(flag+"-"+value);
                return flag;
              },
              message: callbackMessage
            },
            different:{
              field: 'content1,content2,content3,content5,content6,content7,content8,content9,content10',
              message: difregmessage
            }
          }
        },
        content5: {
          validators: {
            regexp: {
              regexp: reg,
              message: regmessage
            },
            callback: {
              callback: function(value, validator) {
                var flag = true;
                if(value) {
                  var parm = {"content": value,"directionId":directionId};
                  flag = checkDesc(parm);
                }
                return flag;
              },
              message: callbackMessage
            },
            different: {
              field: 'content1,content2,content3,content4,content6,content7,content8,content9,content10',
              message: difregmessage
            }
          }
        },
        content6: {
          validators: {
            regexp: {
              regexp: reg,
              message: regmessage
            },
            callback: {
              callback: function(value, validator) {
                var flag = true;
                if(value) {
                  var parm = {"content": value,"directionId":directionId};
                  flag = checkDesc(parm);
                }
                console.log(flag+"-"+value);
                return flag;
              },
              message: callbackMessage
            },
            different: {
              field: 'content1,content2,content3,content4,content5,content7,content8,content9,content10',
              message: difregmessage
            }
          }
        },
        content7: {
          validators: {
            regexp: {
              regexp: reg,
              message: regmessage
            },
            callback: {
              callback: function(value, validator) {
                var flag = true;
                if(value) {
                  var parm = {"content": value,"directionId":directionId};
                  flag = checkDesc(parm);
                }
                console.log(flag+"-"+value);
                return flag;
              },
              message: callbackMessage
            },
            different: {
              field: 'content1,content2,content3,content4,content5,content6,content8,content9,content10',
              message: difregmessage
            }
          }
        },
        content8: {
          validators: {
            regexp: {
              regexp: reg,
              message: regmessage
            },
            callback: {
              callback: function(value, validator) {
                var flag = true;
                if(value) {
                  var parm = {"content": value,"directionId":directionId};
                  flag = checkDesc(parm);
                }
                console.log(flag+"-"+value);
                return flag;
              },
              message: callbackMessage
            },
            different: {
              field: 'content1,content2,content3,content4,content5,content6,content7,content9,content10',
              message: difregmessage
            }
          }
        },
        content9: {
          validators: {
            regexp: {
              regexp: reg,
              message: regmessage
            },
            callback: {
              callback: function(value, validator) {
                var flag = true;
                if(value) {
                  var parm = {"content": value,"directionId":directionId};
                  flag = checkDesc(parm);
                }
                console.log(flag+"-"+value);
                return flag;
              },
              message: callbackMessage
            },
            different: {
              field: 'content1,content2,content3,content4,content5,content6,content7,content8,content10',
              message: difregmessage
            }
          }
        },
        content10: {
          validators: {
            regexp: {
              regexp: reg,
              message: regmessage
            },
            callback: {
              callback: function(value, validator) {
                var flag = true;
                if(value) {
                  var parm = {"content": value,"directionId":directionId};
                  flag = checkDesc(parm);
                }
                console.log(flag+"-"+value);
                return flag;
              },
              message: callbackMessage
            },
            different:{
              field: 'content1,content2,content3,content4,content5,content6,content7,content8,content9',
              message: difregmessage
          }
          }
        }
      }
    });

  });
  //加载列表
  function loadDataGrid(){
    tagTable =  $("#tag-tab-table").DataTable({
      bDestroy: true,
      searching:false,
      processing: true,
      serverSide: true,
      ordering:false, //排序
      paging:true,
      ajax:{
        "url":"/tag/list",
        "type": "POST",
        "dataType":"json",
        "data":function(d){
          //查询 赋值传参
          d.type=tagType;
          d.directionId = ${directionId};
        }
      },
      columns: [
        { "data": null},
        { "data":"id","visible":false},//visible 隐藏或显示
        { "data": "content"},
        { "data": "courseNum", "render":function(data,type,row,meta){
          return data == null?0+"个":data+"个";
        }
        },
        { "data": null,"render":function(data,type,row,meta){
          if(null!=data){
            var btn = "" ;
            <shiro:hasPermission name="tag:find:0">
            if(tagType == 3){
              btn+='<button class="btn btn-sm btn-primary m-r-5 m-b-5" data-toggle="modal"  onclick="getVideoInfo('+row.id+','+tagType+',\'#table-2\');" href="#tag-plan-alert"  type="button">查看</button>';
            }else{
              btn+='<button class="btn btn-sm btn-primary m-r-5 m-b-5" data-toggle="modal"  onclick="getVideoInfo('+row.id+','+tagType+',\'#table-1\');" href="#tag-video-alert"  type="button">查看</button>';
            }
            </shiro:hasPermission>
            <shiro:hasPermission name="tag:update:0">
            btn+='<button class="btn btn-sm btn-warning  m-r-5 m-b-5" onclick="updateTagDialog('+row.id+');"  data-toggle="modal"   href="#tag-update-alert"    type="button">改名</button>';
            </shiro:hasPermission>
            <shiro:hasPermission name="tag:delete:0">
            btn+='<button onclick="deleteTag('+row.id+');" class="btn btn-sm btn-danger m-r-5 m-b-5"  type="button"/>删除</button>';
            </shiro:hasPermission>
            return btn;
          }
        }},
      ],
      language:{
        lengthMenu: "每页 _MENU_ 条记录",//下拉框文字
        info:"第 _PAGE_ 页 ( 总共 _PAGES_ 页 ,共 _TOTAL_ 项)",//左下角显示文字
        infoEmpty:"",//当查询没有数据时左下角显示文字
        sEmptyTable:"没有数据..",//当查询没有数据时表格中间显示文字
        paginate:{                          //分页
          first:"首页",
          last:"尾页",
          next:"下一页",
          previous:"上一页"
        }
      },
      //设置第一列为自增列
      drawCallback: function(settings){
        n = this.api().page.info().start;
        this.api().column(0).nodes().each(function(cell,i){
          cell.innerHTML = ++n;
//          cell.style.width = "20px";
        })
      }
    });
  }

</script>
</body>
</html>