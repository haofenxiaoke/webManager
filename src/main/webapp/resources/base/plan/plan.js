var path = $("#path").val();
var addForm = $("#cateForm");
var updateForm = $("#updateCateForm");
//跳转新增、修改页
function forwardPage(planId){
    window.location.href = path+"/plan/baseInfo/"+planId;
}

/**
 * 初始化下拉菜单
 * @param select 下拉元素 类型必须为jquery对象
 * @param resCode   资源编码
 * @param operCode  操作编码
 */
function initCateSelect(select,resCode,operCode){
    var url = '/cate/list/' + resCode + '/'+operCode;
    $.get(url).done(function (data) {
        if (data.code == HttpUtil.success_code){
            var options = '';
            $.each(data.result,function (index,cate) {
                options+='<option value="'+cate.id+'">'+cate.categoryDesc+'</option>';
            })
            select.append(options);
        }else{
            BootstrapDialog.alert(data.msg);
        }
    });
}

//修改密码
function updateSafe(){
    var pass = safeForm.data('bootstrapValidator').validate().isValid();//表单验证是否通过
    if (pass){
        $.ajax({
            url:"/stu/update",
            type:"post",
            dataType:"json",
            cache: false,
            data :safeForm.serializeArray(),
            success: function (datas){
                if(datas.code == HttpUtil.success_code){
                    safeAlert.modal("show");
                    $("#htmlContent").html("密码修改成功!");
                    setTimeout(function(){
                        safeAlert.modal("hide");
                        safeForm.data('bootstrapValidator').resetForm();
                        safeForm[0].reset();
                    },1000);
                }
            }
        })
    }
}

//排序
function orderBy(datas){
    $.ajax({
        url: "/plan//stage/update",
        type: "post",
        dataType: "json",
        cache: false,
        data: datas,
        success: function (datas) {
            if (datas.code == HttpUtil.success_code) {
                planTable.ajax.reload(null, false);//刷新
            }
        }
    })
}

//删除 有计划变无计划
function removePlan(id){
    BootstrapDialog.confirm({
        title: '删除定制计划',
        message: '确定要删除当前定制的计划吗?',
        type: BootstrapDialog.TYPE_WARNING,
        closable: true,
        btnCancelLabel: '取消',
        btnOKLabel: '确认',
        btnOKClass: 'btn-warning',
        callback: function (result) {
            if (result) {
                var datas = {id:id};
                $.post('/plan/remove',datas,function (data) {
                    if(data.code == HttpUtil.success_code){
                        planTable.ajax.reload(null, false);//刷新
                    }
                });
            }
        }
    })

}