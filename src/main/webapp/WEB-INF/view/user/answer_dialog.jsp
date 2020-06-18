<%@ page pageEncoding="utf-8"  language="java" %>
<%-- 查看回答信息 --%>
<div class="modal fade" id="answer-view-alert">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="panel panel-inverse">
                <div class="panel-heading">
                    <div class="panel-heading-btn">
                        <button type="button" class="btn btn-xs btn-icon btn-circle btn-danger" data-dismiss="modal" aria-hidden="true"><i class="fa fa-times"></i></button>
                    </div>
                    <div class="panel-title">问答信息</div>
                </div>
            </div>
            <div class="panel-body">
                    <div class="form-group">
                        <div id="htmlContent">
                        </div>
                    </div>
            </div>
        </div>
    </div>
</div>
<script>
    function viewDialog(id,userid){
        var datas = {"questionId":id,"userId":userid};
        $.ajax({
            url:"/stu/question/answers",
            type:"post",
            dataType:"json",
            cache: false,
            data :datas,
            success: function (datas){
                if(datas.code == HttpUtil.success_code){
                    var divHtml ='<ul class="media-list media-list-with-divider">';
                    $.each(datas.result,function(i,obj) {
                        var replyTime = "";
                        if(obj.replyTime){
                            replyTime = TimeObjectUtil.formatterDateTime(new Date(obj.replyTime));
                        }
                        divHtml += '<li class="media media-lg"><div>'+obj.flowerName+' '+ replyTime +'</div><div>'+obj.replyContent+'</div></li>';
                    });
                    divHtml+="</ul>";
                    $("#htmlContent").html(divHtml);
                }
            }
        })
    }
</script>