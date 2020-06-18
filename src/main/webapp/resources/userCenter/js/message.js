(function (window,$) {

    $(function(){
        $(window).scrollTop(0);//初始化滚动条置顶
        var vipId=$("#vipid").val()+'';
        var level='userLt-name';
        if(vipId!=null && vipId!=''){
            if(vipId=='1'){
                level+="-month"
            }
            if(vipId=='2'){
                level+="-season"
            }
            if(vipId=='3'){
                level+="-year"
            }
            var vipLevel=$("#vipLevel")
            vipLevel.attr("class",level);
        }


        window.readMessage=function(messageid){
            getMessage(messageid);
        }
        window.hasRead=function(messageid){
            getNoneReadMessage(messageid)
        }

        if(userid!='' && userid!=null){
            noneReadMsg();
        }
      /*  已读未读消息点击切换*/
        $(".userR-title a").on('click', function () {
            $(".userR-title a").removeClass('userR-cur');
            $(this).addClass('userR-cur');
            $(this).parent().next().find('.userR-zccount>div').fadeOut().hide().eq($(this).index()).fadeIn();
            var readFlag=$(this).attr('value');
            if(readFlag=='1'){
                hasReadMsg();
            }else{
                noneReadMsg();
            }

        })


    });
    //js转换时间戳
    function timeChuo(d) {
        let date = new Date(d);
        let year = date.getFullYear();
        let month = date.getMonth() + 1;
        let day = date.getDate();
        let hour = date.getHours();
        let min = date.getMinutes();
        let second = date.getSeconds();
        month = month < 10 ? "0" + month : month;
        day = day < 10 ? "0" + day : day;
        min = min < 10 ? "0" + min : min;
        second = second < 10 ? "0" + second : second;
        date = year + '/' + month + '/' + day + " " + hour + ':' + min + ':' + second;
        return(date)
    }

    /*获取未读消息*/
    function noneReadMsg(){
        //获取未读消息
        $.post('/userCenter/messageUnReadList').done(function (result) {
            if (result.success) {
                if(result.data){
                	console.log(result.data)
                    $("#unRead").html('');
                    $.each(result.data,function (index,message) {
                        var unReadHtml='';
                        /* unReadHtml='<dl class="message-list clearfloat" onclick="readMessage('+message.id+','+message.content+')">'+*/
                        var title=message.title;
                        if(title.length>20){
                            title=title.substring(0,20)+'...';
                        }
                        unReadHtml='<dl class="message-list clearfloat" onclick="readMessage('+message.id+')">'+
                            '<dt class="fl"><img src="/resources/userCenter/images/foter-logo-haofen.png" > </dt>'+
                            '<dd class="fl">'+
                            '<p><a title="'+message.title+'"  style="color: #666;" >'+title+'</a></p>'+
                            '<div>'+message.content+'</div>'+
                            '</dd>'+
                            '</dl>';
                        $("#unRead").append(unReadHtml);
                    })
                    var num=result.data;
                    $("#msgNum").html('共'+num.length+'个消息');
                }else{//无订单时显示的内容
                    $("#msgNum").html('共'+0+'个消息');
                   /* var unread=$("#unRead");
                    unread.html("");
                    unReadHtml='<div class="userR-twnone">'+
                        '<img src="/resources/userCenter/images/noPic.png" width="160">'+
                        '<p>没看到消息内容</p>';
                    $("#unRead").append(unReadHtml);*/
                }
            } else {
            }
        });
    }
    /*获取已读消息*/
    function hasReadMsg(){
        //获取已读消息
        $.post('/userCenter/messageReadList').done(function (result) {
            if (result.success) {
                if(result.data){
                	console.log(result.data)
                    var num=result.data;
                    $("#msgNum").html('共'+num.length+'个消息');
                    var hasRead=$("#read");
                    hasRead.html("");
                    $.each(result.data,function (index,message) {
                        var readHtml='';
                        var title=message.title;
                        if(title.length>20){
                            title=title.substring(0,20)+'...';
                        }
                        readHtml='<dl class="message-list clearfloat" onclick="hasRead('+message.id+')">'+
                            '<dt class="fl"><img src="/resources/userCenter/images/foter-logo-haofen.png" > </dt>'+
                            '<dd class="fl">'+
                            '<p><a title="'+message.title+'"  style="color: #666;" >'+title+'</a></p>'+
                            '<div>'+message.content+'</div>'+//messageDetail('+message.id+')
                            '</dd>'+
                            '</dl>';
                        $("#read").append(readHtml);
                    })
                }else{//无订单时显示的内容
                    $("#msgNum").html('共'+0+'个消息');
                  /*  var hasRead=$("#read");
                    hasRead.html("");
                    var unReadHtml='';
                    unReadHtml='<div class="userR-twnone">'+
                        '<img src="/resources/userCenter/images/noPic.png" width="160">'+
                        '<p>没看到消息内容</p>';
                    $("#read").append(unReadHtml);*/
                }
            } else {
            }
        });
    }

    /*根据消息id获取未读消息内容*/
    function getMessage(messageId){
        var datas={messageId:messageId};
        var relMessage='';
        $.ajax({
            url :'/userCenter/findMessageById' ,
            async : true, // 注意此处需要同步，因为返回完数据后，下面才能让结果的第一条selected
            type : "POST",
            dataType : "json",
            data:datas,
            success : function(result) {
                if (result.success) {
                    if(result.data){
                    	console.log(result)
                        relMessage=result.data.content;
                        var title=result.data.title;
                        if(title.length>20){
                            title=title.substring(0,20)+'...';
                        }
                        layer.open({
                            type: 1,
                            skin: 'layui-layer-demo', //加上边框
                            title:title,
                            area: ['520px', '440px'], //宽高
                            offset:'20%',
                            shadeClose: true,
                            content:'<p style="padding:15px 20px;text-indent: 2em;">'+relMessage+'</p>',
                            end: function(){
                                $.post('/userCenter/readMessage',{messageid:messageId}).done(function (result) {
                                    if(result.success){
                                        $('#page-right').load("/userCenter/right/message");
                                    }
                                })
                            }
                        });

                    }else {
                        relMessage= '未获取到消息内容';

                    }
                } else {
                    alert(result.message);
                }
            },
        });


    }


    /*根据消息id获取已读消息内容*/
    function getNoneReadMessage(messageId){
        var datas={messageId:messageId};
        var relMessage='';
        $.ajax({
            url :'/userCenter/findMessageById' ,
            async : true, // 注意此处需要同步，因为返回完数据后，下面才能让结果的第一条selected
            type : "POST",
            dataType : "json",
            data:datas,
            success : function(result) {
                if (result.success) {
                    if(result.data){
                    	console.log(result)
                        relMessage=result.data.content;
                        var title=result.data.title;
                        if(title.length>20){
                            title=title.substring(0,20)+'...';
                        }
                        layer.open({
                            type: 1,
                            skin: 'layui-layer-demo', //加上边框
                            title:title,
                            area: ['520px', '440px'], //宽高
                            offset:'20%',
                            shadeClose: true,
                            content:'<p style="padding:15px 20px;text-indent: 2em;">'+relMessage+'</p>',
                        });

                    }else {
                        relMessage= '未获取到消息内容';

                    }
                } else {
                    alert(result.message);
                }
            },
        });


    }


})(this,jQuery);