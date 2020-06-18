/**
 * Created by 李恒名 on 2016/6/3.
 */

(function(window){
    var liveIsOverdue = false;//直播是否过期标识符
    var DataTable;
    //打开创建、修改直播课模态框
    function openModal(id) {
        //重置表单
        $('#course-detail-form').bootstrapValidator('resetForm', true);
        $('#preview-image').attr('src','');
        if(id){//如果传过来的有id说明为点击修改按钮进入的模态框，需要初始化模态框数据
            $.post('/live/detail',{id:id},function (data) {
                if(data.code == HttpUtil.success_code){
                    var course = data.result;
                    $('#course-date').val(moment(course.liveStart).format('YYYY-MM-DD'));
                    $('#course-start-time').val(moment(course.liveStart).format('HH:mm'));
                    $('#course-end-time').val(moment(course.liveEnd).format('HH:mm'));
                    $('#course-name').val(course.liveTitle);
                    $('#recordingId').val(course.recordingId);
                    if(pid == 'sjn'){
                        $('#preview-image').attr('src',course.courseUrl);
                        $('#course-image-path').val(course.courseUrl);
                    }
                    $('#teacher-name').find("option[value="+course.teacherId+"]").attr('selected','selected');
                    $('#course-description').val(course.summary);
                    $('#cate-select-save').val(course.categoryId);
                    $('#live-id').val(course.liveId);
                    $('input[name="createType"][value='+course.type+']').attr("checked", true)
                    $('#course-detail-modal').modal('show');

                }
            });
        }else{
            $('#course-detail-modal').modal('show');
        }

        $('#save-course').unbind('click').click(function () {
            var pass = $('#course-detail-form').data('bootstrapValidator').validate().isValid();//表单验证是否通过
            if (pass){
                var courseDate = $.trim($('#course-date').val());
                var data ={
                    categoryId  :$.trim($('#cate-select-save').val()) ,
                    liveStart  :$.trim($('#course-start-time').val()) ,
                    liveEnd  :$.trim($('#course-end-time').val()) ,
                    teacherId  :$.trim($('#teacher-name').val()) ,
                    liveTitle  :$.trim($('#course-name').val()) ,
                    recordingId  :$.trim($('#recordingId').val()),
                    liveId  :$.trim($('#live-id').val()),
                    liveType :$.trim($('#liveType').val())
                    // type:$.trim($('input[name="createType"]:checked').val())
                }
                if(pid == 'sjn'){
                    data.courseUrl = $.trim($('#course-image-path').val()) ;
                    data.summary  = $.trim($('#course-description').val());
                    data.type = 1;
                }else if(pid == 'kjs'){
                    data.type = $.trim($('input[name="createType"]:checked').val());
                }
                data.liveStart = moment(courseDate + ' ' +data.liveStart).toDate();
                data.liveEnd = moment(courseDate + ' ' +data.liveEnd).toDate();
                var url;
                if (id){
                    url = '/live/modify';
                    data.id = id;
                }else{
                    url = '/live/save';
                }
                $.post(url,data,function (data) {
                    if (data.code == HttpUtil.success_code){
                        $('#course-detail-modal').modal('hide');
                        DataTable.ajax.reload();
                    } else{
                        BootstrapDialog.alert(data.message);
                    }
                });
            }
        });

    }

    //删除直播课
    function deleteLive(id){
        var type=$('#liveType').val();

        BootstrapDialog.confirm({
            title: '删除直播课',
            message: '你确定要删除该直播课吗？',
            type: BootstrapDialog.TYPE_WARNING,
            closable: true,
            btnCancelLabel: '取消',
            btnOKLabel: '确认',
            btnOKClass: 'btn-warning',
            callback: function (yes) {
                if (yes){
                    $.post('/live/delete',{id:id},function (result) {
                        if (result.code == HttpUtil.success_code) {
                            DataTable.ajax.reload();
                        }else{
                            if (type==1){
                                BootstrapDialog.alert("该公开课已经配置在首页，请解除配置后再操作删除！")
                            }else {
                                BootstrapDialog.alert("该直播课已经配置在首页，请解除配置后再操作删除！")
                            }
                        }
                    });
                }
            }
        })
    }

    /**
     * 初始化 jQuery File Upload 上传文件插件
     * @param fileId
     * @param previewId  预览图id
     * @param savePathInputId  保存图片路径的input id
     */
    function initFileupload(fileId,previewId,savePathInputId) {
        $('#'+fileId).fileupload({
            url:'/upload/image?dirName=homeSet',
            done: function (e, data) {
                if(data.result.code == HttpUtil.success_code){
                    var path = data.result.result.path;
                    $('#'+previewId).attr('src', path);
                    $('#'+savePathInputId).val(path);

                    $('#course-detail-form')//上传成功表单验证设置为通过
                        .data('bootstrapValidator')
                        .updateStatus('courseImage', 'NOT_VALIDATED', null)
                        .validateField('courseImage');
                }else{
                    var alert = BootstrapDialog.alert||window.alert;
                    alert(data.result.msg);
                }
            }
        });
    }

    function initDataTables(){
        return $('#live-table').DataTable({
            searching:false,
            processing: true,
            serverSide: true,
            ordering:false, //排序
            ajax:{
                "url":"/live/list",
                "type": "POST",
                "dataType":"json",
                "data":function(data){
                    data.dateString=$("#open-course-date").val();
                    data.derectionId= $('#cate-select-find').val();
                    data.courseName = $('#courseName').val();
                    data.liveType = $('#liveType').val();
                    data.liveIsOverdue = liveIsOverdue;
                }
            }
            ,
            columns: [
                {data: "id", "visible": false},//visible 隐藏或显示
                {data: "liveTitle"},
                {data: "cateDirectionName"},
                {render: function (data, type, row,column, meta) {
                    moment.locale('ch', {
                        weekdays  : ["星期日","星期一", "星期二", "星期三", "星期四", "星期五", "星期六"]
                     });
                         return  moment(row.liveStart).format('YYYY-MM-DD dddd ');
                    }
                },
                {render: function (data, type, row, meta) {
                    if (row.recordingId!= null && row.recordingId!="")
                        return '是';
                    return '否';
                }
                },
                {render: function (data, type, row, meta) {
                    return  moment(row.liveStart).format('HH:mm ') + '-' + moment(row.liveEnd).format('HH:mm');
                }
                },
                {render:function (data, type, row, meta) {
                        return $('#buttons').html().replace(/#id/g,row.id);
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

    //初始化Datetimepicker时间控件
    function initDatetimepicker() {
        var timeOption = {
            language:  'zh-CN',
            autoclose: 1,
            startView: 1,
            minView: 0,
            maxView: 1,
            forceParse: 1,
            minuteStep:1
        }
        var dateOption = {
            language:  'zh-CN',
            weekStart: 1,
            todayBtn:  1,
            autoclose: 1,
            todayHighlight: 1,
            startView: 2,
            minView: 2,
            forceParse: 0,
            startDate:new Date()

        }
        $('#course-date').datetimepicker(dateOption);

        $('#course-date').change(function () {

            $('#course-start-time').datetimepicker(timeOption);
            $('#course-end-time').datetimepicker(timeOption);

            var datetimepickeStartTime;
            if(moment(new Date()).format('YYYY-MM-DD') == $(this).val()){
                datetimepickeStartTime = $(this).val() + ' '+  moment(new Date()).format('HH:mm:ss');
            }else{
                datetimepickeStartTime = $(this).val() + ' 00:00:00';
            }
            $('#course-start-time').datetimepicker('setStartDate',datetimepickeStartTime);
            $('#course-end-time').datetimepicker('setStartDate',datetimepickeStartTime);

            var datetimepickeEndTime =  $(this).val() + ' 23:59:59'
            $('#course-start-time').datetimepicker('setEndDate',datetimepickeEndTime);
            $('#course-end-time').datetimepicker('setEndDate',datetimepickeEndTime);
        })

        $('#course-start-time').change(function () {
            $('#course-end-time').val('');
            var time = $(this).val() + ':00';
            $('#course-end-time').datetimepicker('setStartDate', $('#course-date').val() +' ' + time);
        });
        //添加与bootstrapValidator 相关的事件

        $('#course-date').on('hide', function(e) {
            // Validate the date when user change it
            $('#course-detail-form')
            // Get the bootstrapValidator instance
                .data('bootstrapValidator')
                // Mark the field as not validated, so it'll be re-validated when the user change date
                .updateStatus('courseDate', 'NOT_VALIDATED', null)
                // Validate the field
                .validateField('courseDate');
        });

        $('#course-start-time').on('hide', function(e) {
            // Validate the date when user change it
            $('#course-detail-form')
            // Get the bootstrapValidator instance
                .data('bootstrapValidator')
                // Mark the field as not validated, so it'll be re-validated when the user change date
                .updateStatus('liveStart', 'NOT_VALIDATED', null)
                // Validate the field
                .validateField('liveStart');
        });

        $('#course-end-time').on('hide', function(e) {
            // Validate the date when user change it
            $('#course-detail-form')
            // Get the bootstrapValidator instance
                .data('bootstrapValidator')
                // Mark the field as not validated, so it'll be re-validated when the user change date
                .updateStatus('liveEnd', 'NOT_VALIDATED', null)
                // Validate the field
                .validateField('liveEnd');
        });
    }

    function initBindEvents(){
        //页面加载之后默认显示第一个tab
        $('#tabs a:first').tab('show');

        // 绑定tab显示之前事件
        $('#tabs a').on('show.bs.tab', function (e) {
            $('#search-form')[0].reset();
            if ($(this).data('type') == 'overdue')
                liveIsOverdue = true;
            else
                liveIsOverdue = false;
            DataTable.ajax.reload();
        });

        //绑定tab点击事件
        $('#tabs a').click(function (e) {
            $(this).tab('show')
        });

        //绑定搜索按钮事件
        $('#search').click(function () {
            DataTable.ajax.reload();
        });
        //绑定创建课程按钮事件
        $('#createCourse').click(function () {
            openModal();
        })
        //绑定表单验证器
        if(pid == 'sjn'){
            bootstrapValidatorForSjn();
        }else if(pid == 'kjs'){
            bootstrapValidatorForKjs();
        }

        //绑定模态框打开前时间(用于打开前重置表单)
        $('#course-detail-form').on('show.bs.modal', function() {
            $('#course-detail-modal').bootstrapValidator('resetForm', true);
        });

    }

    function bootstrapValidatorForKjs() {
        $('#course-detail-form').bootstrapValidator({
            message: 'This value is not valid',
            excluded: [':disabled'],//不加它重新打开模态框时提示不会清除
            fields: {
                liveId: {
                    validators: {
                        notEmpty: {
                            message: '请输入直播ID'
                        },
                        stringLength: {
                            max: 50,
                            message: '不能超过50个字'
                        }
                    }
                },
                teacherName: {
                    validators: {
                        notEmpty: {
                            message: '请选择老师'
                        }
                    }
                },
                direction: {
                    validators: {
                        notEmpty: {
                            message: '请选择方向'
                        }
                    }
                },
                courseDate : {
                    validators: {
                        notEmpty: {
                            message: '上课日期不能为空'
                        }, date: {
                            format: 'YYYY-MM-DD',
                            message: '格式错误'
                        }
                    }
                },
                liveStart : {
                    validators: {
                        notEmpty: {
                            message: '请选择'
                        }
                    }
                },
                liveEnd : {
                    validators: {
                        notEmpty: {
                            message: '请选择'
                        }
                    }
                },
                teacherName : {
                    validators: {
                        notEmpty: {
                            message: '请输入老师名字'
                        },
                        stringLength: {
                            max: 10,
                            message: '不能超过10个字'
                        }
                    }
                },
                courseName : {
                    validators: {
                        notEmpty: {
                            message: '请输入课程名称'
                        },
                        stringLength: {
                            max: 20,
                            message: '不能超过20个字'
                        }
                    }
                },
                createType : {
                    validators: {
                        notEmpty: {
                            message: '请选择直播类型'
                        }
                    }
                },
                // courseImage : {
                //     validators: {
                //         notEmpty: {
                //             message: '请上传课程的图片'
                //         }
                //     }
                // },
                // courseDescription : {
                //     validators: {
                //         notEmpty: {
                //             message: '请输入课程简介'
                //         },
                //         stringLength: {
                //             max: 500,
                //             message: '不能超过400个字'
                //         }
                //
                //     }
                // },
                recordingId : {
                    validators: {

                    }
                }
            }
        });
    }

    function bootstrapValidatorForSjn() {
        $('#course-detail-form').bootstrapValidator({
            message: 'This value is not valid',
            excluded: [':disabled'],//不加它重新打开模态框时提示不会清除
            fields: {
                liveId: {
                    validators: {
                        notEmpty: {
                            message: '请输入直播ID'
                        },
                        stringLength: {
                            max: 50,
                            message: '不能超过50个字'
                        }
                    }
                },
                teacherName: {
                    validators: {
                        notEmpty: {
                            message: '请选择老师'
                        }
                    }
                },
                direction: {
                    validators: {
                        notEmpty: {
                            message: '请选择方向'
                        }
                    }
                },
                courseDate : {
                    validators: {
                        notEmpty: {
                            message: '上课日期不能为空'
                        }, date: {
                            format: 'YYYY-MM-DD',
                            message: '格式错误'
                        }
                    }
                },
                liveStart : {
                    validators: {
                        notEmpty: {
                            message: '请选择'
                        }
                    }
                },
                liveEnd : {
                    validators: {
                        notEmpty: {
                            message: '请选择'
                        }
                    }
                },
                teacherName : {
                    validators: {
                        notEmpty: {
                            message: '请输入老师名字'
                        },
                        stringLength: {
                            max: 10,
                            message: '不能超过10个字'
                        }
                    }
                },
                courseName : {
                    validators: {
                        notEmpty: {
                            message: '请输入课程名称'
                        },
                        stringLength: {
                            max: 20,
                            message: '不能超过20个字'
                        }
                    }
                },
                createType : {
                    validators: {
                        notEmpty: {
                            message: '请选择直播类型'
                        }
                    }
                },
                courseImage : {
                    validators: {
                        notEmpty: {
                            message: '请上传课程的图片'
                        }
                    }
                },
                courseDescription : {
                    validators: {
                        notEmpty: {
                            message: '请输入课程简介'
                        },
                        stringLength: {
                            max: 500,
                            message: '不能超过400个字'
                        }

                    }
                },
                recordingId : {
                    validators: {

                    }
                }
            }
        });
    }

    /**
     * 初始化老师列表下拉菜单
     * @param select 下拉元素 类型必须为jquery对象
     * @param resCode   资源编码
     * @param operCode  操作编码
     */
    function initTeacherSelect(select,resCode,operCode){
        var url = '/teacher/' + resCode + '/'+operCode;
        $.get(url).done(function (data) {
            if (data.code == HttpUtil.success_code){
                var options = '';
                $.each(data.result,function (index,teacher) {
                    options+='<option value="'+teacher.id+'">'+teacher.name+'</option>';
                })
                select.append(options);
            }else{
                BootstrapDialog.alert(data.msg);
            }
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
                var options = '';
                $.each(data.result,function (index,cate) {
                    options+='<option value="'+cate.id+'">'+cate.categoryDesc+'</option>';
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

            //初始化数据表格插件
            DataTable = initDataTables();

            //初始化各种事件绑定
            initBindEvents();

            //初始化方向分类下拉框
            initCateSelect($('#cate-select-find'),'live','find');

            initCateSelect($('#cate-select-save'),'live','save');

            initTeacherSelect($('#teacher-name'),'course','find');
            //加载日期选择器
            bootstrapDateUtil.show('open-course-date');

            //初始化时间选择器
            initDatetimepicker();

            // //初始化文件上传插件
            if(pid == 'sjn'){
                initFileupload('imageFile','preview-image','course-image-path');
            }
        },
        openModal:openModal,
        deleteLive:deleteLive
    }
})(window);