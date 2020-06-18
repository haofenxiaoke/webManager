<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<%@ taglib prefix="Shiro" uri="http://shiro.apache.org/tags" %>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" contentType="text/html; UTF-8" %>
<%@include file="/WEB-INF/view/include/taglib.jsp" %>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<html>
<head>
    <title>${pname}网管理系统-课程简介</title>

    <meta http-equiv="Content-Type" content="text/html;charset=utf-8"/>
    <script type="text/javascript" charset="utf-8" src="/resources/ueditor/ueditor.config.js"></script>
    <script type="text/javascript" charset="utf-8" src="/resources/ueditor/ueditor.all.js"></script>
    <!--建议手动加在语言，避免在ie下有时因为加载语言失败导致编辑器加载失败-->
    <!--这里加载的语言文件会覆盖你在配置项目里添加的语言类型，比如你在配置项目里配置的是英文，这里加载的中文，那最后就是中文-->
    <script type="text/javascript" charset="utf-8" src="/resources/ueditor/lang/zh-cn/zh-cn.js"></script>
    <style>
        .basediv {
            margin: 30px;
        }
    </style>

    <script>
        window.onload = function () {
            var jobDuty = '${courseText.jobDuty}' + "";
            var summary = '${courseText.summary}' + "";
            var teacherBrief = '${courseText.teacherBrief}' + "";
            var job_duty = UE.getEditor('job_duty');
            job_duty.ready(function () {
                if (jobDuty != null && jobDuty != '') {
                    this.setContent(jobDuty);
                } else {
                    this.setContent("请填写岗位职责");
                }

            });
            var course_brief = UE.getEditor('course_brief');
            course_brief.ready(function(){
                if(summary!=null && summary!=''){
                    this.setContent(summary);
                }else{
                    this.setContent("请填写课程简介");
                }

            });
            var teacher_brief = UE.getEditor('teacher_brief');
            teacher_brief.ready(function(){
                if(teacherBrief!=null && teacherBrief!=''){
                    this.setContent(teacherBrief);
                }else{
                    this.setContent("请填写老师介绍");
                }

            });
            /*上一步保存事件*/
            <Shiro:hasPermission name="addcourse:find:0" >
            $('#backUp').unbind('click').click(function () {
                location.href='/course/backUp/${courseId}/${operType}';
            });
            </Shiro:hasPermission>
            /*下一步保存事件*/
            $('#save-down').unbind('click').click(function () {
                 if(job_duty.getContent()==null || job_duty.getContent()==''){
                     BootstrapDialog.warning('岗位职责不能为空！');
                     return false;
                 }
                if(course_brief.getContent()==null || course_brief.getContent()==''){
                    BootstrapDialog.warning('课程简介不能为空！');
                    return false;
                }
                if(teacher_brief.getContent()==null || teacher_brief.getContent()==''){
                    BootstrapDialog.warning('老师介绍不能为空！');
                    return false;
                }

                $.ajax({
                    url: "/course/config/${courseId}/${operType}",
                    type: "post",
                    dataType: "json",
                    cache: false,
                    data: $("#config").serializeArray(),
                    success: function (datas) {
                        if (datas.code == HttpUtil.success_code) {
                            window.location.href = "/course/course_config/${courseId}/${operType}";
                        }
                    }
                });
            });


        };
    </script>
</head>
<body>
<div>
    <input type="hidden" id="optionType" name="optionType" value="${optionType}">
    <div class="row">
        <div class="col-md-10" style="width:100%;">
            <div class="panel panel-inverse">
                <div class="panel-heading" style="height: 50px">
                    <h4 class="panel-title">创建课程</h4>
                </div>
                <nav class="navbar navbar-default" role="navigation" style="margin:20px;width:90%">
                    <div style="width: 100%;">
                        <ol class="nav navbar-nav" style="width: 100%;">
                            <li style="width: 33.3%" style="background-color:lightseagreen;"><a href="#"
                                                                                                style="background-color: lightseagreen">课程基本信息</a>
                            </li>
                            <li style="width: 33.3%" style="background-color:lightseagreen;"><a href="#"
                                                                                                style="background-color: lightseagreen">课程介绍</a>
                            </li>
                            <li style="width: 33.3%">
                                <a href="#">
                                    课程设置
                                </a>
                            </li>
                        </ol>
                    </div>
                </nav>
                <form id="config" method="post">
                    <div><input type="hidden" value="${courseId}" id="courseId" name="courseId"></div>
                    <div class="basediv">
                        <div class="basediv" style="width: 90%">
                            <h2>岗位职责</h2>
                            <hr style="height:1px;border:none;border-top:1px solid #555555;"/>
                        </div>
                        <div class="basediv" style="width: 90%">
                            <div id="job_duty" name="jobDuty"></div>
                        </div>
                    </div>
                    <div class="basediv">
                        <div class="basediv" style="width: 90%">
                            <h2>课程简介</h2>
                            <hr style="height:1px;border:none;border-top:1px solid #555555;"/>
                        </div>
                        <div class="basediv" style="width: 90%">
                            <div id="course_brief" name="summary"></div>
                        </div>
                    </div>
                    <div class="basediv">
                        <div class="basediv" style="width: 90%">
                            <h2>老师介绍</h2>
                            <hr style="height:1px;border:none;border-top:1px solid #555555;"/>
                        </div>
                        <div class="basediv" style="width: 90%">
                            <div id="teacher_brief" name="teacherBrief"></div>
                        </div>
                    </div>
                    <div style="text-align: center;width: 85%">
                        <button type="button" class="btn btn-sm btn-info m-r-5 btn-lg" id="backUp"
                                style="width: 80px;">上一步
                        </button>
                        <button type="button" class="btn btn-sm btn-info m-r-5 btn-lg" id="save-down"
                                style="width: 80px;">下一步
                        </button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>
</body>
</html>