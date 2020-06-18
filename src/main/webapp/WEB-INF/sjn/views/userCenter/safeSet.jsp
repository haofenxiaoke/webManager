<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<html lang="en">
<head>
  <link href="${basePath}/resources/userCenter/css/studySet.css" rel="stylesheet">
  <link href="${basePath}/resources-sjn/user/css/safeSet.css" rel="stylesheet">
  <link href="/resources-sjn/user/css/index.css" rel="stylesheet">
  <link href="/resources-sjn/user/css/tipTc.css" rel="stylesheet">
  <script src="${basePath}/resources/userCenter/js/user.js"></script>
  <script src="${basePath}/resources/common/js/china_area.js"></script>
  <script src="${basePath}/resources-sjn/userCenter/js/safeSet.js"></script>
  <script src="/resources/userCenter/js/messageClick.js"></script>
  <link type="text/css" href="/resources/common/uploadify/uploadify.css" rel="stylesheet"/>
  <script type="text/javascript" src="/resources/common/uploadify/jquery.uploadify.min.js"></script>
  <script>
    $(".userR-title a").on('click', function () {
      $(".userR-title a").removeClass('userR-cur');
      $(this).addClass('userR-cur');
      $(this).parent().next().find('.userR-zccount>div').fadeOut().hide().eq($(this).index()).fadeIn();
    })
  </script>
  <style>
    .uploadify-button {
      background: #e62c3a !important;
      border-color: #e62c3a !important;
    }
    .uploadify:hover .uploadify-button {
      background:#e62c3a !important;
      border-color: #e62c3a !important;
    }
  </style>
</head>
<body>
<input type="hidden" id="userid" value="${user.userid}">
<input type="hidden" id="vipid" value="${userVip.vipId}">
<div class="userRight fr">
  <div class="userR-title">
    <a class="userR-cur">个人资料</a>
    <a>安全设置</a>
  </div>
  <div class="userR-con">
    <div class="userR-zccount">
      <!--个人资料-->
      <div style="display: block;">
        <form id="userInfo-update-form">
          <div class="userR-txmain">
            <div class="userR-tx">
              <c:choose>
                <c:when test="${empty user.imgurl}">
                  <img id="preview-image" src="/resources/common/images/photo.jpg">
                </c:when>
                <c:otherwise>
                  <img id="preview-image" src="${user.imgurl}">
                </c:otherwise>
              </c:choose>
              <%-- <img id="preview-image" src=<c:if test="${user.imgurl}==null">${user.imgurl}>--%>
            </div>
            <span id="upload-span" style="display: none">
              <div id="queue"></div>
              <input id="file_upload" name="file_upload" type="file" multiple="true">
              <input type="hidden" id="head-image-path" name="imgurl" value="${user.imgurl}">
            </span>
          </div>
          <div style="height: 65px;width: 100%;"></div>
          <div class="userR-data clearfloat">
            <label>昵称：</label>
            <div class="userR-dataR">
              <div class="userR-input"><input type="text" name="username" id="username" value="${user.username}"></div>
            </div>
          </div>
          <div class="userR-data clearfloat">
            <label>性别：</label>
            <div class="userR-dataR">
              <div class="userR-xb">
                <input type="radio" name="sex" value="0"  <c:if test="${'0'==user.sex}">checked</c:if>>男
                <input type="radio" style="margin-left: 10px;" name="sex" value="1"  <c:if test="${'1'==user.sex}">checked</c:if>>女
              </div>
            </div>
          </div>
          <div class="userR-data clearfloat">
            <label>生活地区：</label>
            <div class="userR-dataR" id="city">
              <div class="clearfloat">
                <div class="userR-sel fl mr20">
                  <select id="userProvince" name="userProvince" >
                    <option value="0">--请选择省份--</option>
                  </select>
                </div>
                <div class="userR-sel fr">
                  <%--<select class="city" disabled="disabled" name="userAddress"></select>--%>
                  <select id="userAddress" name="userAddress" >
                    <option value="0">--请选择城市--</option>
                  </select>
                </div>
              </div>
            </div>
          </div>
          <div class="userR-data clearfloat">
            <label>最高学历：</label>
            <div class="userR-dataR">
              <div class="userR-sel">
                <select name="education" id="education">
                  <option value="-1">--学历--</option>
                  <option value="1">硕士研究生及以上</option>
                  <option value="2">本科</option>
                  <option value="3">大专</option>
                  <option value="4">高中及以下</option>
                </select>
              </div>
            </div>
          </div>
          <div class="userR-data clearfloat">
            <label>职业：</label>
            <div class="userR-dataR">
              <div class="userR-input"><input type="text" id="profession" name="profession" value="${user.profession}"></div>
            </div>
          </div>
          <div class="userR-data clearfloat">
            <label>课程基础：</label>
            <div class="userR-dataR">
              <div class="userR-sel">
                <select id="courseBasis" name="courseBasis">
                  <option value="-1">--工作经验--</option>
                  <option value="0" selected>无经验</option>
                  <option value="1">1年经验</option>
                  <option value="2">3年经验</option>
                  <option value="3">3年以上</option>
                </select>
              </div>
            </div>
          </div>
          <div class="userR-data clearfloat">
            <label>QQ号码：</label>
            <div class="userR-dataR">
              <div class="userR-input"><input type="text" id="qqNum" name="qqNum" value="${user.qqNum}"></div>
            </div>
          </div>
        </form>
        <a href="javascript:void(0);" class="btn180 mrl curNo" id="userInfo-update-btn" onclick="btnClick(this)" style=" ">我要修改</a>
        <a class="btn180 mrl curNo" id="userInfo-update-btn1"  onclick="updateInfo(this)" style=" display: none">保存</a>

      </div>


      <!--安全设置-->
      <div>
        <form id="pwd-update-form">
          <div style="height: 65px;width: 100%;"></div>
          <div class="userR-data clearfloat">
            <label>原始密码：</label>
            <div class="userR-dataR">
              <div class="userR-input userColor" ><input type="password" name="oldPassword" id="oldPassword"></div><div style="display: inline" id="tip1"></div>
            </div>
          </div>
          <div class="userR-data clearfloat">
            <label>设置密码：</label>
            <div class="userR-dataR">
              <%-- <p></p>--%>
              <div class="userR-input" ><input type="password" id="password" name="password" disabled="disabled"></div><div style="display: inline" id="tip2"></div>
            </div>
          </div>
          <div class="userR-data clearfloat">
            <label>确认密码：</label>
            <div class="userR-dataR">
              <div class="userR-input"  ><input type="password" id="rePassword" name="rePassword" disabled="disabled"></div><div style="display: inline" id="tip3"></div>
            </div>
          </div>
        </form>
        <a href="javascript:void(0);" class="btn180 mrl curNo" id="pwd-update-btn"  style="background-color:#5583db;">确认</a>
      </div>


    </div>
  </div>
