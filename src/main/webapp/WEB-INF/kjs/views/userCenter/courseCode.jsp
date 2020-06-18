<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2019/8/1 0001
  Time: 15:03
  To change this template use File | Settings | File Templates.
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<style>
    .course-code-box {
        width: 564px;
        margin: 35px 0 0 30px;
        background: rgba(255, 255, 255, 1);
        box-shadow: 0px 0px 30px 0px rgba(215, 215, 215, 0.3);
        border-radius: 10px;
    }

    .course-code-input-box {
        padding-top: 47px;
        position: relative;
    }

    .course-code-input-box:after {
        content: '';
        display: block;
        clear: both;
    }

    .course-code-label {
        font-size: 16px;
        color: #666;
        font-weight: inherit;
        vertical-align: middle;
        padding: 0 30px 0 17px;
        float: left;
        line-height: 40px;
    }

    .course-code-input-warp {
        float: left;
        position: relative;
    }

    .course-code-input-warp:hover .course-code-cancel {
        display: inline-block;
    }

    .course-code-input {
        width: 300px;
        height: 40px;
        font-size: 16px;
        padding: 0 10px;
        color: #666;
        border: 1px solid #BFBFBF;
        border-radius: 3px;
        vertical-align: middle;
        transition: all .3s;
    }

    .course-code-cancel {
        width: 18px;
        height: 18px;
        position: absolute;
        top: 50%;
        right: 10px;
        margin-top: -9px;
        z-index: 10;
        cursor: pointer;
        display: none;
    }

    .course-code-msg {
        position: absolute;
        left: 178px;
        top: 100px;
        font-size: 14px;
        z-index: 1;
        color: #FF0000;
    }

    .course-code-button {
        width: 180px;
        height: 40px;
        background: #BFBFBF;
        border-radius: 3px;
        margin: 63px 0 0 175.09px;
        outline: none;
        border: none;
        font-size: 14px;
        color: #fff;
        transition: all .3s;
    }

    .course-code-btn {
        background: #5583DB;
    }

    .course-code-tip {
        margin: 45px 2px 0 2px;
        padding: 30px 34px;
        border-top: 1px solid #F3F8FF;
    }

    .course-code-title {
        font-size: 16px;
        color: #666;
        line-height: 1;
    }

    .course-code-item {
        font-size: 16px;
        color: #666;
        line-height: 1;
        margin-top: 20px;
    }
</style>
<div class="userRight fr">
    <div class="userR-title">
        <a class="userR-cur" value="0">课程码</a>
    </div>
    <div class="course-code-box">
        <div class="course-code-input-box">
            <label class="course-code-label">输入12位课程码：</label>
            <div class="course-code-input-warp">
                <input class="course-code-input" maxlength="12" type="text">
                <img class="course-code-cancel" src="/resources/common/images/cancel.png" alt="">
            </div>
            <p class="course-code-msg"></p>
        </div>
        <button class="course-code-button" type="button">兑换课程码</button>
        <div class="course-code-tip">
            <p class="course-code-title">温馨提示：</p>
            <p class="course-code-item">1.会计狮课程码不记名、不挂失、不计息、不兑换金额。</p>
            <p class="course-code-item">2.兑换课程仅限指定课程，不可更换。</p>
            <p class="course-code-item">3.已兑换课程可能存在课程下架或者内容变更的情况，请及时观看。</p>
        </div>
    </div>
</div>

<script>
    /*提示*/
    function alertmsg(content) {
        layer.open({
            title: '提示信息'
            , offset: '150px'
            , shadeClose: true
            , content: content
        });
    }

    $('.course-code-input').bind('input propertychange', function () {
        if ($(this).val().length == 12) {
            $('.course-code-button').addClass('course-code-btn')
        } else {
            $('.course-code-button').removeClass('course-code-btn')
            $('.course-code-msg').text('')
            $('.course-code-input').css('border-color', '#BFBFBF')
        }
    })
    $('.course-code-input').focus(function () {
        $(this).css('border-color', '#5583DB')
    })
    $('.course-code-input').blur(function () {
        $(this).css('border-color', '#BFBFBF')
    })
    $('.course-code-cancel').click(function () {
        $('.course-code-input').val('')
    })
    var flag = true;
    $(document).on('click', '.course-code-btn', function () {
        if (flag) {
            flag = false;
            $.post('/ticket/exchange', {code: $('.course-code-input').val()}).done(function (res) {
                flag = true;
                if (res.success) {
                    alertmsg('课程码兑换成功');
                    $('.course-code-input').val('')
                } else {
                    $('.course-code-msg').text(res.message)
                    $('.course-code-input').css('border-color', '#FF0000')
                }
            })
        }
    })
</script>



