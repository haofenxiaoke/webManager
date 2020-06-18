var adminLogTable;
var tempObj = "";//存上次展开的对象
var tempIndex = 0;//存上次展开的行号
var count = true;
var operTypeMap;

var findObj = $("#find");

//时间选择器
var operTime =  $("#operTime").daterangepicker({
    format:'YYYY-MM-DD',//格式化日期
    showDropdowns:true,//显示年与月的选择框
    minDate:"2010-01-01",//最小日期
    maxDate:"2020-12-31",//最大日期
    applyClass: 'btn-success',//应用按钮class
    cancelClass: 'btn-warning',//取消按钮class
    separator:"/",
    ranges: {
        '今天': [moment(), moment()],
        '昨天': [moment().subtract(1, 'days'), moment().subtract(1, 'days')],
        '一周内': [moment().subtract(7, 'days'), moment()],
        '30天内': [moment().subtract(30, 'days'), moment()],
        '本月': [moment().startOf('month'), moment().endOf('month')],
        '上个月': [moment().subtract(1, 'month').startOf('month'), moment().subtract(1, 'month').endOf('month')]
    },
    locale: {
        applyLabel: '保存',
        cancelLabel: '取消',
        fromLabel: '起始时间',
        toLabel: '结束时间',
        customRangeLabel: '选择日期',
        daysOfWeek: ['周日','周一', '周二', '周三', '周四', '周五', '周六'],
        monthNames: ['一月', '二月', '三月', '四月', '五月', '六月', '七月', '八月', '九月', '十月', '十一月', '十二月']
    }
});
//选择取消按钮时
$("#operTime").on('cancel.daterangepicker', function(ev, picker) {
    $(this).val('');
});


findObj.click(function () {
    findObj.attr('disabled',true);
    adminLogTable.ajax.reload(null,false);
});


//监听所有折叠标志 对整个table监听
$('#adminLog-table').on('click', 'span.glyphicon', function (e) {
    //获取行对象
    var tr = $(this).closest('tr');

    var index = tr.find("td").eq(0).html(); //行号

    //具体点击对象
    var obj = $(e.target).parent();
    //row对象
    var row = adminLogTable.row(tr);

    //第一次初始化赋值
    if(count){
        tempIndex = index;
        tempObj = row.child;
        count = false;
    }

    //如果本次展开行和原来的对象不一样把原来的收起来
    if (index != tempIndex) {
        tempObj.hide();
    }

    //把所有的先收起 ,避免一行多个个收起按钮
    $('.glyphicon').removeClass().addClass("glyphicon glyphicon-plus").html("展开");

    //如果是展开状态
    if (row.child.isShown()) {

        // This row is already open - close it
        //改变标志提示内容，收起对象
        obj.html("<span class='glyphicon glyphicon-plus'>展开</span>"+obj.data("cont"));
        row.child.hide();
    }
    else {
        //展开时把当前行付给tempIndex
        tempIndex = index;
        tempObj = row.child;
        // Open this row
        //改变标志提示内容，展开对象
        obj.html("<span class='glyphicon glyphicon-minus'>收起</span>"+obj.data("cont"));
        row.child(format(row.data(), obj.data("name"))).show();
    }

});

//传入行内数据，和要显示的详细内容
function format(d,name) {
    var temp = "";
    if(name=="operName"){
        temp+= '<td width="6%">调用方法:</td><td style="word-wrap:break-word;word-break:break-all;" width="94%"> ' + d.operName + '</td>' ;
    }
    if(name=="operParam"){
        temp+= '<td width="6%">传递参数:</td><td style="word-wrap:break-word;word-break:break-all;" width="94%">' + d.operParam + '</td>';
    }
    //展开的表格数据处理
    return '<table cellpadding="5" cellspacing="0" border="0" width="100%" style="table-layout: fixed"><tbody>' +
        '<tr>' +
        temp
        + '</tr>' +
        '</tbody></table>';
}