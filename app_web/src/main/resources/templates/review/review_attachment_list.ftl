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



<script type="text/html" id="indexTpl">
    {{d.LAY_TABLE_INDEX+1}}
</script>


<script type="text/html" id="attachTableTool">
    <a class="layui-btn layui-btn-xs  btn-edit" lay-event="view">查看</a>
    <a class="layui-btn layui-btn-xs  btn-edit" lay-event="download">下载</a>
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
                {title: '序号',templet: '#indexTpl'},
                {title: "文档标题", field: 'name'},
                {title: "文档性质", field: 'unitPrice'},
                {title: "文档操作",fixed: 'right', align: 'center', toolbar: '#attachTableTool'}
            ]]
        });

        table.on('tool(recordAllTable)', function (obj) { //注：tool是工具条事件名，test是table原始容器的属性 lay-filter="对应的值"
            var data = obj.data; //获得当前行数据
            var layEvent = obj.event; //获得 lay-event 对应的值（也可以是表头的 event 参数对应的值）
            var landId = data.landId;
            var userId = data.userId;

            if (layEvent === 'view') { //查看
                var attachmentUrl = 'http://raw.githubusercontent.com/pauldmps/Android-pdf.js/master/assets/compressed.tracemonkey-pldi-09.pdf';
                var curWwwPath=window.document.location.href;
                var pathName=window.document.location.pathname;
                var pos=curWwwPath.indexOf(pathName);
                var localhostPath=curWwwPath.substring(0,pos);
                window.open(localhostPath+"/pdf/web/viewer.html?file="+attachmentUrl);
            //    view.goto('/pdf/print?userId='+userId+"&landId="+landId);
            }else if (layEvent === 'download') { //下载
                //
            }
        });

    });

</script>

