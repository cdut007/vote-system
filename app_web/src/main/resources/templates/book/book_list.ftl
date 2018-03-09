<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>预订管理列表</title>
<#include "../resource.ftl">
</head>
<body>
<#include "../top_menus.ftl">

<div class="layui-tab" lay-filter="booktab">
<ul class="layui-tab-title">
    <li lay-id="record" class="layui-this">预订记录</li>
    <li>房间预订</li>

</ul>
    <div class="layui-tab-content">
        <div class="layui-tab-item layui-show layui-container margin-top">

            <div class="searchTable">
                <div class="layui-inline">

                    <form class="layui-form" action="">

                            <label class="layui-form-label">房间</label>
                            <div class="layui-input-inline">
                                <select name="roomId" lay-verify="required" lay-filter="room_select" lay-search="">
                                    <option value="">直接选择或搜索选择</option>
                                     <#list roomList as room>
                                     <option value='${room.id!}'>${room.name!}</option>
                                     </#list>

                                </select>
                            </div>


                    </form>

                </div>

                <div class="layui-inline">
                    <label class="layui-form-label">开始时间</label>
                    <div class="layui-input-inline">
                        <input type="text" class="layui-input" id="record_begin_time" placeholder="">
                    </div>

                </div>

                <div class="layui-inline">
                    <label class="layui-form-label">结束时间</label>
                    <div class="layui-input-inline">
                        <input type="text" class="layui-input" id="record_end_time" placeholder="">
                    </div>
                </div>
                <button class="layui-btn" data-type="reload" id="search_book_record">查询记录</button>
                <button class="layui-btn" data-type="reload" id="download_record">下载报表</button>
            </div>


            <div class="layui-row">
                <div class="layui-col-md-12">
                    <table class="table table-bordered table-hover" id="bookRecordTable" lay-filter="bookRecordTable">
                    </table>
                </div>
            </div>
        </div>

        <div class="layui-tab-item layui-container margin-top">

            <div class="searchTable">

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

                <button class="layui-btn" data-type="reload" id="search_room">查询房间</button>
            </div>




            <div class="layui-row">
                <div class="layui-col-md-12">
                    <table class="table table-bordered table-hover"  id="bookTable" lay-filter="bookTable">
                    </table>
                </div>
            </div>
        </div>


    </div>
</div>
</body>

<script type="text/html" id="indexTpl">
    {{d.LAY_TABLE_INDEX+1}}
</script>
<script type="text/html" id="bookTableTool">
    <a class="layui-btn layui-btn-xs" lay-event="book">预订</a>
</script>




