<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>审核公告</title>
    <#include "../resource.ftl">
</head>
<body class="layui-layout-body">
<div class="layui-layout layui-layout-admin">
                <div class="layui-container">
                    <fieldset class="layui-elem-field layui-field-title">
                        <legend>审核</legend>
                    </fieldset>

                    <div class="layui-main" style="margin-bottom: 20px;">
                        <div class="layui-btn-group">

                        </div>

                        <div class="layui-layout-right">
                            <input type="button" class="layui-btn layui-btn" value="通过" id="pass"/>
                            <input type="button" class="layui-btn layui-btn" value="不通过" id="fail"/>
                        </div>
                    </div>

                    <div class="layui-main" style="margin-bottom: 20px;margin-top: 50px">
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
</body>

<script type="text/javascript" src="/aip/AipMain.js"></script>
<script>
    var h = $(window).innerHeight();
    $("#assignBox").height(h - 200);

    function HWPostil1_NotifyCtrlReady() {

        document.all.HWPostil1.HideMenuItem(30);
        var attachId = "${(confirm.attachId)!}";
        OpenFile("/download?referenceAttachId="+attachId);

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
            var reviewId = "${confirm.reviewId!}";
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
                            window.parent.reload(reviewId);

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



        $("#pass").click(function () {

            updateSignStatus("approved");


        });



        $("#fail").click(function () {
            updateSignStatus("forbidden");


        });



    });
</script>

</html>

