/**
 * Created by 李恒名 on 2016/6/12.
 * 订单管理页脚本
 */
(function (window) {
    var DataTable;//对账列表
    var DataTable1;//统计面板
    var orderId;
    var refundStatus = 1;

    //待退款显示列
    var columns = [
        {data: "id", "visible": false},//visible 隐藏或显示
        {data: "orderNum"},
        {data: "programName"},
        {
            render: function (data, type, row, meta) {
                var name;
                if (row.payType == 1) {
                    name = '支付宝';
                } else if (row.payType == 2) {
                    name = '微信支付';
                } else if (row.payType == 3 || row.payType == 4) {
                    name = '财付通(含网银)';
                } else {
                    name = '未知渠道';
                }
                return name;
            }
        },
        {
            render: function (data, type, row, meta) {
                return moment(row.payTime).format('YYYY/MM/DD');
            }
        },
        {data: "costPrice"},
        {data: "realpayPrice"},
        {
            render: function (data, type, row, meta) {
                return '已对账';
            }
        },
        {
            render: function (data, type, row, meta) {
                var buttons = '';
                buttons += $('#button-1').html();
                return buttons.replace(/#id/g, row.id);
            }
        }

    ];

    function initDataTables1(tableId) {
        return $('#' + tableId + '').DataTable({
            bDestroy: true,
            searching: false,
            processing: false,
            serverSide: true,
            ordering: false, //排序
            bPaginate:false,
            ajax: {
                "url": "/order/bill/statistics",
                "type": "POST",
                "dataType": "json",
                "data": function (data) {
                    data.orderNum = $('#order-num').val();
                    data.payType = $('#pay-type').val();
                    var payDateStr = $("#pay-date").val();
                    if(payDateStr || data.orderNum || data.payType){//如果有选择的话使用选择的日期
                        data.payDateStr = payDateStr;
                    }else{//否则默认昨天
                        var date = moment(new Date()).subtract(1,'days').format('YYYY-MM-DD');
                        data.payDateStr = date + '/' + date;
                    }
                }
            }
            ,
            columns: [
                {data: "payTypeDesc"},
                {
                    render: function (data, type, row, meta) {
                        return toThousands(row.count);
                    }
                },
                {
                    render: function (data, type, row, meta) {
                        return fmoney(row.sum);
                    }
                }
            ],
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

    function initDataTables(tableId) {
        return $('#' + tableId + '').DataTable({
            bDestroy: true,
            searching: false,
            processing: true,
            serverSide: true,
            ordering: false, //排序
            ajax: {
                "url": "/order/bill/list",
                "type": "POST",
                "dataType": "json",
                "data": function (data) {
                    data.orderNum = $('#order-num').val();
                    data.payType = $('#pay-type').val();
                    var payDateStr = $("#pay-date").val();
                    if(payDateStr || data.orderNum || data.payType){//如果有选择的话使用选择的日期
                        data.payDateStr = payDateStr;
                    }else{//否则默认昨天
                        var date = moment(new Date()).subtract(1,'days').format('YYYY-MM-DD');
                        data.payDateStr = date + '/' + date;
                    }
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
                },
                decimal:","
            }
        });

    }

    function changeDataCollectTopTips() {
        var active = $('.ranges ul li.active').html();
        if (active == '选择日期') {
            active = '';
        } else {
            active = '(' + active + ')';
        }
        var date = $("#pay-date").val();
        var html = '数据汇总：' + date + active;
        $('#data-collect').html(html)
    }

    function initBindEvents() {
        DataTable = initDataTables('order-table');
        DataTable1 = initDataTables1('order-table1');
        var date = moment(new Date()).subtract(1,'days').format('YYYY-MM-DD');
        var html = '数据汇总：' + date + '/' + date + '(昨天)';
        $('#data-collect').html(html)
        //绑定搜索按钮事件
        $('#search').click(function () {
            //刷新对账列表
            DataTable.ajax.reload();
            if ($('#pay-date').val()){
                changeDataCollectTopTips();
            } else{
                if ($('#order-num').val() || $('#pay-type').val()){
                    $('#data-collect').html('数据汇总');
                }else{
                    $('#data-collect').html(html)
                }

            }
            DataTable1.ajax.reload();

        });


        /*$('#detailTab a[data-toggle="tab"]').on('show.bs.tab', function (e) {

            //type = $(this).attr("data-type");

        });*/

    }

    /**
     * 退款详情
     * @param id 订单id
     */
    function refundDetail(id) {
        var url = '/order/refund/detail';
        $.post(url, {id: id}).done(function (data) {
            if (data.code == HttpUtil.success_code) {
                var detail = data.result;
                var dts = '';
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
                }
                dts += '<dt>申请人：</dt><dd>' + detail.proposerName + '</dd>';
                dts += '<dt>申请时间：</dt><dd>' + moment(detail.ctime).format('YYYY/MM/DD HH:mm ') + '</dd>';
                if (detail.description)
                     dts += '<dt>申请人备注：</dt><dd>' + detail.description + '</dd>';

                $('#detail_2').html(dts);

            } else {
                BootstrapDialog.alert(data.msg);
            }
        }).fail(function () {
            BootstrapDialog.alert('请求服务器失败!');
        });
    }


    /**
     * 查看订单
     * @param id 订单id
     */
    function look(id) {
        $('#detailTab a:first').tab('show');
        $.post('/order/detail', {id: id}).done(function (data) {
            if (data.code == HttpUtil.success_code) {
                var order = data.result;
                var dts = '';
                dts += '<dt>订单编号：</dt><dd>' + order.orderNum + '</dd>';
                dts += '<dt>购买账号：</dt><dd>' + order.username + '</dd>';
                dts += '<dt>会员套餐：</dt><dd>' + order.programName + '</dd>';
                dts += '<dt>来源：</dt><dd>' + order.remark + '</dd>';
                dts += '<dt>下单日期：</dt><dd>' + moment(order.orderTime).format('YYYY-MM-DD HH:mm:ss ') + '</dd>';
                if (order.payStatus == 1 || order.payStatus == 2) {
                    dts += '<dt>支付日期：</dt><dd>' + moment(order.payTime).format('YYYY-MM-DD HH:mm:ss ') + '</dd>';
                    var name;
                    if (order.payType == 1) {
                        name = '支付宝';
                    } else if (order.payType == 2) {
                        name = '微信支付';
                    } else if (order.payType == 3 || order.payType == 4) {
                        name = '财付通(含网银)';
                    } else {
                        name = '未知渠道';
                    }
                    dts += '<dt>支付渠道：</dt><dd>' + name + '</dd>';
                    dts += '<dt>支付流水号：</dt><dd>' + order.payNum + '</dd>';
                }
                dts += '<dt>支付状态：</dt><dd>' + order.statusDesc + '</dd>';
                dts += '<dt>订单金额：</dt><dd>' + order.costPrice + '</dd>';
                dts += '<dt>实付金额：</dt><dd>' + order.realpayPrice + '</dd>';
                if (order.payStatus == 2) {
                    dts += '<dt>退款日期：</dt><dd>' + moment(order.backTime).format('YYYY-MM-DD HH:mm:ss ') + '</dd>';
                    dts += '<dt>退款金额：</dt><dd>' + order.backPrice + '</dd>';
                    dts += '<dt>退款备注：</dt><dd>' + order.backContent + '</dd>';
                }
                $('#detail-1-dl').html(dts);
                $('#order-look-modal').modal('show');
            } else {
                BootstrapDialog.alert(data.msg);
            }

            $.post('/order/refund/detail', {id: id}).done(function (data) {
                if (data.code == HttpUtil.success_code) {
                    var detailList = data.result;
                    var dts = '';
                    if(detailList.length>0){//有退款
                        $.each(detailList,function (index, detail) {
                            if (index == 0){
                                dts += '<dt>订单编号：</dt><dd>' + detail.orderNum + '</dd>';
                                dts += '<dt>支付流水号：</dt><dd>' + detail.payNum + '</dd>';
                                dts += '<dt>会员套餐：</dt><dd>' + detail.programName + '</dd>';
                                dts += '<dt>订单金额：</dt><dd>' + detail.costPrice + '</dd>';
                                dts += '<dt>实付金额：</dt><dd>' + detail.realpayPrice + '</dd>';
                                var name;
                                if (order.payType == 1) {
                                    name = '支付宝';
                                } else if (order.payType == 2) {
                                    name = '微信支付';
                                } else if (order.payType == 3 || order.payType == 4) {
                                    name = '财付通(含网银)';
                                } else {
                                    name = '未知渠道';
                                }
                                dts += '<dt>支付渠道：</dt><dd>' + name + '</dd>';
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
                    }else{//沒有退款
                        dts += '订单没有申请退款';
                    }
                    $('#detail-2-dl').html(dts);

                } else {
                    BootstrapDialog.alert(data.msg);
                }
            }).fail(function () {
                BootstrapDialog.alert('请求服务器失败!');
            });
        }).fail(function () {
            BootstrapDialog.alert('请求服务器失败!');
        });
    }

    function fmoney(s, n) {
        n = n > 0 && n <= 20 ? n : 2;
        s = parseFloat((s + "").replace(/[^\d\.-]/g, "")).toFixed(n) + "";
        var l = s.split(".")[0].split("").reverse(), r = s.split(".")[1];
        t = "";
        for (i = 0; i < l.length; i++) {
            t += l[i] + ((i + 1) % 3 == 0 && (i + 1) != l.length ? "," : "");
        }
        return t.split("").reverse().join("") + "." + r;
    }

    function toThousands(num) {
        var num = (num || 0).toString(), result = '';
        while (num.length > 3) {
            result = ',' + num.slice(-3) + result;
            num = num.slice(0, num.length - 3);
        }
        if (num) { result = num + result; }
        return result;
    }
    //需要暴露到global域的API
    window.page = {
        init: function () {
            //初始化事件绑定
            initBindEvents();
            //加载日期选择器
            bootstrapDateUtil.show('pay-date');
        },
        look: look
    };

})(window);