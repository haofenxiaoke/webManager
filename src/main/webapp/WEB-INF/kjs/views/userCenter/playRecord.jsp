<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%--
  Created by IntelliJ IDEA.
  User: chaishuxiang
  Date: 2016/7/11 0011
  Time: 上午 11:06
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="zh">
<head>
  <link href="/resources/userCenter/css/playRec.css" rel="stylesheet">
  <script src="/resources/userCenter/js/user.js"></script>
  <script src="/resources/userCenter/js/playRecord.js"></script>
  <script src="/resources/userCenter/js/messageClick.js"></script>
</head>
<body>
<input type="hidden" id="userid" value="${user.id}">
<input type="hidden" id="vipid" value="${userVip.vipId}">
  <div class="userRight fr">
    <div class="userR-title">
      <a class="userR-cur">播放记录</a>
    </div>
    <div class="userR-con">
      <div class="userR-zccount">
        <div style="display:block" id="hasRecords">
          <div class="studyZl" id="records">
            <div class="clearfloat">
              <div class="playRec-left fl">
                <p>${today} </p>
                <span>今天</span>
              </div>
              <div class="kjsCrouse fl kjs_" style="width: 730px;">
                <div class="play-list">
                  <i class="restIcon paly-yd"></i>
                  <ul class="clearfloat" id="today">

                  </ul>
                </div>
              </div>
            </div>
            <div class="clearfloat">
              <div class="playRec-left fl">
                <p>${yesterday}</p>
                <span>昨天</span>
              </div>
              <div class="kjsCrouse fl kjs_	" style="width: 730px;">
                <div class="play-list">
                  <i class="restIcon paly-yd"></i>
                  <ul class="clearfloat" id="yesterday">

                  </ul>
                </div>
              </div>
            </div>
            <div class="clearfloat">
            <div class="playRec-left fl">
              <p></p>
              <span>一周内</span>
            </div>
            <div class="kjsCrouse fl kjs_" style="width: 730px;">
              <div class="play-list">
                <i class="restIcon paly-yd"></i>
                <ul class="clearfloat" id="inWeek">

                </ul>
              </div>
            </div>
          </div>
            <div class="clearfloat">
              <div class="playRec-left fl kjs_">
                <p></p>
                <span>一月内</span>
              </div>
              <div class="kjsCrouse fl" style="width: 730px;">
                <div class="play-list">
                  <i class="restIcon paly-yd"></i>
                  <ul class="clearfloat" id="inMonth">

                  </ul>
                </div>
              </div>
            </div>
          </div>

        </div>
      </div>
    </div>
  </div>
</body>
</html>
