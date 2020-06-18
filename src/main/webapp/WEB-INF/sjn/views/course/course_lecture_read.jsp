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
  <link rel="stylesheet" type="text/css" href="${basePath}/resources/common/FlexPaper/css/flexpaper.css"/>
  <script type="text/javascript" src="${basePath}/resources/common/FlexPaper/js/jquery.extensions.min.js"></script>
  <script type="text/javascript" src="${basePath}/resources/common/FlexPaper/js/flexpaper.js"></script>
  <script type="text/javascript" src="${basePath}/resources/common/FlexPaper/js/flexpaper_handlers.js"></script>
  <script type="text/javascript">
    $(function () {

      var swfUrl = '${lecture.lectureConverswfUrl}';
      var pdfUrl = '${lecture.lecturePptUrl}';
//      swfUrl = '/resources/common/FlexPaper/{Paper[*,0].swf,7}';
//      pdfUrl = '/resources/common/FlexPaper/FlexPaper.pdf';
      loadSwf(swfUrl, pdfUrl);
    })


    function loadSwf(swfUrl,pdfUrl) {

      $('#documentViewer').FlexPaperViewer(
              { config:
              {
                SWFFile: swfUrl,
                PDFFile: pdfUrl,
                key: "$98a11cac64dcb843587",
                Scale: 0.5,//缩放比例
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
</body>
</html>