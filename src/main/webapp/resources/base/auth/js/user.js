var path = $("#path").val();
var userForm = $("#userForm");
var updateUserForm = $("#updateUserForm");
var setSwitch =  $("#sex").bootstrapSwitch();
var updateSetSwitch =  $("#update_sex").bootstrapSwitch();
var statusSwitch = $("#status").bootstrapSwitch();
//保存用户
$("#saveUser").click(function(){
    //清除
    formInit();

   //表单验证是否通过
    if(!addForm.data('bootstrapValidator').validate().isValid()) return;

    var parm =  {
        "email": $("#email").val(),
        "num": $("#num").val()
    };

    if(checkEmail(parm)){
        var sex = setSwitch.bootstrapSwitch("state") ?
            setSwitch.bootstrapSwitch("onText") :
            setSwitch.bootstrapSwitch("offText");

        var datas = {
            "username": $("#name").val(),
            "flowerName": $("#flowerName").val(),
            "mobile": $("#mobile").val(),
            "email": $("#email").val(),
            "sex": sex,
            "job": $("#job").val(),
            "num": $("#num").val(),
            "bigImg": "resources/base/system/images/user-12.jpg",
            "smallImg": "resources/base/system/images/user-12.jpg"
        };

        $.ajax({
            url:path+"/user/save",
            type:"post",
            dataType:"json",
            cache: false,
            data :datas,
            success: function (datas){
                if(datas.code == HttpUtil.success_code){
                    addForm.data('bootstrapValidator').resetForm();
                    addForm[0].reset();
                    $("#close").click();
                    userTable.ajax.reload();//刷新
                }
            }
        });

    }else{
        userForm.find("#email").parent().parent().addClass("has-error has-feedback");
        userForm.find("#email").parent().find("li").html("邮箱已经存在!");
    }
})

//修改用户
$("#update_saveUser").click(function(){
    formInit();
    var parm =  {
        "email": $("#update_email").val(),
        "num": $("#update_num").val(),
        "id": $("#userId").val()
    };

    if(checkEmail(parm)){
        //表单验证是否通过
        if(!updateForm.data('bootstrapValidator').validate().isValid()) return;

        var sex = updateSetSwitch.bootstrapSwitch("state") ?
            updateSetSwitch.bootstrapSwitch("onText") :
            updateSetSwitch.bootstrapSwitch("offText");

        var status = statusSwitch.bootstrapSwitch("state") ? 1 : 0;//默认在职

        var datas = {
            "id": $("#userId").val(),
            "username": $("#update_name").val(),
            "flowerName": $("#update_flowerName").val(),
            "mobile": $("#update_mobile").val(),
            "email": $("#update_email").val(),
            "sex": sex,
            "job": $("#update_job").val(),
            "num": $("#update_num").val(),
            "userStatus": status,
            "password": $("#password").val()
        };

        $.ajax({
            url:path+"/user/update",
            type:"post",
            dataType:"json",
            cache: false,
            data :datas,
            success: function (datas){
                if(datas.code == HttpUtil.success_code){
                    $("#update_close").click();
                    userTable.ajax.reload();//刷新
                }
            }
        })
    }else{
        updateUserForm.find("#update_email").parent().parent().addClass("has-error has-feedback");
        updateUserForm.find("#update_email").parent().find("li").html("邮箱已经存在");
    }
})


//验证Email是否唯一
function checkEmail(data){
    var flag = false;
    $.ajax({
        url:path+"/user/check/userEmail",
        type:"post",
        dataType:"json",
        cache: false,
        async: false,
        data :data,
        success: function (datas){
            if(datas.code == HttpUtil.success_code){
                flag =  true;
            }
        }
    })
    return flag;
}

//验证工号是否唯一
function checkNum(data){
    var flag = false;
    $.ajax({
        url:path+"/user/check/userNum",
        type:"post",
        dataType:"json",
        cache: false,
        async: false,
        data :data,
        success: function (datas){
            if(datas.code == HttpUtil.success_code){
                flag =  true;
            }
        }
    })
    return flag;
}

function formInit(){
    $(".has-error").each(function(i,d){
        $(d).removeClass("has-error has-feedback");
    })
    $("li[name=ErrorTip]").each(function(i,d){
        $(d).html("");
    })
}

