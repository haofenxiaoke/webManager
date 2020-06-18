var courseId='';
var t;//代表章节table的变量
var counter = 1;//表示table行的序号
var canSubmit=true;//是否可以提交
var isSubmit=true;//
var coursePositionId='';
var courseDirectionId='';
var operationType='';
var txt='';//章节保存信息
var checkedOrders='';//章节序号数组
var message='';//表单验证错误提示语
//var pid='';//项目编码会计狮：kjs；设计牛：sjn。
String.prototype.trim = function() { return this.replace(/^\s+/, '').replace(/\s+$/, ''); }//解决ie8不支持trim函数的问题
$(document).ready(function () {
    pid=$("#pid").val();
    //拖拽排序
    orderIndex = new BootstrapOrder();

    // 设置目标区域 隐藏消失
    $(document).click(function(event){
        var _con = $('.panel-order');
        if(!_con.is(event.target) &&
            _con.has(event.target).length === 0){
            orderIndex.hide();
        }
    });
    $("#base-next").unbind().bind("click",function() {
            //验证课程基础信息表单
            var isNext=testCourseBase();
            if(isNext==false){
                return;
            }
          $("#brief-href").click();
        }
    )
    $("#brief-back").unbind().bind("click",function() {
            $("#base-href").click();
        }
    )
    $("#brief-next").unbind().bind("click",function() {
            //验证课程长字段
            var isNext=testCourseBrief();
            if(isNext==false){
                return;
            }
            $("#config-href").click();
        }
    )
    $("#config-back").unbind().bind("click",function() {
            $("#brief-href").click();
        }
    )
    courseId=$("#courseId").val()+'';
    coursePositionId=$("#coursePositionId").val()+'';
    courseDirectionId=$("#courseDirectionId").val()+'';
    operationType=$("#operationType").val()+'';
    getDirections();
    directionChange();
    positionChange();
    if(operationType!='0'&& operationType!=0){
        /*回写课程优势*/
        advantageWriteBack(courseId,2);
        /*回写适合对象*/
        suitableWriteBack(courseId,1);
        if(pid=='kjs'){
            /*回写课程行业*/
            getCourseIndustry(courseId);
        }

    }
    //initUeditor();

     validateForm();
//    初始化上传插件
    initFileupload('imageFile','preview-image','course-image-path');
    initLectures();
    showOrderBtn();

});


function showSort() {
    var aa=$("#lecture_table tr");
    var isTrue=false;
    var nullVal = $('.dataTables_empty').html();
    if(nullVal){
        //BootstrapDialog.warning('无有效课程章节，请添加数据！');
        return;
    }
    event.stopPropagation();//取消事件冒泡
    orderIndex.toggleShow();
    addSortData();
}

function addSort(item) {
    orderIndex.addItem(item);
}

//章节数据
function addSortData(){
    $("#lecture_table tr").each(function(index, val) {
        if (index > 0) {
            var order = $(this).find('td').eq(0).html();
            var title = $(this).find('td').eq(1).find("input").val();
            addSort({id: order, name: title, num: parseInt(order)})
        }
    });
}

//覆盖数据
function fillSortData(){
    var datas = [];
    var data = orderIndex.getData();
    orderIndex.hide();

    $("#lecture_table tr").each(function(index, value) {
        if (index > 0) {
            var t_data = [];
            t_data[0] = $(this).find('td').eq(0).html();
            t_data[1] = $(this).find('td').eq(1).find("input").val();
            t_data[2] = $(this).find('td').eq(2).find("input").val();
            t_data[3] = $(this).find('td').eq(3).find("input").val();
            t_data[4] = $(this).find('td').eq(4).find("input").val();
            t_data[5] = $(this).find('td').eq(5).find("input[name='lecturePptUrl']").val();
            t_data[6] = $(this).find('td').eq(5).find("input[name='fileLength']").val();
            t_data[7] = $(this).find('td').eq(5).find("input[name='lectureConverswfUrl']").val();
            t_data[8] = $(this).find('td').eq(5).find("input[name='id']").val();
            t_data[9] =$(this).find('td').eq(6).find("input").is(':checked');
            if($("#lecture_table tr td").size()>7){
                t_data[10] =$(this).find('td').eq(7).find("input[name='videoLength']").val();
            }

            $.each(data,function(d_index){
                if(t_data[0] == data[d_index].id){
                    t_data[0] = data[d_index].num;
                    return false;
                }
            });
            datas.push(t_data);
        }
    });

    if(!datas) return;

    //定义了sort的比较函数
    datas = datas.sort(function(a,b){
        return a[0]- b[0];
    });

    t.clear();//清除对象信息
    $.each(datas,function(index,val){//table赋值
        var o = datas[index];
        var lengthStr='';
        /*增加一行前判断是否需要分钟数*/
        if(operationType!=0&& operationType!='0'){
            lengthStr= '<input type="text" name="videoLength" value="'+o[10]+'" disabled="true" id="videoLength'+o[0]+'"/>';
        }
        var checkedStr;
        var uploadDesc;
        var  url=o[5];
        if(url!=null && url!=''){
            uploadDesc='重新上传';
        }else{
            uploadDesc='上传资料';
        }
        if(o[9]==1) checkedStr="checked";
        var preViewBtnHtml=  '<input id="previewBtn'+o[0]+'" onclick="preview('+o[0]+')" class="btn btn-primary btn-sm" type="button" style="margin-left:10px; visibility:hidden" value="预览"/>';
        if(pid=='sjm'){
            preViewBtnHtml='';
        }
        t.row.add( [
            o[0],
            '<input type="text" name="lectureName" id="lectureName'+o[0]+'" value="'+o[1]+'" />',
            '<input type="text" name="videoId" value="'+o[2]+'" id="videoId'+o[0]+'" />',
            '<input type="text" name="ccVideoUnique" value="'+o[3]+'" id="ccVideoUnique'+o[0]+'" />',
            '<input type="text" name="fileTitle" value="'+o[4]+'" id="fileTitle'+o[0]+'" />',
            '<div class="col-md-4" id="btn'+o[0]+'">'+
            '<span class="btn btn-primary btn-sm fileinput-button">'+
            '<i class="glyphicon glyphicon-plus"></i>'+
            ' <span>'+uploadDesc+'</span>'+
            '<input id="pdfFile'+o[0]+'" type="file" name="pdfFile">'+
            '<input type="hidden" id="lecturePptUrl'+o[0]+'" name="lecturePptUrl" value="'+o[5]+'">'+
            '<input type="hidden" id="lectureConverswfUrl'+o[0]+'" name="lectureConverswfUrl" value="'+o[7]+'">'+
            '<input type="hidden" id="fileLength'+o[0]+'" name="fileLength" value="'+o[6]+'">'+
            '<input type="hidden" name="id" id="id'+o[0]+'" value="'+o[8]+'" />'+
            ' </span>'+'</div>'+
            '<input id="delBtn'+o[0]+'"onclick="delPptUrl(this,'+o[0]+')" class="btn btn-danger btn-sm" type="button"  style="visibility:hidden" value="删除资料"/>'+
            preViewBtnHtml,
            '<input type="checkbox" class="audition" name="isvipVideo" id="isvipVideo'+o[0]+'" '+checkedStr +'/>',
            lengthStr] ).draw();
        initPDFFileupload("pdfFile"+o[0],"lecturePptUrl"+o[0],o[0]);
    });
}

/**
 * 初始化 jQuery File Upload 上传文件插件
 * @param fileId
 * @param previewId  预览图id
 * @param savePathInputId  保存图片路径的input id
 */
