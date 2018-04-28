<div  class="form-container " style="margin-top: 30px;margin-bottom: 50px">

    <fieldset class="layui-elem-field layui-field-title">
        <legend>附件列表</legend>
    </fieldset>
    <div class="layui-row">
        <div class="layui-col-md-12">
            <table class="table table-bordered table-hover"  id="recordAllTable" lay-filter="recordAllTable">
            </table>
        </div>
    </div>

</div>



<script type="text/html" id="indexTpl">
    {{d.LAY_TABLE_INDEX+1}}
</script>


<script type="text/html" id="attachTableTool">
    <a class="layui-btn layui-btn-xs  btn-edit" lay-event="view">查看</a>
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
        console.log('refresh iframe');
    }



    layui.use(['itenderReview','table','util','element'], function () {
        var table = layui.table;
        var id = "${(itenderReview.id)!}"

        var attaches = [];

        function getAttachData() {
            $.ajax({
                url: "/review/attaches",
                type: "POST",
                dataType: "json",
                data: {id:id},
                success: function (res) {
                    if(res!=null){
                        if(res.status){
                            attaches = res.data;

                            recordTable.reload({

                                data:attaches

                            });
                        }
                    }
                },
                error: function (xmlHttpReq, error, ex) {

                }
            })
        }



        getAttachData();

        //第一个实例
        var recordTable = table.render({
            elem: "#recordAllTable", skin: 'line',
            even: false,
            page: false,
            // limits: [5, 10, 15],
            // limit: 5, //每页默认显示的数量
            cols: [[
                {title: '序号',fixed: 'left',width:80,templet: '#indexTpl'},
                {title: "附件标题", field: 'name'},
                {title: "操作",width:140, fixed: 'right', align: 'center', toolbar: '#attachTableTool'}
            ]]
        });

        table.on('tool(recordAllTable)', function (obj) { //注：tool是工具条事件名，test是table原始容器的属性 lay-filter="对应的值"
            var data = obj.data; //获得当前行数据
            var layEvent = obj.event; //获得 lay-event 对应的值（也可以是表头的 event 参数对应的值）


            if (layEvent === 'view') { //查看
                //      view.goto('/review/review_scan?attachId='+data.id);
                var src = '/review/review_scan?attachId='+data.id;
                layui.element.tabDelete('tabBody', 'list-review');
                layui.element.tabAdd('tabBody', {//添加新Tap
                    title:'审批管理',
                    content: '<iframe name="iframe" src="' + src + '" frameborder="0" style="width: 100%;"></iframe>'
                    ,id: 'list-review'
                });
                layui.element.tabChange('tabBody', 'list-review');
                reinitIframe();
            }else if (layEvent === 'download') { //下载

                view.goto('/review/download?attachId='+data.id);

            }
        });

    });

</script>

