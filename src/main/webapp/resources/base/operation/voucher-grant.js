/**
 * Created by 李恒名 on 2016/6/14.
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
                    data.voucherType = 1;
                    data.locked = 0;
                }
            }
            ,
            columns: [
                {data: "id", "visible": false},//visible 隐藏或显示
                {
                    render: function (data, type, row, meta) {
                        return '<input type="radio" name="select-voucher" id="'+row.id+'">';
                    }
                },
                {data: "name"},
                {data: "price"},
                {
                    render: function (data, type, row, meta) {
                        return row.deadline + '天';
                    }
                },{
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
                "url": "/voucher-grant/list",
                "type": "POST",
                "dataType": "json",
                "data": function (data) {
                    data.voucherType = 1;
                    data.createTimeStr = $("#voucher-create-date-2").val();
                    data.name = $('#voucher-name-2').val();
                    data.stuUsername = $('#stu-username').val();
                    data.grantUsername = $('#grant-username').val();
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
                        }else{
                            return  '仅限购买' + row.regulation
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
                        return row.used ? '已使用' : '未使用';
                    }
                },
                {data: "grantUsername"},
                {
                    render: function (data, type, row, meta) {
                        return moment(row.ctime).format('YYYY-MM-DD HH:mm:ss ');
                    }
                },
                {
                    render: function (data, type, row, meta) {
                        var buttons = '';
                        buttons += $('#button-1').html();
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



    function initBindEvents() {

        // 绑定tab显示之前事件
        $('#tabs a').on('show.bs.tab', function (e) {
            $('#search-form')[0].reset();
            if (this.innerHTML == '发放优惠券'){
                DataTable1 = initDataTables1();
                //重置表单
                $('#voucher-num').val(0);
                $('#step-1').click()
                $('#selected-count').html(0);
                $('#stu-table').html('<tr class=""><th>昵称</th>  <th>账号</th><th>操作</th> </tr>');
            }else{
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

        //wizard
        $('#rootwizard').bootstrapWizard();

        $('#next').click(function () {
            wizardNext();
        });

        $('#step-2').click(function () {
            wizardNext();
        });

        $('#previous').click(function () {
            wizardPrevious();
        });

        $('#step-1').click(function () {
            wizardPrevious();
        });

    }


    function wizardNext(){

        var pass = nextValidate();

        if (pass){
            $('#next').parent().hide();
            $('#grant-li').show();
            $('#previous').removeProp('disabled');

            $('#step-2').addClass('active');
            $('#step-1').removeClass('active');


            $('#tab2').addClass('active');
            $('#tab1').removeClass('active');

            $('#add-stu-btn').unbind('click').click(function () {
                var count = $('#selected-count').html();
                if (count == '15'){
                    BootstrapDialog.alert('添加人数已经超过上限：15人，请在下次添加。');
                    return;
                }
                var userid = $('#username').val();

                if ($.trim(userid) == ''){
                    BootstrapDialog.alert('请输入账号');
                }else{

                    var table = $('#stu-table').html();
                    if (table.indexOf(userid) != -1){
                        BootstrapDialog.alert('该学员已被选择');
                        return;
                    }

                    $.post('/voucher-grant/query/stu', {userid: userid}).done(function (data) {
                        if (data.code == HttpUtil.success_code) {
                            var stu = data.result;

                            if (stu) {
                                if (stu.username == 'null' || !stu.username)stu.username = '';
                                var tr ='<tr id="'+stu.id+'">';
                                tr += '<td>'+stu.username+'</td>';
                                tr += '<td>'+stu.userid+'</td>';
                                tr += ' <td>';
                                tr += ' <a style="cursor: pointer" onclick="page.deleteSelected(this)">删除</a>';
                                tr += '</td>';
                                tr += '</tr>';
                                $('#stu-table').append(tr);
                                $('#selected-count').html(parseInt(count) + 1);
                                $('#username').val('');
                                $('#grant-btn').removeProp('disabled');
                            }else {
                                BootstrapDialog.alert('该账号不存在');
                            }
                        } else {
                            BootstrapDialog.alert(data.msg);
                        }
                    });
                }
            });
            $('#grant-btn').unbind('click').click(function () {
                var voucherId = $('input:radio[name=select-voucher]:checked').attr('id');
                var voucherCount = $('#voucher-num').val();

                var ids = '';
                $.each($('#stu-table tr'), function (index, val) {
                    val.id && (ids += val.id+',');
                });
                ids.substring(0, ids.length -1);
                var data ={
                    voucherId:voucherId,
                    voucherCount:voucherCount,
                    ids:ids
                }

                $.post('/voucher-grant/grant', data).done(function (data) {
                    if (data.code == HttpUtil.success_code) {
                        $("#grant-btn").prop("disabled",true);
                        $('#tabs a').last().click();
                        $('#add').show();//发放完成后恢复添加优惠券数量按钮
                    }else {
                        BootstrapDialog.alert(data.message);
                    }
                });
            });
        }
    }

    function wizardPrevious(){
        $('#previous').prop('disabled',true);
        $('#next').removeProp('disabled');
        $('#next').parent().show();
        $('#grant-li').hide();

        $('#step-1').addClass('active');
        $('#step-2').removeClass('active');

        $('#tab1').addClass('active');
        $('#tab2').removeClass('active');
    }

    function nextValidate() {
        var val = $('input:radio[name=select-voucher]:checked').val();

        if(!val){
            BootstrapDialog.alert({title: '提示', message: '请选择优惠券！'});
            return false;
        }

        if ($('#voucher-num').val() == 0){
            BootstrapDialog.alert({title: '提示', message: '请选择优惠券的数量！'});
            return false;
        }

        return true;
    }


    function detail(id){
        var url = '/voucher-grant/detail';
        $.post(url,{id:id}).done(function (data) {
            if (data.code == HttpUtil.success_code){
                var voucherGrant = data.result;
                var dts = '';
                var voucherType='';
                if(voucherGrant.voucherType==1){
                    voucherType='代金券';
                }
                var nickName='';
                if(voucherGrant.stuNickname&&voucherGrant.stuNickname.length>0){
                    nickName=voucherGrant.stuNickname;
                }
                dts+= '<dt>券名：</dt><dd>'+voucherGrant.voucherName+'</dd>';
                dts+= '<dt>券号：</dt><dd>'+voucherGrant.voucherNum+'</dd>';
                dts+= '<dt>金额：</dt><dd>'+voucherGrant.price+'</dd>';
                dts+= '<dt>有效期：</dt><dd>'+moment(voucherGrant.expireDate).format('YYYY-MM-DD HH:mm:ss ')+'</dd>';
                dts+= '<hr/>';
                dts+= '<dt>学员账号：</dt><dd>'+voucherGrant.stuUsername+'</dd>';
                dts+= '<dt>学员昵称：</dt><dd>'+nickName+'</dd>';
                dts+= '<dt>发放人：</dt><dd>'+voucherGrant.grantUsername+'</dd>';
                dts+= '<dt>发放时间：</dt><dd>'+moment(voucherGrant.ctime).format('YYYY-MM-DD HH:mm:ss ')+'</dd>';
                $('#voucher-grant-detail-dl').html(dts);
                $('#voucher-grant-detail-modal').modal('show');
            }else{
                BootstrapDialog.alert(data.msg);
            }
        }).fail(function () {
            BootstrapDialog.alert('请求服务器失败!');
        });
    }


    function deleteSelected(ele) {
        $(ele).parent().parent().remove();
        var count = $('#selected-count').html();
        $('#selected-count').html(count - 1);
        if (count == '1') {
            $("#grant-btn").prop("disabled",true);
        }

    }
    window.page = {
        init: function () {
            //加载日期选择器
            bootstrapDateUtil.show('voucher-create-date');
            //加载日期选择器
            bootstrapDateUtil.show('voucher-create-date-2');
            //初始化事件绑定
            initBindEvents();
        },detail:detail,
        deleteSelected:deleteSelected
    };
})(window);