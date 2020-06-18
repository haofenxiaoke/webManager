var commodityTable;
$(function () {
    /*日期插件初始化*/
    bootstrapDateUtil.show('bargainSuccessTime');
    bootstrapDateUtil.show('bargainTime');
    // 设置默认时间为最近7天
    $("#bargainTime").val(moment().subtract(7, 'days').format("YYYY-MM-DD") + "/" + moment().format("YYYY-MM-DD"));
    // 加载行业数据，二级联动
    $("#directionId").change(function(){
        // 方向每次改变先初始化行业数据
        var select = $("#industryId")
        select.empty();
        select.append('<option value="">'+'请选择行业'+'</option>');
        if($(this).val()){
            getIndustry(select,$(this).val());
        }
    })
    // 表格数据加载
    loadDataGrid();
})
//将时间戳格式化
function formatDate(time,type){
    if(typeof(time)=="undefined"){
        return "";
    }
    var oDate = new Date(time),
        oYear = oDate.getFullYear(),
        oMonth = oDate.getMonth()+1,
        oDay = oDate.getDate(),
        oHour = oDate.getHours(),
        oMin = oDate.getMinutes(),
        oSen = oDate.getSeconds(),
        oTime = oYear +'/'+ getzf(oMonth) +'/'+ getzf(oDay) +'</br>'+ getzf(oHour) +':'+ getzf(oMin) +':'+getzf(oSen);//最后拼接时间
    if(type==1){
        return oYear +'/'+ getzf(oMonth) +'/'+ getzf(oDay);
    }
    return oTime;
};
//补0操作,当时间数据小于10的时候，给该数据前面加一个0
function getzf(num){
    if(parseInt(num) < 10){
        num = '0'+num;
    }
    return num;
}
// 搜索按钮点击事件
function reloadTable() {
    var bargainerBool = isPoneAvailable($("#bargainer").val());
    var exchangeUserPhoneBool = isPoneAvailable($("#exchangeUserPhone").val());
    if(!bargainerBool){
        BootstrapDialog.warning("请输入正确的发放人手机号")
        return;
    }
    if(!exchangeUserPhoneBool){
        BootstrapDialog.warning("请输入正确的兑换人手机号")
        return;
    }
    commodityTable.ajax.reload();
}
// 根据方向获取行业
function getIndustry(select,directionId) {
    var url = '/industry/industryList';
    var datas = {"directionId":directionId};
    $.ajax({
        url:url,
        type:"post",
        dataType:"json",
        cache: false,
        data :datas,
        success: function (data){
            if (data.code == HttpUtil.success_code){
                var options = '';
                $.each(data.result,function (index,cate) {
                    options+='<option value="'+cate.id+'">'+cate.categoryDesc+'</option>';
                })
                select.append(options);
            }else{
                BootstrapDialog.alert(data.msg);
            }
        }
    });
}
// 验证手机号
function isPoneAvailable(phone) {
    var myreg=/^[1][0-9]{10}$/;
    if (phone && !myreg.test(phone)) {
        return false;
    } else {
        return true;
    }
}
// 查看课程模态框展示
function showCourse(id) {
    $.get(
        "/course/findCourseByIndustryId/"+id,
        function (result) {
            if(result.code == HttpUtil.success_code) {
                var detail = '<div style="text-align: left">';
                $(result.result).each(function (index,ele) {
                    detail += ele.title +'<br/>'
                })
                detail+='<div>'
                $("#courseDetail").html(detail)
            }
        }
    ).fail(function () {
        BootstrapDialog.alert({
            title:"网络异常",
            message:"网络异常,请稍后再试",
            type:BootstrapDialog.TYPE_DANGER
        });
        $('#course-modal').modal('hide');
    });
    $('#course-modal').modal('show');
}

// 导出excel
function exportExcel(){
    var dialog = BootstrapDialog.confirm({
        title: '提示',
        message: '是否根据当前条件导出数据',
        type: BootstrapDialog.TYPE_info,
        closable: true,
        btnCancelLabel: '取消',
        btnOKLabel: '确认',
        btnOKClass: 'btn-info',
        callback: function (result) {
            if (result) {
                dialog.close();
                window.location.href ="/commodityBargain/exportCommodityExcel?directionId="+$("#directionId").val()+'&industryId='+$("#industryId").val()
                    +'&bargainSuccessTime='+$("#bargainSuccessTime").val()+'&ticketStatus='+$("#ticketStatus").val()+'&bargainer='+$("#bargainer").val()
                    +'&exchangeUserPhone='+$("#exchangeUserPhone").val()+'&courseTicketId='+$("#courseTicketId").val()+'&bargainStatus='+$("#bargainStatus").val()
                    +'&bargainTime='+$("#bargainTime").val();
            }
        }
    });
}