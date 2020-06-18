var path = $("#path").val();
var addForm = $("#cateForm");
var updateForm = $("#updateCateForm");
//跳转tab页
function forwardTab(user_id){
    location.href = path+"/stu/managerTab/"+user_id;
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
            select.empty();
            var options = '<option value="-1">--方向--</option>';
            $.each(data.result,function (index,cate) {
                options+='<option value="'+cate.id+'">'+cate.categoryDesc+'</option>';
            })
            select.append(options);
        }else{
            BootstrapDialog.alert(data.msg);
        }
    });
}

/**
 * 初始化下拉菜单
 * @param select 下拉元素 类型必须为jquery对象
 * @param selValue   课程分类方向ID
 */
function initCourseSelect(select,selValue){
    var url = '/course/select/list/' + selValue;
    $.get(url).done(function (data) {
        if (data.code == HttpUtil.success_code){
            select.empty();
            var options = '<option value="-1">--课程--</option>';
            $.each(data.result,function (index,course) {
                options+='<option value="'+course.id+'">'+course.title+'</option>';
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