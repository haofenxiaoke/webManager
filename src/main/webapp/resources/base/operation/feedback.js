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
                "url":"/suggestion/list",
                "type": "POST",
                "dataType":"json",
                "data":function(data){
                    data.feedbackDateStr=$("#feedback-date").val();
                    data.status= $('#reply-status').val();
                }
            }
            ,
            columns: [
                {data: "id", "visible": false},//visible 隐藏或显示
                {data: "username"},
                {data: "nickName"},
                {data: "feedbackDesc",'className':'word-break'},
                {render: function (data, type, row, meta) {
                    if (row.replyStatus == 1)
                        return '已回复';
                    return '未回复';
                    }
                },
                {render: function (data, type, row, meta) {
                          return   moment(row.feedbackAddTime).format('YYYY-MM-DD HH:mm:ss ');
                     }
                },
                {data: "phone"},
                {render:function (data, type, row, meta) {
                        var buttons = '';
                        if (row.replyStatus == 1){
                            buttons += $('#button-1').html();
                        }else{
                            buttons += $('#button-2').html();
                        }
                        buttons += $('#button-3').html();
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

        //绑定表单验证器
        $('#feedback-reply-form').bootstrapValidator({
            message: 'This value is not valid',
            excluded: [':disabled'],//不加它重新打开模态框时提示不会清除
            fields: {
                replyContent: {
                    validators: {
                        notEmpty: {
                            message: '回复内容不能为空'
                        },
                        stringLength: {
                            max: 500,
                            message: '回复内容不能超过500个字'
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
    function lookSuggestion(id) {
        $.post('/suggestion/detail',{id:id})
            .done(function (data) {
                if (data.code == HttpUtil.success_code){
                    var feedback = data.result;
                    $('#reply-person').val(feedback.flowerName);
                    $('#reply-date').val(moment(feedback.feedbackReplyTime).format('YYYY-MM-DD HH:mm:ss'));
                    $('#reply-content-2').val(feedback.feedbackReply);
                    $('#feedback-look-modal').modal('show');
                }else{
                    BootstrapDialog.alert(data.msg);
                }
            })
            .fail(function () {
                BootstrapDialog.alert('请求服务器失败!');
            });
    }

    /**
     * 反馈
     * @param id
     */
    function replySuggestion(id) {
        //重置表单
        $('#feedback-reply-form').bootstrapValidator('resetForm', true);
        $('#feedback-reply-modal').modal('show');

        //绑定意见回复按钮点击事件
        $('#feedback-reply-btn').unbind('click').click(function () {
            var passValidate = $('#feedback-reply-form').data('bootstrapValidator').validate().isValid();
            if(passValidate){
                var data = {
                    id:id,
                    feedbackReply:$('#reply-content').val()
                };
                $.post('/suggestion/reply',data)
                    .done(function (data) {
                        if (data.code == HttpUtil.success_code){
                            $('#feedback-reply-modal').modal('hide');
                            DataTable.ajax.reload();
                        }else{
                            BootstrapDialog.alert(data.msg);
                        }
                    }).fail(function () {
                    BootstrapDialog.alert('请求服务器失败!');
                });


            }
        });
    }

    /**
     * 删除意见
     * @param id
     */
    function deleteSuggestion(id) {
        BootstrapDialog.confirm({
            title: '删除意见',
            message: '你确认要删除该意见吗？',
            type: BootstrapDialog.TYPE_WARNING,
            closable: true,
            btnCancelLabel: '取消',
            btnOKLabel: '确认',
            btnOKClass: 'btn-warning',
            callback: function (yes) {
                if (yes){
                    $.post('/suggestion/delete',{id:id})
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
            bootstrapDateUtil.show('feedback-date');
            //初始化事件绑定
            initBindEvents();
            //初始化DataTables
            DataTable = initDataTables();
        },
        look:lookSuggestion,
        reply:replySuggestion,
        delete:deleteSuggestion
    }
})(window)