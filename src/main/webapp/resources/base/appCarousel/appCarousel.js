var path = $("#path").val();
var Expression = /(http|ftp|https):\/\/[\w\-_]+(\.[\w\-_]+)+([\w\-\.,@?^=%&amp;:/~\+#]*[\w\-\@?^=%&amp;/~\+#])?/;
var objExp=new RegExp(Expression);
$(".switch").bootstrapSwitch();

/**
 * 初始化 jQuery File Upload 上传文件插件
 * @param fileId
 * @param previewId  预览图id
 * @param savePathInputId  保存图片路径的input id
 */
function initFileupload(fileId,previewId,savePathInputId) {
    $('#'+fileId).fileupload({
        url:'/upload/appImage?dirName=appCarousel',
        done: function (e, data) {
            if(data.result.code == HttpUtil.success_code){
                var path = data.result.result.path;
                $('#'+previewId).attr('src', path);
                $('#'+savePathInputId).val(path);
                $('#pathUrl').val(path);
                $('#appImgForm')//上传成功表单验证设置为通过
                    .data('bootstrapValidator')
                    .updateStatus('carouseImage', 'NOT_VALIDATED', null)
                    .validateField('carouseImage');
            }else{
                var alert = BootstrapDialog.alert||window.alert;
                alert(data.result.msg);
            }
        }
    });
}


//点击弹出上传轮播图片
$("[href='#app-img-alert']").click(function(e){
    $('#pathUrl').val($(this).attr('src'));
    $('#preview-image').attr('src',$(this).attr('src'));
    var hideData = $(this).attr('hideData');
    if(hideData){
        var arr = hideData.split('#');
        $('#imageOrderNum').val(arr[0]);
        $('#imageId').val(arr[1]);
        var type = arr[3];
        if(type==2){
            $("input[name=type][value='2']").attr('checked','checked');
        }else {
            $("input[name=type][value='1']").attr('checked','checked');
        }
        var href = $('#type-href');
        var code = $('#type-code');
        href.css('display','none');
        code.css('display','none');
        $("#code-type").val('');
        if (type == 2){
            code.css('display','block');
            $("#code-type").val(arr[2]);
        } else{
            href.css('display','block');
            $('#hrefUrl').val(arr[2]);
        }
    }
    formInit();
});
$('#hrefUrl').blur(function(){
    if(!objExp.test($("#hrefUrl").val())){
        $("#hrefUrl").parent().parent().addClass("has-error has-feedback");
        $("#hrefUrl").parent().find("li").html("请输入正确的网址！");
        return;
    }else{
        $("#hrefUrl").parent().parent().removeClass("has-error has-feedback");
        $("#hrefUrl").parent().find("li").html("");
    }
})

//上传轮播图片
$('#appCarouselSave').click(function () {
    if($('#pathUrl').val()==""){
        BootstrapDialog.warning("请上传轮播图！");
        return ;
    }
    var id = $("#imageId").val();
    var url;
    if(id){
        url = "/app/carousel/update";
    }else{
        url = "/app/carousel/save";
    }

    var chkRadio = $('input:radio[name=type]:checked').val();
    if(chkRadio == 1){
        if(!objExp.test($("#hrefUrl").val())){
            $("#hrefUrl").parent().parent().addClass("has-error has-feedback");
            $("#hrefUrl").parent().find("li").html("请输入正确的网址！");
            return;
        }else{
            $("#hrefUrl").parent().parent().removeClass("has-error has-feedback");
            $("#hrefUrl").parent().find("li").html("");
        }
    }

    if(url){
        $.ajax({
            url: url,
            type: "post",
            dataType: "json",
            cache: false,
            data: $('#appImgForm').serializeArray(),
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
    BootstrapDialog.confirm({
        title: '删除轮播图',
        message: '确定要删除当前轮播图吗?',
        type: BootstrapDialog.TYPE_WARNING,
        closable: true,
        btnCancelLabel: '取消',
        btnOKLabel: '确认',
        btnOKClass: 'btn-warning',
        callback: function (result) {
            if (result) {
                $.ajax({
                    url: "/app/carousel/delete",
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
        }
    })



}

function formInit() {
    $(".has-error").each(function (i, d) {
        $(d).removeClass("has-error has-feedback");
    })
    $("li[name=ErrorTip]").each(function (i, d) {
        $(d).html("");
    })
}
//end 配置课程