function initFileupload(fileId,previewId,savePathInputId) {

    $('#'+fileId).fileupload({
        url:'/upload/image',
        done: function (e, data) {
            if(data.result.code == HttpUtil.success_code){
                var path = data.result.result.path;
                $('#'+previewId).attr('src', path);
                $('#'+savePathInputId).val(path);
                $('#course')//上传成功表单验证设置为通过
                    .data('bootstrapValidator')
                    .updateStatus('coverUrl', 'NOT_VALIDATED', null)
                    .validateField('coverUrl');
            }else{
                var alert = BootstrapDialog.alert||window.alert;
                alert(data.result.msg);
            }
        }
    });
}

/*获取方向下拉列表*/
function getDirections(){
    //获取放向下拉菜单数据
    var  condition;
    condition= $("#courseDirectionId").val();
    var  resCode='addcourse';
    var operCode='save';
    var url = '/cate/list/' + resCode + '/'+operCode;
    $.get(url).done(function (data) {
        if (data.code == HttpUtil.success_code){
            var options = '';
            $.each(data.result,function (index,cate) {
                if(condition){
                    if(cate.id==condition){
                        options+='<option value="'+cate.id+'" selected=\"selected\">'+cate.categoryDesc+'</option>';
                    }else{
                        options+='<option value="'+cate.id+'">'+cate.categoryDesc+'</option>';
                    }
                }else{
                    options+='<option value="'+cate.id+'">'+cate.categoryDesc+'</option>';
                }

            })
            $("#directionId").append(options);
            getPosition();
        }else{
            BootstrapDialog.alert(data.msg);
        }
    });
}
/*获取方向下行业的下拉列表*/
function getIndustry(directionId){
    var data={directionId:directionId};
            //获取放向下的行业下拉菜单数据
        $.ajax({
            url: "/industry/industryList",
            type: "post",
            dataType: "json",
            cache: false,
            async: false,
            data: data,
            success: function (datas) {
                var result = datas.result;
                $("#industryids").find("option").remove();
                $.each(result,function(n,obj) {
                    var id=  obj.id;
                    var categoryDesc = obj.categoryDesc;
                    var option = $("<option value='"+id+"'>"+categoryDesc+"</li>");
                    $("#industryids").append(option);
                });
            }
        })
}


/*获取方向下的职位列表*/
function getPosition(){
    /*获取方向下职位的下拉列表*/
    var directionId=$("#directionId").val();
    if(directionId==null ||directionId==''){
        return false;
    }
    var data={directionId:directionId};


    //获取放向下的职位下拉菜单数据
    $.ajax({
        url: "/position/positionList",
        type: "post",
        dataType: "json",
        cache: false,
        async: false,
        data: data,
        success: function (datas) {
            var result = datas.result;
            $("#positionId").find("option").remove();

           // console.log(result);
            var coursePositionId=$('#coursePositionId').val()+"";
            var firstOption = $("<option value='' selected=\"selected\">"+"-"+cate3+"-"+"</li>");
            $("#positionId").append(firstOption);
            if(result!=null && result!=''){

                $.each(result,function(n,obj) {
                    var id=  obj.id;
                    var categoryDesc = obj.categoryDesc;
                    if(coursePositionId!=null && coursePositionId!=""){
                        if(id==coursePositionId){
                            var option = $("<option value='"+id+"' selected=\"selected\">"+categoryDesc+"</li>");
                        }else{
                            var option = $("<option value='"+id+"'>"+categoryDesc+"</li>");
                        }
                        $("#positionId").append(option);
                    }else{
                        var option = $("<option value='"+id+"'>"+categoryDesc+"</li>");
                        $("#positionId").append(option);
                    }
                });
            }

        }
    })
};

/*
* 方向selection变更时触发事件
* */
function directionChange (){
    /*方向选择框change事件*/
    $("#directionId").change(function(){
        /*清空职位*/
        $("#positionId").empty();
        var firstOption = $("<option value='' selected=\"selected\">"+"-"+cate3+"-"+"</li>");
        $("#positionId").append(firstOption);
        /*清空行业*/
        if(pid=='kjs'){
            $("#industry").find("li").remove();
        }
        /*清空适合对象*/
        $("#suitables").find("li").remove();
        /*清空课程优势*/
        $("#advantages").find("li").remove();
        /*清空课程标题*/
        $("#title").val('');
        /*清空版本号*/
        $('#version').val('');
        $('#versionShow').val('');
        /*删除选中状态*/
        $('input:radio[name="createType"]').attr("checked",false);


    })
}
/*
 * 职位selection变更时触发事件
 * */
function positionChange (){
    /*职位选择框change事件*/
    $("#positionId").change(function(){
        /*清空行业*/
        if(pid=='kjs') {
            $("#industry").find("li").remove();
        }
        /*清空适合对象*/
        $("#suitables").find("li").remove();
        /*清空课程优势*/
        $("#advantages").find("li").remove();
        /*清空课程标题*/
        $("#title").val('');
        /*清空版本号*/
        $('#version').val('');
        $('#versionShow').val('');
        /*删除选中状态*/
        $('input:radio[name="createType"]').attr("checked",false);
    })
}
/*
*  初始化百度编辑器
* */
function initUeditor(){
    var jobDuty = '${courseText.jobDuty}' + "";
    var summary = '${courseText.summary}' + "";
    var teacherBrief = '${courseText.teacherId}' + "";
    var job_duty = UE.getEditor('job_duty');
    if(pid=='kjs'){
        job_duty.ready(function () {
            if (jobDuty != null && jobDuty != '') {
                this.setContent(jobDuty);
            } else {
                this.setContent("请填写岗位职责");
            }

        });
    }

    var course_brief = UE.getEditor('course_brief');
    course_brief.ready(function(){
        if(summary!=null && summary!=''){
            this.setContent(summary);
        }else{
            this.setContent("请填写课程简介");
        }

    });
   /* var teacher_brief = UE.getEditor('teacher_brief');
    teacher_brief.ready(function(){
        if(teacherBrief!=null && teacherBrief!=''){
            this.setContent(teacherBrief);
        }else{
            this.setContent("请填写老师介绍");
        }

    });*/
}

/*获取课程优势下拉列表*/
function getCourseAdvantage(courseId,type){
    var directionId = $('#directionId').val();
    var data={type:type,courseId:courseId,directionId:directionId};
            //获取课程优势下拉菜单数据
        $.ajax({
            url:"/tag/typeTagList",
            type: "post",
            dataType: "json",
            cache: false,
            async: false,
            data: data,
            success: function (datas) {
                var result = datas.result;
                $("#courseAdvantages").find("option").remove();
                $.each(result,function(n,obj) {
                    var id=  obj.id;
                    var content = obj.content;
                    var option = $("<option value='"+id+"'>"+content+"</li>");
                    $("#courseAdvantages").append(option);
                });
            }
        })


}


/*获取方向下行业的下拉列表*/
function getIndustry(directionId){
    var data={directionId:directionId};
            //获取放向下的行业下拉菜单数据
        $.ajax({
            url: "/industry/industryList",
            type: "post",
            dataType: "json",
            cache: false,
            async: false,
            data: data,
            success: function (datas) {
                var result = datas.result;
                $("#industryids").find("option").remove();
                $.each(result,function(n,obj) {
                    var id=  obj.id;
                    var categoryDesc = obj.categoryDesc;
                    var option = $("<option value='"+id+"'>"+categoryDesc+"</li>");
                    $("#industryids").append(option);
                });
            }
        })
}

