<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>招标编辑器 - 编辑招标文件</title>
    <#include "../resource.ftl">
    <#include "../zTree_resource.ftl">
    <#include "../ueditor_resource.ftl">
</head>
<body>
<#include "../top_menus.ftl">

<div class="top-menu-bar layui-fluid" id="subMenu">
    <div class="layui-row">
        <div class="layui-col-md6 layui-col-xs6 layui-elip">
            <span class="layui-inline text-warning">正在编辑招标文件:</>
            <span>${invitationDocument.documentName!}</span>
        </div>
        <div class="layui-col-md6 layui-col-xs6" style="text-align: right;padding-right: 40px;">
            <div class="layui-btn-group">
                <button class="layui-btn layui-btn-primary" onclick="deploy()" id="deploy">发布招标文件</button>
            </div>
            <div class="layui-btn-group">
                <button class="layui-btn layui-btn-danger" onclick="undeploy()" id="undeploy">
                    取消发布
                </button>
            </div>
            <div class="layui-btn-group">
                <button class="layui-btn layui-btn-normal" onclick="downloadPdf()">下载PDF</button>
                <button class="layui-btn layui-btn-primary" onclick="print()">打印</button>
            </div>
            <div class="layui-btn-group">
                <button class="layui-btn layui-btn-warm" onclick="view.goto('/invitation/documents')">返回</button>
            </div>
        </div>
    </div>

</div>

<div class="flex-content">
    <div class="flex-left" style="padding: 0px;">
        <div class="layui-tab layui-tab-card custom-layui-tab custom-layui-tab-card">
            <ul class="layui-tab-title">
                <li class="layui-this">招标文件模板</li>
                <li>投标文件模板</li>
            </ul>
            <div class="layui-tab-content">
                <div class="layui-tab-item layui-show">
                    <div id="itemsRoot" class="ztree">

                    </div>
                </div>
                <div class="layui-tab-item">
                    <div id="tenderItemsRoot" class="ztree">

                    </div>
                </div>
            </div>
        </div>
    </div>
    <div class="flex-right">
        <div class="flex-right-container">
            <div id="eidtorContainer"></div>
        </div>

    </div>
</div>

<#include '../print_plugin.ftl'>

<script type="text/javascript">
    var documentId = "${invitationDocument.id!}";
    var status = "${invitationDocument.status!}";
    if (status == "DEPLOYED") {
        $("#deploy").hide();
        $("#undeploy").show();
    } else {
        $("#deploy").show();
        $("#undeploy").hide();
    }

    layui.use(['layer', 'form', 'invitationDocuments', 'renderHtml', 'tableEditor', 'itenderProject'], function () {
        var invitationDocuments = layui.invitationDocuments;
        invitationDocuments.drawTabTree("#itemsRoot", "#tenderItemsRoot", documentId);

        var renderHtml = layui.renderHtml;
        renderHtml.init("#eidtorContainer");


        //初始化编辑器
        // metaTemplate.initEditor("#eidtorContainer");
    });

    /**
     * 打印
     */
    var print = function () {
        layui.invitationDocuments.print();
    }

    var downloadPdf = function () {
        layui.invitationDocuments.downloadPdf(documentId);
    }

    var deploy = function () {
        layui.invitationDocuments.deploy(documentId, function () {
            $("#undeploy").show();
            $("#deploy").hide();
        });
        // layui.layer.open({
        //     type:1,
        //     title:"关联项目信息",
        //     area: '500px',
        //     content: $("#updateProjectInfoWrap"),
        //     btn:false,
        //     success: function (layero, index) {
        //         layui.itenderProject.initProjects("itenderProjectId", "itenderInstanceId", "itenderProjectItemId", layui.form);
        //
        //         layui.form.on('submit(confirm)', function (data) {
        //             layer.load(2);
        //             return false; //阻止表单跳转。如果需要表单跳转，去掉这段即可。
        //         });
        //     }
        // })
    }

    var undeploy = function () {
        layui.invitationDocuments.undeploy(documentId, function () {
            $("#undeploy").hide();
            $("#deploy").show();
        });
    }

    $(function () {
        var contentH = $(window).height() - 111;
        $(".flex-content").height(contentH);
        $(".layui-tab-content").height(contentH - 41).css("overflow","scroll");
    })

</script>
</body>
</html>