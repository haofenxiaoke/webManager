<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<html>
<head>
  <title>在线阅读</title>
  <meta name="viewport" content="initial-scale=1,user-scalable=no,maximum-scale=1,width=device-width" />
  <style type="text/css" media="screen">
    html, body	{ height:100%;}
    body { margin:0; padding:0; overflow:auto; }
  </style>
  <script src="/resources/common/js/jquery-1.9.1.js"></script>
  <link rel="stylesheet" type="text/css" href="${basePath}/resources/common/FlexPaper/css/flexpaper.css"/>
  <script type="text/javascript" src="${basePath}/resources/common/FlexPaper/js/jquery.extensions.min.js"></script>
  <script type="text/javascript" src="${basePath}/resources/common/FlexPaper/js/flexpaper.js"></script>
  <script type="text/javascript" src="${basePath}/resources/common/FlexPaper/js/flexpaper_handlers.js"></script>


  <script type="text/javascript">
    var consultDate;
    $(function () {

      var swfUrl = '${lecture.lectureConverswfUrl}';
      var pdfUrl = '${lecture.lecturePptUrl}';
//      swfUrl = '/resources/common/FlexPaper/{Paper[*,0].swf,7}';
//      pdfUrl = '/resources/common/FlexPaper/FlexPaper.pdf';
      var scale = /msie/.test(navigator.userAgent.toLowerCase())?1.26:0.5;
      loadSwf(swfUrl, pdfUrl,scale);

    })

    function loadSwf(swfUrl,pdfUrl,scale) {

      $('#documentViewer').FlexPaperViewer(
              { config:
              {
                SWFFile: swfUrl,
                PDFFile: pdfUrl,
                key: "$98a11cac64dcb843587",
                Scale: scale,//缩放比例
                ZoomTransition: 'easeOut',
                ZoomTime: 0.5,
                ZoomInterval: 0.2,
                FitPageOnLoad: false,
                FitWidthOnLoad: false,
                FullScreenAsMaxWindow: true,
                ProgressiveLoading: false,
                MinZoomSize: 0.2,//最小的缩放比例
                MaxZoomSize: 5,//设置最大的缩放比例
                SearchMatchAll: false,
                InitViewMode: 'Portrait',
                RenderingOrder: 'html5,flash',
                StartAtPage: '',
                ViewModeToolsVisible: true,
                ZoomToolsVisible: true,
                NavToolsVisible: true,
                CursorToolsVisible: true,
                SearchToolsVisible: true,

                WMode: 'window',
                localeChain: 'zh_CN',
                jsDirectory: '${basePath}/resources/common/FlexPaper/js/',
                cssDirectory: '${basePath}/resources/common/FlexPaper/css/',
                localeDirectory: '${basePath}/resources/common/FlexPaper/locale/'
              }
              });
    }
  </script>
</head>
<body>
<div style="height: 50px;"></div>
<div id="documentViewer" class="flexpaper_viewer" style="z-index: 1;width:95%;margin:0px auto;">
</div>
<div style="height: 50px;"></div>
<script language="javascript" type="text/javascript">
  NTKF_PARAM = {
    siteid: "kf_9751",              //企业id
    settingid: "kf_9751_1431594125839",           //应答客服组id，在客户端生成代码界面创建
    uid: "${SESSION_USER.id!=''?SESSION_USER.id:''}",                //用户id，登录用户必填，游客为空字符串
    uname: "${SESSION_USER.displayName!=''?SESSION_USER.displayName:''}",             //用户名，登录用户必填，游客为空字符串
    isvip: "0",            //是否为vip用户，登录用户可选，游客为"0"
    userlevel: ""   //网站用户级别，登录用户可选，游客不填
  }
</script>
<script type="text/javascript" src="http://dl.ntalker.com/js/xn6/ntkfstat.js?siteid=kf_9751" charset="utf-8"></script>
<script>
  var consultDate;
</script>
</body>
</html>