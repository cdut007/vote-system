<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <title>招投标预发系统 - 用户</title>
    <#include "../resource.ftl">
    <style>
        .layui-tab-title .layui-this:after{
            border-radius: 0px;
        }
        .layui-nav .layui-side-item a {
            color: #464646;
        }
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

</head>
<body class="layui-layout-body">

<div class="layui-layout layui-layout-admin">
<#include "../dashboard_top_menus.ftl">
    <div class="layui-side layui-bg-black">
        <div class="layui-side-scroll">
            <!-- 左侧导航区域（可配合layui已有的垂直导航） -->
            <ul class="layui-nav layui-nav-tree"  lay-filter="userNav">
                <@resource_check url="/management/user/listUser">
                    <li class="layui-nav-item layui-side-item" id="list-user" data-uri="/management/user/listUser">
                        <a class="" href="javascript:;"><img src="/css/img/icon_user_default.png" class="layui-nav-side-img">用户管理</a>
                        <#--<dl class="layui-nav-child">-->
                            <#--<dd id="list-user" data-uri="/management/user/listUser"><a href="javascript:;" style="color: #016EC5">用户列表</a></dd>-->
                        <#--</dl>-->
                    </li>
                </@resource_check>
                <@resource_check url="/management/role">
                    <li class="layui-nav-item layui-side-item" id="list-role" data-uri="/management/role/listRole">
                        <a href="javascript:;"><img src="/css/img/icon_character_default.png" class="layui-nav-side-img">角色管理</a>
                        <#--<dl class="layui-nav-child">-->
                            <#--<dd id="list-role" data-uri="/management/role/listRole"><a href="javascript:;" style="color: #016EC5">角色列表</a></dd>-->
                        <#--</dl>-->
                    </li>
                </@resource_check>
                <@resource_check url="/management/privilege">
                    <li class="layui-nav-item layui-side-item" id="list-privilege" data-uri="/management/privilege/listPrivilege">
                        <a href="javascript:;"><img src="/css/img/icon_limit_default.png" class="layui-nav-side-img">权限管理</a>
                        <#--<dl class="layui-nav-child">-->
                            <#--<dd id="list-privilege" data-uri="/management/privilege/listPrivilege"><a href="javascript:;" style="color: #016EC5">权限列表</a></dd>-->
                        <#--</dl>-->
                    </li>
                </@resource_check>
                <@resource_check url="/industry/list">
                    <li class="layui-nav-item layui-side-item" id="list-industry" data-uri="/industry/list">
                        <a href="javascript:;"><img src="/css/img/icon_record_default.png" class="layui-nav-side-img">行业管理</a>
                        <#--<dl class="layui-nav-child">-->
                            <#--<dd id="list-industry" data-uri="/industry/list"><a href="javascript:;" style="color: #016EC5">行业列表</a></dd>-->
                        <#--</dl>-->
                    </li>
                </@resource_check>
            </ul>
        </div>
    </div>

    <div class="layui-body">
        <!-- 内容主体区域 -->
        <div class="layui-tab" lay-filter="tabBody" lay-allowclose="true" style="margin-top: 0;">
            <ul class="layui-tab-title">
            </ul>
            <div class="layui-tab-content layui-col-md-12" lay-filter="tabTable">
            </div>
        </div>

    </div>

    <div class="layui-footer" style="text-align: center">
        <!-- 底部固定区域 -->
        <span>综改区监督平台</span>
    </div>
</div>
</body>
<script>
    layui.use(['element','itenderUser'], function(){
        var $ = layui.jquery
                ,element = layui.element //Tab的切换功能，切换事件监听等，需要依赖element模块
                ,itenderUser = layui.itenderUser;

        var oli = $(".layui-nav-tree").find("li");
        oli.on('click',function () {
            var othis = $(this);
            var id = othis.attr("id"); //左侧导航栏id
            var uri = othis.data("uri"); //新标签页URI
            var title = othis.text(); //新标签页标题
            element.tabDelete('tabBody', id);//删除旧的已存在Tap
            itenderUser.addNewTab(id,uri,title,'tabBody');//新建新标签页
        });

        element.on('nav(userNav)', function(elem){
            //替换图片
            var imglist = $(".layui-nav-tree").find("img");
            imglist.each(function (index,element) {
                var imgsrc = $(this).attr("src");
                imgsrc = imgsrc.replace("selected","default");
                $(this).attr("src",imgsrc);
            });
            var oimg = elem.find("img");
            var oimgsrc = oimg.attr("src");
            oimgsrc = oimgsrc.replace("default","selected");
            oimg.attr("src",oimgsrc);
        });

    });
</script>
</html>