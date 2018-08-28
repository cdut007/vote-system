<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>交易平台 - 虚拟账户管理</title>
    <#include "../resource.ftl">
    <style>


        .login-label {
            text-align: center;
            font-size: 16px;
            background-color: #ff0000;
            color: white;
            padding: 12px 10px 12px 10px;
        }
        .mui-card{
            border-radius: 10px;
        }
        .layui-input-block {
            margin-left: 0px;
            margin:0 auto;
        }
        .layui-row{
            padding-left: 40px;
            padding-right: 40px;
            height: 100%;
            padding-top: 60px;
        }



    </style>
</head>
<body style="background-color: whitesmoke">

<div id="background" >

    <div class="layui-btn-group demoTable">
        <button class="layui-btn" data-type="getCheckData">批量释放选中行数据</button>
        <button class="layui-btn" data-type="getCheckLength">获取选中数目</button>
        <button class="layui-btn" data-type="isAll">验证是否全选</button>
    </div>

    <div class="layui-row">
        <div class="layui-col-md-12">
            <table class="table table-bordered table-hover" id="taskTable" lay-filter="taskTable">
            </table>
        </div>
    </div>

</div>
</body>




<script type="text/html" id="indexTpl">
    {{d.LAY_INDEX}}
</script>
<script type="text/html" id="taskTableTool">

    <a class="layui-btn  layui-btn-xs layui-btn-danger" lay-event="review">释放账户</a>

</script>

<script type="text/html" id="createTimeLabel">
    {{ new Date(d.createTime).format("yyyy/MM/dd hh:mm:ss") }}
</script>

<script type="text/html" id="typeLabel">
</script>

<script>


    Date.prototype.format = function (format) {
        var args = {
            "M+": this.getMonth() + 1,
            "d+": this.getDate(),
            "h+": this.getHours(),
            "m+": this.getMinutes(),
            "s+": this.getSeconds(),
            "q+": Math.floor((this.getMonth() + 3) / 3),  //quarter
            "S": this.getMilliseconds()
        };
        if (/(y+)/.test(format))
            format = format.replace(RegExp.$1, (this.getFullYear() + "").substr(4 - RegExp.$1.length));
        for (var i in args) {
            var n = args[i];
            if (new RegExp("(" + i + ")").test(format))
                format = format.replace(RegExp.$1, RegExp.$1.length == 1 ? n : ("00" + n).substr(("" + n).length));
        }
        return format;
    };

    layui.use(['form','layer','table','laydate'], function () {
        var form = layui.form;
        var layer = layui.layer;
        var table = layui.table;
        form.render();



        layui.laydate.render({
            elem: '#applyDateBegin'
            ,value: new Date()
            ,type: 'datetime'
            ,done: function(value, date){
                var time = Date.parse(value.replace(/-/g,"/"));

                applyDateBegin = time;

                //{year: 2017, month: 8, date: 18, hours: 0, minutes: 0, seconds: 0}
            }
        });

        layui.laydate.render({
            elem: '#applyDateEnd'
            ,value: new Date()
            ,type: 'datetime'
            ,done: function(value, date){
                var time = Date.parse(value.replace(/-/g,"/"));

                applyDateEnd = time;

                //{year: 2017, month: 8, date: 18, hours: 0, minutes: 0, seconds: 0}
            }
        });

        layui.laydate.render({
            elem: '#bidOpenDate'
            ,value: new Date()
            ,type: 'datetime'
            ,done: function(value, date){
                var time = Date.parse(value.replace(/-/g,"/"));

                bidOpenDate = time;

                //{year: 2017, month: 8, date: 18, hours: 0, minutes: 0, seconds: 0}
            }
        });

        layui.laydate.render({
            elem: '#bidDeadline'
            ,value: new Date()
            ,type: 'datetime'
            ,done: function(value, date){
                var time = Date.parse(value.replace(/-/g,"/"));

                bidDeadline = time;

                //{year: 2017, month: 8, date: 18, hours: 0, minutes: 0, seconds: 0}
            }
        });





        var currentTable = table.render({
            elem: "#taskTable", skin: 'nob',
            even: true,
            page: true,
            url: "/virtualAccount/listSubAccounts",
            method: "POST",
            cols: [[
                {type:'checkbox', fixed: 'left'},
                {title: '序号',templet: '#indexTpl'},
                {title: "虚拟账户", field: 'accountNumber'},
                {title: "虚拟账户名称", field: 'aliasAccountName'},
                {title: "创建时间", templet: '#createTimeLabel'},
                {title: "操作",fixed: 'right', align: 'center', toolbar: '#taskTableTool'}
            ]],

            where:{},

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

        var $ = layui.$, active = {
            getCheckData: function(){ //获取选中数据
                var checkStatus = table.checkStatus('taskTable')
                        ,data = checkStatus.data;
                markDelete(data);
                //layer.alert(JSON.stringify(data));
            }
            ,getCheckLength: function(){ //获取选中数目
                var checkStatus = table.checkStatus('taskTable')
                        ,data = checkStatus.data;
                layer.msg('选中了：'+ data.length + ' 个');
            }
            ,isAll: function(){ //验证是否全选
                var checkStatus = table.checkStatus('taskTable');
                layer.msg(checkStatus.isAll ? '全选': '未全选')
            }
        };

        $('.demoTable .layui-btn').on('click', function(){
            var type = $(this).data('type');
            active[type] ? active[type].call(this) : '';
        });


        function markDelete(datas){
            var index = layer.load(1, {
                shade: [0.1,'#fff'] //0.1透明度的白色背景
            });
            for (var i = 0; i < datas.length; i++) {
                var data = datas[i];
                var subAccNo = data.accountNumber;
                $.ajax({
                    url: '/bank/destroySubAccount',
                    type: "POST",
                    dataType: "json",
                    data: {type:'jiaotong',subAccNo:subAccNo},
                    success: function (res) {
                        layer.close(index);
                        if(res!=null){
                            if(res.success){
                                alert(res.msg);
                                reloadTaskTable();
                            }else{
                                alert("处理失败!"+ res.msg);
                            }
                        }


                    },
                    error: function (xmlHttpReq, error, ex) {
                        alert("处理失败!"+ error);
                        layer.close(index);
                    }
                })
            }
        }

        table.on('tool(taskTable)', function (obj) { //注：tool是工具条事件名，test是table原始容器的属性 lay-filter="对应的值"
            var data = obj.data; //获得当前行数据
            var layEvent = obj.event; //获得 lay-event 对应的值（也可以是表头的 event 参数对应的值）

            var subAccNo = data.accountNumber;


            if (layEvent === 'review') { //点击办理

                var index = layer.load(1, {
                    shade: [0.1,'#fff'] //0.1透明度的白色背景
                });

                $.ajax({
                    url: '/bank/destroySubAccount',
                    type: "POST",
                    dataType: "json",
                    data: {type:'jiaotong',subAccNo:subAccNo},
                    success: function (res) {
                        layer.close(index);
                        if(res!=null){
                            if(res.success){
                                alert(res.msg);
                                reloadTaskTable();
                            }else{
                                alert("处理失败!"+ res.msg);
                            }
                        }


                    },
                    error: function (xmlHttpReq, error, ex) {
                        alert("处理失败!"+ error);
                        layer.close(index);
                    }
                })



            }
        });


        function reloadTaskTable() {
            currentTable.reload({

                page: {
                    curr: 1 //重新从第 1 页开始
                },
                request: {
                    pageName: 'pageNum', //页码的参数名称，默认：page
                    limitName: 'pagesize' //每页数据量的参数名，默认：limit
                }


            });
        }



    });
</script>
</html>
