var path = $("#path").val();
var addForm = $("#homeSetForm");
var updateForm = $("#updatehomeSetForm");
var Expression = /(http|ftp|https):\/\/[\w\-_]+(\.[\w\-_]+)+([\w\-\.,@?^=%&amp;:/~\+#]*[\w\-\@?^=%&amp;/~\+#])?/;
var objExp=new RegExp(Expression);
$(".switch").bootstrapSwitch();
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

/**
 * 初始化 jQuery File Upload 上传文件插件
 * @param fileId
 * @param previewId  预览图id
 * @param savePathInputId  保存图片路径的input id
 */
function initFileupload(fileId,previewId,savePathInputId) {
    $('#'+fileId).fileupload({
        url:'/upload/image?dirName=homeSet',
        done: function (e, data) {
            if(data.result.code == HttpUtil.success_code){
                var path = data.result.result.path;
                $('#'+previewId).attr('src', path);
                $('#'+savePathInputId).val(path);
                $('#pathUrl').val(path);
                $('#course-detail-form')//上传成功表单验证设置为通过
                    .data('bootstrapValidator')
            }else{
                var alert = BootstrapDialog.alert||window.alert;
                alert(data.result.msg);
            }
        }
    });
}

//点击弹出上传课程
$("[href='#homeSet-course-alert']").click(function(e){
    var hideData = $(this).attr('hideData');
    if(hideData){
        var arr = hideData.split('#');
        $('#setType').val(arr[0]);
        $('#setColumn').val(arr[1]);
        $('#setId').val(arr[2]);
      /*  $('#directionId').attr("value",arr[0]);
        $('#courseId').attr("value",arr[3]);*/
    }
});

//点击弹出上传轮播图片
$("[href='#homeSet-img-alert']").click(function(e){
    $('#pathUrl').val($(this).attr('src'));
    $('#bgcolor').val($(this).attr('data-bgColor'));
    $('#preview-image').attr('src',$(this).attr('src'));
    var hideData = $(this).attr('hideData');
    if(hideData){
        var arr = hideData.split('#');
        $('#imageOrderNum').val(arr[0]);
        $('#imageId').val(arr[1]);
        $('#hrefUrl').val(arr[2]);
    }
    formInit();
});

//上传首页设置
$('#saveSet').click(function () {
    var loadurl;
    var id = $("#setId").val();
    var coverUrl = $("#courseId").val();
    if(coverUrl && coverUrl != -1){
        var htmlContent = '<input type="hidden" id="'+$("#setColumn").val()+'" name = "'+$("#setColumn").val()+'" value="'+coverUrl+'"/>';
        $("#htmlContent").html(htmlContent);
        //console.log($('#homeSetForm').serializeArray());
        if(id){
            loadurl = "/homeSet/update";
        }else{
            loadurl = "/homeSet/save";
        }
        $.post(loadurl,$('#homeSetForm').serializeArray(),function(datas){
            if (datas.code == HttpUtil.success_code) {
                window.location.reload();
            }else{
                var alert = BootstrapDialog.alert||window.alert;
                alert(data.result.msg);
            }
        })
    }else{
        alert("请选择课程！");
    }
});

//上传轮播图片
$('#saveImg').click(function () {
    var id = $("#imageId").val();
    var url;
    if(id){
        url = "/homeSet/carousel/update";
    }else{
        url = "/homeSet/carousel/save";
    }

    if(!objExp.test($("#hrefUrl").val())){
        $("#hrefUrl").parent().parent().addClass("has-error has-feedback");
        $("#hrefUrl").parent().find("li").html("请输入正确的网址！");
        return;
    }

    if(url){
        $.ajax({
            url: url,
            type: "post",
            dataType: "json",
            cache: false,
            data: $('#homeSetImgForm').serializeArray(),
            success: function (datas) {
                if (datas.code == HttpUtil.success_code) {
                    window.location.reload();
                }
            }
        });
    }
});

//删除轮播图片
function delCarouselImg(id){
    var datas = {"id":id};
    $.ajax({
        url: "/homeSet/carousel/delete",
        type: "post",
        dataType: "json",
        cache: false,
        data: datas,
        success: function (datas) {
            if (datas.code == HttpUtil.success_code) {
                window.location.reload();
            }
        }
    });
}

//保存热词
$('#saveHot').click(function () {
    var hotForm = $('#saveHotForm');
    var pass = hotForm.data('bootstrapValidator').validate().isValid();//表单验证是否通过
    if (pass) {
        $.ajax({
            url: "/homeSet/hot/save",
            type: "post",
            dataType: "json",
            cache: false,
            data: hotForm.serializeArray(),
            success: function (datas) {
                if (datas.code == HttpUtil.success_code) {
                    window.location.reload();
                }
            }
        });
    }
});

//配置课程
//点击弹出 配置课程
function initFileuploadConfig(fileId,previewId,savePathInputId) {
    $('#'+fileId).fileupload({
        url:'/upload/image?dirName=homeSet',
        done: function (e, data) {
            if(data.result.code == HttpUtil.success_code){
                var path = data.result.result.path;
                $('#'+previewId).attr('src', path);
                $('#'+savePathInputId).val(path);
                $('#course-detail-form')//上传成功表单验证设置为通过
                    .data('bootstrapValidator')
            }else{
                var alert = BootstrapDialog.alert||window.alert;
                alert(data.result.msg);
            }
        }
    });
}
$("[href='#homeSet-config-alert']").click(function(e){
    //先清空
    $('#leftHref-config').val('');
    $('#preview-image-config').attr('src','');
    var hideData = $(this).attr('hideData');
    var dataType = $(this).attr('dataType');
    if(hideData){
        var arr = hideData.split('#');
        $('#imgType-config').val(arr[0]);
        $('#setImgColumn-config').val(arr[1]);
        $('#imgId-config').val(arr[2]);
    }
    if(dataType){
        $('#leftHref-config').val(dataType);
        $('#preview-image-config').attr('src',$(this).attr('src'));
    }
    formInit();
});

$('#saveSet-config').click(function () {
    var loadurl;
    $("#leftHref-config").val("");
    var id = $("#setId-config").val();
    var coverUrl = $("#courseId-config").val();
    if(coverUrl && coverUrl != -1){
        var htmlContent = '<input type="hidden" id="'+$("#setColumn-config").val()+'" name = "'+$("#setColumn-config").val()+'" value="'+coverUrl+'"/>';
        $("#htmlContent-config").html(htmlContent);
        //console.log($('#homeSetForm').serializeArray());
        if(id){
            loadurl = "/homeSet/update";
        }else{
            loadurl = "/homeSet/save";
        }
        $.post(loadurl,$('#homeSetForm-config').serializeArray(),function(datas){
            if (datas.code == HttpUtil.success_code) {
                window.location.reload();
            }else{
                var alert = BootstrapDialog.alert||window.alert;
                alert(data.result.msg);
            }
        })
    }else{
        alert("请选择课程！");
    }
});

$('#saveImg-config').click(function () {
    var id = $("#imgId-config").val();
    var coverUrl = $("#course-image-path-config").val();
    var htmlContent = '<input type="hidden" id="imgColumn-config" name = "'+$("#setImgColumn-config").val()+'" value="'+coverUrl+'"/>';
    $("#htmlContent-img-config").html(htmlContent);

    var leftHref = $("#leftHref-config");
    if(!objExp.test(leftHref.val())){
        leftHref.parent().parent().addClass("has-error has-feedback");
        leftHref.parent().find("li").html("请输入正确的网址！");
        return;
    }
    var url;
    if(id){
        url = "/homeSet/update";
    }else{
        url = "/homeSet/save";
    }
    if(url){
        $.ajax({
            url: url,
            type: "post",
            dataType: "json",
            cache: false,
            data: $('#homeSetImgForm-config').serializeArray(),
            success: function (datas) {
                if (datas.code == HttpUtil.success_code) {
                    window.location.reload();
                }
            }
        });
    }
});

function formInit() {
    $(".has-error").each(function (i, d) {
        $(d).removeClass("has-error has-feedback");
    })
    $("li[name=ErrorTip]").each(function (i, d) {
        $(d).html("");
    })
}
//end 配置课程