<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>招标编辑器</title>
    <#include "../resource.ftl">
</head>
<body>
<#include "../top_menus.ftl">

<div class="layui-container margin-top">
    <fieldset class="layui-elem-field layui-field-title">
        <legend>元模板列表</legend>
    </fieldset>

    <div class="layui-row">
        <div class="layui-col-md-12 margin-bottom">
            <button class="layui-btn layui-btn-success" onclick="view.goto('/meta/template/add')">新建元模板</button>
        </div>
    </div>
    <div class="layui-row">
        <div class="layui-col-md12">
            <table class="table table-bordered table-hover" id="metaTemplateTable" lay-filter="metaTemplateTable">
            </table>
        </div>

    </div>
</div>
</body>
<script type="text/html" id="tableTool">
    <a class="layui-btn layui-btn-xs" lay-event="edit">编辑</a>
    <a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="del">删除</a>
</script>

<script type="text/html" id="convertCreateDate">
    {{ layui.util.toDateString(d.createTime,'yyyy-MM-dd HH:mm:ss')}}
</script>

<script type="text/html" id="convertUpdateDate">
    {{ layui.util.toDateString(d.updateTime,'yyyy-MM-dd HH:mm:ss')}}
</script>

<script type="text/javascript">
    layui.use(['table', 'util', 'metaTemplate'], function () {
        var table = layui.table;
        var metaTemplate = layui.metaTemplate;

        //第一个实例
        var currentTable = table.render({
            elem: "#metaTemplateTable",
            page: true,
            url: "/meta/template/page",
            cols: [[
                {title: "ID", field: 'id', width: 100},
                {title: "元模板名称", field: 'templateName', width: 200},
                {title: "元模板版本", field: 'templateVersion', width: 100},
                {title: "创建时间", field: 'createTime', templet: "#convertCreateDate"},
                {title: "更新时间", field: 'updateTime', templet: "#convertUpdateDate"},
                {title: "操作员", field: 'operator'},
                {fixed: 'right', align: 'center', toolbar: '#tableTool'}
            ]],
            request: {
                pageName: 'pageNum' //页码的参数名称，默认：page
                , limitName: 'pagesize' //每页数据量的参数名，默认：limit
            },
            response: {
                statusName: 'statusCode' //数据状态的字段名称，默认：code
                , statusCode: 200 //成功的状态码，默认：0
                , msgName: 'msg' //状态信息的字段名称，默认：msg
                , countName: 'total' //数据总数的字段名称，默认：count
                , dataName: 'data' //数据列表的字段名称，默认：data
            },
            done: function (res, curr, count) {
                //如果是异步请求数据方式，res即为你接口返回的信息。
                //如果是直接赋值的方式，res即为：{data: [], count: 99} data为当前页数据、count为数据总长度
                console.log(res);

                //得到当前页码
                console.log(curr);

                //得到数据总量
                console.log(count);
            }
        });

        table.on('tool(metaTemplateTable)', function (obj) { //注：tool是工具条事件名，test是table原始容器的属性 lay-filter="对应的值"
            var data = obj.data; //获得当前行数据
            var layEvent = obj.event; //获得 lay-event 对应的值（也可以是表头的 event 参数对应的值）

            if (layEvent === 'del') { //删除
                metaTemplate.deletMetaTemplate(data.id, function (res, status) {
                    if (status) {
                        currentTable.reload();
                    }
                })
            } else if (layEvent === 'edit') { //编辑
                view.goto("/meta/template/edit?metaTemplateId=" + data.id);
            }
        });
    });

</script>
</html>