//时间选择器
var createDate =  $("#createDate").daterangepicker({
    format:'YYYY-MM-DD',//格式化日期
    showDropdowns:true,//显示年与月的选择框
    minDate:"2010-01-01",//最小日期
    maxDate:"2020-12-31",//最大日期
    applyClass: 'btn-success',//应用按钮class
    cancelClass: 'btn-warning',//取消按钮class
    separator:"/",
    ranges: {
        '今天': [moment(), moment()],
        '昨天': [moment().subtract(1, 'days'), moment().subtract(1, 'days')],
        '一周内': [moment().subtract(7, 'days'), moment()],
        '30天内': [moment().subtract(30, 'days'), moment()],
        '本月': [moment().startOf('month'), moment().endOf('month')],
        '上个月': [moment().subtract(1, 'month').startOf('month'), moment().subtract(1, 'month').endOf('month')]
    },
    locale: {
        applyLabel: '保存',
        cancelLabel: '取消',
        fromLabel: '起始时间',
        toLabel: '结束时间',
        customRangeLabel: '选择日期',
        daysOfWeek: ['周日','周一', '周二', '周三', '周四', '周五', '周六'],
        monthNames: ['一月', '二月', '三月', '四月', '五月', '六月', '七月', '八月', '九月', '十月', '十一月', '十二月'],
    },
});
//选择取消按钮时
$("#createDate").on('cancel.daterangepicker', function(ev, picker) {
    $(this).val('');
});
//锁定用户
function lockUser(obj){
    var status = $(obj).attr("status");//当前状态,1正常,0锁定
    var userId = $(obj).val();//用户ID
    var message = status == 1?"是否要锁定用户?":"是否要解锁用户?";
    var data ;
    BootstrapDialog.confirm({
        title: '用户锁定',
        message: message,
        type: BootstrapDialog.TYPE_WARNING,
        closable: true,
        btnCancelLabel: '取消',
        btnOKLabel: '确认',
        btnOKClass: 'btn-warning',
        callback: function (result) {
            if (result) {
                if (status == 1) {
                    //锁定用户
                    data = {"id": userId, "userLock": 0}
                } else {
                    //解锁用户
                    data = {"id": userId, "userLock": 1}
                }
                $.ajax({
                    url: path + "/user/lock",
                    type: "post",
                    dataType: "json",
                    cache: false,
                    async: false,
                    data: data,
                    success: function (d) {
                        if (d.code == HttpUtil.success_code) {
                            //重新加载下用户表格
                            userTable.ajax.reload(null, false);
                        }
                        if (d.code == HttpUtil.error_code) {

                        }
                    }
                })
            }
        }
    })
}

//修改用户弹出框
function updateUserDialog(obj){
    updateForm.data('bootstrapValidator').resetForm();
    updateForm[0].reset();
    formInit();
    $.ajax({
        url:path+"/user/entity",
        type:"post",
        dataType:"json",
        cache: false,
        async: false,
        data :{"id":obj},
        success: function (datas){
            if(datas.code == HttpUtil.success_code){
                var result = datas.result;
                updateUserForm.find("#userId").val(result.id);
                updateUserForm.find("#update_email").val(result.email);
                updateUserForm.find("#update_mobile").val(result.mobile);
                updateUserForm.find("#update_name").val(result.username);
                updateUserForm.find("#update_flowerName").val(result.flowerName);
                updateUserForm.find("#update_num").val(result.num);
                updateUserForm.find("#update_job").val(result.job);
                if(result.sex == "女"){
                    updateUserForm.find("#update_sex").prop("checked",false);
                    updateSetSwitch.bootstrapSwitch("state",false);
                }else{
                    updateUserForm.find("#update_sex").prop("checked",true);
                    updateSetSwitch.bootstrapSwitch("state",true);
                }

                if(result.userStatus == 1){
                    //在职
                    updateUserForm.find("#status").prop("checked",true);
                    statusSwitch.bootstrapSwitch("state",true);
                }else{
                    //离职
                    updateUserForm.find("#status").prop("checked",false);
                    statusSwitch.bootstrapSwitch("state",false);
                }

                updateUserForm.find("#update_setState").text(result.sex);
                updateUserForm.find("#update_email").val(result.email);

            }
        }
    })
}





