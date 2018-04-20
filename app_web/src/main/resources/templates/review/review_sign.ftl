
<div class="margin-top layui-fluid">
    <fieldset class="layui-elem-field layui-field-title">
        <legend>电子签章</legend>
    </fieldset>

    <div class="usBox main" style="padding: 3px;height:660px;" id="assignBox">
        <!-- -----------------------------== 装载AIP控件 ==--------------------------------- -->
        <script type="text/javascript" src="/aip/LoadAip.js"></script>
        <!--该事件在AIP引擎初始化完毕之后触发-->
        <SCRIPT LANGUAGE=javascript FOR=HWPostil1 EVENT=NotifyCtrlReady>
            HWPostil1_NotifyCtrlReady();
        </SCRIPT>
        <!-- --------------------------------== 结束装载控件 ==----------------------------------- -->
    </div>

    <div class="layui-main" style="margin-bottom: 20px;">
        <div class="layui-btn-group">
            <input type="button" class="layui-btn layui-btn-danger" value="电子印章" id="sign"/>
        <#--<input type="button" class="layui-btn layui-btn-danger" value="提 交" id="pass"/>-->
        </div>
    </div>

</div>

<script type="text/javascript" src="/aip/AipMain.js"></script>

	<script>

        layui.use(['form'], function () {


        });

        var h = $(window).innerHeight();
        $("#assignBox").height(h - 200);

        function HWPostil1_NotifyCtrlReady() {
            document.all.HWPostil1.HideMenuItem(30);
            OpenFile("/aip/compressed.tracemonkey-pldi-09.pdf");

        }

        $(function(){


            var sealNum=0;

            $("#sign").click(function(){
                SearchText("申请单位名称",0,0);
                if(AutoSeal(0,1,"申请单位名称")=="-200"){
                    ShowMessage("请插入有效的USBKey！");
                }else{
                    sealNum=sealNum+1;
                };
            });

            $("#pass").click(function() {

                if (GetCurrUserID()==""||sealNum==0) {
                    alert("请先盖章！");
                    return false;
                }

                var paramsArray = {"tenderId":"111"};
                var returnValue = SaveDocArray(paramsArray,"http://raw.githubusercontent.com/pauldmps/Android-pdf.js/master/assets/compressed.tracemonkey-pldi-09.pdf");
                if ("OK" == returnValue) {
                    ShowMessage("报名成功！");
                    window.location.href="/home";
                } else {
                    ShowMessage("报名失败！");
                }


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
                    }
                })

            });
        });
    </script>
