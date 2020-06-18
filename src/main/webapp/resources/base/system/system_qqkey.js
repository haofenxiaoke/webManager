//定义一次对象
var skuObj = $("#skuList");
var path = $("#path").val();
var dataTemp;

//var wapObj = $("#wap_qqKeys");
var wapDetailObj = $("#wapDetail_qqKeys");
var topObj = $("#top_qqKeys");
var comObj = $("#com_qqKeys");
var tikuObj = $("#tiku_qqKeys");
var popObj = $("#pop_qqKeys");
var saveBtnObj = $("#saveBtn");


$(document).ready(function () {

    //初始化
    initVale();
    //管家key和多选框
    bindValue();
    saveBtnObj.on("click", function () {
        /* if($.trim(wapObj.val())==""){
         $().toastmessage('showSuccessToast',"wap公开课不能为空!");
         return;
         }*/
        if($.trim(wapDetailObj.val())==""){
            $().toastmessage('showSuccessToast',"wap课程详细不能为空!");
            return;
        }
        if($.trim(topObj.val())==""){
            $().toastmessage('showSuccessToast',"首页设置不能为空!");
            return;
        }
        if($.trim(comObj.val())==""){
            $().toastmessage('showSuccessToast',"商品详细页不能为空!");
            return;
        }
        if($.trim(tikuObj.val())==""){
            $().toastmessage('showSuccessToast',"题库不能为空!");
            return;
        }
        if($.trim(popObj.val())==""){
            $().toastmessage('showSuccessToast',"推广页不能为空!");
            return;
        }
        saveBtnObj.attr('disabled',true);
        saveData();
    });
});

function initVale(){
    //先清除之前的选中
    dataTemp = {
        "wapDetail": "",
        "wap": "",
        "pop": "",
        "top": "",
        "com": "",
        "tiku": ""
    };
    //  wapObj.val();
    wapDetailObj.val();
    topObj.val();
    comObj.val();
    tikuObj.val();
    popObj.val();
}

skuObj.unbind().bind("change", function(){
    initVale()
    bindValue();
});

function bindValue(){
    getNewData(skuObj.find("option:selected").attr("value"));
    if(dataTemp!=null) {
        // wapObj.val(dataTemp.wap);
        wapDetailObj.val(dataTemp.wapDetail);
        topObj.val(dataTemp.top);
        comObj.val(dataTemp.com);
        tikuObj.val(dataTemp.tiku);
        popObj.val(dataTemp.pop);
    }
}

//获取新数据
function getNewData(id){
    $.ajax({
        url: path + "/qqKey/detail?skuId="+id,
        type: "get",
        dataType: "json",
        cache: false,
        async: false,
        data: null,
        success: function (datas) {
            if(datas.code=="200"){
                var result = datas.result.qqKey;
                //判断返回字串是否是json格式
                if (result!=null && result.match("^\{(.+:.+,*){1,}\}$")){
                    //转json
                    dataTemp =JSON.parse(result);
                }
                else{
                    dataTemp = {};
                }

            }
        }
    })
}


//保存
function saveData(){
    var qqKey = {
        // "wap": wapObj.val(),
        "wapDetail": wapDetailObj.val(),
        "top": topObj.val(),
        "com": comObj.val(),
        "tiku": tikuObj.val(),
        "pop": popObj.val()
    };
    var data = {
        "id": skuObj.val(),
        "qqKey": JSON.stringify(qqKey)
    };
    postData(data);
}

//发请求
function postData(data) {
    $.ajax({
        url: path + "/qqKey/update",
        type: "post",
        dataType: "json",
        cache: false,
        async: false,
        data: data,
        success: function (datas) {
            if(datas.code=="200"){
                $().toastmessage('showSuccessToast',"保存成功!");
                saveBtnObj.attr('disabled',false);
            }else if(datas.code=="500"){
                $().toastmessage('showErrorToast',"保存失败!");
                saveBtnObj.attr('disabled',false);
            }
        }
    })
}
