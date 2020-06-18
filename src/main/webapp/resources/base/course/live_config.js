(function(window){
    var DataTable;
    //初始化弹出框
    function openModel() {

    }
    //删除直播配置
    function delLiveCarousel(id){
        var datas = {"id":id};
        BootstrapDialog.confirm({
            title: '删除直播课',
            message: '确定要删除当前直播课吗?',
            type: BootstrapDialog.TYPE_WARNING,
            closable: true,
            btnCancelLabel: '取消',
            btnOKLabel: '确认',
            btnOKClass: 'btn-warning',
            callback: function (result) {
                if (result) {
                    $.ajax({
                        url: "/configlive/delete",
                        type: "post",
                        dataType: "json",
                        cache: false,
                        data: datas,
                        success: function (datas) {
                            if (datas.code == HttpUtil.success_code) {
                                window.location.reload();
                            }
                        }
                    });
                }
            }
        })
    }

    /**
     * 初始化绑定事件
     */
    function initBindEvents() {
        var type;
        //初始化弹出框参数
        $("[href='#live-img-alert']").click(function (e) {

            var hideData = $(this).attr('hideData');
            if (hideData) {
                var arr = hideData.split('#');
                $('#live-search-orderNum').val(arr[0]);
                $('#live-search-id').val(arr[1]);
                if (arr[3] == 0) {
                    $("input[name=type][value='0']").attr('checked', 'checked');
                } else {
                    $("input[name=type][value='1']").attr('checked', 'checked');
                }
                $('#cate-select-find').find("option[value=" + arr[4] + "]").attr('selected', 'selected');
                initCourseSelect($('#course-select-find'), 'live', 'find',function () {
                    $('#course-select-find').find("option[value=" + arr[5] + "]").attr('selected', 'selected');
                });
            }
            ;

            $('#live-img-alert').click();

            $('#liveCarouselSave').unbind('click').click(function () {
                var id = $("#live-search-id").val();
                var url;
                if (id){
                    url = "/configlive/update";
                }else {
                    url = "/configlive/save";
                }
                var chkRadio = $("#course-select-find").val();
                var data ={
                    courseId  :$.trim($("#course-select-find").val()) ,
                    orderNum  :$.trim($('#live-search-orderNum').val()) ,
                    id:$.trim($('#live-search-id').val()),
                    type:$.trim($("input[name=type]:checked").val())
                }
                if (chkRadio){
                    $.post(url, data, function (datas) {
                        if (datas.code == HttpUtil.success_code) {
                            window.location.reload();
                        }else {
                            alert("该课程已经保存");
                        }
                    });
                }else {
                    alert("请先选择课程")
                }
            })
        });

        //级联表单
        $('#cate-select-find').change(function () {
            initCourseSelect($('#course-select-find'),'live','find');
        })

        $('input:radio[name=type]').change(function () {
            initCourseSelect($('#course-select-find'),'live','find');
        })



    }

    /**
     * 初始化课程下拉菜单
     * @param select 下拉元素 类型必须为jquery对象
     * @param resCode   资源编码
     * @param operCode  操作编码
     */


    function initCourseSelect(select,resCode,operCode,callback){
        var directionId= $('#cate-select-find').val();
        var type= $('input:radio[name=type]:checked').val();
        var url = '/configlive/list/' + resCode + '/'+operCode;
        var data={"directionId":directionId, "type":type};
        $('#course-select-find').find("option").remove();
        $.post(url, data, function (data) {
            if (data.code == HttpUtil.success_code){
                var options = '';
                $.each(data.result,function (index,course) {
                    options+='<option value="'+course.id+'" >'+course.liveTitle+'</option>';
                })
                select.append(options);
                callback();
            }else{
                BootstrapDialog.alert(data.msg);
            }
        });
    }
    /**
     * 初始化方向下拉菜单
     * @param select 下拉元素 类型必须为jquery对象
     * @param resCode   资源编码
     * @param operCode  操作编码
     */
    function initCateSelect(select,resCode,operCode){
        var url = '/cate/list/' + resCode + '/'+operCode;
        $.get(url).done(function (data) {
            if (data.code == HttpUtil.success_code){
                var options = '';
                $.each(data.result,function (index,cate) {
                    options+='<option value="'+cate.id+'" >'+cate.categoryDesc+'</option>';
                })
                select.append(options);
            }else{
                BootstrapDialog.alert(data.msg);
            }
        });

    }

    //需要暴露到global域的API
    window.page ={
        init:function () {
            // //初始化方向分类下拉框
            initCateSelect($('#cate-select-find'),'live','find');
            //初始化各种事件绑定
            initBindEvents();
        },
        delLiveCarousel:delLiveCarousel,
        openModel:openModel,
    }

})(window)
