<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>日志管理列表</title>
<#include "../resource.ftl">
</head>
<body>
<#include "../top_menus.ftl">
<div class="layui-container margin-top">

    <div class="searchTable">

        <div class="layui-inline">
            <label class="layui-form-label">搜索内容</label>
            <div class="layui-input-inline">
                <input type="text" class="layui-input" id="keyword" placeholder="输入搜索关键字...">
            </div>

        </div>


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

        <button class="layui-btn" data-type="reload" id="search_log">查询日志</button>
    </div>


    <div class="layui-row">
        <div class="layui-col-md-12">
            <table class="table table-bordered table-hover" id="logTable" lay-filter="logTable">
            </table>
        </div>
    </div>
</div>
</body>

<script type="text/html" id="indexTpl">
    {{d.LAY_TABLE_INDEX+1}}
</script>
<script type="text/html" id="logTableTool">
    <a class="layui-btn layui-btn-xs" lay-event="edit">编辑</a>
    <a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="del">删除</a>
</script>

<script type="text/javascript">
    layui.use(['table', 'util', 'itenderLog','laydate'], function () {
        var table = layui.table;
        var itenderLog = layui.itenderLog;
        var keyword;


        var beginTime ,endTime;
        var searchDate = {beginTime:beginTime,endTime:endTime};

        layui.laydate.render({
            elem: '#begin_time'
            ,type: 'datetime'
            ,done: function(value, date){
                var time = Date.parse(value.replace(/-/g,"/"));
                beginTime = time;
                //reloadBookList();

                //{year: 2017, month: 8, date: 18, hours: 0, minutes: 0, seconds: 0}
            }
        });

        layui.laydate.render({
            elem: '#end_time'
            ,type: 'datetime'
            ,done: function(value, date){
                var time = Date.parse(value.replace(/-/g,"/"));
                endTime = time;
                //reloadBookList();
                //{year: 2017, month: 8, date: 18, hours: 0, minutes: 0, seconds: 0}
            }

        });

        $('#search_log').click(function () {
            reloadLogList();

        });



        //第一个实例
        var currentTable = table.render({
            elem: "#logTable",
            page: true,
            url: "/log/listLog",
            method: "POST",
            cols: [[
                {title: '序号',templet: '#indexTpl'},
                {title: "访问时间", field: 'recordDate'},
                {title: "用户名", field: 'user'},
                {title: "登录地址", field: 'ip'},
                {title: "访问内容", field: 'content'},
                {title: "浏览器类型", field: 'browserType'},
            ]],
            where:{beginTime:beginTime,endTime:endTime,keyword:keyword},

            request: {
                keyword:'keyword',
                beginTime:'beginTime',
                endTime:'endTime',
                pageName: 'pageNum', //页码的参数名称，默认：page
                limitName: 'pagesize' //每页数据量的参数名，默认：limit
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
                // for(var i=0;i<res.data.length;i++) {
                //     res.data[i].startTime = layui.util.toDateString(res.data[i].startTime, 'yyyy-MM-dd HH:mm:ss')
                // }
                //
                console.log(res);

                //得到当前页码
                console.log(curr);

                //得到数据总量
                console.log(count);
            }
        });

        table.on('tool(logTable)', function (obj) { //注：tool是工具条事件名，test是table原始容器的属性 lay-filter="对应的值"
            var data = obj.data; //获得当前行数据
            var layEvent = obj.event; //获得 lay-event 对应的值（也可以是表头的 event 参数对应的值）
            var logId = data.id;

        });

        function reloadLogList() {


            if(beginTime && endTime && endTime < beginTime){
                layer.msg("结束日期不能早于开始日期");
                return ;
            }
            searchDate.beginTime = beginTime;
            searchDate.endTime = endTime;
            keyword =  $("#keyword").val();

            //执行重载
            currentTable.reload({
                page: {
                    curr: 1 //重新从第 1 页开始
                },
                where:{beginTime:beginTime,endTime:endTime,keyword:keyword},
                request: {
                    beginTime:'beginTime',
                    endTime:'endTime'
                }

            });
        }


    });

</script>
</html>