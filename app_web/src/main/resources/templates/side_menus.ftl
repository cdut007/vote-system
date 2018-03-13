<div class="layui-layout layui-layout-admin">
<#include "./dashboard_top_menus.ftl">
    <div class="layui-side layui-bg-black">
        <div class="layui-side-scroll">
            <!-- 左侧导航区域（可配合layui已有的垂直导航） -->
            <ul class="layui-nav layui-nav-tree"  lay-filter="test">

          <@resource_check url="/book">
        <li class="layui-nav-item"><a href="/book">房间预订</a></li>
          </@resource_check>
        <@resource_check url="/room">
        <li class="layui-nav-item"><a href="/room">房间管理</a></li>
        </@resource_check>
         <@resource_check url="/device">
        <li class="layui-nav-item"><a href="/device">设备管理</a></li>
         </@resource_check>
         <@resource_check url="/log">
        <li class="layui-nav-item"><a href="/log">日志管理</a></li>
         </@resource_check>
                 <@resource_check url="/management/user">
        <li class="layui-nav-item"><a href="/management/user">用户管理</a></li>
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
        var $ = layui.jquery
                ,element = layui.element //Tab的切换功能，切换事件监听等，需要依赖element模块
                ,itenderUser = layui.itenderUser;

        $('dd').on('click',function () {
            var othis = $(this);
            var id = othis.attr("id"); //左侧导航栏id
            var uri = othis.data("uri"); //新标签页URI
            var title = othis.text(); //新标签页标题

            element.tabDelete('tabBody', id);//删除旧的已存在Tap
            itenderUser.addNewTab(id,uri,title,'tabBody');//新建新标签页
        });

    });
</script>