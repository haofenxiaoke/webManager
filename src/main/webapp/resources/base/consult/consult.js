(function(window){
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

                    $('#form1')//上传成功表单验证设置为通过
                        .data('bootstrapValidator')
                        .updateStatus('imgUrl', 'NOT_VALIDATED', null)
                        .validateField('imgUrl');
                }else{
                    var alert = BootstrapDialog.alert||window.alert;
                    alert(data.result.msg);
                }
            }
        });
    }

    function initBindEvents(){
        $('input[name="isSwitch').bootstrapSwitch();
        //绑定表单验证器
        $('#form1').bootstrapValidator({
            message: 'This value is not valid',
            excluded: [':disabled'],//不加它重新打开模态框时提示不会清除
            fields: {
                consultUrl: {
                    validators: {
                        notEmpty: {
                            message: '小能key为空'
                        },
                        stringLength: {
                            max: 128,
                            message: '你已超过字数上限'
                        }
                    }
                },
                imgUrl : {
                    validators: {
                        notEmpty: {
                            message: '图片为空'
                        }
                    }
                }
            }
        });
        $('#form2').bootstrapValidator({
            message: 'This value is not valid',
            excluded: [':disabled'],//不加它重新打开模态框时提示不会清除
            fields: {
                consultUrl: {
                    validators: {
                        notEmpty: {
                            message: '小能key为空'
                        },
                        stringLength: {
                            max: 128,
                            message: '你已超过字数上限'
                        }
                    }
                }
            }
        });
        $('#form3').bootstrapValidator({
            message: 'This value is not valid',
            excluded: [':disabled'],//不加它重新打开模态框时提示不会清除
            fields: {
                consultUrl: {
                    validators: {
                        notEmpty: {
                            message: 'QQ群链接为空'
                        },
                        stringLength: {
                            max: 128,
                            message: '你已超过字数上限'
                        }
                    }
                }
            }
        });
    }

    function initLoadDatas(){
        var url = '/consult/entity';
        $.post(url,function (data) {
            if (data.code == HttpUtil.success_code){
                $(data.result).each(function(index,consult){
                    var type = consult.type;
                    var isSwitch = consult.isSwitch;
                    if(type == 1){
                        $('#form1').find('input[name=id]').val(consult.id);
                        $('#form1').find('#preview-image').attr('src',consult.imgUrl);
                        $('#form1').find('input[name=imgUrl]').val(consult.imgUrl);
                        $('#form1').find('input[name=consultUrl]').val(consult.consultUrl);
                        $('#form1').find('input[name=isSwitch]').prop("checked",isSwitch);
                        $('#form1').find('input[name=isSwitch]').bootstrapSwitch("state",isSwitch);
                        var pages = consult.pageSwitch.split(',');
                        $.each(pages,function(i,item){
                            $('input[name=pageSwitch][value='+item+']').attr("checked","checked");
                        });
                    }else if(type == 2){
                        $('#form2').find('input[name=id]').val(consult.id);
                        $('#form2').find('input[name=consultUrl]').val(consult.consultUrl);
                        $('#form2').find('input[name=isSwitch]').prop("checked",isSwitch);
                        $('#form2').find('input[name=isSwitch]').bootstrapSwitch("state",isSwitch);
                    }else if(type == 3){
                        $('#form3').find('input[name=id]').val(consult.id);
                        $('#form3').find('input[name=consultUrl]').val(consult.consultUrl);
                        $('#form3').find('input[name=isSwitch]').prop("checked",isSwitch);
                        $('#form3').find('input[name=isSwitch]').bootstrapSwitch("state",isSwitch);
                    }
                });
            } else{
                BootstrapDialog.alert(data.message);
            }
        });
    }

    //提交
    function submitForm(select,type) {
        var pass = $(select).data('bootstrapValidator').validate().isValid();//表单验证是否通过

        if(pass){
            var switchSelect = $(select).find('input[name=isSwitch]').bootstrapSwitch();
            var data ={
                type:type,
                id:$(select).find('input[name=id]').val(),
                isSwitch:(switchSelect.bootstrapSwitch("state") ? 1 : 0),
                consultUrl:$(select).find('input[name=consultUrl]').val()
            };

            if(type == 1){
                data['imgUrl'] = $(select).find('#image-path').val();
                var pageSwitch = new Array();
                $('input[name="pageSwitch"]:checked').each(function(index){
                    pageSwitch.push($(this).val());
                });
                if(pageSwitch.length == 0){
                    pageSwitch.push(0);
                }
                data['pageSwitch'] = pageSwitch.toString();
            }

            var url = '/consult/save';
            $.post(url,data,function (data) {
                if (data.code == HttpUtil.success_code){
                    location.reload();
                } else{
                    BootstrapDialog.alert(data.message);
                }
            });
        }
    }

    //需要暴露到global域的API
    window.page ={
        init:function () {
            //初始化各种事件绑定
            initBindEvents();

            //初始化数据
            initLoadDatas();

            //初始化文件上传插件
            initFileupload('imageFile','preview-image','image-path');

        }, submit:submitForm
    }
})(window);