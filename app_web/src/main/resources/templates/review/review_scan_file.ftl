<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>预览文件</title>
    <#include "../resource.ftl">
</head>
<body class="layui-layout-body">
<div class="layui-layout layui-layout-admin">


         <div class="layui-container">
                    <fieldset class="layui-elem-field layui-field-title">
                        <legend>预览文件</legend>
                    </fieldset>


                    <div class="usBox main" style="padding: 3px;height:560px;" id="assignBox">
                        <script type="text/javascript" src="/aip/LoadAip.js"></script>


                        <!--该事件在AIP引擎初始化完毕之后触发-->
                        <SCRIPT LANGUAGE=javascript FOR=HWPostil1 EVENT=NotifyCtrlReady>
                            HWPostil1_NotifyCtrlReady();
                        </SCRIPT>

                    </div>


                </div>
            </div>


</div>
</body>

<script type="text/javascript" src="/aip/AipMain.js"></script>
<script>
    var h = $(window).innerHeight();
    $("#assignBox").height(h - 200);

    function HWPostil1_NotifyCtrlReady() {

        document.all.HWPostil1.HideMenuItem(30);
        var id = "${(attach.id)!}";
        var path = "${(attach.path)!}";
        console.log("file path="+path);
        OpenFile(path);

    }

    function strToJson(str) {
        var json = eval('(' + str + ')');
        return json;
    }


</script>

<script>
    layui.use(['element','itenderUser'], function(){


        layui.element.on('nav(test)', function(elem){
            //替换图片
            var imglist = $(".layui-nav-tree").find("img");
            imglist.each(function (index,element) {
                var imgsrc = $(this).attr("src");
                imgsrc = imgsrc.replace("select","default");
                $(this).attr("src",imgsrc);
            });
            var oimg = elem.find("img");
            var oimgsrc = oimg.attr("src");
            oimgsrc = oimgsrc.replace("default","select");
            oimg.attr("src",oimgsrc);
        });



    });
</script>

<style>


</style>
</html>

