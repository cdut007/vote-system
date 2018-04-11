
<div class="layui-container margin-top">

    <div class="layui-row">


        <div class="searchTable">


            <div class="layui-inline">
                <label class="layui-form-label">搜索任务</label>
                <div class="layui-input-inline">
                    <input type="text" class="layui-input" id="keyword" placeholder="输入搜索关键字...">
                </div>

            </div>


            <button class="layui-btn" data-type="reload" id="search_review">搜索</button>
        </div>

    </div>

    <div class="layui-row">
        <div class="layui-col-md-12">
            <table class="table table-bordered table-hover" id="reviewTable" lay-filter="reviewTable">
            </table>
        </div>
    </div>



</div>

<script type="text/html" id="indexTpl">
    {{d.LAY_TABLE_INDEX+1}}
</script>
<script type="text/html" id="reviewTableTool">
    <a class="layui-btn layui-btn-xs btn-edit" lay-event="review">点击办理</a>
</script>


<script type="text/html" id="statusLabel">
    {{#  if(d.status != 'normal'){ }}
    <span style="color: #FF0000;">{{ d.statusLabel }}</span>
    {{#  } else { }}

      {{# if(d.roomId){ }}
            <span style="color: #F37715;">{{ '使用中' }}</span>
        {{#  } else { }}
        {{ d.statusLabel }}
       {{#  } }}

    {{#  } }}
</script>





<script type="text/javascript">
    layui.use(['table', 'util', 'itenderReview'], function () {
        var table = layui.table;
        var itenderReview = layui.itenderReview;
        var keyword;

        $('#keyword').bind('keypress', function (event) {
            if (event.keyCode == "13") {//enter
                //需要处理的事情
                searchReload();
            }
        });

        $('#search_review').click(function () {
              searchReload();

        });

        function searchReload() {
            keyword =  $("#keyword").val();

            //执行重载
            currentTable.reload({

                page: {
                    curr: 1 //重新从第 1 页开始
                },

                where:{keyword:keyword},
                request: {
                    keyword:'keyword',
                    pageName: 'pageNum', //页码的参数名称，默认：page
                    limitName: 'pagesize' //每页数据量的参数名，默认：limit
                }


            });
        }


        //第一个实例
        var currentTable = table.render({
            elem: "#reviewTable", skin: 'nob',
            even: true,
            page: true,
            url: "/review/listReview",
            method: "POST",
            cols: [[
                {title: '序号',templet: '#indexTpl'},
                {title: "待办任务名称", field: 'name'},
                {title: "待办任务描述", field: 'description'},
                {title: "创建时间", field: '#createTimeLabel'},
                {title: "操作",fixed: 'right', align: 'center', toolbar: '#reviewTableTool'}
            ]],

            where:{keyword:keyword},

            request: {
                keyword:'keyword',
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

        table.on('tool(reviewTable)', function (obj) { //注：tool是工具条事件名，test是table原始容器的属性 lay-filter="对应的值"
            var data = obj.data; //获得当前行数据
            var layEvent = obj.event; //获得 lay-event 对应的值（也可以是表头的 event 参数对应的值）
            var deviceId = data.id;

            if (layEvent === 'review') { //点击办理

            }
        });

    });

</script>

<style>
    .layui-form-pane .layui-input {
        border-radius: 4px 4px 4px 4px;
        width: 490px;
    }
    .layui-form-pane .layui-input-block {
        margin-left: 0px;
        text-align: center;
    }

</style>
</html>