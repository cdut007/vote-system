<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>综改区监督平台</title>
    <#include "../resource.ftl">
    <script src="/js/NetPluginSDK.js"></script>
</head>
<style>
    .video {display: inline-block; vertical-align: middle; width: 100%; height: 600px; line-height: 25px; padding: 20px 0; margin-right: -1px; margin-bottom: -1px;margin-top: 5px; border: 1px solid #e2e2e2; font-size: 14px; text-align: center; background-color: #0C0C0C; color: #fff; transition: all .3s; -webkit-transition: all .3s;}
</style>
<body>
<#include "../dashboard_top_menus.ftl">

<div class="layui-container margin-top">
    <div class="layui-row">
        <div class="layui-col-md12 margin-bottom">
            <input type="hidden" id="roomId" value="${roomId!}">
            <button class="layui-btn layui-btn-success" id="gotoRoom">返回房间列表</button>
        </div>
    </div>
    <div class="layui-row">
        <div class="layui-col-md12">
            <ul id="playerSuperContainer"></ul>
        </div>
    </div>
</div>


</body>
<script>
    layui.use(['layer','itenderSupervision'], function() {
        var layer = layui.layer;
        var itenderSupervision = layui.itenderSupervision;

        var roomId = $("#roomId").val();
        var data = {
            roomId : roomId,
            container: "playerSuperContainer"
        };

        itenderSupervision.beginSupervise(data,function (res,status) {//初始化控件

        });

        $("#gotoRoom").click(function () {
            view.goto("/supervision");
        });

        window.onbeforeunload = onclose;
        function onclose() {
            itenderSupervision.logout(roomId);
        }
    });

</script>

</html>