var path = $("#path").val();
var addForm = $("#tagForm");
var updateForm = $("#updateTagForm");
//跳转tab页
function forwardTab(obj){
    location.href = path+"/tag/managerTab/"+obj;
}
//保存
$("#saveTag").unbind('click').click(function () {
    var pass = addForm.data('bootstrapValidator').validate().isValid();//表单验证是否通过
    if (pass){
        var datas =  addForm.serializeArray();
        $.ajax({
            url:path+"/tag/save/"+tagType+"/"+directionId,
            type:"post",
            dataType:"json",
            cache: false,
            data :datas,
            success: function (datas){
                if(datas.code == HttpUtil.success_code){
                    addForm.data('bootstrapValidator').resetForm();
                    addForm[0].reset();
                    tagTable.ajax.reload();//刷新
                }
            }
        })
        $("#close").click();
    }
})

//修改
$("#update_saveTag").click(function () {
    if (updateformCheck()) {
        var parm = {"content": $("#update_content").val(), "id": updateForm.find("#id").val(),"directionId":directionId};
        if (checkDesc(parm)) {
            var datas = {"id": updateForm.find("#id").val(), "content": $("#update_content").val()}
            $.ajax({
                url: path + "/tag/update",
                type: "post",
                dataType: "json",
                cache: false,
                data: datas,
                success: function (datas) {
                    if (datas.code == HttpUtil.success_code) {
                        tagTable.ajax.reload(null, false);//刷新
                    }
                }
            })
            $("#update_close").click();
        } else {
            updateForm.find("#update_content").parent().parent().addClass("has-error has-feedback");
            updateForm.find("#update_content").parent().find("li").html("该名称已经存在");
        }
    }
})

function formInit() {
    $(".has-error").each(function (i, d) {
        $(d).removeClass("has-error has-feedback");
    })
    $("li[name=ErrorTip]").each(function (i, d) {
        $(d).html("");
    })
}

//改名弹出框
function updateTagDialog(obj) {
    formInit();
    $.ajax({
        url: path + "/tag/entity",
        type: "post",
        dataType: "json",
        cache: false,
        async: false,
        data: {"id": obj},
        success: function (datas) {
            if (datas.code == HttpUtil.success_code) {
                var result = datas.result;
                updateForm.find("#update_content").val(result.content);
                updateForm.find("#id").val(result.id);
            }
        }
    })
}

//
function updateformCheck() {
    formInit();
    if ($.trim(updateForm.find("#update_content").val()) == "") {
        updateForm.find("#update_content").parent().parent().addClass("has-error has-feedback");
        updateForm.find("#update_content").parent().find("li").html("不能为空!");
        return false;
    }
    return true;
}

//验证标签是否唯一
function checkDesc(data) {
    var flag = false;
    $.ajax({
        url: path + "/tag/check/tagDesc",
        type: "post",
        dataType: "json",
        cache: false,
        async: false,
        data: data,
        success: function (datas) {
            if (datas.code == HttpUtil.success_code) {
                flag = true;
            }
        }
    })
    return flag;
}

//删除
function deleteTag(obj) {
    BootstrapDialog.confirm({
        title: '删除标签',
        message: '确定要删除当前标签吗?',
        type: BootstrapDialog.TYPE_WARNING,
        closable: true,
        btnCancelLabel: '取消',
        btnOKLabel: '确认',
        btnOKClass: 'btn-warning',
        callback: function (result) {
            if (result) {
                var datas = {"id": obj, "deleted": 1};
                $.ajax({
                    url: path + "/tag/delete",
                    type: "post",
                    dataType: "json",
                    cache: false,
                    data: datas,
                    success: function (datas) {
                        if (datas.code == HttpUtil.success_code) {
                            tagTable.ajax.reload(null, false);//刷新
                        }
                    }
                })
            }
        }
    })
}

function getVideoInfo(obj,tagType,tableObj){
    var loadUrl;
    var columns = [
        { "data": null,"visible":false},
        { "data": "courseTitle"},
        { "data": "lectureName"},
    ];
    if(tagType == 1)  loadUrl ="/tag//suitable/entity";
    if(tagType == 2)  loadUrl ="/tag//advantage/entity";
    if(tagType == 3) {
        loadUrl ="/tag//plan/entity";
        columns = [
            { "data": null,"visible":false},
            { "data": "planDescribe"},
        ];
    }
    $(tableObj).DataTable({
        bDestroy: true,
        searching:false,
        processing: true,
        serverSide: true,
        ordering:false, //排序
        paging:true,
        ajax:{
            "url":loadUrl,
            "type": "POST",
            "dataType":"json",
            "data":function(d){
                d.tagId = obj;
            }
        },
        columns:columns,
        language:{
            lengthMenu: "",//下拉框文字
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

