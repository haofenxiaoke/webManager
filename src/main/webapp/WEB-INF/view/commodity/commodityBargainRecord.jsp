<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" contentType="text/html; UTF-8" %>
<%@include file="/WEB-INF/view/include/taglib.jsp" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <title>${pname}商品砍价发券记录</title>
  <link href="${pageContext.request.contextPath}/resources/assets/plugins/DataTables/media/css/dataTables.bootstrap.min.css" rel="stylesheet" />
  <link href="${pageContext.request.contextPath}/resources/assets/plugins/bootstrap-daterangepicker/daterangepicker-bs3.css" rel="stylesheet"/>
  <link href="${pageContext.request.contextPath}/resources/assets/plugins/DataTables/extensions/Select/css/select.bootstrap.min.css" rel="stylesheet" />
  <link href="${pageContext.request.contextPath}/resources/assets/plugins/bootstrap-datetimepicker/css/datetimepicker.css" rel="stylesheet"/>
  <link href="${pageContext.request.contextPath}/resources/common/switch/css/bootstrap-switch.min.css" rel="stylesheet" />

</head>
<body>
<div>
  <div class="row">
    <div class="col-md-10" style="width:100%;">
      <div class="panel panel-inverse">
        <div class="panel-heading">
          <h4 class="panel-title">商品砍价发券记录</h4>
        </div>
        <div id="myTabContent" class="tab-content">
          <div class="panel-body">
            <input type="hidden" id="categoryDirections" value="">
            <form class="form-inline" role="form">
              <div class="form-group m-r-10">
                <select style="width: 160px;height: 34px" name="directionId" class="form-control" id="directionId">
                  <option value="">请选择方向</option>
                  <c:forEach items="${categoryDirections}" var="direction">
                    <shiro:hasPermission name="commodity-bargain:view:${direction.id}">
                      <option value="${direction.id}">${direction.categoryDesc}</option>
                    </shiro:hasPermission>
                  </c:forEach>
                </select>
                <select style="width: 160px;height: 34px" name="industryId" class="form-control" id="industryId">
                  <option value="">请选择行业</option>
                </select>
                <input readonly="readonly" class="form-control" id="bargainSuccessTime"
                       placeholder="发放时间">
                <select style="width: 160px;height: 34px" name="ticketStatus" class="form-control" id="ticketStatus">
                  <option value="">兑换状态</option>
                  <option value="0">未兑换</option>
                  <option value="1">已兑换</option>
                </select>
                <input type="text" class="form-control" style="width:220px;" id="bargainer" name="bargainer"
                       placeholder="发放人"/>
                <input type="text" class="form-control" style="width:220px;" id="exchangeUserPhone"
                       name="exchangeUserPhone" placeholder="兑换人"/>
                <input type="text" class="form-control" style="width:220px;" id="code" name="code"
                       placeholder="课程券号"/>
                <select style="width: 160px;height: 34px" name="bargainStatus" class="form-control" id="bargainStatus">
                  <option value="">砍价状态</option>
                  <option value="0">进行中</option>
                  <option value="1">已完成</option>
                  <option value="2">已过期</option>
                </select>
                <div class="form-group m-r-10" style="margin-top:5px">
                  <input readonly="readonly" class="form-control" id="bargainTime"  style="width: 160px;height: 34px"
                         placeholder="砍价时间">
                  <button class="btn btn-success btn-sm m-r-5"  onclick="reloadTable()" type="button">搜索</button>
                  <shiro:hasPermission name="commodity-bargain:excel-export">
                    <button class="btn btn-success btn-sm m-r-5"  onclick="exportExcel()" type="button">导出</button>
                  </shiro:hasPermission>
                </div>
              </div>
            </form>
          </div>
          <div class="panel-body">
            <table id="table-1" class="table table-striped table-bordered" style="text-align: center" width="100%">
              <thead >
              <tr>
                <th style="text-align: center">序号</th>
                <th style="text-align: center">商品</th>
                <th style="text-align: center">方向</th>
                <th style="text-align: center">行业</th>
                <th style="text-align: center">砍价状态</th>
                <th style="text-align: center">砍价时间</th>
                <th style="text-align: center">课程券号</th>
                <th style="text-align: center">发放时间</th>
                <th style="text-align: center">砍价人</th>
                <th style="text-align: center">助力砍价人1</th>
                <th style="text-align: center">助力砍价人2</th>
                <th style="text-align: center">兑换状态</th>
                <th style="text-align: center">兑换人</th>
                <th style="text-align: center">有效期</th>
                <th style="text-align: center">操作</th>
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
<%--模态框--%>
<div class="modal fade"  id="course-modal">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="panel panel-inverse">
        <div class="panel-heading">
          <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
            &times;
          </button>
          <h4 class="panel-title">查看课程</h4>
        </div>
      </div>
      <div class="modal-body">
        <div class="panel-body">
          <form action="/" class="form-horizontal" data-parsley-validate="true" name="form-wizard" id="force-share-create" >
            <div class="form-group">
              <label class="col-md-3 control-label" id="courseDetail"></label>
            </div>
          </form>
        </div>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-sm btn-success" aria-hidden="true" data-dismiss="modal">取消</button>
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
<script  src="${pageContext.request.contextPath}/resources/assets/plugins/bootstrap-datetimepicker/js/locales/bootstrap-datetimepicker.zh-CN.js" charset="UTF-8"></script>
<script src="${pageContext.request.contextPath}/resources/common/switch/js/bootstrap-switch.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/common/utils/js/tool.date.js"></script>
<script src="${pageContext.request.contextPath}/resources/base/course/coursemanage.js"></script>
<script src="${pageContext.request.contextPath}/resources/common/utils/js/utils.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/commodity/commodityBargainRecord.js"></script>
<script>
    //加载列表
    function loadDataGrid(){
        commodityTable =  $("#table-1").DataTable({
            select:true, //是否选中
            autoWidth:false,
            deferRender:true,
            bRetrieve:true,
            responsive: true,
            searching:false, //是否开启搜索
            pagingType:"full_numbers",//分页类型 full_numbers显示所有分页信息
            processing:false, //是否显示处理状态
            serverSide:true, //是否开启服务器模式
            ordering:false, //排序

            aLengthMenu:[10,20,50,100], //下拉框每页显示数量
            //scrollX:true,
            ajax: {
                "url": "/commodityBargain/page",
                "type": "POST",
                "dataType": "json",
                "data": function (d) {
                    //查询 赋值传参
                    d.directionId = $("#directionId").val();
                    d.industryId = $("#industryId").val();
                    d.bargainSuccessTime = $("#bargainSuccessTime").val();
                    d.ticketStatus = $("#ticketStatus").val();
                    d.bargainer = $("#bargainer").val();
                    d.exchangeUserPhone = $("#exchangeUserPhone").val();
                    d.code = $("#code").val();
                    d.bargainStatus = $("#bargainStatus").val();
                    d.bargainTime = $("#bargainTime").val();
                }
            },
            columns: [
                {"data": null},//visible 隐藏或显示
                {"data": "commodityName"},
                {"data": "directionName"},
                {"data": "industryName"},
                {
                    render: function (data, type, row, meta) {
                        if (row.status == 0) {
                            return '进行中';
                        } else if (row.status == 1) {
                            return '已完成';
                        } else {
                            return '已过期';
                        }
                    }
                },
                {"data": function (obj) {
                        return obj.bargainBeginTime == null ? "-":formatDate(obj.bargainBeginTime);
                    }
                },
                {"data": function (obj) {
                        return  obj.code == null ? "-" : obj.code
                    }
                },
                {"data": function (obj) {
                        return obj.bargainSuccessTime == null ? "-":formatDate(obj.bargainSuccessTime);
                    }
                },
                {"data": "bargainer"},
                {
                    render: function (data, type, row, meta) {
                        var helpers = row.bargainHelpers
                        if(!helpers){
                            return '-';
                        }
                        helpers = JSON.parse(helpers);
                        if (helpers.length > 1) {
                            return helpers[1].mobile;
                        } else {
                            return '-';
                        }
                    }
                },
                {
                    render: function (data, type, row, meta) {
                        var helpers = row.bargainHelpers
                        if(!helpers){
                            return '-';
                        }
                        helpers = JSON.parse(helpers);
                        if (helpers.length > 2) {
                            return helpers[2].mobile;
                        } else {
                            return '-';
                        }
                    }
                },
                {
                    render: function (data, type, row, meta) {
                        if (row.ticketStatus == 1) {
                            return '已兑换';
                        }
                        if (row.ticketStatus == 0) {
                            return '未兑换';
                        }
                        return '-';
                    }
                },
                {"data": function (obj) {
                        return  obj.exchangeUserPhone == null ? "-" : obj.exchangeUserPhone
                    }
                },
                {
                    render: function (data, type, row, meta) {
                        if (null != row.validityBeginTime && null != row.validityEndTime) {
                            return formatDate(row.validityBeginTime,1) + "-" +'</br>'+ formatDate(row.validityEndTime,1);
                        } else {
                            return '-';
                        }

                    }
                },
                { "data": null,"render":function(data,type,row,meta){
                        if(null!=data){
                            var btn = "" ;
                            <shiro:hasPermission name="course:find" >
                              btn+= '<button class="btn btn-info m-r-5 m-b-5" data-toggle="modal" onclick="showCourse('+row.industryId+')" type=\"button\">查看课程</button>'
                            </shiro:hasPermission>;
                            return btn;
                        }
                    }
                }
            ],
            columnDefs:[
                {className: "dt-body-center", "targets": "_all"},
                {
                    "targets": [14],
                    "render":function(data,type,row,meta){
                        if(data == null){
                            return "无数据";
                        }
                        return TimeObjectUtil.formatterDateTime(new Date(data))
                    }
                }
            ],
            aoColumnDefs : [
                {
                    "aTargets" :　[1],  //指定列
                    "sWidth": "10%" //宽度
                },
                {
                    "aTargets" :　["_all"],  //指定列
                    "sClass" : "right"
                }
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
                })
            }
        });
    }
</script>
</body>
</html>
