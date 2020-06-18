/**
 * Created by 柴书祥 on 2016/12/23
 * 意见反馈页脚本
 */
var isSendNotice = false;

(function (window) {
    var DataTable;

    function initDataTables(){
        return $('#notice-table').DataTable({
            searching:false,
            processing: true,
            serverSide: true,
            ordering:false, //排序
            ajax:{
                "url":"/app/notice/list",
                "type": "POST",
                "dataType":"json",
                "data":function(data){
                    data.sendTime=$("#send-date").val();
                    // data.sendObject= $('#send-object').val();
                }
            }
            ,
            columns: [
                {data: "id","visible":false},//visible 隐藏或显示
                {data: "title"},
                {render: function (data, type, row, meta) {
                    return   moment(row.sendTime).format('YYYY-MM-DD HH:mm:ss ');
                }
                },
                {render: function (data, type, row, meta) {
                    return moment(row.expiryTime).format('YYYY-MM-DD HH:mm:ss ');
                }
                },
                {data: "readAmount"},
                {render:function (data, type, row, meta) {
                    var buttons = '';
                    // buttons += $('#button-1').html(); //
                    buttons += $('#button-2').html();
                    return buttons.replace(/#id/g,row.id);
                }
                }

            ],
            language:{
                lengthMenu: "每页 _MENU_ 条记录",//下拉框文字
                info:"第 _PAGE_ 页 ( 总共 _PAGES_ 页 ,共 _TOTAL_ 项)",//左下角显示文字
                infoEmpty:"",//当查询没有数据时左下角显示文字
                sEmptyTable:"没有数据..",//当查询没有数据时表格中间显示文字
                paginate:{                          //分页
                    first:"首页",
                    last:"尾页",
                    next:"下一页",
                    previous:"上一页"
                }
            }
        });
    }

    function initBindEvents(){
        //绑定搜索按钮事件
        $('#search').click(function () {
            DataTable.ajax.reload();
        });

        $('#send-modal-bth').click(function () {
            $('#send-notice-form').bootstrapValidator('resetForm', true);
            $('#preview-image').attr("src","");
            $('#sendTime').val('');
            $('#expiryTime').val('');
            if($('#send-object-select option:selected') .val()==0){
                $('#sendTime').css("display","none");
            }else{
                $('#sendTime').css("display","inline-block");
            }
            $('#send-msg-modal').modal('show');

        });
        $('#send-object-select').unbind('change').change(function () {
            if($('#send-object-select').val()==1){
                $('#sendTime').css("display","inline-block");
            }else{
                $('#sendTime').css("display","none");
            }
        })

        $('#send-btn').unbind('click').click(function () {

            var passValidate = $('#send-notice-form').data('bootstrapValidator').validate().isValid();
            if(!passValidate){
                return false;
            }
            if($('#sendTime').val()==''&& $('#send-object-select').val()==1){
                BootstrapDialog.warning('请选择发送时间！');
                return false;
            }
            if(moment($('#sendTime').val())<moment(new Date())&& $('#send-object-select').val()==1){
                BootstrapDialog.warning('发送时间必须大于当前时间！');
                return false;
            }
            if($('#expiryTime').val()==''){
                BootstrapDialog.warning('请选择失效时间！');
                return false;
            }
            /*var sendDate=new Date();
            if(moment($('#sendTime').val())>moment(sendDate)){
                sendDate=moment($('#sendTime').val())
            }*/
            if(moment($('#expiryTime').val())<= moment(new Date()) ){
                BootstrapDialog.warning("失效时间必须大于当前时间！");
                return false;
            }
            if(moment($('#sendTime').val())>moment($('#expiryTime').val()) ||$('#sendTime').val()==$('#expiryTime').val() ){
                BootstrapDialog.warning("失效时间必须大于发送时间！");
                return false;
            }
            if(passValidate){
                var data = {
                    title:$('#msg-title').val(),
                    content:$('#msg-content').val(),
                    type:$('#send-object-select').val(),
                    imgurl:$('#notice-image-path').val(),
                    readAmount:0,
                    sendTime:$('#sendTime').val().length>0?new Date(Date.parse($('#sendTime').val().replace(/-/g, "/"))):new Date(),
                    expiryTime:new Date(Date.parse($('#expiryTime').val().replace(/-/g, "/"))),
                    createTime:new Date()
                };

                if(isSendNotice) return;
                $.ajax({
                    type : "post",
                    url : "/app/notice/send",
                    data : data,
                    async : false,
                    success : function(data){
                        if (data.code == HttpUtil.success_code){
                            isSendNotice = true;
                            $('#send-msg-modal').modal('hide');
                            //模态框关闭时
                            $('#send-msg-modal').on('hidden.bs.modal', function () {
                                isSendNotice = false;
                            })
                            DataTable.ajax.reload();
                        }else{
                            BootstrapDialog.alert(data.msg);
                        }
                    }
                });
            }
        });

        //绑定表单验证器
        $('#send-notice-form').bootstrapValidator({
            message: 'This value is not valid',
            excluded: [':disabled'],//不加它重新打开模态框时提示不会清除
            fields: {
                title: {
                    validators: {
                        notEmpty: {
                            message: '消息标题不能为空'
                        },
                        stringLength: {
                            max: 40,
                            message: '消息标题不能超过40个字'
                        }
                    }
                },imgurl: {
                    validators: {
                        notEmpty: {
                            message: '上传图片不能为空'
                        }
                    }
                },type: {
                    validators: {
                        notEmpty: {
                            message: '发布类型不能为空'
                        }
                    }
                }/*,sendTime: {
                    validators: {
                        notEmpty: {
                            message: '发布时间不能为空'
                        }
                    }
                },expiryTime: {
                    validators: {
                        notEmpty: {
                            message: '失效时间不能为空'
                        }
                    }
                }*/,
                 content: {
                     validators: {
                         notEmpty: {
                            message: '消息链接不能为空'
                         },
                         stringLength: {
                             max: 100,
                            message: '消息内容不能超过100个字'
                         }, regexp: {
                             regexp: /(http|ftp|https):\/\/[\w\-_]+(\.[\w\-_]+)+([\w\-\.,@?^=%&amp;:/~\+#]*[\w\-\@?^=%&amp;/~\+#])?/,
                             message: '请输入正确的链接地址！'
                         }
                     }
                 }
            }
        });
    }

    /**
     * 查看意见
     * @param id
     */
    function lookMessage(id) {
        $.post('/app/notice/detail',{id:id})
            .done(function (data) {
                if (data.code == HttpUtil.success_code){
                    initFileupload('imageFile-look','preview-image-look','notice-image-path-look');
                   /* var message = data.result;//查看弹框的边度编辑器
                    contentLook.ready(function () {
                        this.setContent(message.content);
                    });*/
                    // $('#send-object-look').val(message.sendObject);
                    $('#title-look').val(message.title);
                    /*$('#content-look').val(message.content);*/
                    $('#notice-image-path-look').val(message.imgurl);
                    $('#sendTime-look').val(moment(message.sendTime).format('YYYY-MM-DD HH:mm:ss '));
                    $('#expiryTime-look').val(moment(message.expiryTime).format('YYYY-MM-DD HH:mm:ss '));
                    $('#preview-image-look').attr("src",message.imgurl);
                    jeDate({
                        dateCell: '#sendTime-look',
                        format:"YYYY-MM-DD  hh:mm:ss",
                        isTime:true,
                        isinitVal:false,
                        defaultDate : moment(message.sendTime),
                        minDate: jeDate.now(0) //0代表今天，-1代表昨天，-2代表前天，以此类推
                        // maxDate: jeDate.now(1) //1代表明天，2代表后天，以此类推 });
                    })
                    jeDate({
                        dateCell: '#expiryTime-look',
                        format:"YYYY-MM-DD  hh:mm:ss",
                        isTime:true,
                        isinitVal:false,
                        defaultDate : new Date(message.expiryTime),
                        minDate: jeDate.now(0) //0代表今天，-1代表昨天，-2代表前天，以此类推
                        // maxDate: jeDate.now(1) //1代表明天，2代表后天，以此类推 });
                    })
                    $('#look-msg-modal').modal('show');
                }else{
                    BootstrapDialog.alert(data.msg);
                }
            })
            .fail(function () {
                BootstrapDialog.alert('请求服务器失败!');
            });
    }


    /**
     * 删除消息
     * @param id
     */
    function deleteMessage(id) {
        BootstrapDialog.confirm({
            title: '删除消息',
            message: '你确认要删除该消息吗？',
            type: BootstrapDialog.TYPE_WARNING,
            closable: true,
            btnCancelLabel: '取消',
            btnOKLabel: '确认',
            btnOKClass: 'btn-warning',
            callback: function (yes) {
                if (yes){
                    $.post('/app/notice/delete',{id:id})
                        .done(function (data) {
                            if (data.code == HttpUtil.success_code){
                                DataTable.ajax.reload();
                            }else{
                                BootstrapDialog.alert(data.msg);
                            }
                        }).fail(function () {
                        BootstrapDialog.alert('请求服务器失败!');
                    });
                }
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
            url:'/upload/appImage?dirName=noticeImg',
            done: function (e, data) {
                if(data.result.code == HttpUtil.success_code){
                    var path = data.result.result.path;
                    $('#'+previewId).attr('src', path);
                    $('#'+savePathInputId).val(path);

                    $('#send-notice-form')//上传成功表单验证设置为通过
                     .data('bootstrapValidator')
                     .updateStatus('imgurl', 'NOT_VALIDATED', null)
                     .validateField('imgurl');
                }else{
                    var alert = BootstrapDialog.alert||window.alert;
                    alert(data.result.msg);
                }
            }
        });
    }
    window.page = {
        init:function () {
            //加载日期选择器
            bootstrapDateUtil.show('send-date');
            //初始化事件绑定
            initBindEvents();
            //初始化DataTables
            DataTable = initDataTables();
            //初始化文件上传插件
            initFileupload('imageFile','preview-image','notice-image-path');

        },
        look:lookMessage,
        delete:deleteMessage
    }
})(window)