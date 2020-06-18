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
    .courses-code-select-box {
        padding: 20px 100px 0 100px;
    }

    .courses-code-item-box::after,
    .courses-code-select-box::after {
        clear: both;
        display: block;
        content: "";
    }

    .courses-code-dropdown {
        float: left;
        position: relative;
    }

    .courses-code-toggle {
        width: 300px;
        height: 38px;
        border: 1px solid #aaa;
        text-align: left;
        line-height: 40px;
        padding-left: 10px;
        border-radius: 5px;
        background: #fff;
    }

    .courses-code-text {
        float: left;
        font-size: 16px;
        color: #666;
    }

    .courses-code-icon {
        padding: 0 10px;
        width: 14px;
        height: 14px;
        float: right;
        margin-top: 12px;
        transition: all .3s;
    }

    .courses-code-date {
        float: right;
        font-size: 14px;
        margin-top: 10px;
        color: #FF6700;
    }

    .open .courses-code-icon {
        transform: rotate(180deg);
        color: #5583DB;
    }

    .courses-code-dropdown-menu {
        position: absolute;
        top: 36px;
        left: 0;
        width: 636px;
        border: 1px solid #aaa;
        border-radius: 5px;
        background: #fff;
        display: none;
        padding-bottom: 30px;
        max-height: 500px;
        overflow-y: auto;
    }

    .courses-code-item-box {
        margin: 0 100px;
    }

    .courses-code-item {
        width: 234px;
        height: 230px;
        background: #fff;
        box-shadow: 0px 0px 30px 0px rgba(215, 215, 215, 0.3);
        border-radius: 5px;
        margin-top: 20px;
        float: left;
        margin-right: 30px;
        cursor: pointer;
    }

    .courses-code-item-box .courses-code-item:nth-child(3n) {
        margin-right: 0;
    }

    .courses-code-cover {
        width: 233px;
        height: 149px;
        background: #eee;
    }

    .courses-code-progress {
        margin: 20px 14px 0 14px;
        overflow: hidden;
    }

    .courses-code-progress-box {
        width: 80px;
        height: 5px;
        background: #E0E0E0;
        border-radius: 3px;
        float: left;
        margin-top: 6px;
    }

    .courses-code-current-progress {
        height: 5px;
        background: #FF6700;
        border-radius: 3px;
    }

    .courses-code-progress-text {
        font-size: 0px;
        color: #333;
        float: right;
        margin: 0;
    }

    .courses-code-progress-text span {
        font-size: 12px;
    }

    .courses-code-num {
        color: #FF6700;
    }

    .courses-code-bottom {
        margin: 14px 14px 0 14px;
    }

    .courses-code-bottom p {
        font-size: 12px;
        color: #666666;
        float: left;
    }

    .courses-code-star {
        float: right;
    }

    .courses-code-star img {
        width: 13px;
        height: 13px;
        margin: 0 1px;
    }

    .courses-code-radio {
        display: inline-block;
        vertical-align: middle;
        width: 14px;
        height: 14px;
        margin-right: 14px;
        cursor: pointer;
        background: url("/resources/userCenter/images/radio.png") no-repeat;
    }

    .courses-code-radio-checked {
        background: url("/resources/userCenter/images/radio_checked.png") no-repeat;
    }

    .colorClasss .courses-code-radio {
        background-image: inherit;
        border: 1px solid #BFBFBF;
        border-radius: 7px;
        cursor: default;
    }

    .courses-code-dropdown-menu li {
        margin: 36px 30px 0 15px;
        overflow: hidden;
    }

    .courses-code-radio-box {
        overflow: hidden;
        float: left;
    }

    .colorClasss * {
        color: #BFBFBF !important;
    }

    .courses-code-radio-box label {
        font-size: 16px;
        color: #000;
        vertical-align: middle;
        margin: 0;
    }

    .courses-code-item-date {
        float: right;
        color: #FF6700;
        font-size: 12px;
    }

    .courses-code-list {
        width: 100%;
        box-sizing: border-box;
        overflow: hidden;
    }

    .courses-code-list span {
        display: inline-block;
        margin-top: 20px;
        font-size: 14px;
        color: #666;
        float: left;
        margin-right: 5%;
        width: 30%;
        overflow: hidden;
        text-overflow: ellipsis;
        white-space: nowrap;
    }

    .courses-code-list span:nth-child(3n) {
        margin-right: 0;
    }
