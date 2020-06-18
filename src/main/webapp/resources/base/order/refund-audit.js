/**
 * Created by 李恒名 on 2016/6/12.
 * 订单管理页脚本
 */
(function (window) {
    var DataTable;
    var refundStatus = 1;
    //待审核显示列
    var columns_1 = [
        {data: "id", "visible": false},//visible 隐藏或显示
        {data: "orderNum"},
        {data: "programName"},
        {
            render: function (data, type, row, meta) {
                if (row.refundMoney){
                    return row.refundMoney;
                }
                return 0;
            }
        },
        {data: "proposerName"},
        {
            render: function (data, type, row, meta) {
                return moment(row.ctime).format('YYYY/MM/DD HH:mm:ss ');
            }
        },
        {data: "orderUsername"},
        {
            render: function (data, type, row, meta) {
                var buttons = '';
                buttons += $('#button-2').html();
                buttons = buttons.replace(/#orderId/g, row.orderId);
                buttons = buttons.replace(/#id/g, row.id);
                return buttons;
            }
        }

    ];
    //待退款显示列
    var columns_2 = [
        {data: "id", "visible": false},//visible 隐藏或显示
        {data: "orderNum"},
        {data: "programName"},
        {
            render: function (data, type, row, meta) {
                if (row.refundMoney){
                    return row.refundMoney;
                }
                return 0;
            }
        },
        {data: "proposerName"},
        {
            render: function (data, type, row, meta) {
                return moment(row.teacherManagerPassTime).format('YYYY/MM/DD HH:mm:ss ');
            }
        },
        {data: "orderUsername"},
        {
            render: function (data, type, row, meta) {
                var buttons = '';
                buttons += $('#button-1').html();
                return buttons.replace(/#orderId/g, row.orderId);
            }
        }

    ];

    //已退款显示列
    var columns_3 = [
        {data: "id", "visible": false},//visible 隐藏或显示
        {data: "orderNum"},
        {data: "programName"},
        {
            render: function (data, type, row, meta) {
                if (row.refundMoney){
                    return row.refundMoney;
                }
                return 0;
            }
        },
        {data: "proposerName"},
        {
            render: function (data, type, row, meta) {
                return moment(row.financePassTime).format('YYYY/MM/DD HH:mm:ss ');
            }
        },
        {data: "orderUsername"},
        {
            render: function (data, type, row, meta) {
                var buttons = '';
                buttons += $('#button-1').html();
                return buttons.replace(/#orderId/g, row.orderId);
            }
        }

    ];
    var columns = columns_1;

    function initDataTables(tableId) {
        return $('#' + tableId + '').DataTable({
            bDestroy: true,
            searching: false,
            processing: true,
            serverSide: true,
            ordering: false, //排序
            ajax: {
                "url": "/order/refund/audit/list",
                "type": "POST",
                "dataType": "json",
                "data": function (data) {
                    data.orderNum = $('#order-num').val();
                    data.username = $('#username').val();
                    data.orderDateStr = $("#order-date").val();
                    data.refundStatus = refundStatus;

                }
            }
            ,
            columns: columns,
            language: {
                lengthMenu: "每页 _MENU_ 条记录",//下拉框文字
                info: "第 _PAGE_ 页 ( 总共 _PAGES_ 页 ,共 _TOTAL_ 项)",//左下角显示文字
                infoEmpty: "",//当查询没有数据时左下角显示文字
                sEmptyTable: "没有数据..",//当查询没有数据时表格中间显示文字
                paginate: {                          //分页
                    first: "首页",
                    last: "尾页",
                    next: "下一页",
                    previous: "上一页"
                }
            }
        });

    }

    function initBindEvents() {
        // 绑定tab显示之前事件
        $('#tabs a').on('show.bs.tab', function (e) {
            $('#search-form')[0].reset();
            refundStatus = $(this).data('status');
            if (refundStatus == 1) {
                columns = columns_1;
                $('#order-date').attr('placeholder', '选择申请日期');
            } else if (refundStatus == 2) {
                columns = columns_2;
                $('#order-date').attr('placeholder', '选择审批日期');
            } else if (refundStatus == 3) {
                columns = columns_3;
                $('#order-date').attr('placeholder', '选择退款日期');
            }
            DataTable = initDataTables('order-table-' + refundStatus);
            //DataTable.ajax.reload();
        });

        //页面加载之后默认显示第一个tab
        $('#tabs a:first').tab('show');

        //绑定tab点击事件
        $('#tabs a').click(function (e) {
            $(this).tab('show')
        });

        //绑定搜索按钮事件
        $('#search').click(function () {
            DataTable.ajax.reload();
        });
    }

    /**
     *
     * @param id 退款详情id
     * @param orderId 订单ID
     */
    function showRefundDetailModel(orderId, id) {
        var url = '/order/refund/detail';
        $.post(url, {id: orderId}).done(function (data) {
            if (data.code == HttpUtil.success_code) {
                var detailList = data.result;
                var dts = '';
                if (!id) {//仅查看
                    $('#pass-btns').hide();
                    $.each(detailList, function (index, detail) {
                        if (index == 0) {
                            dts += '<dt>订单编号：</dt><dd>' + detail.orderNum + '</dd>';
                            dts += '<dt>会员套餐：</dt><dd>' + detail.programName + '</dd>';
                            dts += '<dt>订单金额：</dt><dd>' + detail.costPrice + '</dd>';
                            dts += '<dt>实付金额：</dt><dd>' + detail.realpayPrice + '</dd>';
                            dts += '<dt>支付方式：</dt><dd>' + detail.payTypeDesc + '</dd>';
                            dts += '<dt>退款状态：</dt><dd>' + detail.refundStatusDesc + '</dd>';
                            dts += '<hr/>';
                        }
                        if (detail.payType != 5) {//排除优惠券支付
                            dts += '<dt>退款金额：</dt><dd>' + detail.refundMoney + '</dd>';
                            dts += '<dt>银行名称：</dt><dd>' + detail.bankName + '</dd>';
                            dts += '<dt>银行账户姓名：</dt><dd>' + detail.bankAccountName + '</dd>';
                            dts += '<dt>银行卡号：</dt><dd>' + detail.bankCardNum + '</dd>';
                            dts += '<dt>地址：</dt><dd>' + detail.address + '</dd>';
                            dts += '<dt>支行名称：</dt><dd>' + detail.openAccountBankName + '</dd>';
                            dts += '<br/>';
                        }
                        if (detail.financeManagerName) {
                            dts += '<dt>财务审批人：</dt><dd>' + detail.financeManagerName + '</dd>';
                            dts += '<dt>审批时间：</dt><dd>' + moment(detail.financeManagerPassTime).format('YYYY/MM/DD HH:mm ') + '</dd>';
                            if (detail.financeManagerOpinion)
                                dts += '<dt>审批意见：</dt><dd>' + detail.financeManagerOpinion + '</dd>';
                            dts += '<br/>';
                        }
                        if (detail.financeName) {
                            dts += '<dt>财务审批人：</dt><dd>' + detail.financeName + '</dd>';
                            dts += '<dt>审批时间：</dt><dd>' + moment(detail.financePassTime).format('YYYY/MM/DD HH:mm ') + '</dd>';
                            if (detail.financeOpinion)
                                dts += '<dt>审批意见：</dt><dd>' + detail.financeOpinion + '</dd>';
                            dts += '<br/>';
                        }
                        if (detail.teacherManagerName) {
                            dts += '<dt>教务审批人：</dt><dd>' + detail.teacherManagerName + '</dd>';
                            dts += '<dt>审批时间：</dt><dd>' + moment(detail.teacherManagerPassTime).format('YYYY/MM/DD HH:mm ') + '</dd>';
                            if (detail.teacherManagerOpinion)
                                dts += '<dt>审批意见：</dt><dd>' + detail.teacherManagerOpinion + '</dd>';
                            dts += '<br/>';
                        }
                        dts += '<dt>申请人：</dt><dd>' + detail.proposerName + '</dd>';
                        dts += '<dt>申请时间：</dt><dd>' + moment(detail.ctime).format('YYYY/MM/DD HH:mm ') + '</dd>';
                        if (detail.description)
                            dts += '<dt>申请人备注：</dt><dd>' + detail.description + '</dd>';

                        if ((index + 1) != length)
                            dts += '<hr/>';

                    });
                } else {
                    var detail = detailList[0];
                    dts += '<dt>订单编号：</dt><dd>' + detail.orderNum + '</dd>';
                    dts += '<dt>会员套餐：</dt><dd>' + detail.programName + '</dd>';
                    dts += '<dt>订单金额：</dt><dd>' + detail.costPrice + '</dd>';
                    dts += '<dt>实付金额：</dt><dd>' + detail.realpayPrice + '</dd>';
                    dts += '<dt>支付方式：</dt><dd>' + detail.payTypeDesc + '</dd>';
                    dts += '<dt>退款状态：</dt><dd>' + detail.refundStatusDesc + '</dd>';
                    dts += '<hr/>';
                    if (detail.payType != 5) {//排除优惠券支付
                        dts += '<dt>退款金额：</dt><dd>' + detail.refundMoney + '</dd>';
                        dts += '<dt>银行名称：</dt><dd>' + detail.bankName + '</dd>';
                        dts += '<dt>银行账户姓名：</dt><dd>' + detail.bankAccountName + '</dd>';
                        dts += '<dt>银行卡号：</dt><dd>' + detail.bankCardNum + '</dd>';
                        dts += '<dt>地址：</dt><dd>' + detail.address + '</dd>';
                        dts += '<dt>支行名称：</dt><dd>' + detail.openAccountBankName + '</dd>';
                        dts += '<br/>';
                    }
                    if (detail.refundStatus == 3 && detail.payType != 5) {
                        if (detail.financeManagerName) {
                            dts += '<dt>财务审批人：</dt><dd>' + detail.financeManagerName + '</dd>';
                            dts += '<dt>审批时间：</dt><dd>' + moment(detail.financeManagerPassTime).format('YYYY/MM/DD HH:mm ') + '</dd>';
                            if (detail.financeManagerOpinion)
                                dts += '<dt>审批意见：</dt><dd>' + detail.financeManagerOpinion + '</dd>';
                            dts += '<br/>';
                        }
                        dts += '<dt>财务审批人：</dt><dd>' + detail.financeName + '</dd>';
                        dts += '<dt>审批时间：</dt><dd>' + moment(detail.financePassTime).format('YYYY/MM/DD HH:mm ') + '</dd>';
                        if (detail.financeOpinion)
                            dts += '<dt>审批意见：</dt><dd>' + detail.financeOpinion + '</dd>';
                        dts += '<br/>';
                        dts += '<dt>教务审批人：</dt><dd>' + detail.teacherManagerName + '</dd>';
                        dts += '<dt>审批时间：</dt><dd>' + moment(detail.teacherManagerPassTime).format('YYYY/MM/DD HH:mm ') + '</dd>';
                        if (detail.teacherManagerOpinion)
                            dts += '<dt>审批意见：</dt><dd>' + detail.teacherManagerOpinion + '</dd>';
                        dts += '<br/>';
                    } else if (detail.refundStatus == 2) {
                        dts += '<dt>教务审批人：</dt><dd>' + detail.teacherManagerName + '</dd>';
                        dts += '<dt>审批时间：</dt><dd>' + moment(detail.teacherManagerPassTime).format('YYYY/MM/DD HH:mm ') + '</dd>';
                        if (detail.teacherManagerOpinion)
                            dts += '<dt>审批意见：</dt><dd>' + detail.teacherManagerOpinion + '</dd>';
                        dts += '<br/>';
                    }

                    dts += '<dt>申请人：</dt><dd>' + detail.proposerName + '</dd>';
                    dts += '<dt>申请时间：</dt><dd>' + moment(detail.ctime).format('YYYY/MM/DD HH:mm ') + '</dd>';
                    if (detail.description)
                          dts += '<dt>申请人备注：</dt><dd>' + detail.description + '</dd>';
                    dts += '<br/>';

                    dts += '<dt>审批意见：</dt><dd><textarea id="teacherManagerOpinion" cols="30" maxlength="200"></textarea></dd>';
                    $('#pass-btns').show();
                }
                $('#refund-detail-dl').html(dts);
                $('#refund-look-modal').modal('show');

                //绑定审核按钮点击事件
                $('#pass-btn').unbind().click(function () {
                    onAuditBtnClick(id, true);
                });
                $('#no-pass-btn').unbind().click(function () {
                    onAuditBtnClick(id, false);
                });
            } else {
                BootstrapDialog.alert(data.msg);
            }
        }).fail(function () {
            BootstrapDialog.alert('请求服务器失败!');
        });

    }

    function onAuditBtnClick(id, pass) {
        var option = pass ? '通过' : '不通过';
        BootstrapDialog.confirm({
            title: '确认' + option + '审批',
            message: '你确认要' + option + '审批吗？',
            type: BootstrapDialog.TYPE_WARNING,
            closable: true,
            btnCancelLabel: '取消',
            btnOKLabel: '确认',
            btnOKClass: 'btn-warning',
            callback: function (yes) {
                if (yes) {
                    var data = {
                        id: id,
                        pass: pass,
                        teacherManagerOpinion: $.trim($('#teacherManagerOpinion').val()),
                    }
                    $.post('/order/refund/audit/teacher', data).done(function (data) {
                        if (data.code == HttpUtil.success_code) {
                            $('#refund-look-modal').modal('hide');
                        } else {
                            BootstrapDialog.alert(data.msg);
                        }
                        DataTable.ajax.reload();
                    }).fail(function () {
                        BootstrapDialog.alert('请求服务器失败!');
                    });
                }
            }
        });
    }

    function look(orderId) {
        showRefundDetailModel(orderId,false);
    }

    function audit(orderId,id) {
        showRefundDetailModel(orderId, id);
    }

    //需要暴露到global域的API
    window.page = {
        init: function () {
            //初始化事件绑定
            initBindEvents();
            //加载日期选择器
            bootstrapDateUtil.show('order-date');
        },
        audit: audit,
        look: look
    };

})(window);