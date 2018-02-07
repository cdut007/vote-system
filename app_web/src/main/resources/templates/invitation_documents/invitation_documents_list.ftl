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
        <legend>招标文件列表</legend>
    </fieldset>

    <div class="layui-row">
        <div class="layui-col-md-12 margin-bottom">
            <button class="layui-btn layui-btn-success" onclick="view.goto('/invitation/documents/add')">新建招标文件</button>
        </div>
    </div>
    <div class="layui-row">
        <div class="layui-col-md12">
            <form class="layui-form layui-form-pane" action="javascript:void(0)">
                <div class="layui-inline">
                    <label class="layui-form-label">项目</label>
                    <div class="layui-input-inline">
                        <select id="itenderProjectId" lay-filter="itenderProjectId" name="itenderProjectId"
                                lay-verify="" lay-verType="tips" lay-search>
                        </select>

                    </div>

                </div>
                <div class="layui-inline">
                    <label class="layui-form-label">招标项目</label>
                    <div class="layui-input-inline">
                        <select id="itenderProjectInstanceId" lay-filter="itenderProjectInstanceId"
                                name="itenderProjectInstanceId" lay-verify="" lay-search lay-verType="tips">
                        </select>
                    </div>
                </div>
                <div class="layui-inline">
                    <label class="layui-form-label">标段</label>
                    <div class="layui-input-inline">
                        <select id="itenderProjectItemId" lay-filter="itenderProjectItemId" name="itenderProjectItemId"
                                lay-verify="" lay-verType="tips" lay-search>
                        </select>
                    </div>
                </div>
                <div class="layui-inline">
                    <button class="layui-btn" lay-filter="search" lay-submit>
                        <i class="layui-icon">&#xe615;</i> 搜索
                    </button>
                </div>
            </form>
            <table class="table table-bordered table-hover" id="invitationDocumentTable"
                   lay-filter="invitationDocumentTable">
            </table>
        </div>

    </div>
</div>
</body>
<script type="text/html" id="tableTool">
    {{# if(d.status != "COMPLETE") { }}
    <a class="layui-btn layui-btn-xs" lay-event="edit">编辑</a>
    <a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="del">删除</a>
    {{# }else{ }}
    <a class="layui-btn layui-btn-primary layui-btn-xs" lay-event="view">查看</a>
    <a class="layui-btn layui-btn-warm layui-btn-xs" lay-event="assign">签章</a>
    {{# } }}
</script>

<script type="text/html" id="convertCreateDate">
    {{ layui.util.toDateString(d.createTime,'yyyy-MM-dd HH:mm:ss')}}
</script>

<script type="text/html" id="convertUpdateDate">
    {{ layui.util.toDateString(d.updateTime,'yyyy-MM-dd HH:mm:ss')}}
</script>

<script type="text/html" id="convertStatus">
    {{ layui.formaterUtil.autoParseAndMarkStatus(d.status)}}
</script>

<script type="text/javascript">
    layui.use(['table', 'util', 'invitationDocuments', 'form', 'itenderProject','formaterUtil'], function () {
        var table = layui.table;
        var invitationDocuments = layui.invitationDocuments;
        var form = layui.form;
        var itenderProject = layui.itenderProject;


        //第一个实例
        var currentTable = table.render({
            elem: "#invitationDocumentTable",
            page: true,
            url: "/invitation/documents/page",
            loading: true,
            cols: [[
                {title: "ID", field: 'id', width: 100},
                {title: "招标文件名称", field: 'documentName', width: 200},
                {title: "发布状态", field: 'status', width: 200,templet:"#convertStatus"},
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

        table.on('tool(invitationDocumentTable)', function (obj) { //注：tool是工具条事件名，test是table原始容器的属性 lay-filter="对应的值"
            var data = obj.data; //获得当前行数据
            var layEvent = obj.event; //获得 lay-event 对应的值（也可以是表头的 event 参数对应的值）

            if (layEvent === 'del') { //删除
                invitationDocuments.deleteDocument(data.id, function (res, status) {
                    if (status) {
                        currentTable.reload();
                    }
                })
            } else if (layEvent === 'edit') { //编辑
                view.goto("/invitation/documents/edit?id=" + data.id);
            }else if (layEvent === 'view') { //查看
                view.openNew("/invitation/documents/view/pdf?documentId=" + data.id);
            }else if (layEvent === 'assign') { //签章
                view.openNew("/invitation/documents/view/assign?documentId=" + data.id);
            }
        });

        //初始化搜索框数据
        itenderProject.initProjects("itenderProjectId", "itenderProjectInstanceId", "itenderProjectItemId", form);

        //提交搜索
        form.on('submit(search)', function (data) {
            var formData = data.field;
            //刷新表格
            currentTable.reload({
                where: {
                    itenderProjectId: formData.itenderProjectId
                    , itenderProjectInstanceId: formData.itenderProjectInstanceId
                    , itenderProjectItemId: formData.itenderProjectItemId
                }, page: {
                    curr: 1 //重新从第 1 页开始
                }
            });
            return false; //阻止表单跳转。如果需要表单跳转，去掉这段即可。
        });

    });

</script>
</html>