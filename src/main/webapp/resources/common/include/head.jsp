<%@ page language="java"  pageEncoding="UTF-8" contentType="text/html; UTF-8" import="com.kjs.common.util.ParamUtil" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<html>
<head>
    <meta charset="UTF-8" />
    <title></title>
    <link href="/resources/common/css/rest.css" rel="stylesheet">
    <style>
        .headerBg{background-color: #2e323e;width:100%;height: 50px;}
        .head_center {
            width: 1226px;
            margin: 0px auto;
            height: 50px;;
        }

        .head_center div {
            float: left;
        }

        .head_menu{
            height: 30px;
            line-height: 30px;
            font-size: 14px;
            padding-top: 10px;
            color: #ffffff;
            width: 45%;
            margin-left: 100px;
        }
        .head_logo {
            height: 30px;
            padding-top: 10px;
        }

        .head_logo div {
            width: 100%;
        }

        .head_menu span{
            margin-right: 5%;
        }

        .head_menu a{
            color: #ffffff;
            text-decoration: none;
        }

        .head_search{
            float: right !important;
        }
        .search{
            background-color: #ffffff;
            margin-top:10px;
            height: 30px;
            width: 200px;
            border-radius: 5px;
        }

        .search img{
            float: left;
            margin: 5px;
        }

        .search input{
            float: left;
            border: 0px;
            margin-top: 7px;
            outline: none;
        }

        .head_login{
            margin-left: 20px;
            margin-top: 15px;
            color: #ffffff;
        }

        .head_login a{
            color: #ffffff;
            font-size: 12px;
            text-decoration: none;
        }
    </style>
</head>
<body>
<div class="headerBg">
    <div class="head_center">
        <div class="head_logo">
            <img src="../images/trh.png" alt="" height="30"/>
        </div>
        <div class="head_menu">
            <span><a href="#">首页11</a></span>
            <span><a href="#">课程</a></span>
            <span><a href="#">直播</a></span>
            <span><a href="#">学员好评</a></span>
            <span><a href="#">开通会员</a></span>
        </div>
        <div class="head_search">
            <div class="search">
                <img src="../images/courseInfo_search.png" height="20" alt=""/>
                <input type="text" placeholder="你希望学什么?" />
            </div>
            <div class="head_login">
                <a href="javascript:void(0)">登录</a>&nbsp;|&nbsp;<a href="javascript:void(0)">注册</a>
            </div>
        </div>
    </div>
</div>
</body>
</html>