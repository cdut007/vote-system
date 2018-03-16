

<div class="layui-layout layui-layout-admin layui-header header-index">
   <#-- <span class="logo">综改区监督平台</span>-->
    <ul class="layui-nav no-border-radius layui-header" style="padding-left: 8%">
<#if user??>
    <li class="layui-nav-item">您好！${user.userName},欢迎使用综改区公共资源交易监督系统</li>
<#else>
    <li class="layui-nav-item">您好！欢迎使用综改区公共资源交易监督系统</li>
</#if>


    </ul>
    <ul class="layui-nav layui-layout-right layui-header" style="padding-right: 8%">
        <li class="layui-nav-item"><a id="home" href="javascript:;"><img src="/css/img/icon_home.png" class="layui-nav-img">网站首页</a></li>

        <li class="layui-nav-item"><a id="userDetils" href="javascript:;"><img src="/css/img/icon_me.png" class="layui-nav-img">个人中心</a></li>
     <#if user??>
      <li class="layui-nav-item"><a id="logout" href="javascript:;"><img src="/css/img/icon_logout.png" class="layui-nav-img">退出登录</a></li>

     <#else>
         <li class="layui-nav-item"><a id="login" href="javascript:;"><img src="/css/img/icon_login.png" class="layui-nav-img">登录</a></li>

     </#if>
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
        $("#login").click(function () {
            view.goto('/login');

        });
        $("#home").click(function () {
            view.goto('/');

        });
        $("#userDetils").click(function () {
            var userName= '${(user.userName)!}';

            if(!isLogin(userName)){
                view.goto('/login');
                return;
            }

            var url = '/management/user/detilsModal';
            var userId = '${(user.id)!}';
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

<style>
    .layui-layout-admin .layui-header {
        background-color: #016EC5;
    }
    .layui-nav .layui-nav-menu {
        position: relative;
        display: inline-block;
        vertical-align: middle;
        line-height: 60px;
    }
    .layui-nav .layui-this:after, .layui-nav-bar, .layui-nav-tree .layui-nav-itemed:after {
        position: absolute;
        left: 0;
        top: 0;
        width: 0;
        height: 0px;
        background-color: #00000000;
        transition: all .2s;
        -webkit-transition: all .2s;
    }
    .layui-nav-img {
        width: 20px;
        height: 20px;
        margin-right: 2px;
        border-radius: 0%;
    }


    .date{
        background-image:url('/css/img/icon_calendar.png');
        background-position:left;
        background-position: 4px;
        padding-left: 32px;
        background-repeat:no-repeat;
    }
    .btn-edit{
        border: 1px solid #0154AD;
        background-color: #00000000;
        color: #0154AD;
    }
    .btn-edit:hover{
        border: 1px solid #0154AD;
        background-color: #00000000;
        color: #0050ae;
    }
    .btn-delete{
        border: 1px solid #ff3366;
        background-color: #00000000;
        color:#ff3366;

    }
    .btn-delete:hover{
        border: 1px solid #ff3366;
        background-color: #00000000;
        color:#ff2366;
    }

</style>