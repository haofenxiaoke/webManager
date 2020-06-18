//定义一次对象
var skuObj = $("#skuList");//sku列表对象 查询
var path = $("#path").val();//系统路径
var courseReplayTable;

var skuId = 1;
var tableObj = $('#courseReplyLiveNew-table');//数据表格
var beginTimeObj = $("#beginTime");
var courseNameObj = $("#courseName");
var stateObj = $("#state");
var choseList = new Array;//选中的排序列表


var searchBtnObj = $("#searchBtn");
var saveObj = $("#saveBtn");

//时间选择器
var operTime = beginTimeObj.daterangepicker({
    singleDatePicker: true,
    format: 'YYYY-MM-DD',//格式化日期
    showDropdowns: true,//显示年与月的选择框
    minDate: "2010-01-01",//最小日期
    maxDate: new Date(),//最大日期
    locale: {
        daysOfWeek: ['周日', '周一', '周二', '周三', '周四', '周五', '周六'],
        monthNames: ['一月', '二月', '三月', '四月', '五月', '六月', '七月', '八月', '九月', '十月', '十一月', '十二月']
    }
});




$(document).ready(function () {
    //刷新预加载后下拉框赋值
    beginTimeObj.val("");
    courseNameObj.val("");
    skuObj.find("option[value='"+skuId+"']").attr("selected",true);
    stateObj.find("option[value='']").attr("selected",true);

    choseList.length =0;//选中list置空

    skuObj.on("change", function(){
        skuId = skuObj.find("option:selected").attr("value");
    });

    //查询数据表格
    courseReplayTable = tableObj.DataTable({
        select: true, //是否选中
        autoWidth: true,
        deferRender: true,
        responsive: true,
        searching: false, //是否开启搜索
        pagingType: "full_numbers",//分页类型 full_numbers显示所有分页信息
        processing: false, //是否显示处理状态
        serverSide: true, //是否开启服务器模式
        ordering: false, //排序
        aLengthMenu: [10, 20, 50, 100], //下拉框每页显示数量
        ajax: {
            "url": "/replayLive/search",
            "type": "POST",
            "dataType": "json",
            "data": function (d) {
                d.skuId = skuId==null?1:skuId;
                d.state = stateObj.find("option:selected").attr("value");
                d.courseName = courseNameObj.val();
                d.beginTime = beginTimeObj.val();
            }
        },
        columns: [
            {"data": "title"},
            {"data": "sysDicName"},
            {"data": "dateWeek"},
            {"data":"timeStr"},
            {"data":"mobileFlag", "render": function (data, type, row, meta) {
                if(data==null||data==""){
                    return '';
                }
                if(data==0){
                    return "App";
                }if(data==1){
                    return "Web";
                }if(data==2){
                    return "Wap";
                }
            }
            },
            {"data":"order"},
            {"data":"state","render":function(data,type,row,meta){
                if(row.mobileFlag==null||row.mobileFlag==1){
                        if(row.state==1){
                          return  ' <input id="chobox_'+row.id+'" type="checkbox" data-render="switchery" data-theme="default" checked data-id="'+row.id+'" />';
                        }else{
                            return  ' <input id="chobox_'+row.id+'" type="checkbox" data-render="switchery" data-theme="default" data-id="'+row.id+'" />';
                        }
                }
                else{
                    return "";
                }
            }}
        ],
        language: {
            lengthMenu: "每页 _MENU_ 条记录",//下拉框文字
            info: "第 _PAGE_ 页 ( 总共 _PAGES_ 页 ,共 _TOTAL_ 项)",//左下角显示文字
            infoEmpty: "",//当查询没有数据时左下角显示文字
            sEmptyTable: "没有数据..",//当查询没有数据时表格中间显示文字
            paginate: {                          //分页
                first: "首页",
                last: "尾页",
                next: "下一页",
                previous: "上一页"
            }
        },
        drawCallback: function (setting) {
            searchBtnObj.attr('disabled', false);
            var list = setting.json.data;//获取数据列表
            var listReply = setting.json.listReply;//获取启用数据列表
            var ids = setting.json.ids;//获取旧的排序值
            if(choseList.length==0){//最开始放一次
                if(ids.length>0){
                    if(listReply!=null) {
                        for(var i=0;i<listReply.length;i++){
                            var obj = listReply[i];
                            for(var j=0;j<ids.length;j++){
                                if(obj.id==ids[j]){
                                    choseList.push(obj);//给选中列表赋值
                                }
                            }
                        }
                    }
                }
            }

            //初始化切换
            $("#courseReplyLiveNew-table").find("input[id^=chobox_]").each(function(){
                var inputObj = $(this);
                    for(var i=0;i<choseList.length;i++) {
                        var obj = choseList[i];
                        if(inputObj.is(':checked')){
                            continue;
                        }
                        if(inputObj.data("id")==obj.id){
                            inputObj.attr('checked','true');
                        }
                    }
            });

            FormSliderSwitcher.init();

            $("#courseReplyLiveNew-table").find("input[id^=chobox_]").on("change",function(){
                var obj = $(this);
                var id = $(this).data("id");

                if(obj.is(':checked')){//开启
                    for(var i=0;i<list.length;i++){
                        var obj = list[i];
                        if(obj.id==id){ //迭代数据列表id匹配上的时候添加到选中list
                            choseList.push(obj);
                        }
                    }
                }else{//关闭
                    for(var j=0;j<choseList.length;j++){ //移除选中list 的下标
                        var choseObj = choseList[j];
                        if(choseObj.id==id){
                            choseList.splice(j,1);
                        }
                    }
                }
            });
        }
    });
});