/*获取课程优势下拉列表*/
function getCourseAdvantage(courseId,type){
    var directionId = $('#directionId').val();
    var data={type:type,courseId:courseId,directionId:directionId};
            //获取课程优势下拉菜单数据
        $.ajax({
            url:"/tag/typeTagList",
            type: "post",
            dataType: "json",
            cache: false,
            async: false,
            data: data,
            success: function (datas) {
                var result = datas.result;
                $("#courseAdvantages").find("option").remove();
                $.each(result,function(n,obj) {
                    var id=  obj.id;
                    var content = obj.content;
                    var option = $("<option value='"+id+"'>"+content+"</li>");
                    $("#courseAdvantages").append(option);
                });
            }
        })
}

/*回写课程优势的方法 */
function  advantageWriteBack(courseId,type){
    var data={type:type,courseId:courseId};
            //获取课程优势下拉菜单数据
        $.ajax({
            url:"/tag/courseAdvantageTagList",
            type: "post",
            dataType: "json",
            cache: false,
            async: false,
            data: data,
            success: function (datas) {
                var result = datas.result;
                var ul = $("#advantages");
                ul.innerHTML = '';
                $.each(result, function (n, obj) {
                    var id=  obj.id;
                    var content = obj.content;
                    if (courseId != null && courseId != '') {
                        var advantageNum = $("#advantageNum");
                        var li = document.createElement("li");
                        //设置 li 属性，如 id
                        li.setAttribute("id", "advantageTagId" + advantageNum.val());
                        li.setAttribute("class", "list-group-item");
                        li.setAttribute("style", "padding:10px");
                        var inner = "<input type='hidden' name='advantageTagId' style='border:0;' value=" + id + ">" + content + "&nbsp;&nbsp;<button type='button' class='btn btn-default' onclick='advantagedelbtn(this.parentNode.id)' style='background-color: red'>删除</button>";
                        li.innerHTML = inner;
                        ul.append(li);
                        advantageNum.val(parseInt(advantageNum.val()) + 1);
                    }
                });
            }
        })
}
    /*获取适合对象下拉列表*/
function getCourseSuitable(courseId,type){
    var directionId = $('#directionId').val();
    var data={type:type,directionId:directionId};
            //获取适合对象下拉菜单数据
        $.ajax({
            url:"/tag/typeTagList",
            type: "post",
            dataType: "json",
            cache: false,
            async: false,
            data: data,
            success: function (datas) {
                var result = datas.result;
                $("#courseSuitables").find("option").remove();
                $.each(result,function(n,obj) {
                    var id=  obj.id;
                    var content = obj.content;
                    var option = $("<option value='"+id+"'>"+content+"</li>");
                    $("#courseSuitables").append(option);

                });
            }
        })
}

/*获取课程标题下拉列表*/
function getCourseTiTke(courseId,type){
    var directionId = $('#directionId').val();
    var industryId=$('#industryId').val();
    var data={type:type,directionId:directionId};
    //获取适合对象下拉菜单数据
    $.ajax({
        url:"/tag/courseTitleList",
        type: "post",
        dataType: "json",
        cache: false,
        async: false,
        data: data,
        success: function (datas) {
            var result = datas.result;
            $("#courseSuitables").find("option").remove();
            $.each(result,function(n,obj) {
                var id=  obj.id;
                var content = obj.content;
                var option = $("<option value='"+id+"'>"+content+"</li>");
                $("#courseTitles").append(option);

            });
        }
    })
}

/*回写适合对象的方法 */
function  suitableWriteBack(courseId,type){
    var data={type:type,courseId:courseId};
            //获取课程优势下拉菜单数据
        $.ajax({
            url:"/tag/courseSuitableTagList",
            type: "post",
            dataType: "json",
            cache: false,
            async: false,
            data: data,
            success: function (datas) {
                var result = datas.result;
                var ul = $("#suitables");
                ul.innerHTML = '';
                $.each(result, function (n, obj) {
                    var id=  obj.id;
                    var content = obj.content;
                    if (courseId != null && courseId != '') {
                        var advantageNum = $("#suitableNum");
                        var li = document.createElement("li");
                        //设置 li 属性，如 id
                        li.setAttribute("id", "suitableTagId" + advantageNum.val());
                        li.setAttribute("class", "list-group-item");
                        li.setAttribute("style", "padding:10px");
                        var inner = "<input type='hidden' name='suitableTagId' style='border:0;' value=" + id + ">" + content + "&nbsp;&nbsp;<button type='button' class='btn btn-default' onclick='suitabledelbtn(this.parentNode.id)' style='background-color: red'>删除</button>";
                        li.innerHTML = inner;
                        ul.append(li);
                        advantageNum.val(parseInt(advantageNum.val()) + 1);
                    }
                });
            }
        })

}
/*根据课程id回写行业标签*/
/*获取某课程行业的下拉列表*/
function getCourseIndustry(courseId){
    var data={courseId:courseId};
    if(courseId==null ||courseId==''){
        return false;
    }
            //获取放向下的行业下拉菜单数据
        $.ajax({
            url: "/industry/courseIndustry",
            type: "post",
            dataType: "json",
            cache: false,
            async: false,
            data: data,
            success: function (datas) {
                var result = datas.result;
                $("#industryids").find("option").remove();
                $.each(result,function(n,obj) {
                    var id=  obj.id;
                    var categoryDesc = obj.categoryDesc;
                    var industryNum=$("#industryNum");
                    var li = document.createElement("li");
                    //设置 li 属性，如 id
                    li.setAttribute("id", "industryId"+industryNum.val());
                    li.setAttribute("class","list-group-item");
                    li.setAttribute("style","padding:10px");
                    var inner="<input type='hidden' name='industryId' style='border:0;' value="+id+">"+categoryDesc +"&nbsp;&nbsp;<button type='button' class='btn btn-default' onclick='industrydelbtn(this.parentNode.id)' style='background-color:red'>删除</button>";
                    li.innerHTML =inner;
                    var ul=$("#industry");
                    ul.append(li);
                    industryNum.val(parseInt(industryNum.val())+1);
                });
            }
        })
};

/*    /!*职位保存事件*!/
function save_click(obj){
    var li = document.createElement("li");

    //设置 li 属性，如 id
    li.setAttribute("id", "positionId");
    li.setAttribute("class","list-group-item");
    li.setAttribute("style","padding:10px");
    var inner="<input type='hidden' name='positionId' style='border:0;' value="+$('#positionids').find('option:selected').val()+">"+ $("#positionids").find("option:selected").text()+"&nbsp;&nbsp;<button type='button' class='btn btn-default' onclick='delbtn()' style='background-color: red'>删除</button>";
    li.innerHTML =inner;
    var ul=$("#position");
    ul.append(li);
    $("#update_close").click();

}*/
/*行业保存事件*/
function industry_save_click(obj){
    var ul=$("#industry");
    /*保存前循环所有行业 确保不重复*/
    var ids=$("input[name='industryId']");
    var isDouble=false;
    $.each(ids, function(i,arr){
        if(arr.value==$('#industryids').find('option:selected').val()){
            isDouble=true;
        }
    });
    if(isDouble){
        BootstrapDialog.warning('行业不能重复添加！');
        return;
    }
    if($("#industryids").find("option:selected").text()==''||$("#industryids").find("option:selected").text()==null){
        $("#industry_dialog_close").click();
        return false;
    }
    $("#industryids").find("option:selected").text()
    var industryNum=$("#industryNum");
    var li = document.createElement("li");
    //设置 li 属性，如 id
    li.setAttribute("id", "industryId"+industryNum.val());
    li.setAttribute("class","list-group-item");
    li.setAttribute("style","padding:10px");
    var inner="<input type='hidden' name='industryId' style='border:0;' value="+$('#industryids').find('option:selected').val()+">"+ $("#industryids").find("option:selected").text()+"&nbsp;&nbsp;<button type='button' class='btn btn-default' onclick='industrydelbtn(this.parentNode.id)' style='background-color: red'>删除</button>";
    li.innerHTML =inner;
    ul.append(li);
    industryNum.val(parseInt(industryNum.val())+1);
    $("#industry_dialog_close").click();
    /*清空适合对象*/
    $("#suitables").find("li").remove();
    /*清空课程优势*/
    $("#advantages").find("li").remove();
    /*清空课程标题*/
    $("#title").val('');
    /*清空版本号*/
    $('#version').val('');
    $('#versionShow').val('');
    /*删除选中状态*/
    $('input:radio[name="createType"]').attr("checked",false);

}

