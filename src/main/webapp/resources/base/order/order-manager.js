/**
 * Created by 李恒名 on 2016/6/12.
 * 订单管理页脚本
 */
(function (window) {
    var DataTable;
    var orderStatus = 1;
    //未付款显示列
    var columns_0 = [
        {data: "id", "visible": false},//visible 隐藏或显示
        {
            render: function (data, type, row, meta) {
                return row.orderNum;;
            }
        },
        {data: "username"},
        {data: "programName"},
        {data: "remark"},
        {
            render: function (data, type, row, meta) {
                return moment(row.orderTime).format('YYYY-MM-DD HH:mm:ss ');
            }
        },
        {data: "costPrice"},
        {
            render: function (data, type, row, meta) {
                var buttons = '';
                buttons += $('#button-1').html();
                if (row.sourceGid != null && row.remark == '网站前台' && row.realpayPrice > 0) {
                    buttons += $('#button-3').html()
                        .replace(/#sourceChannel/g, row.sourceChannel)
                        .replace(/#sourceInfo/g, row.sourceInfo)
                        .replace(/#type/g, 2);
                }
                return buttons.replace(/#id/g, row.id);
            }
        }

    ];
    //已付款显示列
    var columns_1 = [
        {data: "id", "visible": false},//visible 隐藏或显示
        {
            render: function (data, type, row, meta) {
                return row.orderNum;
            }
        },
        {data: "username"},
        {data: "programName"},
        {data: "remark"},
        {
            render: function (data, type, row, meta) {
                return moment(row.orderTime).format('YYYY-MM-DD HH:mm:ss ');
            }
        },
        {
            render: function (data, type, row, meta) {
                return moment(row.payTime).format('YYYY-MM-DD HH:mm:ss ');
            }
        },
        {data: "costPrice"},
        {data: "realpayPrice"},
        {
            render: function (data, type, row, meta) {
                var buttons = '';
                buttons += $('#button-1').html();
                if (!row.auditStatus || row.auditStatus == '0') {
                    buttons += $('#button-2').html();
                }
                if (row.sourceGid != null && row.remark == '网站前台' && row.realpayPrice > 0) {
                    buttons += $('#button-3').html()
                        .replace(/#sourceChannel/g, row.sourceChannel)
                        .replace(/#sourceInfo/g, row.sourceInfo)
                        .replace(/#type/g, 2);
                }
                return buttons.replace(/#id/g, row.id);
            }
        }

    ];

    //已退款显示列
    var columns_2 = [
        {data: "id", "visible": false},//visible 隐藏或显示
        {
            render: function (data, type, row, meta) {
                return row.orderNum;
            }
        },
        {data: "username"},
        {data: "programName"},
        {data: "remark"},
        {
            render: function (data, type, row, meta) {
                return moment(row.orderTime).format('YYYY-MM-DD HH:mm:ss ');
            }
        },
        {
            render: function (data, type, row, meta) {
                return moment(row.backTime).format('YYYY-MM-DD HH:mm:ss ');
            }
        },
        {
            render: function (data, type, row, meta) {
                if (row.backPrice)
                    return row.backPrice;
                return 0;
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
    var columns = columns_1;

    function initDataTables(tableId) {
        return $('#' + tableId + '').DataTable({
            bDestroy: true,
            searching: false,
            processing: true,
            serverSide: true,
            ordering: false, //排序
            ajax: {
                "url": "/order/list",
                "type": "POST",
                "dataType": "json",
                "data": function (data) {
                    data.orderNum = $('#order-num').val();
                    data.username = $('#username').val();
                    data.orderDateStr = $("#order-date").val();
                    data.payDateStr = $('#pay-date').val();
                    data.orderStatus = orderStatus;
                    data.payMoney = $('#pay-money').val();

                }
            },
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
            },
            dom: '<"left"f>r<"right"<"#light"l><"Blight"B>>tip',
            buttons: [{
                'extend': 'excel',
                'text': '导出excel',//定义导出excel按钮的文字
                'exportOptions': {
                    'modifier': {
                        'page': 'ALL'
                    }
                }
            }  ],
        });

    }

    function initBindEvents() {
        // 绑定tab显示之前事件
        $('#tabs a').on('show.bs.tab', function (e) {
            $('#search-form')[0].reset();
            orderStatus = $(this).data('status');
            if (orderStatus == 0) {
                columns = columns_0;
            } else if (orderStatus == 1) {
                columns = columns_1;
            } else if (orderStatus == 2) {
                columns = columns_2;
            }
            DataTable = initDataTables('order-table-' + orderStatus);
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
        
        //绑定表单验证器
        $('#order-refund-form').bootstrapValidator({
            message: 'This value is not valid',
            excluded: [':disabled'],//不加它重新打开模态框时提示不会清除
            fields: {
                refundMoney: {
                    validators: {
                        notEmpty: {
                            message: '请输入退款金额'
                        },
                        regexp: {
                            regexp: /^\d+(\.\d{1,2})?$/i,
                            message: '只能为正整数，小数点最多两位'
                        },
                        callback: {
                            message: '退款金额，需要小于或等于实际支付金额且大于0',
                            callback: function (value, validator) {
                                console.log(validator);
                                if (!value)
                                    return true;
                                return value > 0 && value <= parseFloat($('#pay-price').val());
                            }
                        }
                    }
                },
                bankName: {
                    validators: {
                        notEmpty: {
                            message: '请输入银行名称'
                        },
                        stringLength: {
                            max: 20,
                            message: '银行名称不能超过20个字'
                        }
                    }
                },
                bankAccountName: {
                    validators: {
                        notEmpty: {
                            message: '请输入银行账户姓名'
                        },
                        stringLength: {
                            max: 10,
                            message: '银行账户姓名不能超过10个字'
                        }
                    }
                },
                bankCardNum: {
                    validators: {
                        notEmpty: {
                            message: '请输入银行卡号'
                        },
                        stringLength: {
                            min:5,
                            max: 20,
                            message: '银行卡号必须为5-20个数字'
                        }
                    }
                },
                province: {
                    validators: {
                        notEmpty: {
                            message: '请选择省份'
                        },
                        callback: {
                            message: '请选择省份',
                            callback: function (value, validator) {
                                return value != '省';
                            }
                        }
                    }
                },
                city: {
                    validators: {
                        notEmpty: {
                            message: '请选择城市'
                        },
                        callback: {
                            message: '请选择城市',
                            callback: function (value, validator) {
                                return value != '市';
                            }
                        }
                    }
                },
                address: {
                    validators: {
                        notEmpty: {
                            message: '请输入详细地址'
                        },
                        stringLength: {
                            max: 50,
                            message: '详细地址不能超过50个字'
                        }
                    }
                },
                openAccountBankName: {
                    validators: {
                        notEmpty: {
                            message: '请输入支行名称'
                        },
                        stringLength: {
                            max: 20,
                            message: '详细地址不能超过20个字'
                        }
                    }
                }

            }
        });
        initChinaArea();
    }

    /**
     * 导出数据
     * @param aLink
     */
    function exportData(aLink) {
        layer.msg('数据正在导出中，可能需要等候3秒到1分钟...', {
            icon: 16
            ,time: 5000
            ,shade: [0.8, '#393D49']
        });

        var datas = {};
        datas.orderNum = $('#order-num').val();
        datas.username = $('#username').val();
        datas.orderDateStr = $("#order-date").val();
        datas.payDateStr = $('#pay-date').val();
        datas.orderStatus = orderStatus;
        datas.payMoney = $('#pay-money').val();
        datas.length = -1;

        var separator = ',\u200C';
        var htmlText = '订单编号,购买账号,会员套餐,来源,下单日期,支付日期,订单金额,实付金额,来源渠道,首次进入网址';

        $.ajax({
            url:"/order/export/csv/answers",
            type:"post",
            dataType:"json",
            cache: false,
            async: false,
            data :datas,
            success: function (data){
                if(data.code == HttpUtil.success_code){
                    $.each(data.result, function (index,order) {
                        htmlText += '\n\u200C'+order.orderNum+
                            separator+order.username+
                            separator+order.programName+
                            separator+order.remark+
                            separator+moment(order.orderTime).format('YYYY-MM-DD HH:mm:ss ')+
                            separator+moment(order.payTime).format('YYYY-MM-DD HH:mm:ss ')+
                            separator+order.costPrice+
                            separator+(order.payStatus == 1 ? order.realpayPrice:0)+
                            separator+(order.sourceChannel ? order.sourceChannel : '')+
                            separator+(order.firstIntoUrl ? order.firstIntoUrl : '')+
                            separator ;
                    })
                }
            }
        })

        aLink.download = $('#export').attr('download');
        var blob = new Blob(["\ufeff", htmlText],{type: 'text/csv'});
        aLink.href = URL.createObjectURL(blob);
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
                    dts += '<dt>支付方式：</dt><dd>' + order.payTypeDesc + '</dd>';
                    dts += '<dt>支付流水号：</dt><dd>' + order.payNum + '</dd>';
                }
                dts += '<dt>支付状态：</dt><dd>' + order.statusDesc + '</dd>';
                dts += '<dt>订单金额：</dt><dd>' + order.costPrice + '</dd>';
                dts += '<dt>实付金额：</dt><dd>' + (order.payStatus == 1 ? order.realpayPrice:0) + '</dd>';

                var reduceTypeDesc = '';
                if (order.reduceType == 1){
                    reduceTypeDesc = '优惠券';
                }else if (order.reduceType == 2){
                    reduceTypeDesc = '优惠码';
                }
                dts += '<dt>优惠方式：</dt><dd>' + reduceTypeDesc + '</dd>';
                if (order.payStatus == 2) {
                    dts += '<dt>退款日期：</dt><dd>' + moment(order.backTime).format('YYYY-MM-DD HH:mm:ss ') + '</dd>';
                    dts += '<dt>退款金额：</dt><dd>' + order.backPrice + '</dd>';
                    dts += '<dt>退款备注：</dt><dd>' + order.backContent + '</dd>';
                }

                if (order.payStatus ==0){
                    $('#detail-unpay').html(dts);
                    $('#order-look-modal-unpay').modal('show');
                }else{
                    $('#detail-1-dl').html(dts);
                    $('#order-look-modal').modal('show');
                }

            } else {
                BootstrapDialog.alert(data.msg);
            }

            $.post('/order/refund/detail', {id: id}).done(function (data) {
                if (data.code == HttpUtil.success_code) {
                    var detailList = data.result;
                    var dts = '';
                    var length = detailList.length;
                    if(length>0){//有退款
                        $.each(detailList,function (index, detail) {
                            if (index == 0){
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

    /**
     * 退款
     * @param id 订单id
     */
    function orderRefund(id) {
        //重置表单
        $('#order-refund-form').bootstrapValidator('resetForm', true);
        var url = '/order/refund/info';
        $.post(url, {id: id}).done(function (data) {
            if (data.code == HttpUtil.success_code) {
                var order = data.result;
                var isVoucherPay = order.payType == '5';
                //优惠券订单
                if (isVoucherPay) {
                    $('#refund-detail').hide();
                } else {
                    $('#refund-detail').show();
                }
                $('#refund-order-num').val(order.orderNum);
                $('#pay-num').val(order.payNum);
                $('#vip-name').val(order.programName);
                $('#order-price').val(order.costPrice);
                $('#pay-price').val(order.realpayPrice);
                $('#pay-type').val(order.payTypeDesc);
                $('#order-refund-modal').modal('show');
                $('#refund-button').unbind('click').click(function () {
                    var validatePass = true;
                    if (!isVoucherPay) {//不是优惠券的话需要表单验证
                        validatePass = $('#order-refund-form').data('bootstrapValidator').validate().isValid();
                    }
                    if (validatePass) {
                        BootstrapDialog.confirm({
                            title: '确认申请退款',
                            message: '你确定要申请退款吗？',
                            type: BootstrapDialog.TYPE_WARNING,
                            closable: true,
                            btnCancelLabel: '取消',
                            btnOKLabel: '确认',
                            btnOKClass: 'btn-warning',
                            callback: function (yes) {
                                if (yes) {
                                    var data;
                                    if (isVoucherPay) {
                                        data = {
                                            orderId: id,
                                            refundMoney:0,
                                            description: $('textarea[name=description]').val()
                                        }
                                    } else {
                                        data = formToJson('order-refund-form');
                                        data.orderId = id;
                                        data.address = data.province + data.city + data.address;
                                    }

                                    $.post('/order/refund', data).done(function (data) {
                                        if (data.code == HttpUtil.success_code) {
                                            $('#order-refund-modal').modal('hide');
                                        } else {
                                            BootstrapDialog.alert(data.msg);
                                        }
                                        DataTable.ajax.reload();
                                    }).fail(function () {
                                        BootstrapDialog.alert('请求服务器失败!');
                                    })
                                }
                            }
                        });
                    }
                });
            } else {
                BootstrapDialog.alert(data.msg);
            }
        }).fail(function () {
            BootstrapDialog.alert('请求服务器失败!');
        });
    }

    function initChinaArea() {
        $.each(provinceJson, function (k, p) {
            var option = "<option data-id='" + p.id + "' value='" + p.province + "'>" + p.province + "</option>";
            $("#province").append(option);
        });
        $.each(cityJson, function (k, p) {
            var option = "<option data-id='" + p.id + "' value='" + p.city + "'>" + p.city + "</option>";
            $("#city").append(option);
        });

        //选择省份后级联城市
        $("#province").change(function () {
            var selValue = $('#province > option:selected').attr('data-id');
            $("#city option:gt(0)").remove();
            $.each(cityJson, function (k, p) {
                // 直辖市处理.|| p.parent == selValue，直辖市为当前自己
                if (p.id == selValue || p.parent == selValue) {
                    var option = "<option data-id='" + p.id + "' value='" + p.city + "'>" + p.city + "</option>";
                    $("#city").append(option);
                }
            });
        });
    }

    /**
     *
     * @param id
     * @param channel
     * @param info
     * @param type 1支付前的轨迹，2下单前的轨迹
     */
    function track(id,channel,info,type) {

        $.get("/order/track/list", {id: id,type:type}).done(function (data) {
            if (data.code == HttpUtil.success_code) {
                var html = ''
                html += '<h5> <B>来源渠道：</B>'+channel+'</h5>';
                var infoName = info.length <= 100?info:info.substring(0,100)+'...';
                html += '<h5> <B>来源网址：</B><a href="'+info+'" target="_blank">'+infoName+'</a></h5>';
                if(channel.indexOf('直接访问') == -1){
                    var firstUrl = data.result[0]?data.result[0].firstEntryUrl:'';
                    var firstUrlName = firstUrl.length<=100?firstUrl:firstUrl.substring(0,100)+'...';
                    html += '<h5> <B>首次进入网址：</B><a href="'+firstUrl+'" target="_blank">'+firstUrlName+'</a></h5>';
                }
                html += '<hr/>';
                if (type == 1){
                    html += '<h6>在'+$('#pname').val()+'浏览轨迹（支付完成之前浏览的所有页面，仅限24小时之内）</h6>';
                }else if (type == 2){
                    html += '<h6>在'+$('#pname').val()+'浏览轨迹（创建订单之前浏览的所有页面，仅限24小时之内）</h6>';
                }

                html += '<table class="table table-hover table-bordered">';
                    html += ' <tr>';
                      html += '<th>停留页面</th>';
                      html += '<th>停留时长</th>';
                      html += '<th>访问时间</th>';
                      html += '<th>网址</th>';
                    html += '</tr>';
                $.each(data.result, function (index,track) {
                    html += ' <tr>';
                        html += '<td>'+track.title+'</td>';
                        html += '<td>'+MillisecondToDate(track.remain)+'</td>';
                        html += '<td>'+moment(track.visit).format("YYYY/MM/DD HH:mm:ss")+'</td>';
                        html += '<td><a title="'+track.url+'" href="'+track.url+'" target="_blank">'+(track.url.length > 50?(track.url.substring(0,50)+'...'):track.url)+'</a></td>';
                    html += '</tr>';
                });
                html += '</table>';
                $('#track-modal-body').html(html);
                $('#order-track-modal').modal('show');
            } else {
                BootstrapDialog.alert(data.msg);
            }
        });

    }

    function MillisecondToDate(msd) {
        var time = parseFloat(msd) /1000;
        if (null!= time &&""!= time) {
            if (time >60&& time <60*60) {
                time = parseInt(time /60.0) +"分钟"+ parseInt((parseFloat(time /60.0) -
                        parseInt(time /60.0)) *60) +"秒";
            }else if (time >=60*60&& time <60*60*24) {
                time = parseInt(time /3600.0) +"小时"+ parseInt((parseFloat(time /3600.0) -
                        parseInt(time /3600.0)) *60) +"分钟"+
                    parseInt((parseFloat((parseFloat(time /3600.0) - parseInt(time /3600.0)) *60) -
                        parseInt((parseFloat(time /3600.0) - parseInt(time /3600.0)) *60)) *60) +"秒";
            }else {
                time = parseInt(time) +"秒";
            }
        }else{
            //time = "0 时 0 分0 秒";
            time = "未知";
        }
        return time;

    }
    //需要暴露到global域的API
    window.page = {
        init: function () {
            //初始化事件绑定
            initBindEvents();
            //加载日期选择器
            bootstrapDateUtil.show('order-date');
            bootstrapDateUtil.show('pay-date');
        },
        look: look,
        refund: orderRefund,
        export:exportData,
        track:track
    }

})(window);