var md5_key = 'duiaNiuBi)JN#ERFGBN';

/**
 * 将表单序列化为json对象
 * @param 表单的id
 * @returns {{}}
 */
function fromToJson(form) {
    var result = {"client": 3, "uuid": Util.createUuid(32, 16)};
    var fieldArray = $('#' + form).serializeArray();
    for (var i = 0; i < fieldArray.length; i++) {
        var field = fieldArray[i];
        if (field.name in result) {
            result[field.name] += ',' + field.value;
        } else {
            result[field.name] = field.value;
        }
    }
    return result;
}

/**
 * 去除空格
 * @param str
 * @returns {*}
 */
function trim(str) {
    if (typeof str !== "string") {
        return str;
    }
    if (typeof str.trim === "function") {
        return str.trim();
    } else {
        return str.replace(/^(\u3000|\s|\t|\u00A0)*|(\u3000|\s|\t|\u00A0)*$/g, "");
    }
}

/**
 * 空字符串判断
 * @param obj
 * @returns {boolean}
 */
function isEmpty(obj) {
    if (obj === undefined) {
        return true;
    } else if (obj == null) {
        return true;
    } else if (typeof obj === "string") {
        if (trim(obj) == "") {
            return true;
        }
    }
    return false;
}

/**
 * 生成uuid
 * @param len
 * @param radix
 * @returns {string}
 */
function createUuid(len, radix) {
    var chars = '0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz'.split('');
    var uuid = [], i;
    radix = radix || chars.length;
    if (len) {
        for (i = 0; i < len; i++) uuid[i] = chars[0 | Math.random() * radix];
    } else {
        var r;
        uuid[8] = uuid[13] = uuid[18] = uuid[23] = '-';
        uuid[14] = '4';
        for (i = 0; i < 36; i++) {
            if (!uuid[i]) {
                r = 0 | Math.random() * 16;
                uuid[i] = chars[(i == 19) ? (r & 0x3) | 0x8 : r];
            }
        }
    }
    $.cookie('recordId', uuid.join(''),{path:"/",domain:"duia.com"});
    return uuid.join('');
}

/**
 * 拼接参数
 * @param data
 * @returns {string}
 */
function appendParams(data) {
    var paramStr = '';
    if (data != null && data != '') {
        paramStr = sortParam(data);
    }
    return paramStr;
}

/**
 * 参数排序
 * @param data
 */
function sortParam(data) {
    var arr = new Array();
    var arrIndex = 0;
    for (var key in data) {
        arr[arrIndex] = key;
        arrIndex++;
    }
    arr = arr.sort();
    var params = '';
    for (var i = 0; i < arrIndex; i++) {
        if (i == 0) {
            params += arr[i] + "=" + data[arr[i]];
        } else {
            params += "&" + arr[i] + "=" + data[arr[i]];
        }
    }
    return params;
}

/**
 * 参数加密
 * @param paramStr
 * @returns {*}
 */
function getSign(paramStr) {
    if (!isEmpty(paramStr)) {
        console.log(paramStr);
        console.log(paramStr+md5_key);
        return md5(paramStr + md5_key);
    }
}

function getSingByNoKey(paramStr){
    if (!isEmpty(paramStr)) {
        return md5(paramStr);
    }
}