/*课程优势保存事件*/
function advantage_save_click(obj){
    var ul=$("#advantages");
    var ids=$("input[name='advantageTagId']");
    var isDouble=false;
    $.each(ids, function(i,arr){
        if(arr.value==$('#courseAdvantages').find('option:selected').val()){
            isDouble=true;
        }
    });
    if(isDouble){
        BootstrapDialog.warning('课程优势不能重复添加！');
        return;
    }
    if($("#courseAdvantages").find("option:selected").text()==''||$("#courseAdvantages").find("option:selected").text()==null){
        $("#advantage_dialog_close").click();
        return false;
    }
    var advantageNum=$("#advantageNum");
    var li = document.createElement("li");
    //设置 li 属性，如 id
    li.setAttribute("id", "advantageTagId"+advantageNum.val());
    li.setAttribute("class","list-group-item");
    li.setAttribute("style","padding:10px");
    var inner="<input type='hidden' name='advantageTagId' style='border:0;' value="+$('#courseAdvantages').find('option:selected').val()+">"+ $("#courseAdvantages").find("option:selected").text()+"&nbsp;&nbsp;<button type='button' class='btn btn-default' onclick='advantagedelbtn(this.parentNode.id)' style='background-color: red'>删除</button>";
    li.innerHTML =inner;
    ul.append(li);
    advantageNum.val(parseInt(advantageNum.val())+1);
    $("#advantage_dialog_close").click();

}

/*适合对象保存事件*/
function suitable_save_click(obj){
    var ul=$("#suitables");
    var ids=$("input[name='suitableTagId']");
    var isDouble=false;
    $.each(ids, function(i,arr){
        if(arr.value==$('#courseSuitables').find('option:selected').val()){
            isDouble=true;
        }
    });
    if(isDouble){
        BootstrapDialog.warning('适合对象不能重复添加！');
        return;
    }
    if($("#courseSuitables").find("option:selected").text()==''||$("#courseSuitables").find("option:selected").text()==null){
        $("#suitable_dialog_close").click();
        return false;
    }
    var suitableNum=$("#suitableNum");
    var li = document.createElement("li");
    //设置 li 属性，如 id
    li.setAttribute("id", "suitableTagId"+suitableNum.val());
    li.setAttribute("class","list-group-item");
    li.setAttribute("style","padding:10px");
    var inner="<input type='hidden' name='suitableTagId' style='border:0;' value="+$('#courseSuitables').find('option:selected').val()+">"+ $("#courseSuitables").find("option:selected").text()+"&nbsp;&nbsp;<button type='button' class='btn btn-default' onclick='suitabledelbtn(this.parentNode.id)' style='background-color: red'>删除</button>";
    li.innerHTML =inner;
    ul.append(li);
    suitableNum.val(parseInt(suitableNum.val())+1);
    $("#suitable_dialog_close").click();

}


/*/!*职位删除按钮时间*!/
function delbtn(){
    $("#positionId").remove();
}*/
/*行业删除按钮*/
function industrydelbtn(industryNum){
    $("#"+industryNum).remove();
    /*清空适合对象*/
    $("#suitables").find("li").remove();
    /*清空课程优势*/
    $("#advantages").find("li").remove();
    /*清空课程标题*/
    $("#title").val('');
    /*清空版本号*/
    $('#version').val('');
    $('#versionShow').val('');
    /*删除选中状态*/
    $('input:radio[name="createType"]').attr("checked",false);
}

/*课程优势删除按钮*/
function advantagedelbtn(advantageNum){
    $("#"+advantageNum).remove();
}
/*适合对象删除按钮*/
function suitabledelbtn(suitableNum){
    $("#"+suitableNum).remove();
}

/*表单验证*/
//验证表单信息
function validateForm(){
    var posMsg=cate3;
    var course = $("#course");
    course
        .bootstrapValidator({
        message: '',
        excluded: [':disabled'],//不加它重新打开模态框时提示不会清除
        fields: {
            directionId: {
                validators: {
                    notEmpty: {
                        message: '方向不能为空!'
                    }
                }
            },
            positionId: {
                validators: {
                    notEmpty: {
                        message:posMsg+'不能为空!'
                    }
                }
            }, title: {
                validators: {
                    notEmpty: {
                        message: '标题不能为空!'
                    },stringLength: {
                        max: 30,
                        message: '课程标题不能超过30个字'
                    },regexp: {
                        regexp: /^[\u4e00-\u9fa5a-zA-Z0-9]+$/,
                        message: '只能输入汉字、数字和字母！'
                    }
                }
            }, learningIdeas1: {
                validators: {
                    notEmpty: {
                        message: '学习思路不能为空!'
                    },stringLength: {
                        max: 14,
                        message: '学习思路过长，不能超过14个字'
                    }
                }
            },learningIdeas2: {
                validators: {
                    notEmpty: {
                        message: '学习思路不能为空!'
                    },stringLength: {
                        max: 14,
                        message: '学习思路过长，不能超过14个字'
                    }
                }
            },learningIdeas3: {
                validators: {
                    notEmpty: {
                        message: '学习思路不能为空!'
                    },stringLength: {
                        max: 14,
                        message: '学习思路过长，不能超过14个字'
                    }
                }
            }, courseStuNum: {
                validators: {
                    notEmpty: {
                        message: '购买基数不能为空!'
                    },regexp: {
                        regexp: /^[1-9][0-9]*$/,
                        message: '只能输入数字！'
                    }
                }
            }, scoreNum: {
                validators: {
                    notEmpty: {
                        message: '评分人数基数不能为空!'
                    },regexp: {
                        regexp:/^[1-9][0-9]*$/,
                        message: '只能输入数字！'
                    }
                }
            }, score: {
                validators: {
                    notEmpty: {
                        message: '评分基数不能为空!'
                    },regexp: {
                        regexp:/^[0-5]$/,
                        message: '只能输入0-5的数字！'
                    }
                }
            }, dayLength: {
                validators: {
                    notEmpty: {
                        message: '建议学习天数不能为空!'
                    },regexp: {
                       // regexp:/^\d+(\.\d+)?$/,
                        regexp:/^[1-9][0-9]*$/,
                        message: '只能输入数字！'
                    }
                }
            },dayHours: {
                validators: {
                    notEmpty: {
                        message: '建议每天学习小时数不能为空!'
                    },regexp: {
                        regexp: /^[1-9][0-9]*$/,
                        message: '只能输入数字！'
                    }
                }
            },dayLecture: {
                validators: {
                    notEmpty: {
                        message: '建议每天听课节数不能为空!'
                    },regexp: {
                        regexp: /^[1-9][0-9]*$/,
                        message: '只能输入数字！'
                    }
                }
            },dayNode: {
                validators: {
                    notEmpty: {
                        message: '建议资料数不能为空!'
                    },regexp: {
                        regexp:/^[1-9][0-9]*$/,
                        message: '只能输入数字！'
                    }
                }
            },coverUrl: {
                validators: {
                    notEmpty: {
                        message: '课程图片不能为空!'
                    }
                }
            }/*,
            practiceSid: {
                validators: {
                    regexp: {
                        regexp:/^[a-z](\d+\,?)+/,
                        message: '只能输入字母+数字(多个数字用逗号分开)！'
                    }
                }
            }*/
        }
    });
}

