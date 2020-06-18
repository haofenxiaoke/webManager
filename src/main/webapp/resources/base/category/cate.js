var path = $("#path").val();
var addForm = $("#cateForm");
//跳转tab页
function forwardTab(obj,desc){
    location.href = path+"/cate/managerTab/"+obj+"/"+desc;
}
//保存
$("#saveCate").click(function(){
	var da = getFormData(cateForm);
	console.log(da);
    var paramType = $("#paramType").val();
    var id = $("#id").val();
    var desc = $("#name").val();
    console.log('laal',id,desc)
    var url=path+"/"+paramType+'/save';
    if(formCheck('name')){
        //默认参数
        var parm =  {"categoryDesc":desc};
        if(directionId){
            parm =  {"categoryDesc":desc,"directionId":directionId};
        }	
        var datas = {"categoryDesc":desc,"directionId":directionId}

        if(id){
            url = path+"/"+paramType+'/update';
            parm = {"categoryDesc": desc, "id": id};
            datas = da;
            datas.id = id;
            datas.categoryDesc = desc;
            //加那些东西
        }

        if(checkDesc(parm,paramType)){
            $.ajax({
                url:url,
                type:"post",
                dataType:"json",
                cache: false,
                data :datas,
                success: function (datas){
                    if(datas.code == HttpUtil.success_code){
                        cateTable.ajax.reload();//刷新
                    }
                }
            })
            $("#close").click();
        }else{
            addForm.find("#name").parent().parent().addClass("has-error has-feedback");
            addForm.find("#name").parent().find("li").html("该名称已经存在");
        }
    }
})

//保存
$("#update_saveCate").click(function(){
    var paramType = $("#paramType").val();
    var id = $("#id").val();
    var desc = $("#update_name").val();
    var url=path+"/"+paramType+'/save';
    if(formCheck('name')){
        //默认参数
        var parm =  {"categoryDesc":desc};
        if(directionId){
            parm =  {"categoryDesc":desc,"directionId":directionId};
        }
        var datas = {"categoryDesc":desc,"directionId":directionId}

        if(id){
            url = path+"/"+paramType+'/update';
            parm = {"categoryDesc": desc, "id": id};
            datas = {"id": id, "categoryDesc": desc}
        }

        if(checkDesc(parm,paramType)){
            $.ajax({
                url:url,
                type:"post",
                dataType:"json",
                cache: false,
                data :datas,
                success: function (datas){
                    if(datas.code == HttpUtil.success_code){
                        cateTable.ajax.reload();//刷新
                    }
                }
            })
            $("#update_close").click();
        }else{
            addForm.find("#name").parent().parent().addClass("has-error has-feedback");
            addForm.find("#name").parent().find("li").html("该名称已经存在");
        }
    }
})

function formInit() {
    $(".has-error").each(function (i, d) {
        $(d).removeClass("has-error has-feedback");
    })
    $("li[name=ErrorTip]").each(function (i, d) {
        $(d).html("");
    })
}

//清空表单数据
function clearForm() {
    var nullVal = '';
    if($("#id")) $("#id").val(nullVal);
    $("#name").val(nullVal);
    $("#name_").val(nullVal);
    $("#time").val(nullVal);
    $("#tishi").val(nullVal);
    $(".zixun_mingcheng").val(nullVal);
    $(".zixun_lianjie").val(nullVal);
    $("#zixunArr").html(null);
    count_num.innerHTML="0/6"
    zixun.checked = "true"
    time_open.checked = "true"
    count.length = 0
    cou=0
    console.log(count)
}

//添加弹出框
function addCateDialog(paramType) {
    $("#paramType").val(paramType);
    $('#desc-id').html('添加');
    //清空表单内容
    clearForm();
    formInit();
}

//改名弹出框
function updateCateDialog(obj, paramType) {
    clearForm();
    formInit();
    $('#desc-id').html('修改');
    $("#paramType").val(paramType);
    $.ajax({
        url: path + "/" + paramType + "/entity",
        type: "post",
        dataType: "json",
        cache: false,
        async: false,
        data: {"id": obj},
        success: function (datas) {
        	console.log(datas)
            if (datas.code == HttpUtil.success_code) {
                var result = datas.result;
                $('#id').val(result.id);
                $('#name').val(result.categoryDesc);	
                $('#name_').val(result.categoryDesc);
                $('#update_name').val(result.categoryDesc);
                $('#tishi').val(result.examDesc)
               var t_o = document.getElementById('time_open');
               if(result.timerStatus == 1) {
            	   t_o.checked = true;
            	   $('#time').val(result.examDate);
                   $('#tishi').val(result.examDesc);
                   $('#time').removeAttr("disabled");
                   $('#tishi').removeAttr("disabled");
               } else {
            	   t_o.checked = false;
            	   $('#time').attr("disabled","true");
                   $('#tishi').attr("disabled","true");
               }
              
               var i_s = document.getElementById('zixun');
               if(result.infoStatus == 1) {
            	   i_s.checked = true;
            	   $('#zixun_mingcheng').removeAttr("disabled");
                   $('#zixun_lianjie').removeAttr("disabled");
            	   var infoArr =JSON.parse(result.infoJson)
                   console.log(infoArr)
                   if(infoArr != null) {
                       infoArr.forEach(function(ele,index){
                    	   add_zixun1(ele.name, ele.url)
                       })
                   }
            	 
               } else {
            	   i_s.checked = false;
            	   $('#zixun_mingcheng').attr("disabled","true");
                   $('#zixun_lianjie').attr("disabled","true");
               } 
            }
        }
    })
}

