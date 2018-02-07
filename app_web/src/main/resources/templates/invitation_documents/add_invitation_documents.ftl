<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>招标编辑器 - 新建招标文件</title>
    <#include "../resource.ftl">

</head>
<body>
<#include "../top_menus.ftl">

<div class="layui-container margin-top">
    <fieldset class="layui-elem-field layui-field-title">
        <legend>新建招标文件</legend>
    </fieldset>

    <div class="layui-row">
        <div class="layui-col-md-12 margin-bottom">
            <button class="layui-btn layui-btn-success" onclick="view.goto('/invitation/documents')">返回列表</button>
        </div>
    </div>
</div>

<div class="layui-container" style="margin-top: 100px;">
    <form class="layui-form layui-form-pane" action="/invitation/documents" method="post"
          id="addInvitationDocumentsForm">

        <#--<div class="layui-row  layui-col-space10">-->
            <#--<div class="layui-col-md12">-->
                <#--<div class="layui-form-item">-->
                    <#--<label for="metaTemplateName" class="layui-form-label">项目</label>-->
                    <#--<div class="layui-input-block">-->
                        <#--<select id="itenderProjectId" name="itenderProjectId" lay-verify="" lay-verType="tips"-->
                                <#--lay-filter="itenderProjectId" lay-search></select>-->
                    <#--</div>-->
                <#--</div>-->
            <#--</div>-->
        <#--</div>-->

        <#--<div class="layui-row  layui-col-space10">-->
            <#--<div class="layui-col-md12">-->
                <#--<div class="layui-form-item">-->
                    <#--<label for="metaTemplateName" class="layui-form-label">招标项目</label>-->
                    <#--<div class="layui-input-block">-->
                        <#--<select id="itenderInstanceId" name="itenderInstanceId" lay-verify="" lay-verType="tips"-->
                                <#--lay-filter="itenderInstanceId" lay-search></select>-->
                    <#--</div>-->
                <#--</div>-->
            <#--</div>-->
        <#--</div>-->

        <#--<div class="layui-row  layui-col-space10">-->
            <#--<div class="layui-col-md12">-->
                <#--<div class="layui-input-inline">-->
                    <#--注:如果有多个标段都使用相同的招标文件，则标段选项不用选择！-->
                <#--</div>-->
                <#--<div class="layui-form-item">-->
                    <#--<label for="metaTemplateName" class="layui-form-label">标段</label>-->
                    <#--<div class="layui-input-block">-->
                        <#--<select id="itenderProjectItemId" name="itenderProjectItemId" lay-verify="" lay-verType="tips"-->
                                <#--lay-filter="itenderProjectItemId" lay-search></select>-->
                    <#--</div>-->
                <#--</div>-->
            <#--</div>-->
        <#--</div>-->

        <div class="layui-row  layui-col-space10">
            <div class="layui-col-md12">
                <div class="layui-form-item">
                    <label for="metaTemplateName" class="layui-form-label">元模板</label>
                    <div class="layui-input-block">
                        <select name="metaTemplateId" lay-verify="metaTemplateId" lay-verType="tips"
                                lay-search>
                            <option value="">请选择或输入一个元模板</option>
                            <#list metaTemplateList as metaTemplate>
                            <option value="${metaTemplate.id!}">${metaTemplate.templateName!}</option>
                            </#list>
                        </select>
                    </div>
                </div>
            </div>
        </div>

        <div class="layui-row  layui-col-space10">
            <div class="layui-col-md12">
                <div class="layui-form-item">
                    <label for="metaTemplateName" class="layui-form-label">招标文件名称</label>
                    <div class="layui-input-block">
                        <input type="text" class="layui-input" name="invitationDocumentName" id="invitationDocumentName"
                               placeholder="请输入招标文件名称" lay-verify="invitationDocumentName" lay-verType="tips">
                    </div>
                </div>
            </div>
        </div>
        <div class="layui-row  layui-col-space10">
            <div class="layui-col-md12">
                <button class="layui-btn layui-btn-success" lay-submit lay-filter="confirm" style="width: 100%">确认新建
                </button>
            </div>
        </div>
    </form>
</div>
</div>

<div>

</div>

<script type="text/javascript">
    layui.use(['form', 'itenderProject', 'layer'], function () {
        var layer = layui.layer;
        var form = layui.form;
        var itenderProject = layui.itenderProject;

        form.verify({
            invitationDocumentName: function (value, item) {
                if (value.length == 0) return "招标文件名称不能为空"
            },
            metaTemplateId: function (value, item) {
                if (value.length == 0) return "请选择一个元模板"
            }
        })
        // itenderProject.initProjects("itenderProjectId", "itenderInstanceId", "itenderProjectItemId", form);

        form.on('submit(confirm)', function (data) {
            layer.load(2);
            return true; //阻止表单跳转。如果需要表单跳转，去掉这段即可。
        });
    })

</script>
</body>
</html>