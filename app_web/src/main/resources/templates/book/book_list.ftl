<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>预订管理列表</title>
<#include "../resource.ftl">
</head>
<body>
<#include "../top_menus.ftl">
<div class="layui-tab" lay-filter="booktab">
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
            <div class="layui-col-md-12 margin-bottom">
                <button class="layui-btn layui-btn-success" id="addDevice">查询房间</button>
            </div>
            <div class="layui-form">
                <div class="layui-form-item">
                    <div class="layui-inline">
                        <label class="layui-form-label">开始时间</label>
                        <div class="layui-input-inline">
                            <input type="text" class="layui-input" id="begin_time" placeholder="">
                        </div>
                    </div>

                    <div class="layui-inline">
                        <label class="layui-form-label">结束时间</label>
                        <div class="layui-input-inline">
                            <input type="text" class="layui-input" id="end_time" placeholder="">
                        </div>
                    </div>
                </div>


            </div>


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




<script type="text/html" id="bookRecordTableTool">

    {{#  if(d.status === 'cancel'){ }}
    <span style="color: #F581B1;">{{ '已取消' }}</span>
    {{#  } else { }}
    <a class="layui-btn layui-btn-xs" lay-event="cancelBook">取消预订</a>
    {{#  } }}

</script>

<script type="text/javascript">
    layui.use(['element','table', 'util', 'itenderBook','laydate'], function () {
        var table = layui.table;
        var itenderBook = layui.itenderBook;
        var element = layui.element; //Tab的切换功能，切换事件监听等，需要依赖element模块

        layui.laydate.render({
            elem: '#begin_time'
            ,type: 'datetime'
        });

        layui.laydate.render({
            elem: '#end_time'
            ,type: 'datetime'
        });


        element.on('tab(booktab)', function(elem){
            if(elem.index == 0){

            }else{

            }
        });

        //第一个实例
        var recordTable = table.render({
            elem: "#bookRecordTable",
            page: true,
            url: "/book/listBookRecord",
            method: "POST",
            cols: [[
                {title: '序号',width:80,templet: '#indexTpl'},
                {title: "房间名", width:80,field: 'room'},
                {title: "预订单位", width:160,field: 'bookOrganization'},
                {title: "预订事项", width:160,field: 'content'},
                {title: "预订类型", width:80,field: 'industry'},
                {title: "预订时间", width:80,field: 'bookTime'},
                {fixed: 'right', align: 'center',width:80, toolbar: '#bookRecordTableTool'}

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

        table.on('tool(bookRecordTable)', function (obj) { //注：tool是工具条事件名，test是table原始容器的属性 lay-filter="对应的值"
            var data = obj.data; //获得当前行数据
            var layEvent = obj.event; //获得 lay-event 对应的值（也可以是表头的 event 参数对应的值）

            var bookId = data.id;
            if (layEvent === 'cancelBook') { //编辑
                itenderBook.cancelBook(bookId,function (res,status) {
                    if(status){
                        data.status = 'cancel';
                        currentTable.reload();
                        layui.layer.msg("取消成功！");
                    }else{
                        layui.layer.msg("操作失败！");
                    }
                });
            }

        });


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

            var bookId = data.id;
            if (layEvent === 'book') { //编辑
                var data = {
                    title: '房间预订',//标题
                    area: 'auto',//宽高
                    closeBtn: 1,//关闭按钮
                    shadeClose: true,//是否点击遮罩关闭
                    queryId: bookId,
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