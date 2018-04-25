
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
    <a class="layui-btn layui-btn-xs btn-edit" lay-event="review">查看</a>
    <a class="layui-btn layui-btn-xs btn-edit" lay-event="commit">认领</a>
</script>

<script type="text/html" id="createTimeLabel">
    {{ new Date(d.createTime).format("yyyy/MM/dd hh:mm:ss") }}
</script>

<script type="text/html" id="typeLabel">
    {{getReviewTypeName(d.type) }}
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
            url: "/review/listReview?all=true",
            method: "POST",
            cols: [[
                {title: '序号',templet: '#indexTpl'},
                {title: "项目名称", field: 'name'},
                {title: "招标项目名称", field: 'tenderName'},
                {title: "任务名称", templet: '#typeLabel'},
                {title: "创建时间", templet: '#createTimeLabel'},
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
            var reviewId = data.id;
            var assigneeId = "${(user.id)!}";

            if (layEvent === 'review') { //点击办理
                $.ajax({
                    url: '/review/review_all_detail?id='+reviewId,
                    type:"GET",
                    cache:false,
                    success: function (res) {
                        //console.log(res);
                        // $('#content').html(res);
                        layui.element.tabDelete('tabBody', 'list-review');
                        layui.element.tabAdd('tabBody', {//添加新Tap
                            title:'审批管理',
                            content: res
                            ,id: 'list-review'
                        });
                        layui.element.tabChange('tabBody', 'list-review');

                    },
                    error: function (xmlHttpReq, error, ex) {

                    }
                })
            }else if (layEvent == 'commit'){



                layer.open({
                    type: 1
                    ,title: '认领任务'
                    ,offset: 'auto' //具体配置参考：http://www.layui.com/doc/modules/layer.html#offset
                    ,id: 'dashauto' //防止重复弹出
                    ,content: '<div style="padding: 20px 100px;">确认认领该任务？</div>'
                    ,btn: '确认'
                    ,btnAlign: 'c' //按钮居中
                    ,shade: 0 //不显示遮罩
                    ,yes: function(){
                        $.ajax({
                            url: "/review/updateReviewStatus",
                            type: "POST",
                            dataType: "json",
                            data: {id:reviewId,assigneeId:assigneeId,status:'approved'},
                            success: function (res) {
                                if(res!=null){
                                    if(res.status){
                                        layer.closeAll('page'); //执行关闭
                                        layer.msg("提交成功!");
                                        $("#review").click();
                                    }else{
                                        layer.msg("提交失败!");
                                    }
                                }else{
                                    layer.msg("提交失败!");
                                }
                            },
                            error: function (xmlHttpReq, error, ex) {
                                layer.msg("提交失败!");
                            }
                        })

                    }
                });


            }
        });

    });

</script>

<style>

    .layui-form-pane .layui-input-block {
        margin-left: 0px;
        text-align: center;
    }

</style>
</html>