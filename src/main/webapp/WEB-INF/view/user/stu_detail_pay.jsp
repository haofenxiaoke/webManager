<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" contentType="text/html; UTF-8" %>
<%@include file="/WEB-INF/view/include/taglib.jsp" %>
<div>
  <div class="row">
    <div class="col-md-10" style="width:100%;">
      <div class="panel panel-inverse">
        <!-- 列表 -->
        <div class="panel-body">
          <div class="panel-body">
            <table id="table-pay" class="table table-striped table-bordered" width="100%">
              <thead>
              <tr>
                <th></th>
                <th>订单号</th>
                <th>会员期限</th>
                <th>购买日期</th>
              </tr>
              </thead>
            </table>
          </div>
        </div>
        <!-- 列表 -->
      </div>
    </div>
  </div>
</div>
<script>
  //Tab页切换
  //加载列表
  var payTable ;
  $(document).ready(function() {
    <shiro:hasPermission name="stu:find:0">
    loaddatagrid();
    </shiro:hasPermission>
  });
  function loaddatagrid(){
    payTable =  $('#table-pay').DataTable({
      bDestroy: true,
      searching:false,
      processing: true,
      serverSide: true,
      ordering:false, //排序
      ajax:{
        "url":"/stu/vip/list",
        "type": "POST",
        "dataType":"json",
        "data":function(d){
          //查询 赋值传参
          d.userId=${user_id};
        }
      },
      columns: [
        { "data": "id",visible:false},//visible 隐藏或显示
        { "data": "order_num"},
        { "data": "vipTerm"},
        { "data": "pay_time"},
      ],
      columnDefs:[
        {className: "dt-body-center", "targets": "_all"},
        {
          "targets": [3],
          "render":function(data,type,row,meta){
            if(data == null){
              return "无登录";
            }
            return TimeObjectUtil.formatterDateTime(new Date(data))
          }
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