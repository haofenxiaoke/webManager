<%@ page pageEncoding="utf-8"  language="java" %>
<%-- 新增分类职位 --%>
<input type="hidden" id="paramType" >
<div class="modal fade" id="position-create-alert">

    <div class="modal-dialog">
        <div class="modal-content">
            <div class="panel panel-inverse">
                <div class="panel-heading">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                    <h4 class="panel-title" id="desc-id">添加</h4>
                </div>
            </div>
            <div class="panel-body">
                <form id="cateForm" class="form-horizontal form" data-parsley-validate="true">
                    <input type="hidden" id="directionId" value="${directionId}">
                    <input type="hidden" id="id">
                    <div class="form-group"  id="pt">
                        <label class="col-md-2 control-label">描述*</label>
                        <div class="col-md-9">
                            <input id="name" type="text" class="form-control" />
                            <ul  class="parsley-errors-list filled">
                                <li name="ErrorTip" class="parsley-required"></li>
                            </ul>
                        </div>
                    </div>
                    <div id="bpt">
                    <div class="form-group bottom_border">
                    	<label class="col-md-2 control-label">名称*</label>
                        <div class="col-md-9">
                            <input id="name_" type="text" class="form-control" />
                            <ul  class="parsley-errors-list filled">
                                <li name="ErrorTip" class="parsley-required"></li>
                            </ul>
                        </div>
                   
                    </div>
                    <div class="form-group">
                         <label class="col-md-2 control-label">考试计时*</label>
                         <div class="col-md-9">
                        <input class="switch-btn switch-btn-animbg form-control" type="checkbox" checked id="time_open">
                        </div>
                    </div>
                  
                  <div class="form-group">
                  	 <label class="col-md-2 control-label">考试日期*</label>
                  	 <div class="col-md-9">
                       <input class="form-control js-datepicker" type="text" id="time" name="time"  value=""/> 
                                                </div>
                  </div>
                  <div class="form-group bottom_border">
                  	<label class="col-md-2 control-label">提示信息*</label>
                  	<div class="col-md-9">
                  		<div style="float:left; line-height: 34px;" >距离</div><input id="tishi" type="text" class="s_input" name="tishi"/><span style="line-height: 34px;">还有<span style="color:#cc9966;">【xxx】</span>天</span>
                  	</div>
                  </div>
                  
                   <div class="form-group">
                         <label class="col-md-2 control-label">咨询链接*</label>
                         <div class="col-md-6">
                        <input class="switch-btn switch-btn-animbg form-control" type="checkbox" checked id="zixun">
                        </div>
                        <div class="num" id="count_num">0/6</div>
                    </div>
                    
                    <div class="form-group" id="zixunArr">
                    	
                    </div>
                    
                    <div class="yuan" id="jia">+</div>
                  </div>
                  
                </form>
            </div>
            
            <div class="modal-footer">
                <a id="close" href="javascript:;" class="btn btn-sm btn-info" data-dismiss="modal">关闭</a>
                <a id="saveCate"  href="javascript:;" class="btn btn-sm btn-success">保存</a>
            </div>
        </div>
    </div>
 
</div>


