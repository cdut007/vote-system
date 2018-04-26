<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>电子签章</title>
    <#include "../resource.ftl">
</head>
<body class="layui-layout-body">
<div class="layui-layout layui-layout-admin">
<#include "../dashboard_top_menus.ftl">
    <div class="layui-side layui-bg-black">
        <div class="layui-side-scroll">
            <!-- 左侧导航区域（可配合layui已有的垂直导航） -->
            <ul class="layui-nav layui-nav-tree"  lay-filter="test">

            <#--<@resource_check url="/review">-->
                <li class="layui-nav-item layui-side-item"><a id="review" href="javascript:;"><img src="/css/img/icon_my_task_default.png" class="layui-nav-side-img">待办任务</a></li>
            <#--</@resource_check>-->

                    <#if user??>
                        <#if user.operator=='operator'>
                        <li class="layui-nav-item layui-side-item"><a id="reviewAll" href="javascript:;"><img src="/css/img/icon_all_tasks_default.png" class="layui-nav-side-img">所有任务</a></li>
                        </#if>
                    </#if>

            </ul>
        </div>
    </div>


    <div class="layui-body">
        <!-- 内容主体区域 -->
        <div class="layui-tab" lay-filter="tabBody" lay-allowclose="true" style="margin-top: 0;">
            <ul class="layui-tab-title" style="visibility:hidden;height: 0px">
            </ul>
            <div class="layui-tab-content layui-col-md-12" id="content" lay-filter="tabTable">
                <div class="layui-container">
                    <fieldset class="layui-elem-field layui-field-title">
                        <legend>电子签章</legend>
                    </fieldset>

                    <div class="layui-main" style="margin-bottom: 20px;">
                        <div class="layui-btn-group">
                            <input type="button" class="layui-btn layui-btn-danger" value="电子印章" id="sign"/>
                            <#--<input type="button" class="layui-btn layui-btn-danger" value="通过" id="pass"/>-->
                            <#--<input type="button" class="layui-btn layui-btn-danger" value="不通过" id="fail"/>-->
                        </div>

                        <div class="layui-layout-right">
                            <input type="button" class="layui-btn layui-btn" value="通过" id="pass"/>
                            <input type="button" class="layui-btn layui-btn" value="不通过" id="fail"/>
                        </div>
                    </div>

                    <div class="layui-main" style="margin-bottom: 20px;">
                        <div class="layui-form-item layui-form-text">
                            <label class="layui-form-label">备注</label>
                            <div class="layui-input-block">
                                <textarea maxlength="30" placeholder="请填写备注" id="remark" name="remark" class="layui-textarea"></textarea>
                            </div>
                        </div>
                    </div>


                    <div class="usBox main" style="padding: 3px;height:560px;" id="assignBox">
                        <script type="text/javascript" src="/aip/LoadAip.js"></script>


                        <!--该事件在AIP引擎初始化完毕之后触发-->
                        <SCRIPT LANGUAGE=javascript FOR=HWPostil1 EVENT=NotifyCtrlReady>
                            HWPostil1_NotifyCtrlReady();
                        </SCRIPT>

                    </div>


                </div>
            </div>
        </div>

    </div>

</div>
</body>

<script type="text/javascript" src="/aip/AipMain.js"></script>
<script>
    var h = $(window).innerHeight();
    $("#assignBox").height(h - 200);

    function HWPostil1_NotifyCtrlReady() {

        document.all.HWPostil1.HideMenuItem(30);
        var confirmId = "${(confirm.id)!}";
        OpenFile("/getSignFile?confirmId="+confirmId);

    }

    function strToJson(str) {
        var json = eval('(' + str + ')');
        return json;
    }


</script>

