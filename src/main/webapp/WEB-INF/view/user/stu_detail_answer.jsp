<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" contentType="text/html; UTF-8" %>
<%@include file="/WEB-INF/view/include/taglib.jsp" %>
<div>
  <div class="row">
    <div class="col-md-10" style="width:100%;">
      <div class="panel panel-inverse">
        <!-- form表单 -->
        <div class="panel-body">
          <div class="panel-body">
            <table id="table-answer" class="table table-striped table-bordered" width="100%">
              <thead>
              <tr>
                <th></th>
                <th>课程</th>
                <th>节</th>
                <th>问题</th>
                <th>回复数量</th>
                <th>操作</th>
              </tr>
              </thead>
            </table>
          </div>
        </div>
        <!-- form表单 -->
      </div>
    </div>
  </div>
</div>
<%@include file="/WEB-INF/view/user/answer_dialog.jsp" %>
<script>
  //Tab页切换
  //加载列表
  var answerTable ;
  $(document).ready(function() {
    <shiro:hasPermission name="user:find:0">
    loaddatagrid();
    </shiro:hasPermission>
  });
  function loaddatagrid(){
    answerTable =  $('#table-answer').DataTable({
      bDestroy: true,
      searching:false,
      processing: true,
      serverSide: true,
      ordering:false, //排序
      ajax:{
        "url":"/stu/question/list",
        "type": "POST",
        "dataType":"json",
        "data":function(d){
          //查询 赋值传参
          d.userId=${user_id};
        }
      },
      columns: [
        { "data": "id",visible:false},//visible 隐藏或显示
        { "data": "courseTitle"},
        { "data": "lectureName"},
        { "data": "questions","render":function(data,type,row,meta){
          return type === 'display' && data.length > 100 ?
          '<span title="'+data+'">'+data.substr( 0, 100 )+'...</span>' :
                  data;
        }},
        { "data": "reply_num"},//answerNum
        { "data": null,"render":function(data,type,row,meta){
          if(null!=data){
            var btn = "" ;
            var param = "";
            <shiro:hasPermission name="stu:find:0">
            if(row.reply_num == 0) return btn;
            btn+='<button class="btn btn-sm btn-primary" onclick="viewDialog('+row.id+',${user_id});"  data-toggle="modal"   href="#answer-view-alert"    type="button">查看</button>';
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
        })
      }
    });

  }
</script>