/*初始化章节资料页面*/
function initLectures(){
    t = $('#lecture_table').DataTable(
            {
                "bPaginate": false, //翻页功能
                "bLengthChange": true, //改变每页显示数据数量
                "bFilter": false, //过滤功能
                "bSort": false, //排序功能
//              "bInfo": true,//页脚信息
                "bAutoWidth": true, //自动宽度
//              "aLengthMenu": [[2,200, 300, -1], [2, 200, 300, "全部"]],
               // scrollX:true,
                paging:false,
                "drawCallback": function( settings ) {
                    var api = this.api();

                    // Output the data for the visible rows to the browser's console
                    //console.log( api.rows( {page:'current'} ).data() );
                },
                language: {
                    lengthMenu: "每页 _MENU_ 条记录",//下拉框文字
                    info: "",//左下角显示文字
                    infoEmpty: "",//当查询没有数据时左下角显示文字
                    sEmptyTable: "没有数据..",//当查询没有数据时表格中间显示文字
                    paginate: {                          //分页
                        first: "首页",
                        last: "尾页",
                        next: "下一页",
                        previous: "上一页"
                    }
                }
            })
    /*删除一行（末行）*/
    $('#delRow').click( function (e) {
        var num=  $("#lecture_table tr").length;
        if(counter<=1){
            return false;
        }
        var row=t.row(num-2);
        row.remove().draw(false);
        showOrderBtn();
        counter=counter-1;
        showOrderBtn();
    });
    if(courseId+''!=''){
        $.ajax({
            url: "/lecture/completeList",
            contentType: "application/x-www-form-urlencoded; charset=utf-8",
            type: "post",
            dataType: "json",
            cache: false,
            async: false,
            data:{courseId:courseId},
            success: function (datas) {
                if(datas.code == HttpUtil.success_code){
                    $.each(datas.result,function (index,lecture) {
                        /* options+='<option value="'+industry.id+'">'+industry.categoryDesc+'</option>';*/
                        var lengthStr='';
                        /*增加一行前判断是否需要分钟数*/
                        if(operationType!=0&& operationType!='0'){
                            lengthStr= '<input type="text" name="videoLength" value="'+parseInt(lecture.videoLength/60)+'分'+lecture.videoLength%60+'秒" disabled="true" id="videoLength'+lecture.lectureOrder+'"/>';
                        }
                        var checkedStr;
                        var uploadDesc;
                        var  url=lecture.lecturePptUrl;
                        if(url!=null && url!=''){
                            uploadDesc='重新上传';
                        }else{
                            uploadDesc='上传资料';
                        }
                        if(lecture.isvipVideo==1) checkedStr="checked";
                        var examPreviewBtnHtml='<input id="previewBtn'+counter+'" onclick="preview('+counter+')" class="btn btn-primary btn-sm" type="button" style="margin-left:10px; visibility:hidden" value="预览"/>';
                        if(pid=='sjn'){
                            examPreviewBtnHtml='';
                        }
                       // t.clear();
                        t.row.add( [
                            //'<input type="text" name="lectureOrder" id="lectureOrder'+lecture.lectureOrder+'" value="'+lecture.lectureOrder+'" readonly="true" onBlur="testLectureOrder(this)"/>',
                            lecture.lectureOrder,
                            '<input type="text" name="lectureName" id="lectureName'+lecture.lectureOrder+'" value="'+lecture.lectureName+'" />',
                            '<input type="text" name="videoId" value="'+(lecture.videoId?lecture.videoId : '')+'" id="videoId'+lecture.lectureOrder+'" />',
                            '<input type="text" name="ccVideoUnique" value="'+(lecture.ccVideoUnique ? lecture.ccVideoUnique : ""　)+'" id="ccVideoUnique'+lecture.lectureOrder+'" />',
                            //'<input type="text" name="videoLength" value="'+lecture.videoLength+'" id="videoLength'+lecture.lectureOrder+'" onBlur="testLectureLength(this)" />',
                            '<input type="text" name="fileTitle" value="'+lecture.fileTitle+'" id="fileTitle'+lecture.lectureOrder+'" />',
                            '<div class="col-md-4" id="btn'+lecture.lectureOrder+'">'+
                            '<span class="btn btn-primary btn-sm fileinput-button">'+
                            '<i class="glyphicon glyphicon-plus"></i>'+
                            ' <span>'+uploadDesc+'</span>'+
                            '<input id="pdfFile'+lecture.lectureOrder+'" type="file" name="pdfFile">'+
                            '<input type="hidden" name="lecturePptUrl" id="lecturePptUrl'+lecture.lectureOrder+'" value="'+lecture.lecturePptUrl+'">'+
                            '<input type="hidden" name="lectureConverswfUrl" id="lectureConverswfUrl'+lecture.lectureOrder+'" value="'+lecture.lectureConverswfUrl+'">'+
                            '<input type="hidden" name="fileLength" id="filelength'+lecture.lectureOrder+'"  value="'+lecture.fileLength+'">'+
                            '<input type="hidden" name="id" id="id'+lecture.lectureOrder+'" value="'+lecture.id+'" />'+
                            ' </span>'+'</div>'+
                            '<input id="delBtn'+lecture.lectureOrder+'"onclick="delPptUrl(this,'+lecture.lectureOrder+')" class="btn btn-danger btn-sm" type="button"  style="visibility:hidden" value="删除资料"/>'+
                            examPreviewBtnHtml,
                            '<input type="checkbox" class="audition" name="isvipVideo" id="isvipVideo'+lecture.lectureOrder+'" '+checkedStr +'/>',
                            lengthStr] ).draw();
                        if($('#lectureConverswfUrl1'+counter).val()!=''&& $('#lectureConverswfUrl1'+counter).val()!='null'){
                            $('#previewBtn'+counter).css("visibility","visible");
                        }
                        initPDFFileupload("pdfFile"+lecture.lectureOrder,"lecturePptUrl"+lecture.lectureOrder,lecture.lectureOrder);
                        counter=counter+1;
                    })

                }else{
                    BootstrapDialog.alert(data.msg);
                }
            }
        });
        showOrderBtn();
    }
}

/* 试听按钮全选/全不选 */
function allAudition() {
    var auditions = $(".audition");
    $.each(auditions,function (index,au) {
        if (!au.checked) {
            $(".audition").attr("checked",true);
            return false;
        }
        if (index == auditions.length-1) {
            $(".audition").attr("checked",false);
        }
    });
}

