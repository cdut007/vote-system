<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>招标编辑器</title>
    <#include "resource.ftl">
</head>
<body>
<#include "top_menus.ftl">

<div class="layui-container">
    <fieldset class="layui-elem-field layui-field-title">
        <legend>电子签章</legend>
    </fieldset>

    <div class="layui-main" style="margin-bottom: 20px;">
        <div class="layui-btn-group">
            <input type="button" class="layui-btn layui-btn-danger" value="电子印章" id="sign"/>
        <#--<input type="button" class="layui-btn layui-btn-danger" value="提 交" id="pass"/>-->
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
<script type="text/javascript" src="/aip/AipMain.js"></script>
<script>
    var h = $(window).innerHeight();
    $("#assignBox").height(h - 200);

    function HWPostil1_NotifyCtrlReady() {
        document.all.HWPostil1.HideMenuItem(30);
        OpenFile("/pdf?documentId=${documentId!}");
    }

    function strToJson(str) {
        var json = eval('(' + str + ')');
        return json;
    }

    $(function () {
        var sealNum = 0;
        var expertApplyId = "";

        //签章
        $("#sign").click(function () {
            SearchText("签章", 0, 0);
            if (AutoSeal(0, 1, "签章") == "-200") {
                ShowMessage("请插入有效的USBKey！");
            } else {
                sealNum = sealNum + 1;
            }
            ;
        });

        //保存
        <#--$("#pass").click(function() {-->

            <#--if (GetCurrUserID()==""||sealNum==0) {-->
                <#--alert("请先盖章！");-->
                <#--return false;-->
            <#--}-->

            <#--var paramsArray = {"taskId":"${taskId}", "id":"${expertPromise.id}","DocumentID":"${expertPromise.id}","projectInstanceId":"${expertApply.projectInstanceId}","projectInstanceName":"${projectInstance}","userType":"1","expertApplyId":"${expertApplyId}"};-->
            <#--var returnValue = SaveDocArray(paramsArray,"${pageScope.basePath}/expertPromise/expertPromiseSave");-->
            <#--if ("OK" == returnValue) {-->
                <#--ShowMessage("文件上传成功！");-->

                <#--/************************************************-->
                 <#--* 如果是业主代表，跳过回避承诺书-->
                 <#--*/-->
                <#--if("${flag}" == "true"){-->
                    <#--ShowMessage("签到成功！");-->
                <#--}-->
                <#--window.location.href="${pageScope.basePath}/expertPromise/expertPromiseAvoid?expertApplyId="+"${expertApplyId}"+"&taskId="+"${taskId}";-->
            <#--} else {-->
                <#--ShowMessage("操作失败！");-->
            <#--}-->
        <#--});-->


    });
</script>

</body>

</html>