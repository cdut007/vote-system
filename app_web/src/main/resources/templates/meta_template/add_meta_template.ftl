<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>招标编辑器 - 新建元模板</title>
    <#include "../resource.ftl">

</head>
<body>
<#include "../top_menus.ftl">

<div class="layui-container margin-top">
    <fieldset class="layui-elem-field layui-field-title">
        <legend>新建元模板</legend>
    </fieldset>

    <div class="layui-row">
        <div class="layui-col-md-12 margin-bottom">
            <button class="layui-btn layui-btn-success" onclick="view.goto('/meta/template')">返回列表</button>
        </div>
    </div>
</div>

<div class="layui-container" style="margin-top: 100px;">
    <form class="layui-form" action="/meta/template/add" method="post" id="addMetaTemplateForm">
        <div class="layui-row  layui-col-space10">
            <div class="layui-col-md10">
                <div class="layui-form-item">
                    <label for="metaTemplateName" class="layui-form-label">元模板名称</label>
                    <div class="layui-input-block">
                        <input type="text" class="layui-input" name="metaTemplateName" id="metaTemplateName"
                               placeholder="请输入元模板名称" lay-verify="templateName" lay-verType="tips">
                    </div>
                </div>
            </div>
            <div class="layui-col-md2">
                <button class="layui-btn layui-btn-success" lay-submit lay-filter="confirm">确认新建</button>
            </div>
        </div>
    </form>
</div>
</div>

<div>

</div>

<script type="text/javascript">
    layui.use('form', function () {
        var form = layui.form;

        form.verify({
            templateName: function (value, item) {
                if (value.length == 0) return "元模板名称不能为空"
            }
        })

    })
    // $().ready(function () {
    //
    //     $("#addMetaTemplateForm").validate({
    //         rules: {
    //             metaTemplateName: "required"
    //         },
    //         messages: {
    //             metaTemplateName: "元模板名称不能为空"
    //         }
    //     });
    // })
</script>
</body>
</html>