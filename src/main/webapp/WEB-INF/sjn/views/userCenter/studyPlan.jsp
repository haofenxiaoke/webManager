<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%--<!DOCTYPE html>--%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html lang="en">
<head>
  <link href="/resources/userCenter/css/studyPlan.css" rel="stylesheet">
  <link href="/resources-sjn/user/css/studyPlan.css" rel="stylesheet">

  <script src="/resources/common/echarts-2.2.7/build/dist/echarts.js"></script>
  <script src="/resources-sjn/userCenter/js/studyPlanDetail.js"></script>
  <script src="/resources-sjn/userCenter/js/studyPlan.js"></script>
  <script src="/resources/userCenter/js/messageClick.js"></script>
  <script src=/resources/common/plugins/bootstrap-daterangepicker/moment.js"></script>
  <link href="/resources-sjn/user/css/tipTc.css" rel="stylesheet">

  <style>
    .kjsCrouse ul{ margin-bottom: 0px;}
    .btn70{ background: rgb(242, 144, 152) !important;}
    .btn70:hover{background: rgb(242, 144, 152) !important;}
    .crouse-a a{padding-left: 0;text-align: center;}
    .crouse-a{background: rgb(242, 144, 152) !important;padding-left: 10px; padding-right: 10px;margin-right: 10px;border-radius: 3px;}
    .textC a{color: #444444 !important;}
    .crouse-a i{right: 10px;top: 0;}
    .textC a:hover{color: #333333 !important;}
    .crouseBtn a{margin: 0;}
    .crouseAdd{width: 68px;height:28px;background: #fff;border:1px solid #dddddd;display: block;border-radius: 3px;text-align: center;float:left;}
    .crouseAdd i{width: 17px;height: 17px;background-position:-143px 0;margin-top: 3px;background: url("/resources-sjn/course/images/zengjia.png") no-repeat !important;}
    .kjsCrouse ul li:hover{transform: translate3d(0 ,0px,0);box-shadow: 0 15px 30px rgba(0,0,0,0)!important;}
    .play-close{position: absolute;right: 10px;top:10px;cursor: pointer;}
    .play-tc{display:block;width:450px;height:260px;background: #fff;border-radius: 3px;position: fixed;top:0;left:0;bottom:0;right:0;margin:auto;z-index: 1000;}
    .play-black{width: 100%;height: 100%;background: rgba(0,0,0,0.5);position: fixed;z-index: 999;top:0;left:0;display:block;}
    .play-tc-tittle{width: 160px;margin:0 auto;text-align: center;position: relative;top:70px;}
    .play-tc-tittle span{font-size: 18px;padding: 0 10px;background: #fff;position: relative;z-index: 2;color:#333;}
    .play-tc-tittle p{width: 160px;border-bottom:1px solid #ccc;position: absolute;z-index: 1;top:10px;}
    .play-tc ul{width: 240px;margin: 100px auto 0 auto;}
    .play-tc ul li{font-size: 16px;color:#666;position: relative;}
    .play-tc ul span{display: block;width: 5px;height: 5px;background: #333333;border-radius: 100px;position: absolute;top:7px;left: -10px;}
  </style>
</head>
<body>
<input type="hidden" value="${user.userid}" id="userid">
<input type="hidden" value="${user.id}" id="stuId">
<input type="hidden" id="is-vip" name="is-vip" value="${user.isVIP}">
<input type="hidden" id="planid" value="${planid}">
<input type="hidden" id="vipid" value="${user.vipId}">
<input type="hidden" value="${unReadMsgClass}">
  <div class="userRight fr" id="userRight">
    <div class="userR-title">
      <a id="m-1" class="userR-cur">定制课程</a>
      <a id="m-2">学习资料</a>
      <a id="m-3">成长记录</a>
    </div>
    <div class="userR-con">
      <div class="userR-zccount" id="planContent">
        <div style="display:block" id="hasPlan">
          <div class="h30"></div>
          <div class="studyZl" id="planDiv">
            <div class="crouseBtn clearfloat" id="plans" >
            </div>
            <div class="crouse-time" id="tagsDiv">
              <div class="clearfloat" id="planTags">
              </div>
            </div>
          </div>
        </div>
        <div id="study-doc">
          <div class="h30"></div>
          <div class="studyZl" id="nodeTable">
            <table class="studyTable" id="lectureNodes">
            </table>
          </div>
        </div>
        <div id="record">
          <%--时间选择器--%>
          <div class="well" id="timeRanger">
            <form class="form-horizontal">
              <fieldset>
                <div class="control-group">
                  <div class="controls">
                    <div class="input-prepend input-group">
                      <span class="add-on input-group-addon"><i class="glyphicon glyphicon-calendar fa fa-calendar"></i></span>
                      <input type="text" style="width: 200px" name="studyRangeDate" id="studyRangeDate" class="form-control"  />
                    </div>
                  </div>
                </div>
              </fieldset>
            </form>
          </div>
          <div id="main" style="height: 400px"></div>
        </div>
      </div>
    </div>
  </div>
<script>
  $(function () {
    var m = Util.getRequestParam('m');m && $('#m-' + m).click();
  });
</script>
<div class="hytc" style="display:none;" id="delTip">
  <div class="tcnr">
    <div class="tcnr-top">
      <div class="tcnrgb" id="delCloseBtn"></div>
    </div>
    <div class="tctx">确定要删除该计划吗？</div>
    <div class="kthy">
      <a class="sjn-qd-btn" id="sjn-qd-btn">确定</a>
      <a class="sjn-qx-btn" id="sjn-qx-btn">取消</a>
    </div>
  </div>
</div>
<div class="fxtc" id="delSuccess" style="display: none;">
  <div class="undefined">
    <a>
      <img src="/resources-sjn/index/images/bd_yes.png" />
      <span>删除计划成功</span>
    </a>
  </div>
</div>
<%--弹出框显示学习思路--%>
<div class="play-tc js-tc" id="ideas" style="display: none">
  <img src="${basePath}/resources/userCenter/images/play-close.png" class="play-close js-close"/>
  <div class="play-tc-tittle">
    <p></p>
    <span>学习方法</span>
  </div>
  <ul>
    <li id="learningIdea1"><span></span></li>
    <li id="learningIdea2"><span></span></li>
    <li id="learningIdea3"><span></span></li>
  </ul>
</div>
<div class="play-black js-black" style="display: none" ></div>
<script type="text/javascript">
  for(var mu=0;mu < $(".crouse-a").length;mu++){
    var str= $(".crouse-a:eq("+mu+") a").text().length;//原始字符串

    var s = $(".crouse-a:eq("+mu+") a").text();//要展示的字符串
    if(str>5){
      s=s.substr(0,5)+"...";
      $(".crouse-a:eq("+mu+") a").text(s);
    }
  }

</script>
</body>
</html>