searchBtnObj.click(function () {
    choseList.length =0;//选中list置空
    searchBtnObj.attr('disabled', true);
    courseReplayTable.ajax.reload();
});


$("#orderBtn").click(function () {
    $("#warn").parent().hide();
    var html='';
    for(var i=choseList.length;i>0;i--){

        var obj = choseList[i-1];
        var device;
        if( obj.mobileFlag==0){
            device= "App";
        }if( obj.mobileFlag==1){
            device= "Web";
        }if( obj.mobileFlag==2){
            device= "Wap";
        }if(obj.mobileFlag==null||obj.mobileFlag==""){
            device="";
        }
        html+="<tr><td>"+obj.title+"</td><td>"+obj.sysDicName+"</td><td>"+obj.dateWeek+"</td><td>"+obj.timeStr+"</td><td>"+device+"</td><td><input id='order_"+obj.id+"' class='form-control' value='' style='width:40px' data-id='"+obj.id+"' onkeyup="+"this.value=this.value.replace(/[^\\d]/ig,'')"+"></td></tr>";
    }

    $("#orderTable").find("tbody").html(html);
});

$("#closeBtn").click(function(){
    $(this).parent().hide();//提示框隐藏
});

//关闭弹框 重载页面
function closeAndReload(){
    $("#cancelBtn").click();
    choseList.length =0;//选中list置空
    saveObj.attr('disabled', false);
    courseReplayTable.ajax.reload();
}

saveObj.click(function(){
    $("#warn").parent().hide();//提示框隐藏

    if(choseList.length==0) {//排序为空的时候保存
        saveObj.attr('disabled', true);
        $.ajax({
            url: path + "/replayLive/update?data="+''+"&id="+skuId,
            type: "post",
            dataType: "json",
            cache: false,
            async: false,
            data: null,
            success: function (datas) {
                if(datas.code=="200"){
                    $().toastmessage('showSuccessToast', "保存成功!");
                    closeAndReload();
                }else{
                    $().toastmessage('showSuccessToast', "保存失败!");
                    closeAndReload();
                }
            }
        });
    }


    var isOrderArray = new Array;//校验是否有序
    var orderMap = new Array; //排序map
    var flag= true;//标记验证结果
    var data="";//要提交的排序内容




    //获取排序内容
    $("#orderTable").find("input[id^=order_]").each(function(){
        var obj = $(this);
        var val = obj.val();
        if(val==""){
            flag=false;
        }

        var id = obj.data("id");
        var map={ //排序序号和idmap
            "order":val,
            "id":id
        }
        orderMap.push(map);;//顺序和id放入Map
        isOrderArray.push(val);//顺序值放入验证list
    });

    if(!flag){
        $("#warn").parent().show();//提示错误
        $("#warn").html("请输入排序顺序！");
    }else{
        isOrderArray.sort();//从小到大排序
        if(isOrderArray.length>0){//如果排序数组不为空进入
            for(var i=0;i<isOrderArray.length;i++){//迭代排序数组
                if(i==0){
                    if(isOrderArray[i]!=1){ //检查有序的list第一个是否是1
                        $("#warn").parent().show();
                        $("#warn").html("必须从1开始排序");
                        return false;
                    }
                }else{//第二次和之后循环
                    if(isOrderArray[i]-isOrderArray[i-1]!=1){//检查后一个和前一个差值
                        $("#warn").parent().show();
                        $("#warn").html("排序有误");
                        return false;
                    }
                }
            }
            if(flag){//验证通过
                for(var j=0;j<isOrderArray.length;j++) {
                    for(var i=0;i<orderMap.length;i++){
                        var map = orderMap[i];
                        if(isOrderArray[j]==map["order"]){
                            data+=map["id"]+',';// 组装放数据
                        }
                    }
                }
                saveObj.attr('disabled', true);
                data = data.substring(0, data.length - 1);
                $.ajax({
                    url: path + "/replayLive/update?data="+data+"&id="+skuId,
                    type: "post",
                    dataType: "json",
                    cache: false,
                    async: false,
                    data: null,
                    success: function (datas) {
                        if(datas.code=="200"){
                            $().toastmessage('showSuccessToast', "保存成功!");
                            closeAndReload();
                        }else{
                            $().toastmessage('showSuccessToast', "保存失败!");
                            closeAndReload();
                        }
                    }
                });
            }
        }
    }
});
