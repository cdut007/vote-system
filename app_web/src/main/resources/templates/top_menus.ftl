
<div class="layui-layout layui-layout-admin layui-header header-index">
    <span class="logo">综改区监督平台</span>
    <ul class="layui-nav no-border-radius layui-header">
        <li class="layui-nav-item"><a href="/dashboard">综改区监督平台</a></li>

        <@resource_check url="/management/user">
            <li class="layui-nav-item"><a href="/book">房间预订</a></li>
        <li class="layui-nav-item"><a href="/room">房间管理</a></li>
        <li class="layui-nav-item"><a href="/device">设备管理</a></li>
        <li class="layui-nav-item"><a href="/log">日志管理</a></li>
        <li class="layui-nav-item"><a href="/management/user">用户</a></li>
        </@resource_check>
    </ul>
    <ul class="layui-nav layui-layout-right layui-header">
        <li class="layui-nav-item">
            <a href="javascript:;">
                <#--<img src="" class="layui-nav-img">-->
                ${user.userName!'#unknow'}
            </a>
            <ul class="layui-nav-child">
                <li><a id="userDetils" href="javascript:;">基本资料</a></li>
            </ul>
        </li>
        <li class="layui-nav-item"><a id="logout" href="javascript:;">安全退出</a></li>
    </ul>
</div>
<script>
    $(function () {
        var pathname = window.location.pathname;
        $(".layui-nav").find("a").each(function (index) {
            var href = $(this).attr("href");
            if (pathname.indexOf(href) != -1) {
                $(this).addClass("layui-this");
            }
        })
    });

    //注意：导航 依赖 element 模块，否则无法进行功能性操作
    layui.use(['element','itenderUser'], function () {
        var element = layui.element
                ,itenderUser = layui.itenderUser;
        $("#logout").click(function () {
            itenderUser.userLogout();//安全退出
        });
        $("#userDetils").click(function () {
            var url = '/management/user/detilsModal';
            var userId = '${user.id!}';
            itenderUser.openModal({
                title: '用户详情',//标题
                area: 'auto',//宽高
                closeBtn: '1',//关闭按钮
                shadeClose: false,//是否点击遮罩关闭
                queryId: userId,
                queryUrl: url
            },function (layerDom,index) {

            });
        });
        //…
    });
</script>