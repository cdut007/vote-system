<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>综改区监督平台</title>
    <#include "resource.ftl">
</head>
<#include "dashboard_top_menus.ftl">
<link rel="stylesheet" href="/css/mui.min.css">
<style>

    #background {
        margin-top: 1px;
        height: 100%;
        width: 100%;
        background: url("/css/img/login_bg.jpg") no-repeat;
        background-size: 100%;
        background-size:cover;
        background-position:center;


    }
    #title{font-family:"SimSun";
        font-size:36px;
        color:#fff;
        text-align: center;
        margin-bottom: 120px;
    }
    img {
        border: 0;
    }

    body .mainmenu {


      margin-top: 15%;


    }


    body .mainmenu:after {
        clear: both;
        content: " ";
        display: block;
    }


    .item-box-text {

        font-size: 18px;
        color: #fff;

    }

    .mui-card-content {
        width: 100%;
        border: 0px;
    }

    .mui-card{
        margin: 0px;
    }

    #field_supervision{
        background-color: #ee5540!important;
        solid #E1260C!important;
    }
    #field_supervision:active {

        background-color: #E1260C!important;
    }
    #field_supervision:hover {

        background-color: #E1260C!important;
    }

    #process_supervision{
        background-color: #b8e986!important;
        solid #82D330!important;
    }
    #process_supervision:active {

        background-color: #82D330!important;
    }

    #process_supervision:hover {

        background-color: #82D330!important;
    }

    #statistics{
        background-color: #53bfeb!important;
        solid #1AA6E0!important;
    }
    #statistics:active {

        background-color: #1AA6E0!important;
    }

    #statistics:hover {

        background-color: #1AA6E0!important;
    }

    #backlog{
        background-color: #fed15c!important;
        solid #EBAB04!important;
    }
    #backlog:active {

        background-color: #EBAB04!important;
    }
    #backlog:hover {

        background-color: #EBAB04!important;
    }
    #system_management{
        background-color: #5cded4!important;
        solid #0EC0B2!important;
    }

    #system_management:active {

        background-color: #0EC0B2!important;
    }

    #system_management:hover {

        background-color: #0EC0B2!important;
    }

    .mui-card{
        border-radius: 6px;
    }
    .layui-this a{
        color: #f6f6f6!important;
    }

</style>
</head>
<body>
<!-- 让IE8/9支持媒体查询，从而兼容栅格 -->
<!--[if lt IE 9]>
<script src="https://cdn.staticfile.org/html5shiv/r29/html5.min.js"></script>
<script src="https://cdn.staticfile.org/respond.js/1.4.2/respond.min.js"></script>
<![endif]-->

