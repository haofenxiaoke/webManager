<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" contentType="text/html; UTF-8" %>
<%@include file="/WEB-INF/view/include/taglib.jsp" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <title>${pname}管理系统-分类管理</title>
  <link href="${pageContext.request.contextPath}/resources/assets/plugins/DataTables/media/css/dataTables.bootstrap.min.css" rel="stylesheet" />
  <link href="${pageContext.request.contextPath}/resources/assets/plugins/DataTables/extensions/Select/css/select.bootstrap.min.css" rel="stylesheet" />
  <link href="${pageContext.request.contextPath}/resources/assets/plugins/bootstrap-daterangepicker/daterangepicker-bs3.css" rel="stylesheet" />
  <link href="${pageContext.request.contextPath}/resources/common/switch/css/bootstrap-switch.min.css" rel="stylesheet" />
  <link href="${pageContext.request.contextPath}/resources/css/cate_tab.css" rel="stylesheet" />
		<style>
		
	</style>
	
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
          <h4 class="panel-title">分类管理-${directionDesc}</h4>
        </div>
       <%--tab页面start--%>
        <ul id="myTab" class="nav nav-tabs">
          <c:if test="${pid=='kjs'}">
               <li><a href="#tab_industry" data-type="industry" data-url="/industry/list" data-toggle="tab">${cate2}</a></li>
          </c:if>
            <li ><a class="active" href="#tab_position" data-type="position" data-url="/position/list" data-toggle="tab">${cate3}</a></li>

        </ul>
        <div id="myTabContent" class="tab-content">
          <div class="tab-pane fade in active" id="tab_position">
            <div class="panel-body">
              <form class="form-inline">
                <button type="button" data-toggle="modal" href="#position-create-alert"  class="btn btn-sm btn-info m-r-5" id="create_position" onclick="addCateDialog('position');">增加${cate3}</button>
              </form>
            </div>
            <!-- 职位 -->
            <div class="panel-body">
              <table id="position" class="table table-striped table-bordered" width="100%">
                <thead>
                <tr>
                  <th></th>
                  <th>${cate3}</th>
                  <th>操作</th>
                </tr>
                </thead>
              </table>
            </div>
          </div>
          <div class="tab-pane fade" id="tab_industry">
            <div class="panel-body">
                <form class="form-inline">
                  <button type="button" data-toggle="modal" href="#position-create-alert"  class="btn btn-sm btn-info m-r-5" id="create_industry" onclick="addCateDialog('industry');">增加${cate2}</button>
                </form>
              </div>
              <!-- 行业 -->
            <div class="panel-body">
              <table id="industry" class="table table-striped table-bordered" width="100%">
                <thead>
                <tr>
                  <th></th>
                  <th>${cate2}</th>
                  <th>操作</th>
                </tr>
                </thead>
              </table>
            </div>
          </div>
        </div>
       <%-- tab页面end--%>
      </div>
    </div>
  </div>
</div>
<%@include file="/WEB-INF/view/category/tab_dialog.jsp" %>


<script src="${pageContext.request.contextPath}/resources/assets/plugins/DataTables/media/js/jquery.dataTables.js"></script>
<script src="${pageContext.request.contextPath}/resources/assets/plugins/DataTables/media/js/dataTables.bootstrap.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/assets/plugins/DataTables/extensions/Select/js/dataTables.select.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/assets/plugins/bootstrap-daterangepicker/moment.js"></script>
<script src="${pageContext.request.contextPath}/resources/assets/plugins/bootstrap-daterangepicker/daterangepicker.js"></script>
<script src="${pageContext.request.contextPath}/resources/common/switch/js/bootstrap-switch.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/common/utils/js/tool.date.js"></script>
<script src="${pageContext.request.contextPath}/resources/base/category/cate.js"></script>