//咨询添加
function add_zixun1 (name, url) {
	if(count.length >= 6) {
		return
	}
	count.push(1);
	cou ++;
	var str = ''
	div = document.createElement("div");
	div.classList.add('jianju')
	div.id = 'zixun' + cou
	str += `<label class="col-md-2 control-label">名称*</label>\ 
        <input id="zixun_mingcheng" type="text" class="s_input input_100 zixun_mingcheng" value="`+ name +`">\
         <label class="col-md-2 control-label" style="width: 70px;">链接*</label>\
        <input id="zixun_lianjie" type="text" class="s_input zixun_lianjie" value="`+ url +`"/>\
        <div class="yuan del" style="margin-left:10px; float: left; color: red;" data-id =`+cou +`>-</div>\
        </div>`
     div.innerHTML = str;
	ziArr.appendChild(div)
	console.log(count.length)
	count_num.innerHTML = count.length+'/6'
	
	 //提炼名称和链接
	 
	
}



function formCheck(id) {
    formInit();
    if ($.trim(addForm.find("#"+id).val()) == "") {
        addForm.find("#"+id).parent().parent().addClass("has-error has-feedback");
        addForm.find("#"+id).parent().find("li").html("不能为空!");
        return false;
    }

    var chinaReg = /^[\d|A-z|\u4E00-\u9FFF]/;
    if (!chinaReg.test($.trim(addForm.find("#name").val()))) {
        addForm.find("#"+id).parent().parent().addClass("has-error has-feedback");
        addForm.find("#"+id).parent().find("li").html("名称必须为中文、数字、字母!");
        return false;
    }
    if ($.trim(addForm.find("#"+id).val()).length>10) {
        addForm.find("#"+id).parent().parent().addClass("has-error has-feedback");
        addForm.find("#"+id).parent().find("li").html("名称最多10位字符!");
        return false;
    }
    return true;
}

//验证分类方向是否唯一
function checkDesc(data, paramType) {
    if(directionId) data['directionId'] = directionId;
    var flag = false;
    $.ajax({
        url: path + "/" + paramType + "/check/cateDesc",
        type: "post",
        dataType: "json",
        cache: false,
        async: false,
        data: data,
        success: function (datas) {
            if (datas.code == HttpUtil.success_code) {
                flag = true;
            }
        }
    })
    return flag;
}

//删除
function deleteCate(paramType,obj) {
    var cateDesc='';
    if(paramType=='cate'){
         cateDesc='方向';
    }else if(paramType=='position' && pid=='kjs'){
         cateDesc='职位';
    }else if(paramType=='position' && pid=='sjn'){
        cateDesc='分类';
    }

    BootstrapDialog.confirm({
        title: '删除方向',
        message: '确定要删除当前'+cateDesc+'吗?',
        type: BootstrapDialog.TYPE_WARNING,
        closable: true,
        btnCancelLabel: '取消',
        btnOKLabel: '确认',
        btnOKClass: 'btn-warning',
        callback: function (result) {
            if (result) {
                var datas = {"id": obj, "deleted": 1};
                if(!checkDelUnique(paramType,datas)){
                    $.ajax({
                        url: path + "/" + paramType + "/delete",
                        type: "post",
                        dataType: "json",
                        cache: false,
                        data: datas,
                        success: function (datas) {
                            if (datas.code == HttpUtil.success_code) {
                                cateTable.ajax.reload();//刷新
                            }
                        }
                    })
                }else{
                    BootstrapDialog.show({
                        title: '警告提示',
                        message: '该课程分类有关联，不能删除！'
                    });
                }
            }
        }
    })
}
//排序
function orderBy(datas,paramType){
    $.ajax({
        url: "/"+paramType+"/order",
        type: "post",
        dataType: "json",
        cache: false,
        data: datas,
        success: function (datas) {
        	console.log('data', datas)
            if (datas.code == HttpUtil.success_code) {
//                cateTable.ajax.reload();//刷新
            }
        }
    })
}

//判断该方向是否被使用
function checkDelUnique(paramType,datas){
    var flag = false;
    $.ajax({
        url: path + "/"+paramType+"/checkDelUnique",
        type: "post",
        dataType: "json",
        cache: false,
        async: false,
        data: datas,
        success: function (datas) {
            if (datas.code == HttpUtil.success_code) {
                flag = true;
            }
        }
    })
    return flag;
}
