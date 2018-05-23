<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>交易平台 - 测试</title>
    <#include "../resource.ftl">
    <script src="/js/encryption.js"></script>
    <script src="/js/md5.js"></script>
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

    <div  class="login-label" id="title">
        测试系统
    </div>

    <div align="center" class="" style="margin:0 auto;width:380px; height: 420px;background-color:#f6f6f6;z-index: 1000; ">

        <div class="layui-row" style="">

            <form class="layui-form" action="">

                <select id="account_item" name="account" lay-verify="required" lay-filter="account_select">
                    <option value="">请选择账号</option>
                    <option value='zhaofu1;12345678'>招标人-招负1（zhaofu1）</option>
                    <option value='toufu1;12345678'>投标人-投负1（toufu1）</option>
                    <option value='toufu2;12345678'>投标人-投负2（toufu2）</option>
                    <option value='toufu3;12345678'>投标人-投负3（toufu3）</option>
                    <option value='daifu1;12345678'>代理机构-代负1（daifu1）</option>
                    <option value='zhaozhuanyuan;123456'>专员-zhaozhuanyuan</option>
                    <option value='zhangjingli;123456'>经理-zhangjingli</option>
                    <option value='likuaiji;123456'>会计-likuaiji</option>
                    <option value='樊俊明;123456'>专家-樊俊明</option>
                    <option value='翟旭东;123456'>专家-翟旭东</option>
                    <option value='张小平;123456'>专家-张小平</option>
                    <option value='张志明;123456'>专家-张志明</option>
                    <option value='王朝霞;123456'>专家-王朝霞</option>
                    <option value='E;Ul!@#$%12345'>平台审核-E</option>
                </select>
            </form>

            <form class="layui-form" action="">

                <select id="domain_item" name="domain" lay-verify="required" lay-filter="domain_select">
                    <option value="">请选择环境</option>
                    <option value='https://stage.jcebid.com'>57环境</option>
                    <option value='http://47.94.241.88'>88环境</option>
                    <option value='http://127.0.0.1:8080'>本地环境</option>
                </select>
            </form>

                    <div class="layui-form-item">
                        <div class="layui-input-block">
                            <button id="login" type="submit" class="layui-btn layui-btn-default layui-btn-block" lay-submit lay-filter="login" style="width: 100%">
                                登录
                            </button>
                        </div>

                    </div>

            <div class="layui-form-item">
                <div class="layui-input-block">
                    <button id="join" type="submit" class="layui-btn layui-btn-default layui-btn-block" lay-submit lay-filter="join" style="width: 100%">
                        投标人报名
                    </button>
                </div>

            </div>



            <div class="layui-form-item">
                <div class="layui-input-block">

                    <button id="logout" type="submit" class="layui-btn layui-btn-danger layui-btn-block" lay-submit lay-filter="login" style="width: 100%">
                        登出
                    </button>
                </div>
            </div>


            <div class="layui-form-item">
                <div class="layui-input-block">
                    <button id="createProject" type="submit" class="layui-btn layui-btn-default layui-btn-block" lay-submit lay-filter="create" style="width: 100%">
                        新建項目
                    </button>
                </div>
            </div>

            <div class="layui-form-item">
                <div class="layui-input-block">
                    <button id="decrptProject" type="submit" class="layui-btn layui-btn-default layui-btn-block" lay-submit lay-filter="decrpt" style="width: 100%">
                        一键解密开标
                    </button>
                </div>
            </div>

        </div>



    </div>


    <div class="layui-row">
        <div class="layui-col-md-12">
            <table class="table table-bordered table-hover" id="taskTable" lay-filter="taskTable">
            </table>
        </div>
    </div>

</div>
</body>


<div id="chooseOrganizationA"  style="display: none">
    <form class="layui-form" action="">
    <select id="organization_item" lay-verify="required" lay-filter="organization_select">
        <option value="">请选择代理机构</option>
    </select>
</form>
    <div class="layui-input-block">

        <button id="online_organizationA"  class="layui-btn layui-btn-default layui-btn-block" style="width: 100%">
            在线提交
        </button>
    </div>
</div>


<div id="noticeJoin"  style="display: none">
    <form class="layui-form" action="">
        <select id="notice_item" lay-verify="required" lay-filter="notice_select">
            <option value="">请选择代理机构</option>
        </select>
    </form>
    <div class="layui-input-block">

        <button id="online_notice"  class="layui-btn layui-btn-default layui-btn-block" style="width: 100%">
            报名
        </button>
    </div>