</div>

<script type="text/javascript">
  $(document).ready(function () {
    var education=${user.education}+'';
    var province=${user.userProvince}+'';
    var address=${user.userAddress}+'';
    var courseBasis=${user.courseBasis}+'';
    $("#education").val(education);
    $("#userProvince").val(province);
    $("#userAddress").val(address);
    $("#courseBasis").val(courseBasis);

    //上传图像
    $('#file_upload').uploadify({
      'swf' : '/resources/common/uploadify/uploadify.swf',// 指定swf文件
      'uploader' : '/upload/file',// 后台处理的页面
      'cancelImg' : '/resources/common/uploadify/img/uploadify-cancel.png',// 取消按钮图片路径
      "queueID" : 'queue',// 上传文件页面中，你想要用来作为文件队列的元素的id, 默认为false  自动生成,  不带#
      'method' : 'post',// 设置上传格式
      'auto' : true,// 当选中文件后是否自动提交
      'multi' : false,// 是否支持多个文件上传
      'sizeLimit':'2M',
      'simUploadLimit' : 1,
      'buttonText' : '上传图像',// 按钮显示的文字
      'onInit': function () {//载入时触发，将flash设置到最小
        $("#queue").hide();
      },
      'onUploadSuccess': function (file, data, response) {// 上传成功后执行
//        $('#' + file.id).find('.data').html(' 上传完毕');
        var path = JSON.parse(data).data['path'];
        //裁剪上传图片
        layer.open({
          type: 2,
          title: '更换图像',
          shadeClose: true,
          shade: 0.8,
          area: ['600px', '450px'],
          offset: '100px',
          content: '/upload/preview?imgUrl=' + path, //iframe的url
          btn: ['确定', '取消'],
          yes: function (index) {
            var destPath = window["layui-layer-iframe" + index].saveFunc();
            if (destPath) {
              $('#preview-image').attr('src', destPath+'?t='+Math.random());
              $('#head-image-path').val(destPath);
            }
            layer.close(index); //如果设定了yes回调，需进行手工关闭
          },
          success: function (layero) {
            layero.find('.layui-layer-btn').css('text-align', 'center')
          }
        });
      }
    });

  })

</script>

<%--修改成功提示内容--%>
<div class="fxtc" id="upInfoTip" style="display: none;">
  <div class="undefined">
    <a>
      <img src="/resources-sjn/index/images/bd_yes.png" />
      <span id="sucMessage">修改个人信息成功</span>
    </a>
  </div>
</div>

<%--修改密码成功提示内容--%>
<div class="fxtc" id="passTip" style="display: none;">
  <div class="undefined">
    <a>
      <img src="/resources-sjn/index/images/bd_yes.png" />
      <span id="passSucMsg"></span>
    </a>
  </div>
</div>
</body>
</html>