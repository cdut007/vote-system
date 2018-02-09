<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>综改区监督平台</title>
    <#include "resource.ftl">
</head>
<body>
<#include "top_menus.ftl">

<div class="layui-container">
    <fieldset class="layui-elem-field layui-field-title">
        <legend>暂无内容，待补充...</legend>
    </fieldset>
    <#--<form class="layui-form" style="margin-top: 20px;width: 600px;">-->
        <#--<div class="layui-form-item">-->
            <#--<label class="layui-form-label">内容类型</label>-->
            <#--<div class="layui-input-block">-->
                <#--<input type="radio" name="itemContentType" value="text" title="文本类型" checked>-->
                <#--<input type="radio" name="itemContentType" value="file" title="文件类型">-->
            <#--</div>-->
        <#--</div>-->
        <#--<div class="layui-form-item">-->

            <#--<label class="layui-form-label">节点名称</label>-->
            <#--<div class="layui-input-block">-->
                <#--<input type="text" class="layui-input" name="templateItemName" placeholder="请输入节点名称"-->
                       <#--lay-verify="required" lay-verType="tips">-->
            <#--</div>-->
        <#--</div>-->
        <#--<div class="layui-form-item">-->
            <#--<div class="layui-input-block">-->
                <#--<button class="layui-btn" lay-submit lay-filter="addItemConfirm">确定</button>-->
            <#--</div>-->
        <#--</div>-->
    <#--</form>-->
</div>


</body>
<script>
    //注意：导航 依赖 element 模块，否则无法进行功能性操作
    layui.use(['element', 'form'], function () {
        var element = layui.element;

        //…
    });
</script>
</html>