</div>


<div id="decrptPro"  style="display: none">
    <form class="layui-form" action="">
        <select id="project_item" lay-verify="required" lay-filter="project_select">
            <option value="">请选择开标解密项目</option>
        </select>
    </form>
    <div class="layui-input-block">

        <button id="online_decrpt"  class="layui-btn layui-btn-default layui-btn-block" style="width: 100%">
            一键解密
        </button>
    </div>
</div>


<div id="createPro"  style="display: none">

    <div class="layui-inline">
        <label class="layui-form-label">项目名称</label>
        <div class="layui-input-inline">
            <input type="text" class="layui-input" id="projectName" placeholder="输入项目名称...">
        </div>

    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">招标文件获取时间</label>
        <div class="layui-input-inline">
            <input lay-verify="required"  type="text" class="layui-input date " id="applyDateBegin" placeholder="">
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">招标文件获取截止时间</label>
        <div class="layui-input-inline">
            <input lay-verify="required"  type="text" class="layui-input date " id="applyDateEnd" placeholder="">
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">投标文件递交截止时间</label>
        <div class="layui-input-inline">
            <input lay-verify="required"  type="text" class="layui-input date " id="bidDeadline" placeholder="">
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">开标时间</label>
        <div class="layui-input-inline">
            <input lay-verify="required"  type="text" class="layui-input date " id="bidOpenDate" placeholder="">
        </div>
    </div>

    <div class="layui-input-block">

        <button id="online_create"  class="layui-btn layui-btn-default layui-btn-block" style="width: 100%">
            创建
        </button>
    </div>
</div>


<script type="text/html" id="indexTpl">
    {{d.LAY_INDEX}}
