<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>审批</title>
    <#include "../resource.ftl">
</head>
<body class="layui-layout-body">

<span class="layui-breadcrumb">
          <a id="my_review_nav" href="javascript:;">我的任务</a>
          <span lay-separator="">/</span>
          <a id="my_review_detail_nav" href="javascript:;" style="visibility: hidden">待办任务</a>
          <span lay-separator="">/</span>
          <a><cite id="title" style="visibility: hidden">审核</cite></a>
        </span>

<div class="layui-layout layui-layout-admin">
  <div class="">

                   <fieldset class="layui-elem-field layui-field-title">
                        <legend>用印签章</legend>
                    </fieldset>

                    <div class="layui-main" style="margin-bottom: 20px;">
                        <div class="layui-btn-group">
                            <input type="button" class="layui-btn layui-btn-danger" value="电子印章" id="sign" style="visibility: hidden"/>
                        </div>

                        <div class="layui-layout-right">
                            <input type="button" class="layui-btn layui-btn" value="下一步" id="pass"/>
                        </div>
                    </div>

                    <#--<div class="layui-main" style="margin-bottom: 20px;;margin-top: 50px">-->
                        <#--<div class="layui-row">-->
                            <#--<div class="layui-col-xs6">-->
                                <#--<div class="layui-form-item layui-form-text">-->
                                    <#--<label class="layui-form-label">备注</label>-->
                                    <#--<div class="layui-input-block" style="width: 70%" >-->
                                        <#--<textarea maxlength="30" placeholder="请填写备注" id="remark" name="remark" class="layui-textarea"></textarea>-->
                                    <#--</div>-->

                                <#--</div>-->
                            <#--</div>-->
                            <#--<div class="layui-col-xs6">-->
                                <#--<label class="layui-form-label" id="remarkInfo" style="width: 100%;text-align: left"></label>-->
                            <#--</div>-->
                        <#--</div>-->

                    <#--</div>-->


                    <div class="usBox main" style="padding: 3px;height:560px;" id="assignBox">
                        <script type="text/javascript" src="/aip/LoadAip.js"></script>


                        <!--该事件在AIP引擎初始化完毕之后触发-->
                        <SCRIPT LANGUAGE=javascript FOR=HWPostil1 EVENT=NotifyCtrlReady>
                            HWPostil1_NotifyCtrlReady();
                        </SCRIPT>

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

        var id = "${(confrim.attachId)!}";
        OpenFile("/getAttachFile?referenceAttachId="+id);


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
        var lastOne = "${lastOne!}";
        var type = "${confirm.type!}";
        var reviewType = "${(title)!}";

            $("#sign").css("visibility","visible");
            $("#title").text('用印签章');


        $("#my_review_detail_nav").css("visibility","visible");
        $("#title").css("visibility","visible");
        $("#my_review_detail_nav").html(reviewType);
        if(lastOne){
            $("#pass").html('提交');
        }

        $("#my_review_detail_nav").click(function(){
            var reviewId = "${confirm.reviewId!}";
            window.parent.reload(reviewId);
        });

        $("#my_review_nav").click(function(){
            var reviewId = "${confirm.reviewId!}";
            window.parent.myTask();
        });

        function updateSignStatus(signResult) {
            var signResult= signResult;
            var signId = "${(user.id)!}";
            var confirmId = "${confirm.id!}";
            var reviewId = "${confirm.reviewId!}";
            var description = $('#remark').val();
            $.ajax({
                url: "/review/updateSignFileResult",
                type: "POST",
                dataType: "json",
                data: {signId:signId,description:description,confirmId:confirmId,signResult:signResult},
                success: function (res) {
                    if(res!=null){
                        if(res.status){
                            layer.closeAll('page'); //执行关闭
                            layer.msg("提交成功!");
                            if(lastOne){
                                window.parent.myTask();
                            }else{
                                window.parent.reloadSignFile(reviewId);
                            }

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



        //签章
        $("#sign").click(function () {
            var name  ='签章';
            SearchText(name, 0, 0);
            if (AutoSeal(0, 1, name) == "-200") {
                ShowMessage("请插入有效的USBKey！");
            } else {
                sealNum = sealNum + 1;
            }
            ;
        });

        $("#pass").click(function () {
            var r = ShowMessageOkCancel("确认通过?");
            if(r==1){

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
            }



        });




        <#--var confirmId = "${confirm.id!}";-->
        <#--$.ajax({-->
            <#--url: "/review/getSignList",-->
            <#--type: "POST",-->
            <#--dataType: "json",-->
            <#--data: {confirmId:confirmId},-->
            <#--success: function (res) {-->
                <#--if(res!=null){-->
                    <#--if(res.status){-->
                         <#--var text='';-->
                         <#--for(var i = 0 ; i<res.data.length;i++){-->
                             <#--var item = res.data[i];-->
                             <#--text+=item.description+"<br>";-->
                         <#--}-->
                        <#--$('#remarkInfo').html(text);-->

                    <#--}else{-->
                        <#--console.log("提交失败!");-->
                    <#--}-->
                <#--}else{-->
                    <#--console.log("提交失败!");-->
                <#--}-->
            <#--},-->
            <#--error: function (xmlHttpReq, error, ex) {-->
                <#--console.log("提交失败!");-->
            <#--}-->
        <#--})-->






    });
</script>

<style>
    .layui-breadcrumb {
        visibility: visible;
        font-size: 14px;
    }

    .layui-breadcrumb span[lay-separator] {
        margin: 0 10px;
        color: #999;
    }
</style>
</html>
