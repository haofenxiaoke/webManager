/**
 * Created by 李恒名 on 2016/6/14.
 * 意见反馈页脚本
 */

(function (window) {
    var DataTable;
    var voucherType = 1;

    var vipInfos = {};
    function getVipInfos() {
        $.ajax({
            type : 'post',
            url : '/vip/info/list',
            async : false,
            success : function(data){
                if (data.code == HttpUtil.success_code) {
                    vipInfos = data.result;
                }else{
                    BootstrapDialog.alert(data.message);
                }
            }
        });
    }
    
    //再次校验
    function againValidate(value) {
        getVipInfos();
        var checkedValue = new Array();
        $('input[name="regulation"]:checked').each(function(index){
            checkedValue.push($(this).val());
        });

        var flag = false;
        var maxVipPrice = 0;
        $(vipInfos).each(function (index, info) {
            if(info.days == 360){
                maxVipPrice = info.price;
            }
            if (value > info.price && checkedValue.indexOf(info.days+'') != -1) {
                flag = true;
            }
        });

        if(value > maxVipPrice || flag) {
            flag = true;
        }
        return flag;
    }

    function initDataTables(tableType) {
        return $('#data-table-' + tableType).DataTable({
            bDestroy: true,
            searching: false,
            processing: true,
            serverSide: true,
            ordering: false, //排序
            ajax: {
                "url": "/voucher/list",
                "type": "POST",
                "dataType": "json",
                "data": function (data) {
                    data.createTimeStr = $("#voucher-create-date").val();
                    data.name = $('#voucher-name').val();
                    data.voucherType = voucherType;
                }
            }
            ,
            columns: [
                {data: "id", "visible": false},//visible 隐藏或显示
                {data: "name"},
                {data: "price"},
                {
                    render: function (data, type, row, meta) {
                        return row.deadline + '天';
                    }
                },
                {
                    render: function (data, type, row, meta) {
                        var length = row.regulation.split(',').length;
                        if (length == 3) {
                            return '可购买所有会员';
                        }else{
                            return  '仅限购买' + row.regulation
                                    .replace(/,/g, '、')
                                    .replace(/30/g, '月会员')
                                    .replace(/90/g, '季会员')
                                    .replace(/360/g, '年会员');
                        }
                    }
                },
                {data: "createUserName"},
                {
                    render: function (data, type, row, meta) {
                        return moment(row.ctime).format('YYYY-MM-DD HH:mm:ss ');
                    }
                },
                {
                    render: function (data, type, row, meta) {
                        var buttons = '';
                        buttons += $('#button-1').html();
                        if (row.locked == 0)
                            buttons += $('#button-2').html();
                        else
                            buttons += $('#button-3').html();
                        return buttons.replace(/#id/g, row.id);
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


    function saveOrUpdate(method, id) {
        $('#create-voucher-btn').unbind().click(function () {
            var passValidate = $('#create-voucher-form').data('bootstrapValidator').validate().isValid();
            var price = $('#voucher-price').val();
            if(againValidate(price)){
                BootstrapDialog.alert('套餐价格已改变，不符合使用规则');
                passValidate = false;
            }
            if (passValidate) {
                if ($("input[name='regulation']:checkbox:checked").length == 0){
                    BootstrapDialog.alert('请选择使用规则');
                    return;
                }
                var data = formToJson('create-voucher-form');
                data.beginTime = new Date(data.beginTime);
                data.endTime = new Date(data.endTime);
                data.type = voucherType;
                var url;
                if (method == 'save') {
                    url = '/voucher/add';
                } else {
                    data.id = id;
                    url = '/voucher/modify';
                }
                $.post(url, data)
                    .done(function (data) {
                        if (data.code == HttpUtil.success_code) {
                            $('#create-voucher-modal').modal('hide');
                            DataTable.ajax.reload();
                        } else {
                            BootstrapDialog.alert(data.msg);
                        }
                    }).fail(function () {
                    BootstrapDialog.alert('请求服务器失败!');
                });
            }
        });
    }

    function initBindEvents() {
        // 绑定tab显示之前事件
        $('#tabs a').on('show.bs.tab', function (e) {
            $('#search-form')[0].reset();
            voucherType = $(this).data('type');
            if (voucherType == 1) {
                $('#voucher-name').attr('placeholder', '请输入券名');
                $('#create-model-btn').html('创建优惠券模板');
                $('#name-label').html('券名');
            } else if (voucherType == 2) {
                $('#voucher-name').attr('placeholder', '请输入优惠码名字');
                $('#create-model-btn').html('创建模板');
                $('#name-label').html('优惠码名字');
            }
            DataTable = initDataTables(voucherType);
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

        $('#create-model-btn').click(function () {
            $('#create-voucher-form').bootstrapValidator('resetForm', true);
            $("input[name='regulation']").each(function () {
                $(this).prop('disabled', true);
            });
            $("input[name='regulation']:checkbox:checked").each(function () {
                $(this).prop('checked', false);
            });
            $('.modal-title').html('创建模板');
            $('#create-voucher-modal').modal('show');
            saveOrUpdate('save');
        });

        var dateOption = {
            language: 'zh-CN',
            weekStart: 1,
            todayBtn: 1,
            autoclose: 1,
            todayHighlight: 1,
            startView: 2,
            minView: 0,
            forceParse: 0,
            minuteStep: 1,
            startDate: new Date()

        }

        $('#voucher-begin-time').datetimepicker(dateOption);
        $('#voucher-end-time').datetimepicker(dateOption);

        $('#voucher-begin-time').change(function () {
            $('#voucher-end-time').val('');
            $('#voucher-end-time').datetimepicker('setStartDate', $(this).val());
        });

        $('#voucher-begin-time').on('hide', function (e) {
            // Validate the date when user change it
            $('#create-voucher-form')
            // Get the bootstrapValidator instance
                .data('bootstrapValidator')
                // Mark the field as not validated, so it'll be re-validated when the user change date
                .updateStatus('beginTime', 'NOT_VALIDATED', null)
                // Validate the field
                .validateField('beginTime');
        });

        $('#voucher-end-time').on('hide', function (e) {
            // Validate the date when user change it
            $('#create-voucher-form')
            // Get the bootstrapValidator instance
                .data('bootstrapValidator')
                // Mark the field as not validated, so it'll be re-validated when the user change date
                .updateStatus('endTime', 'NOT_VALIDATED', null)
                // Validate the field
                .validateField('endTime');
        });

        $('#voucher-price').bind('input propertychange',function () {
            $('#inlineCheckbox30').prop('disabled',true);
            $('#inlineCheckbox90').prop('disabled',true);
            $('#inlineCheckbox360').prop('disabled',true);
            $('#inlineCheckbox30').prop('checked',false);
            $('#inlineCheckbox90').prop('checked',false);
            $('#inlineCheckbox360').prop('checked',false);
            var value = $(this).val();
            if(value != ''){
                $('#inlineCheckbox30').removeAttr('title');
                $('#inlineCheckbox90').removeAttr('title');
                $('#inlineCheckbox360').removeAttr('title');
            }else{
                $('#inlineCheckbox30').attr('title', '请先填写金额');
                $('#inlineCheckbox90').attr('title', '请先填写金额');
                $('#inlineCheckbox360').attr('title', '请先填写金额');
            }

            $(vipInfos).each(function (index, info) {
                var days = info.days;
                if (days == 30 && value <= info.price) {
                    $('#inlineCheckbox30').prop('disabled', false);
                    $('#inlineCheckbox90').prop('disabled', false);
                    $('#inlineCheckbox360').prop('disabled', false);
                } else if (days == 90 && value <= info.price) {
                    $('#inlineCheckbox30').attr('title', '金额超过会员价格')
                    $('#inlineCheckbox90').prop('disabled', false);
                    $('#inlineCheckbox360').prop('disabled', false);
                } else if (days == 360 && value <= info.price) {
                    $('#inlineCheckbox30').attr('title', '金额超过会员价格')
                    $('#inlineCheckbox90').attr('title', '金额超过会员价格')
                    $('#inlineCheckbox360').prop('disabled', false);
                }
            });
        });

        //绑定表单验证器
        $('#create-voucher-form').bootstrapValidator({
            message: 'This value is not valid',
            excluded: [':disabled'],//不加它重新打开模态框时提示不会清除
            fields: {
                name: {
                    validators: {
                        notEmpty: {
                            message: '券名不能为空'
                        },
                        stringLength: {
                            max: 20,
                            message: '券名不能超过20个字'
                        }
                    }
                },
                price: {
                    validators: {
                        notEmpty: {
                            message: '金额不能为空'
                        }, callback: {
                            message: '金额上限为年会员的价格',
                            callback: function (value, validator) {
                                var maxVipPrice = 0;
                                $(vipInfos).each(function (index, info) {
                                    if(info.days == 360){
                                        maxVipPrice = info.price;
                                        return false;
                                    }
                                });
                                return  value <= maxVipPrice;
                            }
                        }
                        , regexp: {
                             regexp:  /^[0-9]*[1-9][0-9]*$/,
                            message: '金额必须为大于零的正整数'
                        }
                    }
                },
                deadline: {
                    validators: {
                        notEmpty: {
                            message: '有效期不能为空'
                        }
                    }
                },
                description: {
                    validators: {
                        stringLength: {
                            max: 200,
                            message: '消息内容不能超过200个字'
                        }
                    }
                }
            }
        });
    }


    function modifyVoucher(id) {
        $.post('/voucher/detail', {id: id}).done(function (data) {
            if (data.code == HttpUtil.success_code) {

                $('#create-voucher-form [name=name]').val(data.result.name);
                $('#create-voucher-form [name=price]').val(data.result.price);
                $('#create-voucher-form [name=deadline]').val(data.result.deadline);
                $('#create-voucher-form [name=description]').val(data.result.description);
                $("input[name='regulation']").each(function () {
                    $(this).prop('disabled', false);
                });
                $("input[name='regulation']:checkbox:checked").each(function () {
                    $(this).prop('checked', false);
                });
                var regulation = data.result.regulation;
                $.each(regulation.split(','), function (index,value) {
                    $('#inlineCheckbox'+value).prop('checked', true);
                });
                $('.modal-title').html('修改模板');
                $('#create-voucher-modal').modal('show');
                saveOrUpdate('update', id);
            } else {
                BootstrapDialog.alert(data.msg);
            }
        }).fail(function () {
            BootstrapDialog.alert('请求服务器失败!');
        });
    }

    function lock(id, status) {

        var title, message, url;

        if (status == 1) {
            title = '锁定模板';
            message = '你确认要锁定该模板吗？';
            url = '/voucher/locked';
        } else {
            title = '解锁模板';
            message = '你确认要解锁该模板吗？';
            url = '/voucher/unlock';
        }

        BootstrapDialog.confirm({
            title: title,
            message: message,
            type: BootstrapDialog.TYPE_WARNING,
            closable: true,
            btnCancelLabel: '取消',
            btnOKLabel: '确认',
            btnOKClass: 'btn-warning',
            callback: function (yes) {
                if (yes) {
                    $.post(url, {id: id})
                        .done(function (data) {
                            if (data.code == HttpUtil.success_code) {
                                DataTable.ajax.reload();
                            } else {
                                BootstrapDialog.alert(data.msg);
                            }
                        })
                        .fail(function () {
                            BootstrapDialog.alert('请求服务器失败!');
                        });
                }
            }
        });

    }


    window.page = {
        init: function () {
            //加载日期选择器
            bootstrapDateUtil.show('voucher-create-date');
            //初始获取套餐信息
            getVipInfos();
            //初始化事件绑定
            initBindEvents();
            //初始化DataTables
            // DataTable = initDataTables(1);
        },
        lock: lock,
        modifyVoucher: modifyVoucher
    };
})(window);