
<div class="layui-container margin-top">

    <div class="layui-row">


        <div class="searchTable">

            <div class="layui-inline">

                <form class="layui-form" action="">

                    <label class="layui-form-label">任务名称</label>
                    <div class="layui-input-inline">
                        <select name="typeId" lay-verify="required" lay-filter="type_select">
                            <option value="">请选择</option>
                            <option value='tender'>招标登记表、招标文件审核</option>
                            <option value='notice_delay'>延期公告审核</option>
                            <option value='notice_update'>变更公告审核</option>
                            <option value='notice_cancel'>撤销公告审核</option>
                            <option value='notice_again'>再次公告审核</option>
                            <option value='notice_price_verfiy'>控制价公告&清单审核</option>
                            <option value='bid_winning'>中标通知书及附件审核</option>
                        </select>
                    </div>


                </form>

            </div>



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

<script type="text/html" id="createTimeLabel">
    {{ new Date(d.createTime).format("yyyy/MM/dd hh:mm:ss") }}
</script>

<script type="text/html" id="typeLabel">
    {{getReviewTypeName(d.type) }}
</script>


<script type="text/html" id="nameLabel">
    {{#  if(d.status == 'forbidden'){ }}
     <span style="color: #FF0000;">{{ '【未通过】' }}</span>{{ d.name }}
    {{#  } else { }}
    {{ d.name }}

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


    layui.use(['form','table', 'util', 'itenderReview'], function () {
        var table = layui.table;
        var form = layui.form;
        var itenderReview = layui.itenderReview;
        var keyword;
        var type;
        layui.form.render();


        form.on('select(type_select)', function(data){
            type = data.value;
            searchReload();

            return false;
        });


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

                where:{keyword:keyword,type:type},
                request: {
                    keyword:'keyword',
                    type:'type',
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
                {title: "项目名称", templet: '#nameLabel'},
                {title: "招标项目名称", field: 'tenderName'},
                {title: "任务名称", templet: '#typeLabel'},
                {title: "创建时间", templet: '#createTimeLabel'},
                {title: "操作",fixed: 'right', align: 'center', toolbar: '#reviewTableTool'}
            ]],

            where:{keyword:keyword,type:type},

            request: {
                keyword:'keyword',
                type:'type',
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

            if (layEvent === 'review') { //点击办理
                $.ajax({
                    url: '/review/review_detail?id='+reviewId,
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