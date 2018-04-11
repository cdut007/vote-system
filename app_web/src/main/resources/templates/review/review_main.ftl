<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>待办任务列表</title>
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
        <li class="layui-nav-item layui-side-item"><a id="review" href="javascript:;"><img src="/css/img/icon_room_default.png" class="layui-nav-side-img">待办任务</a></li>
          <#--</@resource_check>-->

            </ul>
        </div>
    </div>


    <div class="layui-body">
        <!-- 内容主体区域 -->
        <div class="layui-tab" lay-filter="tabBody" lay-allowclose="true" style="margin-top: 0;">
            <ul class="layui-tab-title" style="visibility:hidden">
            </ul>
            <div class="layui-tab-content layui-col-md-12" id="content" lay-filter="tabTable">
            </div>
        </div>

    </div>

</div>
</body>

<script>
    layui.use(['element','itenderUser'], function(){
      //  var $ = layui.jquery ;

        setTimeout(function(){
            var doc = $('li .layui-this');
            doc.each(function (i) {
                var a = $(this);
                var img = a.children('img').eq(0);
                var href = a.attr('href');
                if(href == '/review'){
                    img.attr("src","/css/img/icon_equipment_selected.png");
                }else if( href == '/log'){
                    img.attr("src","/css/img/icon_record_selected.png");

                }
                a.css("color","#fff");

                // img.hover(
                //         function () {
                //             var imgsrc = img.attr("src");
                //             imgsrc = imgsrc.replace("default","selected");
                //             img.attr("src",imgsrc);
                //         },
                //         function () {
                //
                //         }
                // );

                console.log(href); //得到当前点击的DOM对象

            })
        },50);


        $("#review").click(function () {


            $.ajax({
                url: '/review/review_list',
                type:"GET",
                cache:false,
                success: function (res) {
                    //console.log(res);
                    // $('#content').html(res);
                    layui.element.tabDelete('tabBody', 'list-review');
                    layui.element.tabAdd('tabBody', {//添加新Tap
                        title:'审批管理',
                        content: res
                        ,id: 'list-review'
                    });
                    layui.element.tabChange('tabBody', 'list-review');

                },
                error: function (xmlHttpReq, error, ex) {

                }
            })


                }
        );

        $("#review").click();



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