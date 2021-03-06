<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" isErrorPage="true" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta charset="utf-8">
    <title>好分小课-500</title>
    <style type="text/css">
        * {
            margin: 0;
            padding: 0;
            font-family: "微软雅黑";
        }

        img {
            border: 0;
        }

        a {
            text-decoration: none;
        }

        input {
            outline: none;
        }

        li {
            list-style-type: none;
        }

        body {
            background: #eef3fa;
        }

        .Find {
            width: 500px;
            height: 320px;
            position: fixed;
            top: 50%;
            left: 50%;
            margin-top: -160px;
            margin-left: -250px;
        }

        .Find-img {
            height: auto;
            overflow: hidden;
            margin: 0px auto;
        }

        .Find p {
            font-size: 24px;
            color: #333333;
            text-align: center;
            margin-top: 35px;
        }

        .Z-btn {
            height: auto;
            overflow: hidden;
            text-align: center;
            margin-top: 35px;
        }

        .Z-btn input {
            border: none;
            outline: none;
            width: 180px;
            height: 40px;
            border-radius: 3px;
            background: #5583db;
            color: #fff;
        }

        .Z-btn input:hover {
            background: #3b5b98;
        }
    </style>
</head>
<body>
<div class="Find">
    <div class="Find-img">
        <img src="${basePath}/resources/error/images/500_03.png"/>
    </div>
    <p>抱歉~你指定的页面无法访问！</p>
    <div class="Z-btn">
        <input type="button" value="返回首页"onclick="returnIndex();" />
    </div>
</div>
<script>
    function returnIndex(){
        window.location.href="/";
    }
</script>
</body>
</html>