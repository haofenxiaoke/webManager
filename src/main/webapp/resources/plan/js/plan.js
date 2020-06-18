/**
 * 计划
 * @author zhenghui
 * @date 2016年7月8日
 */
(function ($) {


    $(document).ready(function () {
        bindEvents();
    })

    //绑定各种事件
    function bindEvents() {

        //计划定制
        $('#kecheng').click(function () {
            madePlan();
        });

        //学习思路
        $('.chakan a').click(function () {
            $('#ideas').show();
            $('.js-black').show();
            var ulContent = $('#ideas-ul');
            var ideas = $(this).parent().find("p").html();
            try{
                ideas=JSON.parse(ideas);
                ulContent.empty();
                $.each(ideas,function (key,value) {
                    if(value.length > 14){
                        value = value.substring(0,14)+'...';
                    }
                    ulContent.append('<li><span></span>'+value+'</li>');
                });
            }catch(e){
                ulContent.empty();
                ideas = ideas.length <= 14?ideas:ideas.substring(0,14)+'...';
                ulContent.append('<li><span></span>'+ideas+'</li>');
            }
        });

        $('#ideas-close').click(function () {
            $('#ideas').hide();
            $('.js-black').hide();
        });

        //非会员
        $('#vip-no').click(function () {
            var userId = $('#user-id').val();
            var isVIP = $('#is-vip').val();
            //登录 跳购买 未登录 跳登录
            if(!userId || userId == -1){
                Util.User.login(function(user){
                    $('#is-vip').val(user.isVIP);
                    //登录或注册完成后 先生成计划 再到支付界面
                    //验证计划个数
                    check();
                })
            }else{
                //登录后 vip 与普通用户
                if(userId){
                    check();
                }
            }

        });

        //会员点击确认 生成计划
        $('#vip-ok').click(function () {
            //验证计划个数
            check();
        });

    }

    //跳转收银台
    function goBuy(){
        var spm = $('#vip-no').attr('datatype');
        var directionId = $('#direction-id').val();
        var industryId = $('#industry-id').val();
        var positionId = $('#position-id').val();
        var productId = $('#product-id').val()

        var flag = false;
        if(productId == 'kjs'){
            flag = directionId && industryId && positionId;
        }else if(productId == 'sjn'){
            flag = directionId && positionId;
        }

        if(flag){
            window.location.href = '/order/save?spm='+spm+'&did='+directionId+"&iid="+industryId+'&pid='+positionId;
        }
    }

    //课程定制
    function madePlan(){
        var nullVal='';
        var isVIP = $('#is-vip').val();
        var userId = $('#user-id').val();
        var directionId = $('#direction-id').val();
        var industryId = $('#industry-id').val();
        var positionId = $('#position-id').val();

        var productId = $('#product-id').val()

        if(productId == 'sjn'){
            if(!directionId){
                layer.alert('请先选择方向！');
                return;
            }
            if(!positionId){
                layer.alert('请选择分类！');
                return;
            }
        }else{
            if(!positionId){
                layer.alert('请先选择职位！');
                return;
            }
            if(!industryId){
                layer.alert('请选择行业！');
                return;
            }
        }

        var url = '/plan?directionId='+directionId+
            "&industryId="+industryId+"&positionId="+positionId;

        //vip用户直接验证
        if(userId && isVIP == 'true'){
            //验证计划是否重复
            var datas = {directionId:directionId,industryId:industryId,positionId:positionId};
            $.post('/plan/check/duplicate',datas).done(function (result) {
                if (result.success) {
                    if(result.data){
                        window.location.href = url;
                    }else layer.msg('该计划已经有了!', {time: 3000,icon: 6});
                } else {
                    //console.log(result.message);
                }
            })
        }else{
            window.location.href = url;
        }

    }

    //生成用户计划
    function savePlan(){
        var datas ={};
        var isVIP = $('#is-vip').val();
        var directionId = $('#direction-id').val();
        var industryId = $('#industry-id').val();
        var positionId = $('#position-id').val();

        datas['directionId'] = directionId;
        datas['industryId'] = industryId;
        datas['positionId'] = positionId;
        $.post('/plan/save',datas).done(function (result) {
            if (result.success) {
                var url = '/userCenter';
                window.location.href = url;
            }
        })
    }

    function check(){
        $.post('/plan/check').done(function (result) {
            if (result.success) {
                if(result.data){
                    //验证重复
                    var directionId = $('#direction-id').val();
                    var industryId = $('#industry-id').val();
                    var positionId = $('#position-id').val();
                    var datas = {directionId:directionId,industryId:industryId,positionId:positionId};
                    $.post('/plan/check/duplicate',datas).done(function (result) {
                        if (result.success) {
                            if(result.data){
                                savePlan();
                            }else toUserCenter('该计划已经有了!');
                        } else {
                            //console.log(result.message);
                        }
                    })
                }
                else toUserCenter('计划数已达上限!');

            } else {
                //console.log(result.message);
            }
        })
    }

    function toUserCenter(message){
        layer.msg(message, {time: 3000,icon: 6});
        setTimeout(function(){
            window.location.href = '/userCenter';
        },3000);
    }


    window.goBuy = goBuy;
})(jQuery)
