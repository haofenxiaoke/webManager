/**
 * Created by admin on 2017/7/17.
 */
(function (window) {

    function init() {
       $("#menuSubmit").click(function(){
           var option= $("input:checked").val();
           var date={ "option":option}
           $.ajax({
               url:"/video/config/update",
               type:"POST",
               data:date,
               dataType: "json",
               success:function(e){
                   BootstrapDialog.alert(e.result);
               }
           })
       })
    }
    window.page={
        init:function(){
            init()
        }
    }

})(window)