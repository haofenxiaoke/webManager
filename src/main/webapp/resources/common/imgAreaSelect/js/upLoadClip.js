/*默认选区位置*/
var _x1=0,_y1=0,_x2=120,_y2=120;

function preview(img, selection) {
    position(selection.x1,selection.y1,selection.width,selection.height,img.width,img.height);
}

/**
 * *根据位置显示裁剪后的图片
 * form表单赋值
 * @param x
 * @param y
 * @param w
 * @param h
 * @param w1 缩放后图片宽度
 * @param h1 缩放后图片高度
 *
 */
function position(x,y,w,h,w1,h1){

    var lsize = 300;//左边图片显示大小 300*300
    var rsize = 120;//右边图片显示大小 120*120

    if (!w || !h) return;

    var scaleX = rsize/w;
    var scaleY = rsize/h;

    $('#preview img').css({
        width: (scaleX*w1),
        height: (scaleY*h1),
        marginLeft: -(scaleX*x),
        marginTop: -(scaleY*y)
    });

    //截取坐标位置
    var image = new Image();
    image.src = $('#src').val();
    var ow = image.width;
    var oh = image.height;

    var multiple = ow > oh ? (ow > lsize ? ow / lsize : 1):(oh > lsize ? oh/lsize:1);

    $('#x').val(Math.round(x*multiple));
    $('#y').val(Math.round(y*multiple));
    $('#w').val(Math.round(w*multiple));
    $('#h').val(Math.round(h*multiple));
}

//上传裁剪后的图像文件
function saveFunc() {
    var imgpath;
    $.ajax({
        url:'/upload/clip',
        type:"post",
        dataType:"json",
        cache: false,
        async: false,
        data :$('#clip-id').serialize(),
        success: function (datas){
            if (datas.code == HttpUtil.success_code) {
                imgpath =  datas.result;
            }
        }
    })
    return imgpath;
}

/**
 * 缩放显示图片
 * @param imgId 绑定事件选择器ID
 * @constructor
 */
function ZoomImage(ImgID) {
    var size = 300;
    var img_w = $("#" + ImgID).width();
    var img_h = $("#" + ImgID).height();

    if (img_w > 0 && img_h > 0) {

        //缩放倍数
        var multiple = img_w > img_h ? (img_w > size ?(img_w / size) : 1) : (img_h > size ?(img_h / size) : 1);

        var width = img_w / multiple; //宽度等比缩放
        var height = img_h / multiple; //高度等比缩放

        $("#" + ImgID).css({"width": width, "height": height});//设置缩放后的宽度和高度

        $('#img-origin').imgAreaSelect({ aspectRatio: '1:1', handles: true,
            fadeSpeed: 200, onSelectChange: preview,x1: _x1, y1: _y1, x2: _x2, y2: _y2 });

        position(_x1,_y1,_x2-_x1,_y2-_y1,width,height);

    }
}