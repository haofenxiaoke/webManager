var path = $("#path").val();
var obj;
var objId;

$(".switch-input").bootstrapSwitch();

$(".switch-input").each(function (n, b) {
    if(b.value==2){
        $(this).bootstrapSwitch("state",false);
    }
});


//监听切换
$('.switch-input').on('switchChange.bootstrapSwitch', function (e, state) {
    var object = $(this);
    var functionId =object.data("function-id");
    if(functionId==1) {
        changeRadio(object);
    }
    if(functionId==2){
        changeRadio2(object);
    }
    if(state){//状态为on
        $(this).val(1);
    }
    else{//状态为0FF
        $(this).val(2);
    }
});

$(function () {
    $(".uploadImage").fileupload({
        url: path + '/sysLiveConfig/ajaxBanReviewPic',
        sequentialUploads: true,
        add: function (e, data) {
            if (!validataEval(data.files[0].name.toLowerCase(), /(.jpg|.png|.gif|.ps|.jpeg|.bmp)$/)) {
                $().toastmessage('showSuccessToast', "图片格式不对!");
                return;
            } else {
                data.submit();
            }
        }
    }).bind('fileuploadprogress', function (e, data) {
        obj = $(this);
        objId = obj.data("id");
        $("#uploaddiv_" + objId).find(".progress_div").css("display", "");
        $("#uploaddiv_" + objId).find(".progressbar").css("display", "");
        var progress = parseInt(data.loaded / data.total * 100, 10);
        $("#uploaddiv_" + objId).find(".pic_progress").css('width', progress + '%');
        $("#uploaddiv_" + objId).find(".pic_progress").html(progress + '%');
    }).bind('fileuploaddone', function (e, data) {
        $("#headImg" + objId).attr("src", data._response.result[0].src);
        $("#liveConfig" + objId + "_pic").val(data._response.result[0].path);
        $("#uploaddiv_" + objId).find(".progress_div").css("display", "none");
        $("#uploaddiv_" + objId).find(".progressbar").css("display", "none");
    });
});

// 校验图片格式
function validataEval(obj, reg) {
    var result = obj.match(reg);
    if (result==null) {
        return false;
    } else {
        return true;
    }
}


function changeRadio(obj) {
    var $in = $(obj).parent().parent().next();
    if ($(obj).val() == 2) {
        $in.attr("readonly", "readonly").val("");
    } else {
        $in.removeAttr("readonly");
    }
}

function changeRadio2(obj) {
    var id = $(obj).data("id");
    if ($(obj).val() == 1) {
        $("#divContent" + id).hide();
    } else {
        $("#divContent" + id).show();
    }
}