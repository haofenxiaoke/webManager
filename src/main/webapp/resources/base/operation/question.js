/**
 * Created by 李恒名 on 2016/6/14.
 * 意见反馈页脚本
 */

(function (window) {
    var DataTable;

    function initDataTables(){
        return $('#question-table').DataTable({
            searching:false,
            processing: true,
            serverSide: true,
            ordering:false, //排序
            ajax:{
                "url":"/question/list",
                "type": "POST",
                "dataType":"json",
                "data":function(data){
                    data.questionDateStr=$("#submit-date").val();
                    data.cateId=$("#cate-select").val();
                    data.courseId=$("#course-select").val();
                    data.lectureId=$("#lecture-select").val();
                    data.content=$("#search-content").val();
                    data.replyStatus=$("#reply-status").val();
                }
            },
            columns: [
                {data: "id", "visible": false},//visible 隐藏或显示
                {data: "username"},
                {data: "nickName"},
                {render: function (data, type, row, meta) {
                    return  row.content.length > 15 ?row.content.substring(0,15)+'...':row.content;
                 }
                },
                {data: "courseName"},
                {data: "lectureName"},
                {render: function (data, type, row, meta) {
                    return   moment(row.submitDate).format('YYYY-MM-DD HH:mm:ss ');
                    }
                },
                {render: function (data, type, row, meta) {
                    if (row.replyStatus == 1)
                        return '已回答';
                    return '未回答';
                    }
                },
                {render:function (data, type, row, meta) {
                        var buttons = '';
                        buttons += $('#button-1').html();
                        buttons += $('#button-2').html();
                        return buttons.replace(/#id/g,row.id);
                    }
                }

            ],
            language:{
                lengthMenu: "每页 _MENU_ 条记录",//下拉框文字
                info:"第 _PAGE_ 页 ( 总共 _PAGES_ 页 ,共 _TOTAL_ 项)",//左下角显示文字
                infoEmpty:"",//当查询没有数据时左下角显示文字
                sEmptyTable:"没有数据..",//当查询没有数据时表格中间显示文字
                paginate:{                          //分页
                    first:"首页",
                    last:"尾页",
                    next:"下一页",
                    previous:"上一页"
                }
            }
        });
    }

    /**
     * 查看意见
     * @param id
     */
    function lookQuestion(id) {
       $.post('/question/detail',{id:id})
            .done(function (data) {
                if (data.code == HttpUtil.success_code){
                    var  question = data.result;
                    var html ='';
                    html+=' <div class="list-group-item active">';
                    html+='<h5 class="list-group-item-heading">'+question.nickName+'<small> '+moment(question.questionTime).format('YYYY-MM-DD HH:mm:ss')+'</small></h5>';
                    html+=' <p class="list-group-item-text">'+question.questions+'</p>';
                    html+='</div>';
                    html+='<hr>';
                    $.each(question.replyList,function (index,reply) {
                        html+=' <div  class="list-group-item">';
                        html+='<h5 class="list-group-item-heading">'+reply.flowerName+'<small> '+moment(reply.replyTime).format('YYYY-MM-DD HH:mm:ss')+'</small></h5>';
                        html+=' <p class="list-group-item-text">'+reply.replyContent+'</p>';
                        html+='</div>';
                    });
                    $('#question-list').html(html);

                    //重置表单
                    $('#question-reply-form').bootstrapValidator('resetForm', true);
                    $('#question-reply-modal').modal('show');

                    //绑定意见回复按钮点击事件
                    $('#question-reply-btn').unbind('click').click(function () {
                        var passValidate = $('#question-reply-form').data('bootstrapValidator').validate().isValid();
                        if(passValidate){
                            var data = {
                                questionId:id,
                                replyContent:$('#reply-content').val()
                            };
                            $.post('/question/reply',data)
                                .done(function (data) {
                                    if (data.code == HttpUtil.success_code){
                                        $('#question-reply-modal').modal('hide');
                                        DataTable.ajax.reload();
                                    }else{
                                        BootstrapDialog.alert(data.msg);
                                    }
                                }).fail(function () {
                                BootstrapDialog.alert('请求服务器失败!');
                            });
                        }
                    });
                }else{
                    BootstrapDialog.alert(data.msg);
                }
            })
            .fail(function () {
                BootstrapDialog.alert('请求服务器失败!');
            });
    }

    /**
     * 删除提问
     * @param id
     */
    function deleteQuestion(id) {
        BootstrapDialog.confirm({
            title: '删除提问',
            message: '你确认要删除该提问吗？',
            type: BootstrapDialog.TYPE_WARNING,
            closable: true,
            btnCancelLabel: '取消',
            btnOKLabel: '确认',
            btnOKClass: 'btn-warning',
            callback: function (yes) {
                if (yes){
                    $.post('/question/delete',{id:id})
                        .done(function (data) {
                            if (data.code == HttpUtil.success_code){
                                DataTable.ajax.reload();
                            }else{
                                BootstrapDialog.alert(data.msg);
                            }
                        }).fail(function () {
                        BootstrapDialog.alert('请求服务器失败!');
                    });
                }
            }
        });
    }

    function initBindEvents(){
        //绑定搜索按钮事件
        $('#search').click(function () {
            DataTable.ajax.reload();
        });

        $('#search-reset').click(function () {
           $('#search-form')[0].reset();
        });


        //绑定表单验证器
        $('#question-reply-form').bootstrapValidator({
            message: 'This value is not valid',
            excluded: [':disabled'],//不加它重新打开模态框时提示不会清除
            fields: {
                replyContent: {
                    validators: {
                        notEmpty: {
                            message: '回复内容不能为空'
                        },
                        stringLength: {
                            max: 500,
                            message: '回复内容不能超过500个字'
                        }
                    }
                }
            }
        });
    }



    function initCountInfo() {
        $.getJSON('/question/count')
            .done(function (data) {
                if (data.code == HttpUtil.success_code){
                    $('#today-add').html(data.result.todayAddCount);
                    $('#unreply').html(data.result.noReplyCount);

                }else{
                    BootstrapDialog.alert(data.msg);
                }
            }).fail(function () {
            BootstrapDialog.alert('请求服务器失败!');
        });
    }


    /**
     * 初始化下拉菜单
     * @param select 下拉元素 类型必须为jquery对象
     * @param resCode   资源编码
     * @param operCode  操作编码
     */
    function initCateSelect(select,resCode,operCode){
        var url = '/cate/list/' + resCode + '/'+operCode;
        $.get(url).done(function (data) {
            if (data.code == HttpUtil.success_code){
                select.empty();
                var options = '<option value="">--方向--</option>';
                $.each(data.result,function (index,cate) {
                    options+='<option value="'+cate.id+'">'+cate.categoryDesc+'</option>';
                })
                select.append(options);
            }else{
                BootstrapDialog.alert(data.msg);
            }
        });
    }

    /**
     * 初始化课程下拉菜单
     * @param select 下拉元素 类型必须为jquery对象
     * @param selValue   课程分类方向ID
     */
    function initCourseSelect(select,selValue){
        var url = '/course/select/list/' + selValue;
        $.get(url).done(function (data) {
            if (data.code == HttpUtil.success_code){
                select.empty();
                var options = '<option value="">--课程--</option>';
                $.each(data.result,function (index,course) {
                    options+='<option value="'+course.id+'">'+course.title+'</option>';
                })
                select.append(options);
            }else{
                BootstrapDialog.alert(data.msg);
            }
        });
    }

    /**
     * 初始化节（视频）下拉菜单
     * @param select 下拉元素 类型必须为jquery对象
     * @param selValue   课程ID
     */
    function initLectureSelect(select,selValue){
        var url = '/lecture/list';
        $.get(url,{courseId:selValue}).done(function (data) {
            if (data.code == HttpUtil.success_code){
                var options = '';
                $.each(data.result,function (index,lecture) {
                    options+='<option value="'+lecture.id+'">'+lecture.lectureName+'</option>';
                })
                select.append(options);
            }else{
                BootstrapDialog.alert(data.msg);
            }
        });
    }

    /**
     * 初始化级联下拉菜单
     */
    function initSelects() {
        var $cateSelect = $('#cate-select');
        var $courseSelect = $('#course-select');
        var $lectureSelect = $('#lecture-select');
        initCateSelect($cateSelect,'question','find');
        $cateSelect.change(function() {
            $courseSelect.val("");
            $lectureSelect.val("");
            initCourseSelect($courseSelect,$(this).val());
                $courseSelect.change(function() {
                    $lectureSelect.val("");
                    initLectureSelect($lectureSelect,$(this).val());
                });
        });
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

        var datas = {
            questionDateStr: $("#question-date").val(),
            cateId: $("#cate-select").val(),
            courseId: $("#course-select").val(),
            lectureId: $("#lecture-select").val(),
            content: $("#search-content").val(),
            replyStatus: $("#reply-status").val()
        };

        var separator = ',\u200C';
        var htmlText = '学员账号,昵称,内容,课程,节,提问日期,回答状态,回答的答案,回答老师姓名,老师花名';

        $.ajax({
            url:"/question/export/csv/answers",
            type:"post",
            dataType:"json",
            cache: false,
            async: false,
            data :datas,
            success: function (data){
                if(data.code == HttpUtil.success_code){
                    $.each(data.result, function (index,info) {
                        htmlText += '\n\u200C'+info.userName+
                            separator+(info.nickName ? info.nickName : '')+
                            separator+info.content+
                            separator+info.courseTitle+
                            separator+info.lectureName+
                            separator+info.questionTime+
                            separator+(info.replyStatus == 1 ? '已回答' : '未回答')+
                            ','+info.answers+
                        separator+(info.teacherName ? info.teacherName : '')+
                            separator+(info.flowerName ? info.flowerName : '');
                    })
                }
            }
        })

        aLink.download = $('#export').attr('download');
        var blob = new Blob(["\ufeff", htmlText],{type: 'text/csv,charset=utf-8'});
        aLink.href = URL.createObjectURL(blob);
    }

    window.page = {
        init:function () {
            //初始化统计信息
            initCountInfo();
            //初始化级联下拉菜单
            initSelects()
            //加载日期选择器
            bootstrapDateUtil.show('submit-date');
            //初始化DataTables
            DataTable = initDataTables();
            //初始化事件绑定
            initBindEvents();
        },
        look:lookQuestion,
        export:exportData,
        delete:deleteQuestion
    }
})(window)