<script src="${pageContext.request.contextPath}/resources/js/commodity/jquery.cxcalendar.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/commodity/jquery.cxcalendar.languages.js"></script>
<%-- <script src="${pageContext.request.contextPath}/resources/js/commodity/jquery.cxcalendar.min.js"></script>  --%>
<script>
  var pid ='${pid}';
  var directionId = ${directionId};
  var tableId = $('#myTab a:first').attr("data-type");
  var loadurl=$('#myTab a:first').attr("data-url");
  //Tab页切换
  $(function(){
    $('#myTab a:first').tab('show');
    loaddatagrid();//初始化 默认第1项
    $('a[data-toggle="tab"]').on('show.bs.tab', function (e) {
      tableId = $(this).attr("data-type");
      loadurl = $(this).attr("data-url");
      //切换加载
//      cateTable.ajax.reload();
      loaddatagrid();//初始化 默认第1项
    });

    //向上、向下
    $("#position").on('click', 'a', function () {
      var order_type = $(this).attr("data-type");
      var current_row = $(this).parents('tr');
      var dataobj = cateTable.row(current_row);
      var first_id =dataobj.data().id;
      var first_orderNum =dataobj.data().orderNum;

      var last_num;
      if(order_type == 'up'){
        if(Number(dataobj[0]) == 0){
          cateTable.ajax.reload();//刷新
          return;
        }
        last_num = Number(dataobj[0])-1;
      }else{
        last_num = Number(dataobj[0])+1;
      }
      var data = cateTable.row(last_num).data()

      // alert((order_type == 'up')+"前行："+first_id+"--"+first_orderNum+"--后："+data.id+"--"+data.orderNum);
      var datas = {"firstid": first_id, "firstnum": data.orderNum,"lastid": data.id, "lastnum": first_orderNum};
      orderBy(datas,"position");
    } );

    //行业排序
    $("#industry").on('click', 'a', function () {
      var order_type = $(this).attr("data-type")
      var current_row = $(this).parents('tr');
      var dataobj = cateTable.row(current_row);
      var first_id =dataobj.data().id;
      var first_orderNum =dataobj.data().orderNum;

      var last_num;
      if(order_type == 'up'){
        if(Number(dataobj[0]) == 0){
          cateTable.ajax.reload();//刷新
          return;
        }
        last_num = Number(dataobj[0])-1;
      }else{
        last_num = Number(dataobj[0])+1;
      }
      var data = cateTable.row(last_num).data()

      // alert((order_type == 'up')+"前行："+first_id+"--"+first_orderNum+"--后："+data.id+"--"+data.orderNum);
      var datas = {"firstid": first_id, "firstnum": data.orderNum,"lastid": data.id, "lastnum": first_orderNum};
      orderBy(datas,"industry");
    } );

  });

  //职业排序
  function orderByOn(){
    var order_type = $(this).attr("data-type");
    var current_row = $(this).parents('tr');
    var dataobj = cateTable.row(current_row);
    var first_id =dataobj.data().id;
    var first_orderNum =dataobj.data().orderNum;

    var last_num;
    if(order_type == 'up'){
      if(Number(dataobj[0]) == 0){
        cateTable.ajax.reload();//刷新
        return;
      }
      last_num = Number(dataobj[0])-1;
    }else{
      last_num = Number(dataobj[0])+1;
    }
    var data = cateTable.row(last_num).data()

    // alert((order_type == 'up')+"前行："+first_id+"--"+first_orderNum+"--后："+data.id+"--"+data.orderNum);
    var datas = {"firstid": first_id, "firstnum": data.orderNum,"lastid": data.id, "lastnum": first_orderNum};
    return datas;
  }

  //加载列表
  var cateTable ;
  function loaddatagrid(){
    cateTable =  $('#'+tableId).DataTable({
      bDestroy: true,
      searching:false,
      processing: true,
      serverSide: true,
      ordering:false, //排序
      paging:false,
      ajax:{
        "url":loadurl,
        "type": "POST",
        "dataType":"json",
        "data":function(d){
        	console.log(d)
          d.directionId=directionId;
        }
      },
      columns: [
        { "data": "id","visible":false},//visible 隐藏或显示
        { "data": "categoryDesc"},
        { "data": null,"render":function(data,type,row,meta){
          if(null!=data){
            var btn = "" ;
            <shiro:hasPermission name="cate:update:0">
            btn+='<button class="btn btn-sm btn-warning  m-r-5 m-b-5 edit" onclick="updateCateDialog('+row.id+',\''+tableId+'\');"  data-toggle="modal"   href="#position-create-alert"    type="button">编辑</button>';
            </shiro:hasPermission>
            <shiro:hasPermission name="cate:delete:0">
            btn+='<button onclick="deleteCate(\''+tableId+'\','+row.id+');" class="btn btn-sm btn-danger m-r-5 m-b-5"  type="button" status = "'+row.industryNum+'"/>删除</button>';
            </shiro:hasPermission>
            <shiro:hasPermission name="cate:up:0">
            btn+='<a class="btn btn-sm btn-info m-r-5 m-b-5" data-type="up" type="button">向上</a>';
            </shiro:hasPermission>
            <shiro:hasPermission name="cate:down:0">
            btn+='<a class="btn btn-sm btn-info m-r-5 m-b-5" data-type="down"  type="button">向下</a>';
            </shiro:hasPermission>
            return btn;
          }
        }},
      ],
      language:{
        lengthMenu: "每页 _MENU_ 条记录",//下拉框文字
        info:"",//左下角显示文字
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
  
  //日历
	 $('#time').cxCalendar({
            wday: 0
        })
  
  // 编辑
var position = document.getElementById('position')
var industry = document.getElementById('industry')
var create_industry = document.getElementById('create_industry')
var create_position = document.getElementById('create_position')
position.addEventListener('click', clickP, false)
industry.addEventListener('click', clickI, false)
create_industry.addEventListener('click', clickI, false)
create_position.addEventListener('click', clickI, false)
var paramType = document.getElementById('paramType')
var pt = document.getElementById('pt')
var bpt = document.getElementById('bpt')
function clickP (e) {
		 var isEdit = e.target.className.indexOf('edit') > -1;
		 console.log(isEdit)
		 if(isEdit) {
			console.log(1)
		 	pt.classList.add('dp')
		 	bpt.classList.remove('dp')
	}
  }
  function clickI (e) {
		  var isEdit = e.target.className.indexOf('edit') > -1;
			console.log('lal')
			 pt.classList.remove('dp')
			 bpt.classList.add('dp')
  }

//输入框是否可以输入
var time_open = document.getElementById('time_open')
var time = document.getElementById('time')
var tishi = document.getElementById('tishi')

var zixun = document.getElementById('zixun')
var zixun_mingcheng = document.getElementsByClassName('zixun_mingcheng')
var zixun_lianjie = document.getElementsByClassName('zixun_lianjie')

time_open.addEventListener('click', open_time, false)
zixun.addEventListener('click', open_zixun, false)
function open_time () {
	if(time_open.checked == true) {
		console.log("true")
		time.removeAttribute('disabled')
		tishi.removeAttribute('disabled')
		
	} else {
		console.log("false")
		time.setAttribute("disabled",true)
		tishi.setAttribute("disabled",true)
	}
}

function open_zixun () {
	if(zixun.checked == true) {
		console.log("true")
		
		for(var i = 0; i < zixun_lianjie.length; i++) {
			zixun_mingcheng[i].removeAttribute('disabled')
			zixun_lianjie[i].removeAttribute('disabled')
		}
		
		
	} else {
		console.log("false")
		
		for(var i = 0; i < zixun_lianjie.length; i++) {
			zixun_mingcheng[i].setAttribute("disabled",true)
		zixun_lianjie[i].setAttribute("disabled",true)
		}
	}
}

// 咨询拼接

var jia = document.getElementById('jia')
var ziArr = document.getElementById('zixunArr')
var count_num = document.getElementById('count_num')
jia.addEventListener('click', add_zixun, false)
ziArr.addEventListener('click', del_zixun,false)
var arr = []
var count = []
var cou = 0
function add_zixun () {
	if(zixun.checked == false) {
		return
	}
	if(count.length >= 6) {
		return
	}
	count.push(1);
	cou ++;
	var str = ''
	div = document.createElement("div");
	div.classList.add('jianju')
	div.id = 'zixun' + cou
	str += `<label class="col-md-2 control-label">名称*</label>\ 
        <input id="zixun_mingcheng" type="text" class="s_input input_100 zixun_mingcheng" >\
         <label class="col-md-2 control-label" style="width: 70px;">链接*</label>\
        <input id="zixun_lianjie" type="text" class="s_input zixun_lianjie" />\
        <div class="yuan del" style="margin-left:10px; float: left; color: red;" data-id =`+cou +`>-</div>\
        </div>`
     div.innerHTML = str;
	ziArr.appendChild(div)
	console.log(count.length)
	count_num.innerHTML = count.length+'/6'
	
	 //提炼名称和链接
	 
	
}

function del_zixun(e){
	if(zixun.checked == false) {
		return
	}
	 var isDel = e.target.className.indexOf('del') > -1;
	 var index = e.target.getAttribute('data-id');
	 var id = 'zixun' + index
	 if(isDel) {
		 count.splice(0,1);
			console.log('删除',count)
			
			 var beiDel =document.getElementById(id)
		 ziArr.removeChild(beiDel)
		 count_num.innerHTML = count.length+'/6'
	 }

}

//判断是否为空

function getFormData (form) {
	 var JsonArr
	 var JsonObjArr =[]
	var categoryDesc = form.name_.value;
	var timerStatu = form.time_open.checked;
	var examDate = form.time.value;
	var examDsc = form.tishi.value;
	var infoStatu = form.zixun.checked;
	//var infoJson = form.
	JsonArr = $('.jianju')
	if(infoStatu == true) {
			infoStatu = 1;
			for(var i = 0; i < JsonArr.length; i++) {
				var obj = {}
				if(JsonArr.length == 0) {
					alert('请检查必填字段');
					 return false;
				}
				obj.name = JsonArr[i].childNodes[2].value
				obj.url =JsonArr[i].childNodes[6].value
				console.log(infoStatu)
				if(obj.name == "" || obj.value == "") {
				alert('请检查必填字段');
				 return false;
				 
			}
				JsonObjArr.push(obj)
			}
			
			
		} else {
			infoStatu = 2
			JsonObjArr=null;
		}
		console.log('infoStatu',infoStatu)
	
	JsonObjArr = JSON.stringify(JsonObjArr)
	console.log(JsonObjArr)
	
	if(timerStatu == true) {
		timerStatu = 1;
		if(!examDsc|| !timerStatu) {
			alert('请检查必填字段');
			 return false;
		}
		
	} else {
		timerStatu = 2
		//timerStatu =null;
		//examDsc =null;
	}

	return {
		name: categoryDesc,
		timerStatus: timerStatu,
		examDesc: examDsc, //不明字段
		examDate:examDate,
		infoStatus:infoStatu,
		infoJson:JsonObjArr
	}
}

 
 


</script>
</body>
</html>