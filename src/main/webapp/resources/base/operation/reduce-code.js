/**
 * Created by 李恒名 on 2016/6/14.
 * 意见反馈页脚本
 */

(function (window) {
    var DataTable1;
    var DataTable2;

    //ITEM 1
    function initDataTables1() {
        return $('#feedback-table').DataTable({
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
                    data.voucherType = 2;
                    data.locked = 0;
                    data.reduceCode = true;
                }
            }
            ,
            columns: [
                {data: "id", "visible": false},//visible 隐藏或显示
                {
                    render: function (data, type, row, meta) {
                        return '<input type="radio" name="select-voucher" id="' + row.id + '">';
                    }
                },
                {data: "name"},
                {data: "price"},
                {
                    render: function (data, type, row, meta) {
                        return row.deadline + '天';
                    }
                }, {
                    render: function (data, type, row, meta) {
                        var length = row.regulation.split(',').length;
                        if (length == 3) {
                            return '可购买所有会员';
                        } else {
                            return '仅限购买' + row.regulation
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

    function initDataTables2() {
        return $('#voucher-table-2').DataTable({
            bDestroy: true,
            searching: false,
            processing: true,
            serverSide: true,
            ordering: false, //排序
            ajax: {
                "url": "/reduce-code/list",
                "type": "POST",
                "dataType": "json",
                "data": function (data) {
                    data.voucherType = 2;
                    data.createTimeStr = $("#voucher-create-date-2").val();
                    data.name = $('#voucher-name-2').val();
                    data.grantUsername = $('#grant-username').val();
                    data.stuUsername = $('#stu-username').val();
                    data.used = $('#used-select').val();

                }
            }
            ,
            columns: [
                {data: "id", "visible": false},//visible 隐藏或显示
                {data: "voucherName"},
                {data: "price"},
                {
                    render: function (data, type, row, meta) {
                        var length = row.regulation.split(',').length;
                        if (length == 3) {
                            return '可购买所有会员';
                        } else {
                            return '仅限购买' + row.regulation
                                    .replace(/,/g, '、')
                                    .replace(/30/g, '月会员')
                                    .replace(/90/g, '季会员')
                                    .replace(/360/g, '年会员');
                        }
                    }
                },
                {data: "voucherNum"},
                {data: "stuUsername"},
                {
                    render: function (data, type, row, meta) {
                        return row.used == 0 ? '未使用' : '已使用';
                    }
                },
                {data: "grantUsername"},
                {
                    render: function (data, type, row, meta) {
                        return moment(row.ctime).format('YYYY-MM-DD HH:mm:ss ');
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


    function initBindEvents() {

        // 绑定tab显示之前事件
        $('#tabs a').on('show.bs.tab', function (e) {
            $('#search-form')[0].reset();
            if (this.innerHTML == '生成优惠码') {
                DataTable1 = initDataTables1();
                //重置表单
                $('#voucher-num').val(0);
            } else {
                DataTable2 = initDataTables2();
            }
        });

        //页面加载之后默认显示第一个tab
        $('#tabs a:first').tab('show');

        //绑定tab点击事件
        $('#tabs a').click(function (e) {
            $(this).tab('show')
        });
        //绑定搜索按钮事件
        $('#search').click(function () {
            DataTable1.ajax.reload();
        });
        //绑定搜索按钮事件
        $('#search-2').click(function () {
            DataTable2.ajax.reload();
        });


        $('#generate-btn').click(function () {
            var $btn = $(this);
            let pass = generateValidate();
            if (pass) {
                let voucherTemplateId = $('input:radio[name=select-voucher]:checked').attr('id');
                let voucherCount = $('#count').val();
                let url = '/reduce-code/generate';
                let data = {
                    voucherTemplateId: voucherTemplateId,
                    voucherCount: voucherCount
                };
                $btn.prop('disabled', true).html('生成中...');
                $.post(url, data).done(function (data) {
                    if (data.code == HttpUtil.success_code) {
                        $('#count').val(1);
                        $('#tabs a').last().click();
                        let codes = data.result;
                        if (codes.length  > 5){
                            $('#code-generate-success-modal').modal('show');
                            $('#export-btn').click(function (){
                                exportData(this,codes);
                            })
                        }
                        $btn.prop('disabled', false).html('确认生成');
                    } else {
                        BootstrapDialog.alert(data.message);
                    }
                });
            }
        });


        $('#batch-export-btn').click(function () {
            var datas = {};
            datas.createTimeStr = $("#voucher-create-date-2").val();
            datas.name = $('#voucher-name-2').val();
            datas.voucherType = 2;
            datas.grantUsername = $('#grant-username').val();
            datas.reduceCode = true;
            datas.start = 0;
            datas.length = -1;

            var separator = ',\u200C';
            var htmlText = '优惠码名字,金额,使用规则,优惠码编号,学员,使用状态,发放人,发放时间';

            $.ajax({
                url:"/reduce-code/list",
                type:"post",
                dataType:"json",
                cache: false,
                async: false,
                data :datas,
                success: function (data){
                    if(data.data){
                        $.each(data.data, function (index,info) {
                            var regulation = '仅限购买' + info.regulation
                                    .replace(/,/g, '、')
                                    .replace(/30/g, '月会员')
                                    .replace(/90/g, '季会员')
                                    .replace(/360/g, '年会员');
                            if (info.regulation.split(',').length == 3) {
                                regulation = '可购买所有会员';
                            }
                            htmlText += '\n\u200C'+info.voucherName+
                                separator+info.price+
                                separator+regulation+
                                separator+info.voucherNum+
                                separator+info.stuUsername+
                                separator+(info.used == 0 ? '未使用' : '已使用')+
                                separator+info.grantUsername+
                                separator+moment(info.ctime).format('YYYY-MM-DD HH:mm:ss ')+
                                separator;
                        })
                    }
                }
            })

            this.download = $('#batch-export-btn').attr('download');
            var blob = new Blob(["\ufeff", htmlText],{type: 'text/csv,charset=utf-8'});
            this.href = URL.createObjectURL(blob);
        });

    }

    /**
     * 导出数据
     * @param aLink
     */
    function exportData(aLink,datas) {
        // layer.msg('数据正在导出中，可能需要等候3秒到1分钟...', {
        //     icon: 16
        //     ,time: 5000
        //     ,shade: [0.8, '#393D49']
        // });

        var separator = ',\u200C';
        var htmlText = '优惠码名字,金额,使用规则,优惠码编号,使用状态,发放人,发放时间';

        $.each(datas, function (index,info) {
            var regulation = '仅限购买' + info.regulation
                    .replace(/,/g, '、')
                    .replace(/30/g, '月会员')
                    .replace(/90/g, '季会员')
                    .replace(/360/g, '年会员');
            if (info.regulation.split(',').length == 3) {
                regulation = '可购买所有会员';
            }
            htmlText += '\n\u200C'+info.voucherName+
                separator+info.price+
                separator+regulation+
                separator+info.voucherNum+
                separator+(info.used == 0 ? '未使用' : '已使用')+
                separator+info.grantUsername+
                separator+moment(info.ctime).format('YYYY-MM-DD HH:mm:ss ')+
                separator;
        })
        aLink.download = $('#export-btn').attr('download');
        var blob = new Blob(["\ufeff", htmlText],{type: 'text/csv,charset=utf-8'});
        aLink.href = URL.createObjectURL(blob);
        $('#code-generate-success-modal').modal('hide');
    }

    function generateValidate() {
        var val = $('input:radio[name=select-voucher]:checked').val();

        if (!val) {
            BootstrapDialog.alert({title: '提示', message: '请选择优惠码模板！'});
            return false;
        }

        var count = $('#count').val();
        if (count == '') {
            BootstrapDialog.alert({title: '提示', message: '请输入要生成的数量！'});
            return false;
        } else {
            if(/^[0-9]+$/.test(count)){
                if (count < 1) {
                    BootstrapDialog.alert({title: '提示', message: '数量不能小于1！'});
                    return false;
                } else if (count > 100) {
                    BootstrapDialog.alert({title: '提示', message: '数量不能超过100！'});
                    return false;
                }
            }else{
                BootstrapDialog.alert({title: '提示', message: '数量必须为正整数！'});
                return false;
            }

        }

        return true;
    }


    function detail(id) {
        var url = '/voucher-grant/detail';
        $.post(url, {id: id}).done(function (data) {
            if (data.code == HttpUtil.success_code) {
                var voucherGrant = data.result;
                var dts = '';
                var voucherType = '';
                if (voucherGrant.voucherType == 1) {
                    voucherType = '代金券';
                }
                var nickName = '';
                if (voucherGrant.stuNickname && voucherGrant.stuNickname.length > 0) {
                    nickName = voucherGrant.stuNickname;
                }
                dts += '<dt>券名：</dt><dd>' + voucherGrant.voucherName + '</dd>';
                dts += '<dt>券号：</dt><dd>' + voucherGrant.voucherNum + '</dd>';
                dts += '<dt>金额：</dt><dd>' + voucherGrant.price + '</dd>';
                dts += '<dt>有效期：</dt><dd>' + moment(voucherGrant.expireDate).format('YYYY-MM-DD HH:mm:ss ') + '</dd>';
                dts += '<hr/>';
                dts += '<dt>学员账号：</dt><dd>' + voucherGrant.stuUsername + '</dd>';
                dts += '<dt>学员昵称：</dt><dd>' + nickName + '</dd>';
                dts += '<dt>发放人：</dt><dd>' + voucherGrant.grantUsername + '</dd>';
                dts += '<dt>发放时间：</dt><dd>' + moment(voucherGrant.ctime).format('YYYY-MM-DD HH:mm:ss ') + '</dd>';
                $('#voucher-grant-detail-dl').html(dts);
                $('#voucher-grant-detail-modal').modal('show');
            } else {
                BootstrapDialog.alert(data.msg);
            }
        }).fail(function () {
            BootstrapDialog.alert('请求服务器失败!');
        });
    }

    window.page = {
        init: function () {
            //加载日期选择器
            bootstrapDateUtil.show('voucher-create-date');
            //加载日期选择器
            bootstrapDateUtil.show('voucher-create-date-2');
            //初始化事件绑定
            initBindEvents();
        },
        detail: detail
    };
})(window);