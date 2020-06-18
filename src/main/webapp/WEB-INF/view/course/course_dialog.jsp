<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2016/5/30 0030
  Time: 下午 4:23
  To change this template use File | Settings | File Templates.
--%>
<%@ page pageEncoding="utf-8"  language="java" %>
<!DOCTYPE html>
<html lang="en">

<div class="modal fade" id="industry_dialog1" tabindex="-1" role="dialog">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close"
                        data-dismiss="modal" aria-hidden="true">
                    &times;
                </button>
                <h4 class="modal-title" id="myModalLabel">
                   选择行业
                </h4>
            </div>
            <div class="modal-body">

            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default"
                        data-dismiss="modal">关闭
                </button>
                <button type="button" class="btn btn-primary">
                    提交更改
                </button>
            </div>
        </div>
    </div>
</div>

<%-- 选择行业 --%>
<div class="modal fade" id="industry_dialog">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close"
                        data-dismiss="modal" aria-hidden="true">
                    &times;
                </button>
                <h4 class="modal-title">
                    选择版本
                </h4>
            </div>
            <div > <input type="hidden" id="industryNum" value="0"></div>
            <div class="modal-body">
                <form id="checkIndustryForm" class="form-horizontal form-bordered" data-parsley-validate="true">
                    <input type="hidden" id="idIndustry">
                    <div class="form-group">
                        <label class="col-md-3 control-label">选择版本</label>
                        <div class="col-md-9">
                            <select style="width: 160px" name="industryids" id="industryids" class="form-control">
                            </select>
                            <ul  class="parsley-errors-list filled">
                                <li name="ErrorTip" class="parsley-required"></li>
                            </ul>
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <a id="industry_dialog_close" href="javascript:;" class="btn btn-sm btn-info" data-dismiss="modal">关闭</a>
                <a id="check_position_save" href="javascript:void(0)" onclick="industry_save_click($('#industryids'))" return false; class="btn btn-sm btn-success">保存</a><%-- href="javascript:;"--%>
            </div>
        </div>
    </div>
</div>
<%-- 选择课程优势 --%>
<div class="modal fade" id="advantage_dialog" tabindex="-1" role="dialog">
    <div class="modal-dialog">
        <div class="modal-content">

            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                <h4 class="modal-title">选择课程优势</h4>
            </div>

            <%--记录课程优势标签的选择数--%>
            <div > <input type="hidden" id="advantageNum" value="0"></div>
            <div class="modal-body">
                <form id="checkAdvantageForm" class="form-horizontal form-bordered" data-parsley-validate="true">
                   <%-- <input type="hidden" id="idIndustry">--%>
                    <div class="form-group">
                        <label class="col-md-3 control-label">选择课程优势</label>
                        <div class="col-md-9">
                            <select style="width: 160px" name="courseAdvantages" id="courseAdvantages" class="form-control">
                            </select>
                            <%-- <input id="update_name" type="text" class="form-control" />--%>
                            <ul  class="parsley-errors-list filled">
                                <li name="ErrorTip" class="parsley-required"></li>
                            </ul>
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <a id="advantage_dialog_close" href="javascript:;" class="btn btn-sm btn-info" data-dismiss="modal">关闭</a>
                <a id="check_advantage_save" href="javascript:void(0)" onclick="advantage_save_click($('#courseAdvantages'))" return false; class="btn btn-sm btn-success">保存</a><%-- href="javascript:;"--%>
            </div>
        </div>
    </div>
</div>

<%-- 选择课程适合对象 --%>
<div class="modal fade" id="suitable_dialog">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                <h4 class="modal-title">选择适合对象</h4>
            </div>
            <%--记录课程优势标签的选择数--%>
            <div > <input type="hidden" id="suitableNum" value="0"></div>
            <div class="modal-body">
                <form id="checkSuitableForm" class="form-horizontal form-bordered" data-parsley-validate="true">
                    <%-- <input type="hidden" id="idIndustry">--%>
                    <div class="form-group">
                        <label class="col-md-3 control-label">选择适合对象</label>
                        <div class="col-md-9">
                            <select style="width: 160px" name="courseSuitables" id="courseSuitables" class="form-control">
                            </select>
                            <ul  class="parsley-errors-list filled">
                                <li name="ErrorTip" class="parsley-required"></li>
                            </ul>
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <a id="suitable_dialog_close" href="javascript:;" class="btn btn-sm btn-info" data-dismiss="modal">关闭</a>
                <a id="check_suitable_save" href="javascript:void(0)" onclick="suitable_save_click($('#courseSuitables'))" return false; class="btn btn-sm btn-success">保存</a><%-- href="javascript:;"--%>
            </div>
        </div>
    </div>
</div>

<%-- 填写课程适标题 --%>
<div class="modal fade" id="createCourse_dialog">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                <h4 class="modal-title">创建新课程</h4>
            </div>
            <div class="modal-body">
                <form id="writeCourseTitleForm" class="form-horizontal form-bordered" data-parsley-validate="true">
                    <%-- <input type="hidden" id="idIndustry">--%>
                    <div class="form-group">
                        <label class="col-md-3 control-label">填写课程标题</label>
                        <div class="col-md-9">
                            <input type="text" id="writeCourseTitle">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-md-3 control-label">版本号</label>
                        <div class="col-md-9">
                            <input type="text" id="createVersion" value="第一版" readonly style="border: none">
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <a id="createCourse_dialog_close" href="javascript:;" class="btn btn-sm btn-info" data-dismiss="modal">关闭</a>
                <a id="createCourse_save" href="javascript:void(0)" onclick="courseTitle_save_click($('#writeCourseTitle'))" return false; class="btn btn-sm btn-success">保存</a><%-- href="javascript:;"--%>
            </div>
        </div>
    </div>
</div>


<%-- 选择课程适标题 --%>
<div class="modal fade" id="updateCourse_dialog">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                <h4 class="modal-title">选择课程标题</h4>
            </div>
            <div class="modal-body">
                <form id="checkCourseTitleForm" class="form-horizontal form-bordered" data-parsley-validate="true">
                    <%-- <input type="hidden" id="idIndustry">--%>
                    <div class="form-group">
                        <label class="col-md-3 control-label">课程版本更新</label>
                        <div class="col-md-9">
                            <select style="width: 160px" name="courseTitles" id="courseTitles" class="form-control">
                            </select>
                            <%-- <input id="update_name" type="text" class="form-control" />--%>
                           <%-- <ul  class="parsley-errors-list filled">
                                <li name="ErrorTip" class="parsley-required"></li>
                            </ul>--%>
                        </div>

                    </div>
                    <div class="form-group">
                        <label class="col-md-3 control-label">版本号</label>
                        <div class="col-md-9">
                            <input type="text" id="versionNO" readonly="readonly">
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <a id="updateCourse_dialog_close" href="javascript:;" class="btn btn-sm btn-info" data-dismiss="modal">关闭</a>
                <a id="updateCourse_save" href="javascript:void(0)" onclick="courseTitle_save_click($('#courseTitles'))" return false; class="btn btn-sm btn-success">保存</a><%-- href="javascript:;"--%>
            </div>
        </div>
    </div>
</div>
</html>
<script>


</script>


