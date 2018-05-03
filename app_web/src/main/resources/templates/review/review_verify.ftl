<div  class="form-container " style="margin-top: 30px">

    <fieldset class="layui-elem-field layui-field-title">
        <legend>审批</legend>
    </fieldset>
    <div class="layui-row">
        <div class="layui-col-md-12">
            <table class="table table-bordered table-hover" id="verifyAllTable" lay-filter="verifyAllTable">
            </table>
        </div>


        <div class="layui-row">


            <div class="" style="text-align: right;width: 100%">
                <button class="layui-btn" data-type="reload" id="verify">提交</button>
                <button class="layui-btn layui-btn-danger  btn-delete" data-type="reload" id="rollback">退回</button>
            </div>

    </div>

</div>


<script type="text/html" id="indexTpl">
    {{d.LAY_TABLE_INDEX+1}}
</script>


    <script type="text/html" id="signTableTool">
        {{#  if(d.status == 'approved'){ }}
        <span style="color: rgba(76, 76, 76, 0.85);">{{ '已通过' }}</span>
        {{#  } else { }}

        {{# if(d.status == 'forbidden'){ }}
        <span style="color: #F37715;">{{ '不通过' }}</span>
        {{#  } else { }}

                {{# if(d.type == 'notice'){ }}
                 <a class="layui-btn layui-btn-xs  btn-edit" lay-event="sign">审核</a>
                {{#  } else { }}
                <a class="layui-btn layui-btn-xs  btn-edit" lay-event="sign">用印登记</a>
                {{#  } }}

        {{#  } }}

        {{#  } }}

    </script>


    <script type="text/html" id="countTool">

        <#if user??>
            <#if user.operator??>
            <#if user.operator=='operator'>

             {{# if(d.type == 'notice'){ }}
                  {{'/'}}
                {{#  } else { }}
                   {{d.count}}
                {{#  } }}

            </#if>
            </#if>
        <#else>
         {{# if(d.type == 'notice'){ }}
                  {{'/'}}
                {{#  } else { }}
                 {{d.count}}
                {{#  } }}

        </#if>

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

    //调整iframe高度
    function reinitIframe() {
        var iframes = document.getElementsByName("iframe");
        try {
            for(var i = 0; i < iframes.length; i++)
                    //iframes[i].height = iframes[i].contentWindow.document.documentElement.scrollHeight;
            {
                iframes[i].height = window.screen.height;
            }
        } catch(ex) {

        }
    }




    layui.use(['itenderReview','table','util', 'element'], function () {
        var table = layui.table;
        var itenderReview = layui.itenderReview;
        var type = "${(itenderReview.type)!}";
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
                return '选择审批人';
            }

            return null;
        }


        var nextOperator = getNextOperator(operator);

        function getConfirmData(callback) {
            $.ajax({
                url: "/review/confirms",
                type: "POST",
                dataType: "json",
                data: {id:id},
                success: function (res) {
                    if(res!=null){
                        if(res.status){
                            confirms = res.data;
                            if(callback!=null){
                                callback(confirms);
                            }
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

        if(checkReviewNeedSign(type) && operator == 'approver'){
            $("#verify").text('盖章');
        }


        function postToResult() {

            $.ajax({
                url: "/review/postToResult",
                type: "POST",
                dataType: "json",
                data: {reviewId:id},
                success: function (res) {
                    if(res!=null){
                        if(res.status){
                            layer.closeAll('page'); //执行关闭
                            layer.msg("提交成功!");
                            $("#review_nav").click();

                        }else{
                            ShowMessage("提交失败!");
                        }
                    }else{
                        ShowMessage("提交失败!");
                    }
                },
                error: function (xmlHttpReq, error, ex) {
                    ShowMessage("提交失败!");
                }
            })
        }



        $("#verify").click(function () {
            postToResult();

            getConfirmData( function(confirms){
                if(confirms){
                    for(var i = 0 ; i<confirms.length;i++){
                        if(confirms[i].status != 'approved'){
                            if(confirms[i].status == 'forbidden'){
                                layer.msg("审核不通过，请退回!");
                                return
                            }else{
                                layer.msg("请先签章!");
                                return
                            }
                        }
                    }

                    if(checkReviewNeedSign(type) && operator == 'approver'){
                        var src = '/review/review_sign_file?reviewId='+id;
                        layui.element.tabDelete('tabBody', 'list-review');
                        layui.element.tabAdd('tabBody', {//添加新Tap
                            title:'审批管理',
                            content: '<iframe name="iframe" src="' + src + '" frameborder="0" style="width: 100%;"></iframe>'
                            ,id: 'list-review'
                        });
                        layui.element.tabChange('tabBody', 'list-review');
                        reinitIframe();
                    }else{

                        if(operator == 'approver'){

                            layer.open({
                                type: 1
                                ,title: '提交'
                                ,offset: 'auto' //具体配置参考：http://www.layui.com/doc/modules/layer.html#offset
                                ,id: 'dashauto' //防止重复弹出
                                ,content: '<div style="padding: 20px 100px;">确认提交至交易平台？</div>'
                                ,btn: '确认'
                                ,btnAlign: 'c' //按钮居中
                                ,shade: 0 //不显示遮罩
                                ,yes: function(){
                                    postToResult();
                                }
                            });

                        }else{
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

                    }


                }
            });



                }
        );

        $("#rollback").click(function () {
            layer.open({
                type: 1
                ,title: '退回任务'
                ,offset: 'auto' //具体配置参考：http://www.layui.com/doc/modules/layer.html#offset
                ,id: 'dashauto' //防止重复弹出
                ,content: '<div style="padding: 20px 100px;">确认退回上一级？</div>'
                ,btn: '确认'
                ,btnAlign: 'c' //按钮居中
                ,shade: 0 //不显示遮罩
                ,yes: function(){
                    $.ajax({
                        url: "/review/rollbackReviewStatus",
                        type: "POST",
                        dataType: "json",
                        data: {id:id},
                        success: function (res) {
                            if(res!=null){
                                if(res.status){
                                    layer.closeAll('page'); //执行关闭
                                    layer.msg("退回成功!");
                                    $("#review_nav").click();
                                }else{
                                    layer.msg("退回失败!");
                                }
                            }else{
                                layer.msg("退回失败!");
                            }
                        },
                        error: function (xmlHttpReq, error, ex) {
                            layer.msg("退回失败!");
                        }
                    })

                }
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
                {title: '序号',fixed: 'left',width:80,templet: '#indexTpl'},
                {title: "文档标题", field: 'name'},
                {title: "份数", field:'count', align: 'center',event: 'setCount', style:'cursor: pointer;',templet: '#countTool'},
                {title: "审核",fixed: 'right',width:140, align: 'center', toolbar: '#signTableTool'}
            ]],
            data:confirms

        });




        table.on('tool(verifyAllTable)', function (obj) { //注：tool是工具条事件名，test是table原始容器的属性 lay-filter="对应的值"
            var data = obj.data; //获得当前行数据
            var layEvent = obj.event; //获得 lay-event 对应的值（也可以是表头的 event 参数对应的值）
            var signId = "${(user.id)!}";
            var description= '通过';
            var signResult="approved";
            var confirmId = data.id;

            if (layEvent === 'sign') { //

                if(data.type != 'notice'){
                    if (!data.count||isNaN(data.count)){
                        layer.msg("请设置份数");
                        return;
                    }
                }



               // view.goto('/review/review_sign?confirmId='+confirmId);
                var title = $('#title').text();


                var src = '/review/review_sign?confirmId='+confirmId+"&title="+  encodeURIComponent(title);
                        layui.element.tabDelete('tabBody', 'list-review');
                        layui.element.tabAdd('tabBody', {//添加新Tap
                            title:'审批管理',
                            content: '<iframe name="iframe" src="' + src + '" frameborder="0" style="width: 100%;"></iframe>'
                            ,id: 'list-review'
                        });
                        layui.element.tabChange('tabBody', 'list-review');

                reinitIframe();

            } else  if(obj.event === 'setCount') {

                if(operator != 'operator'){
                    return;
                }

                if(data.status == 'approved'){
                    return;
                }
                if(data.type == 'notice'){
                    return;
                }



                layer.prompt({
                    formType: 2
                    , title: '修改份数'
                    , value: data.count
                }, function (value, index) {
                    var reg = new RegExp("^[0-9]*$");
                    if (!reg.test(value)) {
                        layer.msg("请输入合法整数!");
                        return
                    }


                    $.ajax({
                        url: "/review/updateConfirmCount",
                        type: "POST",
                        dataType: "json",
                        data: {confirmId: confirmId, count: value},
                        success: function (res) {
                            layer.close(index);
                            if(res!=null){
                                if(res.status){
                                    //这里一般是发送修改的Ajax请求

                                    //同步更新表格和缓存对应的值
                                    obj.update({
                                                count: value
                                            }
                                    );
                                    getConfirmData();

                                }else{
                                    layer.msg("提交失败!");
                                }
                            }else{
                                layer.msg("提交失败!");
                            }

                        },
                        error: function (xmlHttpReq, error, ex) {
                            layer.msg("提交失败!");
                            layer.close(index);
                        }
                    })

                });
            }


        });

        getConfirmData();

    });

</script>

