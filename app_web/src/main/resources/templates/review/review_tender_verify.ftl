<div  class="form-container ">

    <fieldset class="layui-elem-field layui-field-title">
        <legend>用印审核</legend>
    </fieldset>
    <div class="layui-row">
        <div class="layui-col-md-12">
            <table class="table table-bordered table-hover" id="verifyAllTable" lay-filter="verifyAllTable">
            </table>
        </div>


        <div class="layui-row">


            <div class="" style="text-align: right;width: 100%">

                <button class="layui-btn" data-type="reload" id="verify">提交</button>
            </div>

    </div>

</div>


<script type="text/html" id="indexTpl">
    {{d.LAY_TABLE_INDEX+1}}
</script>


    <script type="text/html" id="signTableTool">
        <a class="layui-btn layui-btn-xs  btn-edit" lay-event="sign">签章</a>
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


    layui.use(['itenderReview','table','util', 'element'], function () {
        var table = layui.table;
        var itenderReview = layui.itenderReview;
        var operator ="${(user.operator)!}";
        var id = "${(itenderReview.id)!}";
        var confirms = [];

        function getNextOperator(operator) {

            var operators=['operator','department_leader','branch_leader','approver'];
             for(var i = 0 ; i<operators.length;i++){
                if(operators[i] == operator){
                    if(i+1<operators.length){
                        return operators[i+1];
                    }else{

                        return null;
                    }

                }
             }

            return null;
        }



        function getOperatorTitle(operator) {

            if(operator == 'department_leader'){
                return '选择科室负责人';
            }else if(operator == 'branch_leader'){
                return '选择分管负责人';
            }else if(operator == 'approver'){
                return '选择审批负责人';
            }

            return null;
        }


        var nextOperator = getNextOperator(operator);

        function getConfirmData() {
            $.ajax({
                url: "/review/confirms",
                type: "POST",
                dataType: "json",
                data: {id:id},
                success: function (res) {
                    if(res!=null){
                        if(res.status){
                            confirms = res.data;

                            verifyTable.reload({

                                data:confirms

                            });
                        }
                    }
                },
                error: function (xmlHttpReq, error, ex) {

                }
            })
        }

        $("#verify").click(function () {
            var title  = getOperatorTitle(nextOperator);
            var data = {
                title: title,//标题
                area: 'auto',//宽高
                closeBtn: 1,//关闭按钮
                shadeClose: true,//是否点击遮罩关闭
                queryUrl: '/review/choose_operator_page?operator='+nextOperator+"&id="+id
            }
            itenderReview.openModal(data,function (layerDom,index) {
                getConfirmData();
            });

                }
        );

        //第一个实例
        var verifyTable = table.render({
            elem: "#verifyAllTable", skin: 'line',
            even: true,
            page: false,
            // limits: [5, 10, 15],
            // limit: 5, //每页默认显示的数量
            cols: [[
                {title: '序号',templet: '#indexTpl'},
                {title: "文档标题", field: 'name'},
                {title: "审核",fixed: 'right', align: 'center', toolbar: '#signTableTool'}
            ]],
            data:confirms

        });

        table.on('tool(verifyAllTable)', function (obj) { //注：tool是工具条事件名，test是table原始容器的属性 lay-filter="对应的值"
            var data = obj.data; //获得当前行数据
            var layEvent = obj.event; //获得 lay-event 对应的值（也可以是表头的 event 参数对应的值）
            var landId = data.landId;
            var userId = data.userId;

            if (layEvent === 'sign') { //

            }


        });

        getConfirmData();

    });

</script>

