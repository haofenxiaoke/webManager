<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="zh">
<head>
  <link href="/resources/userCenter/css/studyPlan.css" rel="stylesheet">

  <script src="/resources/common/echarts-2.2.7/build/dist/echarts.js"></script>
  <script src="/resources/userCenter/js/studyPlanDetail.js"></script>
  <script src="/resources/userCenter/js/studyPlan.js"></script>
  <script src="/resources/userCenter/js/messageClick.js"></script>
  <script src="/resources/common/plugins/bootstrap-daterangepicker/moment.min.js"></script>
  <link href="/resources/userCenter/css/tipTc.css" rel="stylesheet">

  <style>
    .kjsCrouse ul{ margin-bottom: 0px;}
    .crouse-a a{padding-left: 0;text-align: center;}
    .crouse-a i{right: 11px;top: 0;}
    .play-close{position: absolute;right: 10px;top:10px;cursor: pointer;}
    .play-tc{display:block;width:450px;height:260px;background: #fff;border-radius: 3px;position: fixed;top:0;left:0;bottom:0;right:0;margin:auto;z-index: 1000;}
    .play-black{width: 100%;height: 100%;background: url(${basePath}/resources/userCenter/images/kjs-tcBg.png) repeat;
      position: fixed;z-index: 999;top:0;left:0;display:block;}
    .play-tc-tittle{width: 160px;margin:0 auto;text-align: center;position: relative;top:60px;}
    .play-tc-tittle span{font-size: 18px;padding: 0 10px;background: #fff;position: relative;z-index: 2;color:#333;}
    .play-tc-tittle p{width: 160px;border-bottom:1px solid #ccc;position: absolute;z-index: 1;top:12px;}
    .play-tc ul{width: 240px;margin: 80px auto 0 auto;}
    .play-tc ul li{font-size: 16px;color:#666;position: relative;margin-bottom: 10px;}
    .play-tc ul span{display: block;width: 5px;height: 5px;background: #5583db;border-radius: 100px;position: absolute;top:7px;left: -10px;}


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
                      <input type="text" style="width: 200px; height: 34px;line-height: 34px;" name="studyRangeDate" id="studyRangeDate" class="form-control"  />
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
      <img src="${basePath}/resources/course/images/fenxiang.png" />
      <span style="font-size: 18px;">删除计划成功</span>
  </div>

</div>

<div class="play-tc js-tc" id="ideas" style="display: none">
  <%--<img src="${basePath}/resources/userCenter/images/play-close.png" class="play-close js-close"/>--%>
  <div class="close-btn js-close" id="ideas-close"></div>
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
  for(mu=0;mu< $(".crouse-a").length;mu++){
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