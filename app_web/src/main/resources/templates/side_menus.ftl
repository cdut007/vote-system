<div class="layui-layout layui-layout-admin">
<#include "./dashboard_top_menus.ftl">
    <div class="layui-side layui-bg-black">
        <div class="layui-side-scroll">
            <!-- 左侧导航区域（可配合layui已有的垂直导航） -->
            <ul class="layui-nav layui-nav-tree"  lay-filter="test">
   <#--<@resource_check url="/book">-->
                    <#--<li class="layui-nav-item">-->
                        <#--<a class="" href="javascript:;"><img src="/css/img/icon_room_default.png" class="layui-nav-side-img">房间管理</a>-->
                        <#--<dl class="layui-nav-child">-->
                            <#--<dd id="book-room" data-uri="/book"><a href="/book">房间预订</a></dd>-->
                            <#--<dd id="list-room" data-uri="/room"><a href="/room">房间维护</a></dd>-->

                        <#--</dl>-->
                    <#--</li>-->
   <#--</@resource_check>-->
          <@resource_check url="/book">
        <li class="layui-nav-item layui-side-item"><a href="/book"><img src="/css/img/icon_room_default.png" class="layui-nav-side-img">房间预订</a></li>
          </@resource_check>
        <@resource_check url="/room">
        <li class="layui-nav-item layui-side-item"><a href="/room"><img src="/css/img/icon_limit_default.png" class="layui-nav-side-img">房间管理</a></li>
        </@resource_check>
         <@resource_check url="/device">
        <li class="layui-nav-item layui-side-item"><a href="/device"><img src="/css/img/icon_equipment_default.png" class="layui-nav-side-img">设备管理</a></li>
         </@resource_check>
         <@resource_check url="/log">
        <li class="layui-nav-item layui-side-item"><a href="/log"><img src="/css/img/icon_record_default.png" class="layui-nav-side-img">日志管理</a></li>
         </@resource_check>
                 <@resource_check url="/management/user">
        <li class="layui-nav-item layui-side-item"><a href="/management/user"><img src="/css/img/icon_user_default.png" class="layui-nav-side-img">用户管理</a></li>
                 </@resource_check>


                <#--<@resource_check url="/management/user/listUser">-->
                    <#--<li class="layui-nav-item">-->
                        <#--<a class="" href="javascript:;">用户管理</a>-->
                        <#--<dl class="layui-nav-child">-->
                            <#--<dd id="list-user" data-uri="/management/user/listUser"><a href="javascript:;">用户列表</a></dd>-->
                        <#--</dl>-->
                    <#--</li>-->
                <#--</@resource_check>-->
                <#--<@resource_check url="/management/role">-->
                    <#--<li class="layui-nav-item">-->
                        <#--<a href="javascript:;">角色管理</a>-->
                        <#--<dl class="layui-nav-child">-->
                            <#--<dd id="list-role" data-uri="/management/role/listRole"><a href="javascript:;">角色列表</a></dd>-->
                        <#--</dl>-->
                    <#--</li>-->
                <#--</@resource_check>-->
                <#--<@resource_check url="/management/privilege">-->
                    <#--<li class="layui-nav-item">-->
                        <#--<a href="javascript:;">权限管理</a>-->
                        <#--<dl class="layui-nav-child">-->
                            <#--<dd id="list-privilege" data-uri="/management/privilege/listPrivilege"><a href="javascript:;">权限列表</a></dd>-->
                        <#--</dl>-->
                    <#--</li>-->
                <#--</@resource_check>-->
                <#--<@resource_check url="/industry/list">-->
                    <#--<li class="layui-nav-item">-->
                        <#--<a href="javascript:;">行业管理</a>-->
                        <#--<dl class="layui-nav-child">-->
                            <#--<dd id="list-industry" data-uri="/industry/list"><a href="javascript:;">行业列表</a></dd>-->
                        <#--</dl>-->
                    <#--</li>-->
                <#--</@resource_check>-->
            </ul>
        </div>
    </div>


</div>

<script>
    layui.use(['element','itenderUser'], function(){

        // layui.element.on('nav(filter)', function(elem){
        //     console.log(elem); //得到当前点击的DOM对象
        // });


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
         /*color: #0069ae;*/
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
</style>