$(document).ready(function () {
    var industryData='';
    var pid=$('#pid').val();
    if($('#preCourseId').val()==0){
        $("input[name='createType']").eq(0).attr("checked","checked");
    }else{
        $("input[name='createType']").eq(1).attr("checked","checked");
    }
    $("input[name=createType]").change(function(){
        $("#title").val('');
        $("#versionShow").val('');
    })
    $("input[name=createType]").click(function(){
        industryData='';
        var directionId=$('#directionId option:selected') .val();
        var positionId=$('#positionId option:selected') .val();
        if(pid=='kjs'){
            var industryIds=$("input[name='industryId']");
            for(var i=0;i< industryIds.size();i++){
                industryData+=industryIds[i].value+',';
            }
            if(industryData.length>0){
                industryData=industryData.substr(0,industryData.length-1);
            }
        }

       /* $("#title").val('');
        $("#versionShow").val('');*/
        switch($("input[name=createType]:checked").attr("value")) {
            case "1":
                //window.location.href="#createCourse_dialog";
                $("#createCourse_dialog").modal();
                //$('#writeCourseTitle').val($('#title').val());//如果允许手动修改标题则需要放开本行
                $("#preCourseId").val('0');
                $('#version').val("1");
                break;
            case "2":
                if(directionId=='' || !directionId || directionId==-1){
                    BootstrapDialog.warning("请选择方向！");
                    $("input[name=createType]").attr("checked",false);//取消选中状态
                    return;
                }
                if(positionId=='' || !positionId){
                    BootstrapDialog.warning("请选择"+cate3+"!");
                    $("input[name=createType]").attr("checked",false);
                    return;
                }
                if(pid=='kjs'){
                    if(industryIds=='' || !industryIds|| industryIds.size()==0 ){
                        BootstrapDialog.warning("请选择行业！");
                        $("input[name=createType]").attr("checked",false);
                        return;
                    }
                }

                var postData={directionId:directionId,positionId:positionId,industryIds:industryData};
                $.ajax({
                    url:"/course/courseListByIds",
                    type: "post",
                    dataType: "json",
                    cache: false,
                    async: false,
                    data: postData,
                    success: function (datas) {
                        var result = datas.result;
                        $("#courseTitles").find("option").remove();
                        $.each(result,function(n,obj) {
                            if(n==0){
                                numberUpperCase.init((parseInt(obj.version)+1).toString());
                                $('#versionNO').val('第'+numberUpperCase.pri_ary()+'版');
                                $("#preCourseId").val(obj.id);
                            }
                            var id=  obj.id;
                            var content = obj.title;
                            var option = "<option value='"+id+"' version='"+obj.version+"'>"+content+"</option >";
                            $("#courseTitles").append(option);
                        });
                    }
                })
                $("#updateCourse_dialog").modal();
                break;
            default:
                break;
        }
    });
    /*标题选择的change事件*/
    $("#courseTitles").change(function(){
        var versionShow=$('#courseTitles').find("option:selected").attr("version");
        versionShow=parseInt(versionShow)+1;
        $("#preCourseId").val($('#courseTitles').find("option:selected").val());
        if(!versionShow) return;
        numberUpperCase.init(versionShow.toString());
        $('#versionNO').val('第'+numberUpperCase.pri_ary()+'版');
        $('#versionShow').val('第'+numberUpperCase.pri_ary()+'版');
        $('#version').val(versionShow);

    });
})



function courseTitle_save_click(obj){
    var idName=obj.attr('value');;
    var text=obj.find("option:selected").text();
    if(text==''){
        if(idName==''|| !idName){
            BootstrapDialog.warning("请填写课程标题！");
            return ;
        }
        $("#createCourse_dialog_close").click();
        $("#title").val(idName);
        $("#versionShow").val('第一版');
        $("#courseId").val();
    }else{
        $("#updateCourse_dialog_close").click();
        $("#title").val(text);
        $("#versionShow").val($("#versionNO").val());
        $("#version").val(parseInt($('#courseTitles').find("option:selected").attr("version"))+1);
        $("#checkCourseId").val($('#courseTitles').find("option:selected").attr("value"));
    }
    $('#course')//表单验证设置为通过
        .data('bootstrapValidator')
        .updateStatus('title', 'NOT_VALIDATED', null)
        .validateField('title');

}


function updateTitle(){
    var checkedRadio=$("input[name=createType]:checked");
    if(checkedRadio.length==0){
        BootstrapDialog.warning('请选择创建类型！');
        return;
    }
    $("input[name=createType]:checked").click();
}