/*删除已上传资料*/
function delPptUrl(e,id){
    BootstrapDialog.confirm({
        title: '删除资料',
        message: '你确定要删除已上传的资料吗？',
        type: BootstrapDialog.TYPE_DANGER,
        closable: true,
        btnCancelLabel: '取消',
        btnOKLabel: '确认',
        btnOKClass: 'btn-warning',
        callback: function (yes) {
            if (yes){
                $("#lecturePptUrl"+id).val('');
                $("#delBtn"+id).css("visibility","hidden");
                $("#previewBtn"+id).css("visibility","hidden");
                $("#btn"+id).show();
            }
        }
    })
}

/*增加一行*/
function rowadd(){
    var lengthStr='';
    /*增加一行前判断是否需要分钟数*/
    if(operationType!=0&& operationType!='0'){
       lengthStr= '<input type="text" name="videoLength" value="0" disabled="true" id="videoLength'+counter+'" />';
    }
    t.row.add( [
        //'<input type="text" name="lectureOrder" id="lectureOrder'+counter+'" value="'+counter+'" readonly="true" onBlur="testLectureOrder(this)"/>',
        counter,
        '<input type="text" name="lectureName" id="lectureName'+counter+'" placeholder="请输入标题" onfocus="deleteInputValue(this)"  />',
        '<input type="text" name="videoId" placeholder="请输入乐视ID" id="videoId'+counter+'" onfocus="deleteInputValue(this)"/>',
        '<input type="text" name="videoId" placeholder="请输入CC视频ID" id="ccVideoUnique'+counter+'" onfocus="deleteInputValue(this)"/>',
        //'<input type="text" name="videoLength" value="0" disabled="true" id="videoLength'+counter+'"  onfocus="deleteInputValue(this)" onBlur="testLectureLength(this)"/>',
        '<input type="text" name="fileTitle" placeholder="请输入资料名" id="fileTitle'+counter+'" onfocus="deleteInputValue(this)"/>',
        '<div class="col-md-4" id="btn'+counter+'">'+
        '<span class="btn btn-primary btn-sm fileinput-button">'+
        '<i class="glyphicon glyphicon-plus"></i>'+
        ' <span >上传资料</span>'+
        '<input id="pdfFile'+counter+'" type="file" name="pdfFile">'+
        '<input type="hidden" id="lecturePptUrl'+counter+'" name="lecturePptUrl" value="">'+
        '<input type="hidden" id="lectureConverswfUrl'+counter+'" name="lectureConverswfUrl" value="">'+
        '<input type="hidden" id="filelength'+counter+'" name="fileLength" value="">'+
        '<input type="hidden" name="id" id="id'+counter+'" />'+
        ' </span>'+'</div>'+
        '<input id="delBtn'+counter+'" onclick="delPptUrl(this,'+counter+')" class="btn btn-danger btn-sm" type="button"  style="visibility:hidden" value="删除资料"/>'+
        '<input id="previewBtn'+counter+'" onclick="preview('+counter+')" class="btn btn-primary btn-sm" type="button"  style="margin-left:10px; visibility:hidden" value="预览"/>',
        '<input type="checkbox" class="audition"  name="isvipVideo" id="isvipVideo'+counter+'" />',lengthStr
    ] ).draw();
    initPDFFileupload("pdfFile"+counter,"lecturePptUrl"+counter,counter);
    counter=counter+1;
    showOrderBtn();
}

//预览
function preview(counter) {
    var swfUrl = $('#lectureConverswfUrl'+counter).val();
    var pdfUrl = $('#lecturePptUrl'+counter).val();
    var loadUrl = '/course/preview?swfUrl='+swfUrl+'&pdfUrl='+pdfUrl;
    layer.open({
        title:'讲义预览',
        type: 2,
        shadeClose:true,
        area: ['893px', '600px'],
        fix: false, //不固定
        maxmin: true,
        content: loadUrl
    });
}

/*输入框清空问题*/
function deleteInputValue(obj){
    obj.value='';
    obj.removeAttribute("onfocus");
}
/*审核*/
function examCourse(id){
    if(canSubmit==false){
        BootstrapDialog.alert("请等待资料上传完成！");
        return false;
    }
    //var lectureTest=testLectures();
    submitForm(1);
}

/*审核不通过*/
function examCourseFailed(id){
    $.ajax({
        url: "/course/courseExamineFail",
        type: "post",
        dataType: "json",
        cache: false,
        async: false,
        data: {id:courseId},
        success: function (datas) {
            BootstrapDialog.alert("课程审核不通过");
            window.location.href = "/course/manager";
        }
    })
}
/*试听课程选择*/
// function check(counter){
//    // var lectureNum = $('#lectureOrder'+counter).val();
//     var arr ="1,2,3";
//     if(arr.indexOf(counter) < 0){
//         $('#isvipVideo'+counter).attr("checked",false);
//         BootstrapDialog.show({
//             title: '提示',
//             message: '试听章节只能选择前3节！'
//         });
//     }
// }
/*验证是否可以提交*/
function testLectures(){
    /*审核前验证信息*/
    txt = "[";
    checkedOrders='';
    $("#lecture_table tr").each(function(index, val) {
        if(index >0){
           // var order=$(this).find('td').eq(0).find("input").val();
            var order=$(this).find('td').eq(0).html();
            var lectureTitles=$(this).find('td').eq(1).find("input").val();
            var leshiID=$(this).find('td').eq(2).find("input").val();
            var ccVideoUnique=$(this).find('td').eq(3).find("input").val();
           // var length=$(this).find('td').eq(3).find("input").val();
            var ziliaoName=$(this).find('td').eq(4).find("input").val();
            var ziliaoURL=$(this).find('td').eq(5).find("input[name='lecturePptUrl']").val();
            var fileLength=$(this).find('td').eq(5).find("input[name='fileLength']").val();
            var lectureConverswfUrl=$(this).find('td').eq(5).find("input[name='lectureConverswfUrl']").val();
            var id=$(this).find('td').eq(5).find("input[name='id']").val();
            var isVipCheckBox=$(this).find('td').eq(6).find("input").is(':checked');

            notNullLectures(order,lectureTitles,leshiID,ziliaoName,ziliaoURL,ccVideoUnique);
            if(!isSubmit){
                return false;
            }
            leshiIDTest(leshiID);
            ccValidate(ccVideoUnique);
            if(!isSubmit){
                return false;
            }
            if(isVipCheckBox==true){
                isVipCheckBox=1;
                checkedOrders+=order+':';
            }else{
                isVipCheckBox=0;
            }
            if(id==''){
                id=0;
            }
            if(fileLength==''){
                fileLength=0;
            }
            if(lectureConverswfUrl==''){
                lectureConverswfUrl=0;
            }
            var lectureCourseId=0;
            if($("#courseId").val()!=''&& $("#courseId").val()!=undefined){
                lectureCourseId=$("#courseId").val();
            }
            var rowtxt= "{"+"\"courseId\":\""+lectureCourseId+"\","
                +"\"id\":\""+id+"\","
                +"\"lectureOrder\":\""+order+"\","
                +"\"lectureName\":\""+lectureTitles+"\","
                +"\"videoId\":\""+leshiID+"\","
                +"\"ccVideoUnique\":\""+ccVideoUnique+"\","
               // +"\"videoLength\":\""+length+"\","
                +"\"fileTitle\":\""+ziliaoName+"\","
                +"\"lecturePptUrl\":\""+ziliaoURL+"\","
                +"\"fileLength\":\""+fileLength+"\","
                +"\"lectureConverswfUrl\":\""+lectureConverswfUrl+"\","
                +"\"isvipVideo\":\""+isVipCheckBox+"\""
                +"}";
            txt=txt+rowtxt+",";
        }
    });
    if(!isSubmit){
        return false;
    }
    txt=txt.substr(0,txt.length-1)+"]";
    var orders=checkedOrders.substr(0,checkedOrders.length-1).split(':');
    //var message='';
    testLectureOrders();
    if(!isSubmit){
        return false;
    }
    // testIsVipVideo(checkedOrders.substr(0,checkedOrders.length-1).split(':'));
    if(!isSubmit){
        return false;
    }
    return true;
}