<script>
    layui.use(['element','itenderUser'], function(){
        //  var $ = layui.jquery ;


        var sealNum = 0;
        var expertApplyId = "";


        function updateSignStatus(signResult) {
            var signResult= signResult;
            var signId = "${(user.id)!}";
            var confirmId = "${confirm.id!}";
            var description = $('#remark').text();
            $.ajax({
                url: "/review/updateSignResult",
                type: "POST",
                dataType: "json",
                data: {signId:signId,description:description,confirmId:confirmId,signResult:signResult},
                success: function (res) {
                    if(res!=null){
                        if(res.status){
                            layer.closeAll('page'); //执行关闭
                            layer.msg("提交成功!");
                            window.history.back(-1);

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

        function getOperatorName(operator) {

            if(operator == 'department_leader'){
                return '科室负责人';
            }else if(operator == 'branch_leader'){
                return '分管负责人';
            }else if(operator == 'approver'){
                return '审批人';
            }

            return "经办人";
        }


        //签章
        $("#sign").click(function () {
            var operator ="${(user.operator)!}";
            var name  = getOperatorName(operator);
            SearchText(name, 0, 0);
            if (AutoSeal(0, 1, name) == "-200") {
                ShowMessage("请插入有效的USBKey！");
            } else {
                sealNum = sealNum + 1;
            }
            ;
        });

        $("#pass").click(function () {

            if (GetCurrUserID()==""||sealNum==0) {

                ShowMessage("请先盖章！");
                return ;
            }
            var name = "${(confirm.name)}";
            var paramsArray = {"fileName":encodeURIComponent(name)};
            var returnValue = SaveDocArray(paramsArray,"/upload");
            var info = JSON.parse(returnValue);

            if (200 == info.code) {
                ShowMessage("文件上传成功！");
                updateSignStatus("approved");
            } else {
                ShowMessage("操作失败！");
            }





        });



        $("#fail").click(function () {
            updateSignStatus("forbidden");


        });


        layui.element.on('nav(test)', function(elem){
            //替换图片
            var imglist = $(".layui-nav-tree").find("img");
            imglist.each(function (index,element) {
                var imgsrc = $(this).attr("src");
                imgsrc = imgsrc.replace("select","default");
                $(this).attr("src",imgsrc);
            });
            var oimg = elem.find("img");
            var oimgsrc = oimg.attr("src");
            oimgsrc = oimgsrc.replace("default","select");
            oimg.attr("src",oimgsrc);
        });



        $("#review").click(function () {

                    view.goto('/review');


                }
        );



        $("#reviewAll").click(function () {

            view.goto('/review');


                }
        );


        //  $("#review").click();



        // var $ = layui.jquery
        //         ,element = layui.element //Tab的切换功能，切换事件监听等，需要依赖element模块
        //         ,itenderUser = layui.itenderUser;

        // $('.layui-side-item').on('click',function () {
        //     var othis = $(this);
        //     var id = othis.attr("id"); //左侧导航栏id
        //     var uri = othis.data("uri"); //新标签页URI
        //     var title = othis.text(); //新标签页标题
        //     console.log(othis);
        //     //
        //     // element.tabDelete('tabBody', id);//删除旧的已存在Tap
        //     // itenderUser.addNewTab(id,uri,title,'tabBody');//新建新标签页
        // });

    });
</script>

<style>

    .layui-nav .layui-side-item a {
        color: #464646;
    }


    /*.layui-this, .layui-nav-tree .layui-nav-child dd.layui-this a, .layui-nav-tree .layui-this, .layui-nav-tree .layui-this>a, .layui-nav-tree .layui-this>a:hover {*/
    /*background-color: #f6f6f6;*/
    /*color: #0154AD;*/
    /*}*/


    .layui-nav-side-img {
        width: 20px;
        height: 20px;
        margin-right: 2px;
        border-radius: 0%;
    }
    .layui-bg-black {
        background-color: #f6f6f6!important;
    }
    .layui-nav {
        background-color: #f6f6f6;
    }
    .layui-this a{
        color: #f6f6f6!important;
    }
</style>
</html>


<#--<!DOCTYPE html>-->
<#--<html lang="en">-->
<#--<head>-->
<#--<meta charset="UTF-8">-->
<#--<title>电子签章</title>-->
<#--<#include "../resource.ftl">-->
<#--</head>-->
<#--<body>-->

<#--<div class="layui-container">-->
<#--<fieldset class="layui-elem-field layui-field-title">-->
<#--<legend>电子签章</legend>-->
<#--</fieldset>-->

<#--<div class="layui-main" style="margin-bottom: 20px;">-->
<#--<div class="layui-btn-group">-->
<#--<input type="button" class="layui-btn layui-btn-danger" value="电子印章" id="sign"/>-->
<#--&lt;#&ndash;<input type="button" class="layui-btn layui-btn-danger" value="提 交" id="pass"/>&ndash;&gt;-->
<#--</div>-->
<#--</div>-->

<#--<div class="usBox main" style="padding: 3px;height:560px;" id="assignBox">-->
<#--<script type="text/javascript" src="/aip/LoadAip.js"></script>-->


<#--<!--该事件在AIP引擎初始化完毕之后触发&ndash;&gt;-->
<#--<SCRIPT LANGUAGE=javascript FOR=HWPostil1 EVENT=NotifyCtrlReady>-->
<#--HWPostil1_NotifyCtrlReady();-->
<#--</SCRIPT>-->

<#--</div>-->


<#--</div>-->
<#--<script type="text/javascript" src="/aip/AipMain.js"></script>-->
<#--<script>-->
<#--var h = $(window).innerHeight();-->
<#--$("#assignBox").height(h - 200);-->

<#--function HWPostil1_NotifyCtrlReady() {-->

<#--document.all.HWPostil1.HideMenuItem(30);-->
<#--var confirmId = "${confirmId!}";-->
<#--OpenFile("/getSignFile?confirmId="+confirmId);-->

<#--}-->

<#--function strToJson(str) {-->
<#--var json = eval('(' + str + ')');-->
<#--return json;-->
<#--}-->

<#--$(function () {-->
<#--var sealNum = 0;-->
<#--var expertApplyId = "";-->

<#--//签章-->
<#--$("#sign").click(function () {-->
<#--SearchText("签章", 0, 0);-->
<#--if (AutoSeal(0, 1, "签章") == "-200") {-->
<#--ShowMessage("请插入有效的USBKey！");-->
<#--} else {-->
<#--sealNum = sealNum + 1;-->
<#--}-->
<#--;-->
<#--});-->

<#--//保存-->
<#--&lt;#&ndash;$("#pass").click(function() {&ndash;&gt;-->

<#--&lt;#&ndash;if (GetCurrUserID()==""||sealNum==0) {&ndash;&gt;-->
<#--&lt;#&ndash;alert("请先盖章！");&ndash;&gt;-->
<#--&lt;#&ndash;return false;&ndash;&gt;-->
<#--&lt;#&ndash;}&ndash;&gt;-->

<#--&lt;#&ndash;var paramsArray = {"taskId":"${taskId}", "id":"${expertPromise.id}","DocumentID":"${expertPromise.id}","projectInstanceId":"${expertApply.projectInstanceId}","projectInstanceName":"${projectInstance}","userType":"1","expertApplyId":"${expertApplyId}"};&ndash;&gt;-->
<#--&lt;#&ndash;var returnValue = SaveDocArray(paramsArray,"${pageScope.basePath}/expertPromise/expertPromiseSave");&ndash;&gt;-->
<#--&lt;#&ndash;if ("OK" == returnValue) {&ndash;&gt;-->
<#--&lt;#&ndash;ShowMessage("文件上传成功！");&ndash;&gt;-->

<#--&lt;#&ndash;/************************************************&ndash;&gt;-->
<#--&lt;#&ndash;* 如果是业主代表，跳过回避承诺书&ndash;&gt;-->
<#--&lt;#&ndash;*/&ndash;&gt;-->
<#--&lt;#&ndash;if("${flag}" == "true"){&ndash;&gt;-->
<#--&lt;#&ndash;ShowMessage("签到成功！");&ndash;&gt;-->
<#--&lt;#&ndash;}&ndash;&gt;-->
<#--&lt;#&ndash;window.location.href="${pageScope.basePath}/expertPromise/expertPromiseAvoid?expertApplyId="+"${expertApplyId}"+"&taskId="+"${taskId}";&ndash;&gt;-->
<#--&lt;#&ndash;} else {&ndash;&gt;-->
<#--&lt;#&ndash;ShowMessage("操作失败！");&ndash;&gt;-->
<#--&lt;#&ndash;}&ndash;&gt;-->
<#--&lt;#&ndash;});&ndash;&gt;-->


<#--});-->
<#--</script>-->

<#--</body>-->

<#--</html>-->

