<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>预览文件</title>
    <#include "../resource.ftl">
</head>
<body class="layui-layout-body">
<div class="layui-layout layui-layout-admin">
<#include "../dashboard_top_menus.ftl">
    <div class="layui-side layui-bg-black">
        <div class="layui-side-scroll">
            <!-- 左侧导航区域（可配合layui已有的垂直导航） -->
            <ul class="layui-nav layui-nav-tree"  lay-filter="test">

            <#--<@resource_check url="/review">-->
                <li class="layui-nav-item layui-side-item"><a id="review" href="javascript:;"><img src="/css/img/icon_my_task_default.png" class="layui-nav-side-img">待办任务</a></li>
            <#--</@resource_check>-->

                    <#if user??>
                        <#if user.operator??>
                        <#if user.operator=='operator'>
                        <li class="layui-nav-item layui-side-item"><a id="reviewAll" href="javascript:;"><img src="/css/img/icon_all_tasks_default.png" class="layui-nav-side-img">所有任务</a></li>
                        </#if>
                        </#if>
                    </#if>

            </ul>
        </div>
    </div>


    <div class="layui-body">
        <!-- 内容主体区域 -->
        <div class="layui-tab" lay-filter="tabBody" lay-allowclose="true" style="margin-top: 0;">
            <ul class="layui-tab-title" style="visibility:hidden;height: 0px">
            </ul>
            <div class="layui-tab-content layui-col-md-12" id="content" lay-filter="tabTable">
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
        OpenFile("/getAttachFile?id="+id);

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



        $("#review").click(function () {

                    view.goto('/review');


                }
        );



        $("#reviewAll").click(function () {

            view.goto('/review');


                }
        );


        //  $("#review").click();



        // var $ = layui.jquery
        //         ,element = layui.element //Tab的切换功能，切换事件监听等，需要依赖element模块
        //         ,itenderUser = layui.itenderUser;

        // $('.layui-side-item').on('click',function () {
        //     var othis = $(this);
        //     var id = othis.attr("id"); //左侧导航栏id
        //     var uri = othis.data("uri"); //新标签页URI
        //     var title = othis.text(); //新标签页标题
        //     console.log(othis);
        //     //
        //     // element.tabDelete('tabBody', id);//删除旧的已存在Tap
        //     // itenderUser.addNewTab(id,uri,title,'tabBody');//新建新标签页
        // });

    });
</script>

<style>

    .layui-nav .layui-side-item a {
        color: #464646;
    }


    /*.layui-this, .layui-nav-tree .layui-nav-child dd.layui-this a, .layui-nav-tree .layui-this, .layui-nav-tree .layui-this>a, .layui-nav-tree .layui-this>a:hover {*/
    /*background-color: #f6f6f6;*/
    /*color: #0154AD;*/
    /*}*/


    .layui-nav-side-img {
        width: 20px;
        height: 20px;
        margin-right: 2px;
        border-radius: 0%;
    }
    .layui-bg-black {
        background-color: #f6f6f6!important;
    }
    .layui-nav {
        background-color: #f6f6f6;
    }
    .layui-this a{
        color: #f6f6f6!important;
    }
</style>
</html>

