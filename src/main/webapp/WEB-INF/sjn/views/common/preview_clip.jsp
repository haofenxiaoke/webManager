<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>图像裁剪</title>
  <link rel="stylesheet" type="text/css" href="${basePath}/resources/common/imgAreaSelect/css/index.css"/>
  <link rel="stylesheet" type="text/css" href="${basePath}/resources/common/imgAreaSelect/css/imgareaselect-animated.css" />
  <script type="text/javascript" src="${basePath}/resources/common/js/jquery-1.9.1.js"></script>
  <script type="text/javascript" src="${basePath}/resources/common/imgAreaSelect/js/upLoadClip.js"></script>
  <script type="text/javascript" src="${basePath}/resources/common/imgAreaSelect/js/jquery.imgareaselect.pack.js"></script>
  <style>
    .layui-layer-title{background: #f7f9fa!important;}
  </style>
</head>
<body style="margin:0;padding:0;height: auto;">
<div class="container demo" style="width:560px;height:290px;padding:20px;">
  <div style="float: left; border-right:1px solid #eee;padding-right:20px;">
    <div class="frame" style="margin-left:0em; width: 300px;max-height: 300px;">
      <img id="img-origin" src="${imgUrl}" onload="ZoomImage(this.id);"/>
    </div>
  </div>

  <div style="float: left; width: 235px;text-align: center;">
    <p style="font-size:14px;color:#666;margin-bottom:10px;">预览</p>
    <div class="frame" style=" width: 120px; height: 120px;margin:0 auto;">
      <div id="preview" style="width: 120px; height: 120px; overflow: hidden;border-radius: 50%;border:2px solid #ddd;">
        <img src="${imgUrl}"/>
      </div>
    </div>

    <table style="margin-top: 1em;">
      <thead>
      <tr>
        <th colspan="2" style="font-size: 110%; font-weight: bold; text-align: left; padding-left: 0.1em;">
          <form id="clip-id" method="post">
            <input type="hidden" name="x" id="x" value="" />
            <input type="hidden" name="y" id="y" value="" />
            <input type="hidden" name="w" id="w" value="" />
            <input type="hidden" name="h" id="h" value="" />
            <input type="hidden" name="src" id="src" value="${imgUrl}" />
          </form>
        </th>
      </tr>
      </thead>

    </table>

  </div>
</div>

</body>
</html>