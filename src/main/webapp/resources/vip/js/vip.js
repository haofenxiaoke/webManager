/**
 * vip会员
 * @author zhenghui
 * @date 2016年7月8日
 */
(function ($) {


    $(document).ready(function () {
        bindEvents();
    })

    //绑定各种事件
    function bindEvents() {

        //购买
        $('.dredge-btn').click(function () {
            var spm = $(this).attr('dataType');
            var isVIP = $('#is-vip').val();
            var userId = $('#user-id').val();
            var url = '/order/save?spm=' + spm;
            //登录 跳购买 未登录 跳登录
            if (!userId || userId == -1) {
                Util.User.login(function (user) {
                    window.location.href = url;
                })
            } else {
                window.location.href = url;
            }

        });

    }

    function refreshBuyList(size) {
        if (!size) size = 1;
        $.get('/broadcast/buy/list/recently/' + size + '?' + Math.random()).done(function (result) {
            if (result.success) {
                var html = '';
                for (var i = 0; i < result.data.length; i++) {
                    var obj = result.data[i];
                    html += '<li>' + obj.city + obj.mobile + '购买了<span>' + obj.price + '元' + '<span style="display: block;">会员套餐</span></span></li>';
                }
                $('#buy-list').append(html);

            } else {
                console.error && console.error(result.message);
            }
        });
    }

    function refreshBuyCount() {
        $.get('/broadcast/buy/count/today?' + Math.random()).done(function (result) {
            if (result.success) {
                $('#buy-count').html(result.data)
            } else {
                console.error && console.error(result.message);
            }
        });
    }

/*
    var IE_NOT_LOAD_COUNT_TASK = setInterval(function () {
        if ($('#buy-count').html() == '') {
            refreshBuyCount();
        } else {
            clearInterval(IE_NOT_LOAD_COUNT_TASK);
        }
    }, 100)

    var IE_NOT_LOAD_LIST_TASK = setInterval(function () {
        if ($('#buy-list').size() == 0) {
            refreshBuyList(4);
        } else {
            clearInterval(IE_NOT_LOAD_LIST_TASK);
        }
    }, 100)
*/

    refreshBuyCount();
    refreshBuyList(4);


    setInterval(refreshBuyCount, 1000 * 60 * 2);
    setInterval(refreshBuyList, 3000);

})(jQuery);
