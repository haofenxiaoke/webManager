/**
 * Created by 李恒名 on 2016/6/12.
 * 订单管理页脚本
 */
(function (window) {

    var stu;

    function initVipPriceSelect() {
        $.get('/vip/info/list').done(function (data) {
            if (data.code == HttpUtil.success_code) {
                var vipInfoList = data.result;
                var html = '<option value="" selected>请选择套餐类型</option>';
                $.each(vipInfoList, function (index, vipInfo) {
                    html += '<option id="'+vipInfo.id+'" value=' + vipInfo.price + '>' + vipInfo.describle + '</option>';
                });
                $('#vip-price-select').html(html);
            } else {
                BootstrapDialog.alert(data.message);
            }
        });
    }

    function initBindEvents() {
        $('#vip-price-select').change(function () {
            $('#select-stu-btn').prop('disabled', false);
            $('#order-price').html($(this).children('option:selected').val());
        });
        $('#username').focus(function () {
            $('#select-stu-btn').prop('disabled', false);
            $(this).val('');
            var html = ''
            html+='<tr class="">';
            html+='<th>选择</th>';
            html+='<th>券名</th>';
            html+='<th>券号</th>';
            html+='<th>金额</th>';
            html+='<th>有效期</th>';
            html+=' </tr>';
            $('#stu-table').html(html);
        });
        $('#select-stu-btn').click(function () {
            var price = $('#vip-price-select').val();
            if (price == ''){
                BootstrapDialog.alert('请选择套餐类型');
                return;
            }
            var userid = $('#username').val();
            if (!userid) {
                BootstrapDialog.alert('请输入学员账号');
                return;
            }

            $.post('/voucher-grant/query/stu', {userid: userid}).done(function (data) {
                if (data.code == HttpUtil.success_code) {
                  stu = data.result;
                    if (stu) {
                        $.post('/voucher-grant/list/stu', {id: stu.id,price:price}).done(function (data) {
                            if (data.code == HttpUtil.success_code) {
                                var html = ''
                                html+='<tr class="">';
                                html+='<th>选择</th>';
                                html+='<th>券名</th>';
                                html+='<th>券号</th>';
                                html+='<th>金额</th>';
                                html+='<th>有效期</th>';
                                html+=' </tr>';
                                if (data.result.length < 1){
                                    BootstrapDialog.alert('没有符合条件的优惠券供使用');
                                }else{
                                    $.each(data.result, function (index,uv) {
                                        if (uv.voucherType == 1){
                                            uv.voucherType = '代金券';
                                        }
                                        html += '<tr>';
                                        html += '<td><input type="radio" name="voucher-item" id="'+uv.id+'"></td>';
                                        html += '<td>'+uv.voucherName+'</td>';
                                        html += '<td>'+uv.voucherNum+'</td>';
                                        html += '<td>'+uv.price+'</td>';
                                        html += '<td>'+moment(uv.ctime).format('YYYY/MM/DD')+'-'+moment(uv.expireDate).format('YYYY/MM/DD')+'</td>';
                                        html += '</tr>';
                                    });
                                }
                                $('#stu-table').html(html);
                                $('#select-stu-btn').prop('disabled', true);
                            }else {
                                BootstrapDialog.alert(data.msg);
                            }
                        });

                    }else {
                        BootstrapDialog.alert('你查找的学员不存在，请确认后重新输入');
                    }
                } else {
                    BootstrapDialog.alert(data.msg);
                }
            });
        });

        $('#create-order-btn').click(function () {
            if ($('#vip-price-select').val() == '') {
                BootstrapDialog.alert('请选择套餐');
                return
            }

            var $radio = $('input:radio[name=voucher-item]:checked');
            if ($radio.length == 0 ){
                BootstrapDialog.alert('请选择优惠券');
                return
            }

            var id = $radio.attr('id');
            var $tds = $($radio.parent().siblings('td'));
            var price = parseInt($tds.get(2).innerHTML);
            var voucherPrice = parseInt($('#vip-price-select').find("option:selected").val());
            var userName='';
            if(stu.username && stu.username.length>0){
                userName=stu.username;
            }
            if (price < voucherPrice ){
                BootstrapDialog.alert('券金额不足，请重新选择');
                return
            }
            if (price > voucherPrice ){
                BootstrapDialog.alert('券金额超过应付金额，请重新选择');
                return
            }

            var dts = '';
            dts+= '<dt>套餐类型：</dt><dd>'+$('#vip-price-select').find("option:selected").text()+'</dd>';
            dts+= '<dt>学员账号：</dt><dd>'+stu.userid+'</dd>';
            dts+= '<dt>学员昵称：</dt><dd>'+userName+'</dd>';
            dts+= '<dt>金额：</dt><dd>'+price+'</dd>';
            dts+= '<dt>使用券名：</dt><dd>'+$tds.get(0).innerHTML+'</dd>';
            dts+= '<dt>使用券号：</dt><dd>'+$tds.get(1).innerHTML+'</dd>';
            $('#order-detail-dl').html(dts);
            $('#order-confrim-modal').modal('show');

            $('#confirm-create').unbind('click').click(function () {
                $('#order-confrim-modal').modal('hide');
                var vipId = $('#vip-price-select').children('option:selected').attr('id');
                var uid = $('#username').val();
                var userVoucherId = id;

                var data = {
                    vipId: vipId,
                    uid: uid,
                    userVoucherId: userVoucherId
                };

                $.post('/order/add', data).done(function (data) {
                    if (data.code == HttpUtil.success_code) {
                        location.href = '/order/manager';
                    }else{
                        BootstrapDialog.alert(data.msg);
                    }
                });

            });

        });
    }

    //需要暴露到global域的API
    window.page = {
        init: function () {
            initVipPriceSelect();
            //初始化事件绑定
            initBindEvents();
        }
    }

})(window);