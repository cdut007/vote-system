<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>招标编辑器 - 编辑元模板</title>
    <#include "../resource.ftl">
    <#include "../zTree_resource.ftl">
    <#include "../ueditor_resource.ftl">
<#--<link rel="stylesheet" href="/css/word_style/sheets-of-paper-a4.css">-->
<#--<link rel="stylesheet" href="/js/bootstrap-treeview.min.css">-->
</head>
<body>
<#include "../top_menus.ftl">

<div class="top-menu-bar layui-fluid" id="subMenu">
    <div class="layui-row">
        <div class="layui-col-md4 layui-elip">
            <span class="layui-inline text-warning">正在编辑元模板:</>
            <span id="templateNameWrap">${metaTemplate.templateName!}</span>
        </div>
        <div class="layui-col-md8" style="text-align: right;">
            <div class="layui-btn-group">
                <button class="layui-btn layui-btn-warm" onclick="updateTemplateName()">修改模板名称</button>
                <button class="layui-btn layui-btn-primary" onclick="addRootItem()">新建根节点</button>
                <button class="layui-btn layui-btn-primary" onclick="createItems()">新建选项</button>
            </div>

            <div class="layui-btn-group">
                <button class="layui-btn" onclick="addItem()">新建节点</button>
                <button class="layui-btn " onclick="addChildItem()">新建子节点</button>
                <button class="layui-btn layui-btn-normal" onclick="updateItem()">修改节点</button>
                <button class="layui-btn  layui-btn-danger" onclick="deleteItem()">删除节点</button>
            </div>

            <div class="layui-btn-group">
                <button class="layui-btn layui-btn-warm" onclick="view.goto('/meta/template')">返回</button>
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
        <div class="flex-right-container" id="eidtorContainer">
        <#--<div id="editor" style="width:100%;height:100%;"></div>-->
        </div>

    </div>
</div>
<#--<div class="layui-fluid" id="texti" style="margin-top: 20px;">-->
    <#--<form class="layu-form" action="javascript:void(0);">-->
        <#--<div class="layui-form">-->
            <#--<div class="layui-form-item">-->
                <#--<div class="layui-inline">-->
                    <#--<button class="layui-btn layui-btn-sm add-item">添加选项</button>-->

                <#--</div>-->
            <#--</div>-->
            <#--<div class="layui-form-item">-->
                <#--<div class="layui-inline">-->
                    <#--<div class="layui-input-inline" style="width: 80px;">是否选中</div>-->
                    <#--<div class="layui-input-inline">选项值</div>-->
                <#--</div>-->

            <#--</div>-->
            <#--<div class="item-wrap"></div>-->
            <#--<div class="layui-form-item">-->
                <#--<button class="layui-btn layui-btn-fluid" style="width: 100%" lay-submit-->
                        <#--lay-filter="confirmChooseItems">确认-->
                <#--</button>-->
            <#--</div>-->
        <#--</div>-->
    <#--</form>-->
<#--</div>-->

<#--<#include "../ueditor_resource.ftl">-->
<#--<script src="/js/bootstrap-treeview.min.js"></script>-->
<#--<script src="/js/stickUp.min.js"></script>-->
<script type="text/javascript">
    var templateId = "${metaTemplate.id!}";

    layui.use(['layer', 'form', 'metaTemplate','formEditorCheckbox'], function () {
        var metaTemplate = layui.metaTemplate;
        metaTemplate.drawTabTree("#itemsRoot", '#tenderItemsRoot', templateId);

        //初始化编辑器
        metaTemplate.initEditor("#eidtorContainer");


    });

    /**
     * 新建根节点
     */
    var addRootItem = function () {
        layui.metaTemplate.addRootItem(templateId, function (res) {
            console.log("渲染右侧界面");
            //TODO
        });
    }

    /**
     * 新建子节点
     */
    var addChildItem = function () {
        layui.metaTemplate.addChildItem(templateId, function (res) {
            //TODO
            console.log("渲染右侧界面");

        });
    }

    /**
     * 新建节点，如果没有选中的节点，则默认添加到根节点。如果有选中的节点，则直接添加在该节点后
     */
    var addItem = function () {
        layui.metaTemplate.addItem(templateId, function (res) {
            //TODO
            console.log("渲染右侧界面");

        });
    }

    /**
     * 更新节点名称
     */
    var updateItem = function () {
        layui.metaTemplate.updateItem(function (res) {
            //TODO
            console.log("渲染右侧界面");

        });
    }

    /**
     * 删除选中节点
     */
    var deleteItem = function () {
        layui.metaTemplate.deleteItem();
    }


    var updateTemplateName = function () {
        layui.metaTemplate.updateTemplateName(templateId, $("#templateNameWrap").text(), function (val) {
            $("#templateNameWrap").text(val);
        })
    }


    // function createChooseItem($itemWrap) {
    //     var $inputs = $itemWrap.find(".layui-input");
    //     var index = $inputs ? $inputs.length : 0;
    //     var $item = $('<div class="layui-form-item">\n' +
    //             '                <div class="layui-inline" style="width: 100%;">\n' +
    //             '                    <div class="layui-input-inline" style="width: 80px;text-align: center;">\n' +
    //             '                        <input type="radio" name="item_radio" title=" ">\n' +
    //             '                    </div>\n' +
    //             '                    <div class="layui-input-inline" style="width: 300px;">\n' +
    //             '                        <input type="text" class="layui-input" name="item_input_' + index + '">\n' +
    //             '                    </div>\n' +
    //             '                    <div class="layui-input-inline" style="width: 50px;">\n' +
    //             '                        <button class="layui-btn layui-btn-danger item-del">删除</button>\n' +
    //             '                    </div>\n' +
    //             '                </div>\n' +
    //             '            </div>'
    //     )
    //     $itemWrap.append($item);
    //     layui.form.render("radio");
    //
    //     var $delBtn = $item.find(".item-del");
    //     $delBtn.off("click").on("click", function () {
    //         $item.remove();
    //     })
    // }
    //
    var createItems = function () {
        // layui.layer.open({
        //     title: "新建选项",
        //     type: 1,
        //     area: '500px',
        //     content: $("#texti"),
        //     success: function (layero, index) {
        //         var $addBtn = layero.find(".add-item");
        //         var $itemWrap = layero.find(".item-wrap");
        //         //初始化一个选项
        //         createChooseItem($itemWrap);
        //
        //         $addBtn.off("click").on("click", function () {
        //             createChooseItem($itemWrap);
        //         });
        //
        //         layui.form.on('checkbox', function (data) {
        //             console.log(data.elem); //得到checkbox原始DOM对象
        //             console.log(data.elem.checked); //是否被选中，true或者false
        //             console.log(data.value); //复选框value值，也可以通过data.elem.value得到
        //             console.log(data.othis); //得到美化后的DOM对象
        //         });
        //
        //         layui.form.on("submit(confirmChooseItems)", function (data) {
        //             console.log(data);
        //             var fields = data.field;
        //             var $chooseWrap = $("<div class='choose-wrap'></div>");
        //             for (var key in fields) {
        //                 var val = fields[key];
        //                 var $chooseItem = $("<div><input type='checkbox'><span>" + val + "</span></div>");
        //                 $chooseWrap.append($chooseItem);
        //             }
        //
        //             return false;
        //         })
        //     }
        // })
        layui.formEditorCheckbox.openChooseItems(function (html) {
            console.log(html)
        })
    }

    $(function () {
        var contentH = $(window).height() - 111;
        $(".flex-content").height(contentH);
        $(".layui-tab-content").height(contentH - 41).css("overflow","scroll");
    })



</script>
</body>
</html>