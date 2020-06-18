var path = $("#path").val();
var addForm = $("#cateForm");
var updateForm = $("#updateCateForm");
var statusSwitch = $("#status").bootstrapSwitch();
//跳转tab页
function forwardTab(obj,desc){
    location.href = path+"/course/managerTab/"+obj+"/"+desc;
}
/*日期*/
//弹出日期
/*bootstrapDateUtil.show("createDate");*/