/*章节资料的非空验证、格式验证*/
function notNullLectures(/*length,*/order,lectureTitles,leshiID,ziliaoName,ziliaoURL,ccId){
    if(order==null || order==''){
        BootstrapDialog.warning("节次不能为空");
        isSubmit=false;
        return;
    }
    if (isNaN(order) == true){
        BootstrapDialog.warning("节次必须为数字");
        isSubmit=false;
        return ;
    }
    if(lectureTitles==null || lectureTitles==''){
        BootstrapDialog.warning("标题不能为空");
        isSubmit=false;
        return ;
    }
    if(lectureTitles.length>50){
        BootstrapDialog.warning("标题最多50个字符");
        isSubmit=false;
        return ;
    }
    /*if(leshiID==null || leshiID==''){
        BootstrapDialog.warning("乐视ID不能为空");
        isSubmit=false;
        return;
    }*/
    if(!ccId){
        BootstrapDialog.warning("CC视频ID不能为空");
        isSubmit=false;
        return;
    }
    if(isNaN(leshiID)==true){
        BootstrapDialog.warning("乐视ID必须是数字");
        isSubmit=false;
        return ;
    }
    // if(pid=='kjs'){
    //     if((ziliaoName==null|| ziliaoName.trim()==''|| ziliaoName.trim()=='请输入资料名')){
    //         BootstrapDialog.warning("资料名称不能为空！");
    //         isSubmit=false;
    //         return ;
    //     }
    //     if(ziliaoName.length>50){
    //         BootstrapDialog.warning("资料名称最多50个字符");
    //         isSubmit=false;
    //         return ;
    //     }
    //     if((ziliaoURL==null|| ziliaoURL=='')){
    //         BootstrapDialog.warning("请上传资料！");
    //         isSubmit=false;
    //         return ;
    //     }
    // }
    // if(pid=='sjn'){
    //     if((ziliaoName.trim()==''||ziliaoName.trim()=='请输入资料名')&&ziliaoURL!=''){
    //         BootstrapDialog.warning("请填写资料名！");
    //         isSubmit=false;
    //         return ;
    //     }
    //     if((ziliaoURL==null|| ziliaoURL=='')&&(ziliaoName.trim()!=''&ziliaoName.trim()!='请输入资料名')){
    //         BootstrapDialog.warning("请上传资料！");
    //         isSubmit=false;
    //         return ;
    //     }
    // }

}
/*乐视ID验证*/
function leshiIDTest(leshiID){
    /*验证乐视ID是否有效*/
    if(leshiID){
        $.ajax({
            url:'/letv/validate',
            type:'post',
            async:false,
            data:{videoId:leshiID},
            success:function(data){
                data=JSON.parse(data);
                if(data.code == '0'&& data.data){/*data.code == 0 && data.data*/

                }else if(data.code=='105') {
                    BootstrapDialog.warning("输入的乐视ID非法"+data.message);
                    isSubmit=false;
                    return ;
                }else{
                    BootstrapDialog.warning('系统错误'+data.message);
                    isSubmit=false;
                    return ;
                }
            },
            error: function(e) {
                BootstrapDialog.warning("输入的乐视ID非法");
                isSubmit=false;
                return ;
            }
        });
    }
}

/*cc视频ID验证*/
function ccValidate(videoId){
    /*验证乐视ID是否有效*/
    if(videoId){
        $.ajax({
            url:'/letv/cc/validate',
            type:'post',
            async:false,
            data:{videoId:videoId},
            success:function(data){
                var result = data.result;
                if(data.code == 200){
                    var cc_data= JSON.parse(result);
                    if(cc_data.error) {
                        BootstrapDialog.warning("输入的cc视频ID非法："+cc_data.error);
                        isSubmit=false;
                        return ;
                    }
                }else{
                    BootstrapDialog.warning('系统错误：'+data.msg);
                    isSubmit=false;
                    return ;
                }
            },
            error: function(e) {
                BootstrapDialog.warning("输入的乐视ID非法");
                isSubmit=false;
                return ;
            }
        });
    }
}

/*验证章节序号是否正确*/
function testLectureOrders(){
    var isSubmit=true;
    /*验证章节序号*/
    var ordersByName=document.getElementsByName('lectureOrder');
    var ordersVal=new Array();
    for(var i=0;i<ordersByName.length;i++){
        ordersVal[i]=ordersByName[i].value;
    }
    for(var i=1;i<=ordersByName.length;i++){
        if(ordersVal.indexOf(i+'')<0){
            message='请检查节次输入是否正确';
            isSubmit=false;
            BootstrapDialog.warning(message);
            return;
        }
    }
    return isSubmit;
}
/**
 * 验证试听章节问题
 * @param orders
 */
function testIsVipVideo(orders){
    /*验证试听课情况*/
    for(var i=0;i<orders.length;i++){
        if(orders[i]>3){
            isSubmit=false;
            message='只能试听前三个章节！';
            BootstrapDialog.warning(message);
            return;
        }
        if(orders.length>3){
            isSubmit=false;
            message='最多只能试听三个章节！';
            BootstrapDialog.warning(message);
            return;
        }
        if(orders.length==3){
            if(orders.indexOf('1')<0||orders.indexOf('2')<0||orders.indexOf('3')<0){
                isSubmit=false;
                message='只能试听1-2-3章！';
                BootstrapDialog.warning(message);
                return;
            }
        }
        if(orders.length==2){
            if(orders.indexOf('1')<0||orders.indexOf('2')<0){
                isSubmit=false;
                message='试听前两章！';
                BootstrapDialog.warning(message);
                return;
            }
        }
        if(orders.length==1){
            if(orders.indexOf('1')<0){
                isSubmit=false;
                message='试听第一章';
                BootstrapDialog.warning(message);
                return;
            }
        }
        if(orders.length<1){
            isSubmit=false;
            message='至少选择一个章节试听！';
            BootstrapDialog.warning(message);
            return;
        }
    }
    isSubmit=true;
}
/**
 * 初始化 jQuery File Upload 上传文件插件(pdf上传)
 * @param fileId
 * @param previewId  预览图id
 * @param counter  要隐藏的按钮的编号
 * @param savePathInputId  保存图片路径的input id
 */
function initPDFFileupload(fileId,savePathInputId,counter) {
    //清空
    var nullVal = '';
    var fileLength = $('#filelength'+counter);
    var pdfPath = $('#'+savePathInputId);
    var swfPath = $('#lectureConverswfUrl'+counter);
    var url='';
    pid=$("#pid").val();
    if(pid=='kjs'){
        url='/upload/pdf';
    }else if(pid=='sjn'){
        url='/upload/sjnImg'
    }
    $('#'+fileId).fileupload({
        url:url,
        done: function (e, data) {
            canSubmit=false;
            fileLength.val(nullVal);
            pdfPath.val(nullVal);swfPath.val(nullVal);
            if(data.result.code == HttpUtil.success_code){
                if(pid=='kjs'){
                    var filelength=data.result.result.fileLength;
                    pdfPath.val(data.result.result.path);
                    swfPath.val(data.result.result.swfPath);
                    fileLength.val(filelength);
                }else if(pid=='sjn'){
                    var filelength=data.result.result.fileLength;
                    fileLength.val(filelength);
                    pdfPath.val(data.result.result.path);
                }
                BootstrapDialog.success('上传资料成功!');
                $("#btn"+counter).hide();
                var delBtn=$("#delBtn"+counter);
                if(pid=='kjs'){
                    var previewBtn= $("#previewBtn"+counter);
                    previewBtn.css("visibility","visible");
                }
                delBtn.css("visibility","visible");
                canSubmit=true;
            }else{
                canSubmit=true;
                var alert = BootstrapDialog.warning||window.alert;
                alert(data.result.msg );
            }
        }
    });
}