<script type="text/html" id="bookRecordTableTool">

    {{#  if(d.status === 'cancel'){ }}
    <span style="color: #F581B1;">{{ '已取消' }}</span>

    {{#  } }}

    {{#  if(d.status === 'occupy'){ }}
    <span style="color: #00F7DE;">{{ '使用中' }}</span>

    {{#  } }}

    {{#  if(d.status === 'expired'){ }}
    <span style="color: #e8e8e8;">{{ '已完成' }}</span>

    {{#  } }}

    {{#  if(d.status === 'ordered'){ }}
    <a class="layui-btn layui-btn-xs" lay-event="cancelBook">取消预订</a>

    {{#  } }}


</script>


<script type="text/html" id="beginTime">
    {{ new Date(beginTime).format("yyyy-MM-dd hh:mm:ss") }}
</script>

<script type="text/html" id="endTime">
    {{ new Date(endTime).format("yyyy-MM-dd hh:mm:ss") }}
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


    var beginDate = new Date();
    var endDate = new Date(beginDate.getTime() + 8 * 3600 *1000);
    var beginTime = beginDate.getTime(),endTime = endDate.getTime();

    layui.use(['form','element','table', 'util', 'itenderBook','laydate'], function () {
        var table = layui.table;
        var form = layui.form;
        var itenderBookModule = layui.itenderBook;
        var element = layui.element; //Tab的切换功能，切换事件监听等，需要依赖element模块

        var record_beginDate = new Date(beginDate.getTime() - 30*24 * 3600 *1000);
        var record_endDate = new Date(record_beginDate.getTime() + 30*24 * 3600 *1000);

        var recordBeginTime = null,recordEndTime = null;
        var roomId=null;

        var searchDate = {beginTime:beginTime,endTime:endTime};
        var searchRecordDate = {beginTime:recordBeginTime,endTime:recordEndTime};




        form.on('select(room_select)', function(data){
            roomId = data.value;

            return false;
        });

        layui.laydate.render({
            elem: '#record_begin_time'
            ,type: 'datetime'
            ,done: function(value, date){
                if(!value){
                    recordBeginTime = 0;

                }else{
                    var time = Date.parse(value.replace(/-/g,"/"));

                    recordBeginTime = time;
                }




                //{year: 2017, month: 8, date: 18, hours: 0, minutes: 0, seconds: 0}
            }
        });

        layui.laydate.render({
            elem: '#record_end_time'
            ,type: 'datetime'
            ,done: function(value, date){
                if(!value){
                    recordEndTime = 0;

                }else{
                    var time = Date.parse(value.replace(/-/g,"/"));
                    recordEndTime = time;
                }


                //{year: 2017, month: 8, date: 18, hours: 0, minutes: 0, seconds: 0}
            }

        });


        layui.laydate.render({
            elem: '#begin_time'
            ,type: 'datetime'
            ,value:beginDate
            ,done: function(value, date){
                if(!value){
                    beginTime = 0;

                }else{
                    var time = Date.parse(value.replace(/-/g,"/"));
                    beginTime = time;
                }
                var time = Date.parse(value.replace(/-/g,"/"));
                //reloadBookList();

                //{year: 2017, month: 8, date: 18, hours: 0, minutes: 0, seconds: 0}
            }
        });

        layui.laydate.render({
            elem: '#end_time'
            ,type: 'datetime'
            ,value: endDate
            ,done: function(value, date){
                if(!value){
                    endTime = 0;

                }else{
                    var time = Date.parse(value.replace(/-/g,"/"));
                    endTime = time;
                }

                //reloadBookList();
                //{year: 2017, month: 8, date: 18, hours: 0, minutes: 0, seconds: 0}
            }

        });


        element.on('tab(booktab)', function(elem){
            if(elem.index == 0){
                recordTable.reload();

            }else{

            }
        });

        //第一个实例
        var recordTable = table.render({
            elem: "#bookRecordTable",
            page: true,
            url: "/book/listBookRecord",
            method: "POST",
            cols: [[
                {title: '序号',templet: '#indexTpl'},
                {title: "房间名", field: 'room'},
                {title: "预订单位", field: 'bookOrganization'},
                {title: "预订事项", field: 'content'},
                {title: "预订类型", field: 'industry'},
                {title: "预订时间", field: 'bookTime'},
                {title: "创建时间", field: 'createTimeStr'},

                {fixed: 'right', align: 'center',toolbar: '#bookRecordTableTool'}

            ]],
            where:{beginTime:recordBeginTime,endTime:recordEndTime,roomId:roomId},

            request: {
                beginTime:'beginTime',
                endTime:'endTime',
                roomId:'roomId',
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

        table.on('tool(bookRecordTable)', function (obj) { //注：tool是工具条事件名，test是table原始容器的属性 lay-filter="对应的值"
            var data = obj.data; //获得当前行数据
            var layEvent = obj.event; //获得 lay-event 对应的值（也可以是表头的 event 参数对应的值）

            var bookId = data.id;
            if (layEvent === 'cancelBook') { //编辑
                itenderBookModule.cancelBook(bookId,function (res,status) {
                    if(status){
                        data.status = 'cancel';
                        recordTable.reload();
                        layui.layer.msg("取消成功！");
                    }else{
                        layui.layer.msg("操作失败！");
                    }
                });
            }

        });


        //第一个实例
        var currentTable = table.render({
            elem: "#bookTable",
            page: true,
            url: "/book/listBook",
            method: "POST",
            id: 'bookReload',
            cols: [[
                {title: '序号',width:120,templet: '#indexTpl'},
                {title: "房间名", width:300,field: 'name'},
                {title: "预订开始时间",width:180,field: 'beginTime', templet: '#beginTime'},
                {title: "预订结束时间",width:180,field: 'endTime', templet: '#endTime'},
                {fixed: 'right', width:354,align: 'center',toolbar: '#bookTableTool'}

            ]],
                where:{beginTime:beginTime,endTime:endTime},

            request: {
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
                console.log(res);

                //得到当前页码
                console.log(curr);

                //得到数据总量
                console.log(count);
            }
        });

        table.on('tool(bookTable)', function (obj) { //注：tool是工具条事件名，test是table原始容器的属性 lay-filter="对应的值"
            var data = obj.data; //获得当前行数据
            var layEvent = obj.event; //获得 lay-event 对应的值（也可以是表头的 event 参数对应的值）

            var bookId = data.id;
            if (layEvent === 'book') { //预订


                var data = {
                    title: '房间预订',//标题
                    area: 'auto',//宽高
                    closeBtn: 1,//关闭按钮
                    shadeClose: true,//是否点击遮罩关闭
                    queryId: bookId,
                    beginTime:searchDate.beginTime,
                    endTime:searchDate.endTime,
                    queryUrl: '/book/add_page'
                }
                itenderBookModule.openModal(data,function (layerDom,index) {

                    if(layerDom == 'end'){
                        //

                        recordTable.reload();
                        currentTable.reload();
                        element.tabChange('booktab', 'record');
                    }else if(layerDom == 'cancel'){

                        currentTable.reload();
                    }

                });
            }

        });



        $('#download_record').click(function () {
            if(!recordBeginTime){
                layer.msg("请选择开始日期!");
                return ;
            }

            if(!recordEndTime){
                layer.msg("请选择结束日期!");
                return ;
            }

            if(recordEndTime < recordBeginTime){
                layer.msg("结束日期不能早于开始日期");
                return ;
            }

            var data = {beginTime:recordBeginTime,endTime:recordEndTime,roomId:roomId}
            itenderBookModule.downloadBook(data,function (res,status) {
                if(status){
                    layer.closeAll('page'); //执行关闭
                    layer.msg("下载成功!");
                }else{
                    layer.msg("下载失败!");
                }
            });

        });


        $('#search_room').click(function () {
            reloadBookList();

        });

        $('#search_book_record').click(function () {
            reloadBookRecordList();

        });

        function reloadBookRecordList() {

            if(recordBeginTime && !recordBeginTime){
                layer.msg("请选择开始日期!");
                return ;
            }

            if(recordBeginTime && !recordEndTime){
                layer.msg("请选择结束日期!");
                return ;
            }


            if(!recordBeginTime && !recordEndTime){
                if(recordEndTime < recordBeginTime){
                    layer.msg("结束日期不能早于开始日期");
                    return ;
                }
            }



            searchRecordDate.beginTime = recordBeginTime;
            searchRecordDate.endTime = recordEndTime;

            //执行重载
            recordTable.reload({
                page: {
                    curr: 1 //重新从第 1 页开始
                },
                where:{beginTime:recordBeginTime,endTime:recordEndTime,roomId:roomId},
                request: {
                    beginTime:'beginTime',
                    endTime:'endTime',
                    roomId:roomId,
                    pageName: 'pageNum', //页码的参数名称，默认：page
                    limitName: 'pagesize' //每页数据量的参数名，默认：limit
                }

            });
        }



        function reloadBookList() {
            if(!beginTime){
                layer.msg("请选择开始日期!");
                return ;
            }

            if(!endTime){
                layer.msg("请选择结束日期!");
                return ;
            }

            if(endTime < beginTime){
                layer.msg("结束日期不能早于开始日期");
                return ;
            }
            searchDate.beginTime = beginTime;
            searchDate.endTime = endTime;

            //执行重载
            currentTable.reload({
                page: {
                    curr: 1 //重新从第 1 页开始
                },
                where:{beginTime:beginTime,endTime:endTime},
                request: {
                    beginTime:'beginTime',
                    endTime:'endTime',
                    pageName: 'pageNum', //页码的参数名称，默认：page
                    limitName: 'pagesize' //每页数据量的参数名，默认：limit
                }

            });
        }



    });

</script>
</html>