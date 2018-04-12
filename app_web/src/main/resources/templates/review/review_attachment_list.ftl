<div  class="form-container ">

    <fieldset class="layui-elem-field layui-field-title">
        <legend>附件列表</legend>
    </fieldset>
    <div class="layui-row">
        <div class="layui-col-md-12">
            <table class="table table-bordered table-hover" id="recordAllTable" lay-filter="recordAllTable">
            </table>
        </div>
    </div>

</div>

<style>
    .form-item-content {
        float: left;

        padding-left: 15px;
        padding-bottom: 8px;
        line-height: 20px;
        text-align: left;

    }
    .form {
        float: left;
        padding: 9px 15px;
        width: 100%;
        font-weight: 400;
        font-size: 20px;
    }


</style>

<script type="text/html" id="indexTpl">
    {{d.LAY_TABLE_INDEX+1}}
</script>


<script type="text/html" id="reachLowPrice">
    {{#  if(d.reachLowPrice == true){ }}
    <div>是</div>
    {{#  } else { }}
    <div>否</div>
    {{#  } }}
</script>
<script type="text/html" id="attachTableTool">
    <a class="layui-btn layui-btn-xs  btn-edit" lay-event="print">打印</a>
</script>



<script type="text/javascript">

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


    layui.use(['itenderReview','table','util', 'itenderReview','element'], function () {
        var table = layui.table;
        var landId = "${(itenderReview.id)!}";

        //第一个实例
        var recordTable = table.render({
            elem: "#recordAllTable", skin: 'line',
            even: true,
            page: true,
            limits: [5, 10, 15],
            limit: 5, //每页默认显示的数量
            url: "/bid/listBid",
            method: "POST",
            cols: [[
                {title: '序号',templet: '#indexTpl'},
                {title: "文档标题", field: 'proposer'},
                {title: "文档性质", field: 'unitPrice'},
                {title: "文档操作",fixed: 'right', align: 'center', toolbar: '#attachTableTool'}
            ]],

            where:{landId:landId},

            request: {
                landId:'landId'
                , pageName: 'pageNum' //页码的参数名称，默认：page
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

        table.on('tool(recordAllTable)', function (obj) { //注：tool是工具条事件名，test是table原始容器的属性 lay-filter="对应的值"
            var data = obj.data; //获得当前行数据
            var layEvent = obj.event; //获得 lay-event 对应的值（也可以是表头的 event 参数对应的值）
            var landId = data.landId;
            var userId = data.userId;

            if (layEvent === 'print') { //编辑
                view.goto('/bid/print?userId='+userId+"&landId="+landId);
            }
        });

    });

</script>