/**
 * 课程基础验证
 */
function testCourseBase(){
    /*验证课程基本信息*/
    var passBase=$('#course').data('bootstrapValidator').validate().isValid();//表单验证是否通过
    if(!passBase){   $("#base-href").click(); return false;}
    var liReg=true;
    var courseImage;
    if(pid=='kjs'){
        if($("#industry").children().length==0 ||$("#advantages").children().length==0||$("#suitables").children().length==0 ){
            liReg=false;
        }
    }else if(pid=='sjn'){
        if($("#advantages").children().length==0||$("#suitables").children().length==0 ){
            liReg=false;
        }
    }
    if(!liReg){
        BootstrapDialog.warning('请选择课程所属行业、课程优势、适合对象');
        return false;
    }
    if($("#suitables").children().length>5){
        BootstrapDialog.warning('适合对象不得超过5个');
        return false;
    }
    var courseImage=$("#course-image-path").val();
    if(courseImage==null || courseImage==''){
        BootstrapDialog.warning('请选择课程图片！');
        return false;
    }
    return passBase;
}
/*验证课程简介*/
function testCourseBrief(){
    if(pid=='kjs'){
        /*验证课程简介页面*/
        if( UE.getEditor('job_duty').getContent()==null ||  UE.getEditor('job_duty').getContent()==''){
            BootstrapDialog.warning('岗位职责不能为空！');
            return false;
        }
    }
    if( UE.getEditor('course_brief').getContent()==null ||  UE.getEditor('course_brief').getContent()==''){
        BootstrapDialog.warning('课程简介不能为空！');
        return false;
    }
    if($('#teacherId option:selected').val()==''){
        BootstrapDialog.warning('请选择老师！');
        return false;
    }
    return true;
}

/**
 * 验证表单信息
 */
function testForm(){
    isSubmit=testCourseBase();
    if(!isSubmit){
        return;
    }
    isSubmit=testCourseBrief();
    if(!isSubmit){
        return;
    }
    isSubmit=testLectures();
    if(!isSubmit){
        return;
    }

}
/**
 * 提交表单信息
 */
function submitForm(examState){
    testForm();
    if(!isSubmit){
        //BootstrapDialog.warning(message);
        return false;
    }
    if(isSubmit){
        var baseArray=$('#course').serializeArray();
        var jsonBase=formToJson('course');
        var briefArray=formToJson('config');
        var industryId='';
        var advantageTagId='';
        var suitableTagId='';
        $("input[name='industryId']").each(
            function(){
                industryId+=$(this).val()+',';
            }
        )
        $("input[name='advantageTagId']").each(
            function(){
                advantageTagId+=$(this).val()+',';
            }
        )
        $("input[name='suitableTagId']").each(
            function(){
                suitableTagId+=$(this).val()+',';
            }
        )
        industryId=industryId.substr(0,industryId.length-1);
        advantageTagId=advantageTagId.substr(0,advantageTagId.length-1);
        suitableTagId=suitableTagId.substr(0,suitableTagId.length-1);
        var configArray=txt;
       if(examState==1){
           if($('#preCourseId').val()!='0'){
               var versionShow=$('#version').val();
               if(parseInt(versionShow)>1){
                   versionShow=parseInt(versionShow)-1;
               }
               if(!versionShow) return;
               numberUpperCase.init(versionShow.toString());
               BootstrapDialog.confirm({
                   title: '审核提示',
                   message: '系统将自动下线'+$("#title").val()+'课程第'+numberUpperCase.pri_ary()+'版，不要忘记发站内信通知学员哦。',
                   type: BootstrapDialog.TYPE_WARNING,
                   closable: true,
                   btnCancelLabel: '取消',
                   btnOKLabel: '确认',
                   btnOKClass: 'btn-warning',
                   callback: function (yes) {
                       if (yes){
                           $.ajax({
                               url: "/course/submitAll",
                               type: "post",
                               dataType: "json",
                               cache: false,
                               data: {courseBase:JSON.stringify(jsonBase),courseText:JSON.stringify(briefArray),courseLectures:configArray,courseId:courseId,industryId:industryId,advantageTagId:advantageTagId,suitableTagId:suitableTagId,examState:examState},
                               success: function (datas) {
                                   if (datas.code == HttpUtil.success_code) {
                                       // window.location.href = "/course/course_config/${courseId}/${operationType}";
                                       window.location.href = "/course/manager";
                                   }
                               }
                           });

                       }
                   }
               })
           }else{
               BootstrapDialog.confirm({
                   title: '审核通过',
                   message: '你确定要通过该课程的审核吗？',
                   type: BootstrapDialog.TYPE_WARNING,
                   closable: true,
                   btnCancelLabel: '取消',
                   btnOKLabel: '确认',
                   btnOKClass: 'btn-warning',
                   callback: function (yes) {
                       if (yes){
                           $.ajax({
                               url: "/course/submitAll",
                               type: "post",
                               dataType: "json",
                               cache: false,
                               data: {courseBase:JSON.stringify(jsonBase),courseText:JSON.stringify(briefArray),courseLectures:configArray,courseId:courseId,industryId:industryId,advantageTagId:advantageTagId,suitableTagId:suitableTagId,examState:examState},
                               success: function (datas) {
                                   if (datas.code == HttpUtil.success_code) {
                                       window.location.href = "/course/manager";
                                   }
                               }
                           });

                       }
                   }
               })
           }

       }else{
           $.ajax({
               url: "/course/submitAll",
               type: "post",
               dataType: "json",
               cache: false,
               data: {courseBase:JSON.stringify(jsonBase),courseText:JSON.stringify(briefArray),courseLectures:configArray,courseId:courseId,industryId:industryId,advantageTagId:advantageTagId,suitableTagId:suitableTagId,examState:examState},
               success: function (datas) {
                   if (datas.code == HttpUtil.success_code) {
                       window.location.href = "/course/manager";
                   }
               }
           });
       }

    }

}
/*百度编辑器内容预览*/
function editor_preview(jobDuty,courseBrief,teacherId){
    layer.closeAll();


    var data ={
        courseBrief:courseBrief,
        teacherId:teacherId,
        pid:$('#pid').val()
    };
    if($('#pid').val()=='kjs'){
        data.jobDuty = jobDuty;
    }
    $.post("/course/editorPreview",data ,function(data){
        layer.open({
            type: 1,
            title: false,
            maxmin: false,
            closeBtn: 1,
            shadeClose: true,
            skin: 'yourclass',
            area: ['80%', '70%'],
            content: data
        });
    });

}

//排序按钮的显示隐藏
function showOrderBtn(){
    var aa=$("#lecture_table tr");
    if(aa.length>=3){
        $("#sort").css("display","inline-block");
    }else{
        $("#sort").css("display","none");
    }
}

