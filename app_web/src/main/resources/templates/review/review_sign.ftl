<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>电子签章</title>
    <#include "../resource.ftl">
</head>
<body class="layui-layout-body">
<div class="layui-layout layui-layout-admin">
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

                    <div class="layui-main" style="margin-bottom: 20px;;margin-top: 50px">
                        <div class="layui-row">
                            <div class="layui-col-xs6">
                                <div class="layui-form-item layui-form-text">
                                    <label class="layui-form-label">备注</label>
                                    <div class="layui-input-block" style="width: 70%" >
                                        <textarea maxlength="30" placeholder="请填写备注" id="remark" name="remark" class="layui-textarea"></textarea>
                                    </div>

                                </div>
                            </div>
                            <div class="layui-col-xs6">
                                <label class="layui-form-label" id="remarkInfo" style="width: 100%;text-align: left"></label>
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




        var confirmId = "${confirm.id!}";
        $.ajax({
            url: "/review/getSignList",
            type: "POST",
            dataType: "json",
            data: {confirmId:confirmId},
            success: function (res) {
                if(res!=null){
                    if(res.status){
                         var text='';
                         for(var i = 0 ; i<res.data.length;i++){
                             var item = res.data[i];
                             text+=item.description+"<br>";
                         }
                        $('#remarkInfo').html(text);

                    }else{
                        console.log("提交失败!");
                    }
                }else{
                    console.log("提交失败!");
                }
            },
            error: function (xmlHttpReq, error, ex) {
                console.log("提交失败!");
            }
        })






    });
</script>

<style>

</style>
</html>