<div id="background" class="layui-container login  mui-fullscreen" style="margin-top: 60px">


    <div  class="mainmenu ">
        <div id="title" class="mui-card-content-inner">
            <img src="/css/img/system_label.png" style="width: 800px;height: 50px" />
        </div>

        <div class="layui-row layui-col-space30">
            <div class="layui-col-md2 layui-col-md-offset1">
                <div class="mui-card">

                    <button id="field_supervision" class="mui-card-content" href="qc_report.html">
                        <div class="mui-card-content-inner">
                            <div class="mui-card-box">
                                <div class="item-box-icon">
                                    <img src="/css/img/icon_field_supervision.png" />
                                </div>
                                <div class="item-box-text">
                                    <span>现场监督</span>
                                </div>
                            </div>

                        </div>
                    </button>
                </div>
            </div>
            <div class="layui-col-md2">
                <div class="mui-card">
                    <button id="process_supervision" class="mui-card-content" href="qc_review.html">
                        <div class="mui-card-content-inner">
                            <div class="mui-card-box">
                                <div class="item-box-icon">
                                    <img src="/css/img/icon_process_supervision.png" />
                                </div>
                                <div class="item-box-text">
                                    <span>全流程监督</span>
                                </div>
                            </div>

                        </div>
                    </button>
                </div>
            </div>
            <div class="layui-col-md2">
                <div class="mui-card">
                    <button id="statistics" href="qc_reform.html" class="mui-card-content">
                        <div class="mui-card-content-inner">
                            <div class="mui-card-box">
                                <div class="item-box-icon">
                                    <img src="/css/img/icon_statistics.png" />
                                </div>
                                <div class="item-box-text">
                                    <span>统计分析</span>
                                </div>
                            </div>

                        </div>
                    </button>
                </div>
            </div>
            <div class="layui-col-md2">
                <div class="mui-card">
                    <button id="backlog" href="qc_inquire.html" class="mui-card-content">
                        <div class="mui-card-content-inner">
                            <div class="mui-card-box">
                                <div class="item-box-icon">
                                    <img src="/css/img/icon_backlog.png" />
                                </div>
                                <div class="item-box-text">
                                    <span>待办事项</span>
                                </div>
                            </div>

                        </div>
                    </button>
                </div>
            </div>
            <div class="layui-col-md2">
                <div class="mui-card">
                    <button id="system_management" href="qc_inquire.html" class="mui-card-content">
                        <div class="mui-card-content-inner">
                            <div class="mui-card-box">
                                <div class="item-box-icon">
                                    <img src="/css/img/icon_system_management.png" />
                                </div>
                                <div class="item-box-text">
                                    <span>系统管理</span>
                                </div>
                            </div>

                        </div>
                    </button>
                </div>
            </div>

        </div>



    </div>

</div>
</body>

<script>
    //注意：导航 依赖 element 模块，否则无法进行功能性操作
    layui.use(['element', 'form','layer'], function () {
        var element = layui.element;
        var layer = layui.layer;

        $("#field_supervision").click(function () {
            //示范一个公告层
            var userName= '${(user.userName)!}';

            if(!isLogin(userName)){
                view.goto('/login');
                localStorage.setItem('url','/supervision');
                return;
            }

            view.goto('/supervision');

                }
          );

        $("#process_supervision").click(function () {
                    //示范一个公告层
                    layer.open({
                        type: 1
                        ,title: false //不显示标题栏
                        ,closeBtn: false
                        ,area: '300px;'
                        ,shade: 0.8
                        ,id: 'LAY_layuipro' //设定一个id，防止重复弹出
                        ,btn: ['知道了']
                        ,btnAlign: 'c'
                        ,moveType: 1 //拖拽模式，0或者1
                        ,content: '<div style="padding: 50px; line-height: 22px; background-color: #393D49; color: #fff; font-weight: 300;">开发中...</div>'

                    });
                }
        );

        $("#statistics").click(function () {
                    //示范一个公告层
                    layer.open({
                        type: 1
                        ,title: false //不显示标题栏
                        ,closeBtn: false
                        ,area: '300px;'
                        ,shade: 0.8
                        ,id: 'LAY_layuipro' //设定一个id，防止重复弹出
                        ,btn: ['知道了']
                        ,btnAlign: 'c'
                        ,moveType: 1 //拖拽模式，0或者1
                        ,content: '<div style="padding: 50px; line-height: 22px; background-color: #393D49; color: #fff; font-weight: 300;">开发中...</div>'

                    });
                }
        );

        $("#backlog").click(function () {

            var userName= '${(user.userName)!}';

            if(!isLogin(userName)){
                view.goto('/login');
                localStorage.setItem('url','/review');
                return;
            }
            layer.close(layer.index);
            //示范一个公告层
            view.goto('/review');

                }
        );

        $("#system_management").click(function () {
            var userName= '${(user.userName)!}';

            if(!isLogin(userName)){
                view.goto('/login');
                localStorage.setItem('url','/book');
                return;
            }
            layer.close(layer.index);
                    //示范一个公告层
            view.goto('/book');

                }
        );

    });
</script>
</html>