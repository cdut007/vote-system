<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>设备管理列表</title>
<#include "../resource.ftl">
</head>
<body>
<#include "../top_menus.ftl">
<div class="layui-container margin-top">
    <div class="layui-row">
        <div class="layui-col-md-12 margin-bottom">
            <button class="layui-btn layui-btn-success" id="addDevice">添加设备</button>
        </div>
    </div>

    <div class="layui-row">
        <div class="layui-col-md-12">
            <table class="table table-bordered table-hover" id="deviceTable" lay-filter="deviceTable">
            </table>
        </div>
    </div>
</div>
</body>

<script type="text/html" id="indexTpl">
    {{d.LAY_TABLE_INDEX+1}}
</script>
<script type="text/html" id="deviceTableTool">
    <a class="layui-btn layui-btn-xs" lay-event="edit">编辑</a>
    <a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="del">删除</a>
</script>

<script type="text/javascript">
    layui.use(['table', 'util', 'itenderDevice'], function () {
        var table = layui.table;
        var itenderDevice = layui.itenderDevice;

        //第一个实例
        var currentTable = table.render({
            elem: "#deviceTable",
            page: true,
            url: "/device/listDevice",
            method: "POST",
            cols: [[
                {title: '序号',templet: '#indexTpl'},
                {title: "设备型号", field: 'model'},
                {title: "设备名称", field: 'name'},
                {title: "设备地址", field: 'ip'},
                {title: "登录信息", field: 'account'},
                {title: "设备状态", field: 'statusLabel'},
                {title: "维护电话", field: 'maintenancePhone'},
                {fixed: 'right', align: 'center', toolbar: '#deviceTableTool'}
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

        table.on('tool(deviceTable)', function (obj) { //注：tool是工具条事件名，test是table原始容器的属性 lay-filter="对应的值"
            var data = obj.data; //获得当前行数据
            var layEvent = obj.event; //获得 lay-event 对应的值（也可以是表头的 event 参数对应的值）
            var deviceId = data.id;

            if (layEvent === 'edit') { //编辑
                var data = {
                    title: '设备编辑',//标题
                    area: 'auto',//宽高
                    closeBtn: 1,//关闭按钮
                    shadeClose: true,//是否点击遮罩关闭
                    queryId: deviceId,
                    queryUrl: '/device/edit_page'
                }
                itenderDevice.openModal(data,function (layerDom,index) {
                    currentTable.reload();
                });
            } else if (layEvent === 'del') { //删除
                itenderDevice.deleteDevice(deviceId,function (res,status) {
                    if(status){
                        currentTable.reload();
                        layui.layer.msg("删除成功！");
                    }else{
                        layui.layer.msg("操作失败！");
                    }
                });
            }
        });
        $('#addDevice').click(function () {
            var data = {
                title: '添加设备',//标题
                area: 'auto',//宽高
                closeBtn: 1,//关闭按钮
                shadeClose: true,//是否点击遮罩关闭
                queryUrl: '/device/add_page'
            }
            itenderDevice.openModal(data,function (layerDom,index) {
                currentTable.reload();
            });
        });
    });

</script>
</html>