</style>

<input type="hidden" id="commodities" value='${commodities}'>

<div class="userRight fr">
    <div class="userR-title">
        <a class="userR-cur" value="0">已兑换课程</a>
    </div>
    <div class="courses-code-select-box">
        <div class="dropdown courses-code-dropdown">
            <button class="courses-code-toggle" type="button" data-toggle="dropdown" aria-haspopup="true"
                    aria-expanded="false">
                <span class="courses-code-text"></span>
                <span class="glyphicon glyphicon-menu-down courses-code-icon"></span>
            </button>
            <ul class="dropdown-menu courses-code-dropdown-menu"></ul>
        </div>
        <p class="courses-code-date">2019 .12 .12 -2020.12. 12</p>
    </div>
    <div class="courses-code-item-box"></div>
</div>

<script>
    var renderData = JSON.parse($("#commodities").val());
    console.log(renderData)
    var htmlAll = '';
    var noneHTML = '<div class="userR-twnone"><img src="/resources/userCenter/images/noPic.png" width="160"><p>您还没有兑换课程</p></div>'
    if (renderData == '' || !renderData.length) {
        $('.courses-code-select-box').html(noneHTML)
    } else {
        for (var i = 0; i < renderData.length; i++) {
            if (i == 0) {
                $('.courses-code-text').text(renderData[i].commodityName);
                $('.courses-code-date').text(time(renderData[i]))
                htmlAll = htmlFunc(renderData[i], i, true)
                /** 默认显示第一项 */
                if (renderData[i].courseList.length > 0) {
                    renderItem(renderData[i])
                } else {
                    $('.courses-code-item-box').html(noneHTML)
                }
            } else {
                htmlAll += htmlFunc(renderData[i], i, false)
            }
        }
        $('.courses-code-dropdown-menu').html(htmlAll)
        $(document).off('click.radio').on('click.radio', '.courses-code-radio', function () {
            if ($(this).hasClass('courses-code-radio-checked') || $(this).parents('li').hasClass('colorClasss')) {
                if ($(this).parents('li').hasClass('colorClasss')) {
                    alertmsg('课程商品已过期');
                }
                return false;
            }
            var _index = Number($(this).attr('id'))

            $('.courses-code-text').text(renderData[_index].commodityName);
            $('.courses-code-date').text(time(renderData[_index]))

            $('.courses-code-radio').removeClass('courses-code-radio-checked')
            $(this).addClass('courses-code-radio-checked');
            renderItem(renderData[_index]);
        })
    }
    /** 跳转详情 */
    $(document).on('click', '.courses-code-item', function () {
        var detailId = $(this).attr('id');
        window.location.href = window.location.origin + '/course/play/' + detailId
    })

    /** 渲染 */
    function renderItem(item) {
        if (item.validStatus) {
            var _HTML = '';
            for (var k = 0; k < item.courseList.length; k++) {
                if (k == 0) {
                    _HTML = _HTMLfUNC(item.courseList[k])
                } else {
                    _HTML += _HTMLfUNC(item.courseList[k])
                }
            }
            if (item.courseList.length) {
                $('.courses-code-item-box').html(_HTML)
            } else {
                $('.courses-code-item-box').html(noneHTML)
            }
            $('.courses-code-date').css('color', '#FF6700')
        } else {
            $('.courses-code-item-box').html(noneHTML)
            $('.courses-code-date').css('color', '#BFBFBF')
        }
    }

    function _HTMLfUNC(item) {
        var progress = (item.finishLectureNum * 100) / item.lectureNum;
        var starHTML = null;
        for (var m = 0; m < 5; m++) {
            if (m < item.score) {
                if (m == 0) {
                    starHTML = '<img src="/resources/userCenter/images/star-01.png">'
                } else {
                    starHTML += '<img src="/resources/userCenter/images/star-01.png">'
                }
            } else {
                if (m == 0) {
                    starHTML = '<img src="/resources/userCenter/images/star-02.png">'
                } else {
                    starHTML += '<img src="/resources/userCenter/images/star-02.png">'
                }
            }
        }

        return '<div class="courses-code-item" id=' + item.id + ' >' +
            '<img class="courses-code-cover" src="' + item.coverUrl + '" alt="cover">' +
            '<div class="courses-code-progress">' +
            '<div class="courses-code-progress-box">' +
            '<div class="courses-code-current-progress" style="width:' + progress + '%"></div>' +
            '</div>' +
            '<p class="courses-code-progress-text">' +
            '<span>学习了</span>' +
            '<span class="courses-code-num">' + item.finishLectureNum + '</span>' +
            '<span>/' + item.lectureNum + '课程小节</span>' +
            '</p>' +
            '</div>' +
            '<div class="courses-code-bottom">' +
            '<p>学员：' + item.courseStuNum + '人</p>' +
            '<div class="courses-code-star">' + starHTML + '</div>' +
            '</div>' +
            '</div>'
    }

    /** 提示 */
    function alertmsg(content) {
        layer.open({
            title: '提示信息'
            , offset: '150px'
            , shadeClose: true
            , content: content
        });
    }

    /**
     * 格式化时间
     * @param {formater}         指定格式 YYYY-MM-DD HH:mm
     * @param {t}                时间戳
     */
    function dateFormater(str, t) {
        var date = t ? new Date(t) : new Date(),
            Y = date.getFullYear() + '',
            M = date.getMonth() + 1,
            D = date.getDate(),
            H = date.getHours(),
            m = date.getMinutes(),
            s = date.getSeconds();
        return str
            .replace(/YYYY|yyyy/g, Y)
            .replace(/YY|yy/g, Y.substr(2, 2))
            .replace(/MM/g, (M < 10 ? '0' : '') + M)
            .replace(/DD/g, (D < 10 ? '0' : '') + D)
            .replace(/HH|hh/g, (H < 10 ? '0' : '') + H)
            .replace(/mm/g, (m < 10 ? '0' : '') + m)
            .replace(/ss/g, (s < 10 ? '0' : '') + s);
    }

    function htmlFunc(item, index, checked) {

        var chaeckedClass = '';
        var courseHTML = '';
        var colorClasss = '';

        if (checked) {
            chaeckedClass = 'courses-code-radio-checked'
        }
        if (!item.validStatus) {
            colorClasss = 'colorClasss'
        }

        for (var j = 0; j < item.courseList.length; j++) {
            if (j == 0) {
                courseHTML = '<span>' + item.courseList[j].title + '</span>'
            } else {
                courseHTML += '<span>' + item.courseList[j].title + '</span>'
            }
        }
        return '<li class="' + colorClasss + '">' +
            '<div class="courses-code-radio-box">' +
            '<span id=' + index + ' class="courses-code-radio ' + chaeckedClass + '"></span>' +
            '<label>' + item.commodityName + '</label>' +
            '</div>' +
            '<p class="courses-code-item-date">' + time(item) + '</p>' +
            '<div class="courses-code-list">' + courseHTML +
            '</div></li>'
    }

    function time(item) {
        return ('有效期 ：' + dateFormater('YYYY.MM.DD', item.validityBeginTime) + '-' + dateFormater('YYYY.MM.DD', item.validityEndTime))
    }


</script>