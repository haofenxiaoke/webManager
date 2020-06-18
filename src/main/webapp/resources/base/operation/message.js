/**
 * Created by 李恒名 on 2016/6/14.
 * 意见反馈页脚本
 */

(function (window) {
    var DataTable;

    function initDataTables(){
        return $('#feedback-table').DataTable({
            searching:false,
            processing: true,
            serverSide: true,
            ordering:false, //排序
            ajax:{
                "url":"/message/list",
                "type": "POST",
                "dataType":"json",
                "data":function(data){
                    data.sendDateStr=$("#send-date").val();
                    data.sendObject= $('#send-object').val();
                }
            }
            ,
            columns: [
                {data: "id", "visible": false},//visible 隐藏或显示
                {data: "title"},
                {render: function (data, type, row, meta) {
                    if (row.sendObject == 1)
                        return '付费学员';
                    if (row.sendObject == 0)
                        return '免费学员';
                    return '未知';
                    }
                },
                {render: function (data, type, row, meta) {
                          return   moment(row.sendtime).format('YYYY-MM-DD HH:mm:ss ');
                     }
                },
                {data: "senderName"},
                {render:function (data, type, row, meta) {
                        var buttons = '';
                        buttons += $('#button-1').html();
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
            $('#send-msg-form').bootstrapValidator('resetForm', true);
            $('#send-msg-modal').modal('show');
        });

        $('#send-btn').click(function () {
            var passValidate = $('#send-msg-form').data('bootstrapValidator').validate().isValid();
            if(passValidate){
                var data = {
                    sendObject:$('#send-object-select').val(),
                    title:$('#msg-title').val(),
                    content:$('#msg-content').val()
                };
                $.post('/message/send',data)
                    .done(function (data) {
                        if (data.code == HttpUtil.success_code){
                            $('#send-msg-modal').modal('hide');
                            DataTable.ajax.reload();
                        }else{
                            BootstrapDialog.alert(data.msg);
                        }
                    }).fail(function () {
                    BootstrapDialog.alert('请求服务器失败!');
                });
            }
        });
        //绑定表单验证器
        $('#send-msg-form').bootstrapValidator({
            message: 'This value is not valid',
            excluded: [':disabled'],//不加它重新打开模态框时提示不会清除
            fields: {
                msgTitle: {
                    validators: {
                        notEmpty: {
                            message: '消息标题不能为空'
                        },
                        stringLength: {
                            max: 50,
                            message: '消息标题不能超过50个字'
                        }
                    }
                },
                msgContent: {
                    validators: {
                        notEmpty: {
                            message: '消息内容不能为空'
                        },
                        stringLength: {
                            max: 1000,
                            message: '消息内容不能超过1000个字'
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
        $.post('/message/detail',{id:id})
            .done(function (data) {
                if (data.code == HttpUtil.success_code){
                    var message = data.result;

                    if (message.sendObject == 0)
                        message.sendObject = '免费学员'
                    else if (message.sendObject == 1)
                        message.sendObject = '付费学员'
                    else
                        message.sendObject = '未知学员'

                    $('#send-object-look').val(message.sendObject);
                    $('#msg-title-look').val(message.title);
                    $('#msg-content-look').val(message.content);
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
                    $.post('/message/delete',{id:id})
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
    window.page = {
        init:function () {
            //加载日期选择器
            bootstrapDateUtil.show('send-date');
            //初始化事件绑定
            initBindEvents();
            //初始化DataTables
            DataTable = initDataTables();
        },
        look:lookMessage,
        delete:deleteMessage
    }
})(window)