<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>预订管理列表</title>
<#include "../resource.ftl">
</head>
<body>
<#include "../top_menus.ftl">
<div class="layui-tab">
<ul class="layui-tab-title">
    <li class="layui-this">预订记录</li>
    <li>房间预订</li>

</ul>
    <div class="layui-tab-content">
        <div class="layui-tab-item layui-show layui-container margin-top">

            <div class="layui-row">
                <div class="layui-col-md-12">
                    <table class="table table-bordered table-hover" id="bookRecordTable" lay-filter="bookRecordTable">
                    </table>
                </div>
            </div>
        </div>

        <div class="layui-tab-item layui-container margin-top">

            <div class="layui-row">
                <div class="layui-col-md-12">
                    <table class="table table-bordered table-hover" id="bookTable" lay-filter="bookTable">
                    </table>
                </div>
            </div>
        </div>


    </div>
</div>
</body>

<script type="text/html" id="indexTpl">
    {{d.LAY_TABLE_INDEX+1}}
</script>
<script type="text/html" id="bookTableTool">
    <a class="layui-btn layui-btn-xs" lay-event="book">预订</a>
</script>

<script type="text/javascript">
    layui.use(['table', 'util', 'itenderBook'], function () {
        var table = layui.table;
        var itenderBook = layui.itenderBook;

        //第一个实例
        var currentTable = table.render({
            elem: "#bookTable",
            page: true,
            url: "/book/listBook",
            method: "POST",
            cols: [[
                {title: '序号',width:80,templet: '#indexTpl'},
                {title: "房间名", width:80,field: 'name'},
                {fixed: 'right', align: 'center',width:80, toolbar: '#bookTableTool'}

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

        table.on('tool(bookTable)', function (obj) { //注：tool是工具条事件名，test是table原始容器的属性 lay-filter="对应的值"
            var data = obj.data; //获得当前行数据
            var layEvent = obj.event; //获得 lay-event 对应的值（也可以是表头的 event 参数对应的值）


            if (layEvent === 'book') { //编辑
                var data = {
                    title: '房间预订',//标题
                    area: 'auto',//宽高
                    closeBtn: 1,//关闭按钮
                    shadeClose: true,//是否点击遮罩关闭
                    queryUrl: '/book/add_page'
                }
                itenderBook.openModal(data,function (layerDom,index) {
                    currentTable.reload();
                });
            }

        });


    });

</script>
</html>