</script>
<script type="text/html" id="taskTableTool">
    {{#  if(!d.assignee){ }}
    <a class="layui-btn  layui-btn-xs layui-btn-danger" lay-event="review">点击签收</a>
    {{#  } else { }}
    <a class="layui-btn layui-btn-xs btn-edit" lay-event="review">点击办理</a>

    {{#  } }}
</script>

<script type="text/html" id="createTimeLabel">
    {{ d.createTime}}
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

    layui.use(['form','layer','table','itenderUser','laydate'], function () {
        var form = layui.form;
        var itenderUser = layui.itenderUser;
        var layer = layui.layer;
        var table = layui.table;
        var domain;
        var account;
        var userId;
        var organizationA;
        var noticeJoin;
        var decrptProject;
        var applyDateBegin,applyDateEnd,bidDeadline,bidOpenDate;
        form.render();
        $("#login").show();
        $("#logout").hide();


        layui.laydate.render({
            elem: '#applyDateBegin'
            ,type: 'datetime'
            ,done: function(value, date){
                var time = Date.parse(value.replace(/-/g,"/"));

                applyDateBegin = time;

                //{year: 2017, month: 8, date: 18, hours: 0, minutes: 0, seconds: 0}
            }
        });

        layui.laydate.render({
            elem: '#applyDateEnd'
            ,type: 'datetime'
            ,done: function(value, date){
                var time = Date.parse(value.replace(/-/g,"/"));

                applyDateEnd = time;

                //{year: 2017, month: 8, date: 18, hours: 0, minutes: 0, seconds: 0}
            }
        });

        layui.laydate.render({
            elem: '#bidOpenDate'
            ,type: 'datetime'
            ,done: function(value, date){
                var time = Date.parse(value.replace(/-/g,"/"));

                bidOpenDate = time;

                //{year: 2017, month: 8, date: 18, hours: 0, minutes: 0, seconds: 0}
            }
        });

        layui.laydate.render({
            elem: '#bidDeadline'
            ,type: 'datetime'
            ,done: function(value, date){
                var time = Date.parse(value.replace(/-/g,"/"));

                bidDeadline = time;

                //{year: 2017, month: 8, date: 18, hours: 0, minutes: 0, seconds: 0}
            }
        });

        form.on('select(organization_select)', function(data){

            organizationA = data.value;

            return false;
        });
        form.on('select(notice_select)', function(data){

            noticeJoin = data.value;

            return false;
        });
        form.on('select(project_select)', function(data){

            decrptProject = data.value;

            return false;
        });


        form.on('select(domain_select)', function(data){
            domain = data.value;

            return false;
        });

        form.on('select(account_select)', function(data){
            account = data.value;

            return false;
        });

        $("#join").click(function () {
            $.ajax({
                url: "/test/getTenderProjectList",
                type: "POST",
                dataType: "json",
                data: {},
                success: function (res) {
                    var obj =res.data;
                    var objLength = obj.length;
                    if(objLength>0){

                        $('#notice_item').empty();
                        $("#notice_item").append('<option value="">请选择报名</option>');

                        $(obj).each(function (i) {

                            $("#notice_item").append('<option value="' + obj[i].noticeId + '">' + obj[i].title + '</option>');

                        });


                    }else{

                        $('#notice_item').find('option').remove();
                        $("#notice_item").append('<option value="">请选择报名</option>');


                    }

                    bindNoticeTenderCommit(obj);

                    layer.open({
                        title: '选择招标报名',
                        type: 1,
                        area: ['500px', '300px']
                        ,content: $('#noticeJoin')
                        ,
                        success: function() {
                            form.render()


                        }
                    });

                },
                error: function (xmlHttpReq, error, ex) {
                    layer.close(index);
                    alert("获取招标公告失败!");
                }
            })
        });




        function bindNoticeTenderCommit(data) {
            $("#online_notice").click(function() {
                if (!noticeJoin) {
                    layer.msg("请选择报名!");
                    return;
                }

                // var orgName = '';
                // for (var i = 0; i < data.length; i++) {
                //     if(data[i].noticeId == noticeJoin){
                //         orgName = data[i].title;
                //         break
                //     }
                // }

                $.ajax({
                    url: "/test/tenderApplicationForm",
                    type: "POST",
                    dataType: "json",
                    data: {
                        noticeId: noticeJoin
                        ,userId:userId
                    },
                    success: function(res) {
                        if (res != null) {
                            if (res.status) {
                                alert("选择报名提交成功!");
                                reloadTaskTable();
                            } else {
                                layer.msg("选择报名提交失敗!");
                            }
                        }
                    },
                    error: function(xmlHttpReq, error, ex) {
                        layer.msg("选择报名失敗!");
                    }
                })
            });
        }

        $("#login").click(function () {

           if(!account){
               layer.msg("选择登录账号!");
               return;
           }

           var userInfo = account.split(";");

            var password = encode64(userInfo[1]);
            var  verify = (b64_md5(Utf8Encode(userInfo[0])));
            verify = verify+(b64_md5(Utf8Encode(password)));
            var username = userInfo[0];
            userId = username;
            var index = layer.load(1, {
                shade: [0.1,'#fff'] //0.1透明度的白色背景
            });

           $.ajax({
               url: "/test/login",
               type: "POST",
               dataType: "json",
               data: {password:password,verify:verify,username:username,domain:domain,userId:userId},
               success: function (res) {
                   layer.close(index);
                   if(res!=null){
                       if(res.status){
                           $("#title").text('已登录');
                           $("#title").css({"background-color":"#00ff00"});

                           layer.msg("登陸成功!");
                           reloadTaskTable();
                           $("#login").hide();
                           $("#logout").show();
                       }else{
                           layer.msg("登陸失敗!");
                       }
                   }
               },
               error: function (xmlHttpReq, error, ex) {
                   layer.close(index);
                   alert("登陸失敗!");
               }
           })
       });

        $("#decrptProject").click(function () {
            var index = layer.load(1, {
                shade: [0.1,'#fff'] //0.1透明度的白色背景
            });
            $.ajax({
                url: "/test/pagingBidOpeningData",
                type: "POST",
                dataType: "json",
                data: {userId:userId},
                success: function (res) {
                    layer.close(index);
                    if(res!=null){
                        if(res.data && res.data.length>0){
                            var obj =res.data;
                            var objLength = obj.length;
                            if(objLength>0){

                                $('#project_item').empty();
                                $("#project_item").append('<option value="">请选择一键解密项目</option>');

                                $(obj).each(function (i) {
                                        var item = obj[i];
                                    $("#project_item").append('<option value="' + item[item.length-1] + '">' + item[0] + '</option>');

                                });


                            }else{

                                $('#project_item').find('option').remove();
                                $("#project_item").append('<option value="">请选择一键解密项目</option>');


                            }

                            bindDecrptProjectCommit(obj);

                            layer.open({
                                title: '选择解密项目',
                                type: 1,
                                area: ['500px', '300px']
                                ,content: $('#decrptPro')
                                ,
                                success: function() {
                                    form.render()


                                }
                            });
                        }else{
                            alert("一键开标解密失败!"+ res.msg);
                        }
                    }
                },
                error: function (xmlHttpReq, error, ex) {
                    layer.close(index);
                    alert("一键开标解密失败!");
                }
            })
        })

        function bindDecrptProjectCommit(data) {
            $("#online_decrpt").click(function() {
                if (!decrptProject) {
                    layer.msg("请选择解密项目!");
                    return;
                }

                $.ajax({
                    url: "/test/openDecrypt",
                    type: "POST",
                    dataType: "json",
                    data: {
                        expertApplyId: decrptProject
                        ,userId:userId
                    },
                    success: function(res) {
                        if (res != null) {
                            if (res.status) {
                                alert("选择解密项目成功!");
                                reloadTaskTable();
                            } else {
                                layer.msg("选择解密项目失敗!");
                            }
                        }
                    },
                    error: function(xmlHttpReq, error, ex) {
                        layer.msg("选择解密项目失敗!");
                    }
                })
            });
        }
        $("#createProject").click(function () {



            layer.open({
                title: '选择解密项目',
                type: 1,
                area: ['500px', '450px']
                ,content: $('#createPro')
                ,
                success: function() {
                    form.render()


                }
            });

            $("#online_create").click(function() {


                var projectName =  $("#projectName").val();

                if(!projectName){
                    layer.msg("输入项目名称!");
                    return;
                }

                if(!applyDateBegin||!applyDateEnd||!bidDeadline||!bidOpenDate){
                    layer.msg("选择时间!");
                    return;
                }



                var index = layer.load(1, {
                    shade: [0.1,'#fff'] //0.1透明度的白色背景
                });


                $.ajax({
                    url: "/test/createProject",
                    type: "POST",
                    dataType: "json",
                    data: {userId:userId,projectName:projectName,applyDateBegin:applyDateBegin,
                        applyDateEnd:applyDateEnd,bidDeadline:bidDeadline,bidOpenDate:bidOpenDate},
                    success: function (res) {
                        layer.close(index);
                        if(res!=null){
                            if(res.status){
                                alert("創建成功!");
                                reloadTaskTable();
                            }else{
                                alert("創建失敗!"+ res.msg);
                            }
                        }
                    },
                    error: function (xmlHttpReq, error, ex) {
                        layer.close(index);
                        alert("創建失敗!");
                    }
                })
            });


        });


        $("#logout").click(function () {

            $.ajax({
                url: "/test/logout",
                type: "POST",
                dataType: "json",
                data: {userId:userId},
                success: function (res) {
                    $("#title").text('测试系统');
                    $("#title").css({"background-color":"#ff0000"});
                    $("#login").show();
                    $("#logout").hide();
                    userId=null;
                    reloadTaskTable();
                },
                error: function (xmlHttpReq, error, ex) {

                }
            })
        });


        var currentTable = table.render({
            elem: "#taskTable", skin: 'nob',
            even: true,
            page: true,
            url: "/test/workflow/pagingTask",
            method: "POST",
            cols: [[
                {title: '序号',templet: '#indexTpl'},
                {title: "任务名称", field: 'name'},
                {title: "任务描述", field: 'description'},
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

        table.on('tool(taskTable)', function (obj) { //注：tool是工具条事件名，test是table原始容器的属性 lay-filter="对应的值"
            var data = obj.data; //获得当前行数据
            var layEvent = obj.event; //获得 lay-event 对应的值（也可以是表头的 event 参数对应的值）
            var taskId = data.id;
            var assignId = data.assignee;

            if(!assignId){
                assignId = '';
            }

            if (layEvent === 'review') { //点击办理

                var index = layer.load(1, {
                    shade: [0.1,'#fff'] //0.1透明度的白色背景
                });

                $.ajax({
                    url: '/test/workflow/customTaskForm?taskId='+taskId+"&userId="+userId+"&assignee="+assignId+"&taskName="+data.name,
                    type:"GET",
                    cache:false,
                    success: function (res) {
                        layer.close(index);
                        if(res!=null){
                            if(res.status){
                               if(res.type == '委托代理机构'){
                                   var obj =res.data;
                                   var objLength = obj.length;
                                   if(objLength>0){

                                       $('#organization_item').empty();
                                       $("#organization_item").append('<option value="">请选择代理机构</option>');

                                       $(obj).each(function (i) {

                                           $("#organization_item").append('<option value="' + obj[i].organizationAId + '">' + obj[i].title + '</option>');

                                       });


                                   }else{

                                       $('#organization_item').find('option').remove();
                                       $("#organization_item").append('<option value="">请选择代理机构</option>');


                                   }

                                   bindOrganizationCommit(taskId,obj);

                                   layer.open({
                                       title: '选择代理机构',
                                       type: 1,
                                       area: ['500px', '300px']
                                       ,content: $('#chooseOrganizationA')
                                       ,
                                       success: function() {
                                           form.render()


                                       }
                                   });
                               }else if(res.type == '上传委托代理合同'){
                                   layer.msg("上传委托代理合同成功!");
                                   reloadTaskTable();

                               }else if(res.type == '指定项目经理'){
                                   layer.msg("指定项目经理成功!");
                                   reloadTaskTable();
                               }else if(res.type == '指定待办人'){
                                   layer.msg("指定待办人成功!");
                                   reloadTaskTable();
                               }else if(res.type == '指定报名审核专员'){
                                   layer.msg("指定报名审核专员成功!");
                                   reloadTaskTable();
                               }else if(res.type == '项目管理'){
                                   layer.msg("项目管理操作成功!");
                                   reloadTaskTable();
                               }else if(res.type == '招标/资格预审公告审核'){
                                   layer.msg("招标/资格预审公告审核成功!");
                                   reloadTaskTable();
                               }else if(res.type == '招标文件项目经理审核'){
                                   layer.msg("招标文件项目经理审核成功!");
                                   reloadTaskTable();
                               }else if(res.type == '招标文件代理机构审核'){
                                   layer.msg("招标文件代理机构审核成功!");
                                   reloadTaskTable();
                               }else if(res.type == '专家抽取申请信息'){
                                   layer.msg("专家抽取申请信息成功!");
                                   reloadTaskTable();
                               }else if(res.type == '报名申请'){
                                   layer.msg("报名申请审核成功!");
                                   reloadTaskTable();
                               }else if(res.type == '投标文件上传'){
                                   layer.msg("投标文件上传成功!");
                                   reloadTaskTable();
                               }else if(res.type == '开标现场'){
                                   layer.msg("投标人签到成功!");
                                   reloadTaskTable();
                               }else if(res.type == '专家签到'){
                                   layer.msg("专家签到成功!");
                                   reloadTaskTable();
                               }else if(res.type == '投标文件上传回执'){
                                   layer.msg("投标文件上传回执成功!");
                                   reloadTaskTable();
                               }else if(res.type == '指定评标委员会组长'){
                                   layer.msg("指定评标委员会组长成功!");
                                   reloadTaskTable();
                               }else if(res.type == '基准价系数抽取'){
                                   layer.msg("基准价系数抽取成功!");
                                   reloadTaskTable();
                               }else if(res.type == '第一信封文件解密'){
                                   layer.msg("第一信封文件解密成功!");
                                   reloadTaskTable();
                               }else{
                                   reloadTaskTable();
                               }
                            }else{
                                alert("处理失败!"+ res.msg);
                            }
                        }


                    },
                    error: function (xmlHttpReq, error, ex) {
                        layer.close(index);
                    }
                })


                function bindOrganizationCommit(taskId,data) {
                    $("#online_organizationA").click(function() {
                        if (!organizationA) {
                            layer.msg("选择代理机构!");
                            return;
                        }

                        var orgName = '';
                        for (var i = 0; i < data.length; i++) {
                            if(data[i].organizationAId == organizationA){
                                orgName = data[i].title;
                                break
                            }
                        }

                        $.ajax({
                            url: "/test/commitOrgazationA",
                            type: "POST",
                            dataType: "json",
                            data: {
                                orgId: organizationA,
                                organAName:orgName,
                                taskId:taskId
                                ,userId:userId
                            },
                            success: function(res) {
                                if (res != null) {
                                    if (res.status) {
                                        alert("选择代理机构提交成功!");
                                        reloadTaskTable();
                                    } else {
                                        layer.msg("选择代理机构提交失敗!");
                                    }
                                }
                            },
                            error: function(xmlHttpReq, error, ex) {
                                layer.msg("选择代理机构提交失敗!");
                            }
                        })
                    });
                }

            }
        });


        function reloadTaskTable() {
            currentTable.reload({

                page: {
                    curr: 1 //重新从第 1 页开始
                },

                where:{userId:userId},
                request: {
                    pageName: 'pageNum', //页码的参数名称，默认：page
                    limitName: 'pagesize' //每页数据量的参数名，默认：limit
                }


            });
        }



    });
</script>
</html>
