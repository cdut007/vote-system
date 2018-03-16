
<div class="margin-top layui-fluid">
    <div class="layui-row">
            <form class="layui-form layui-form-pane" action="">
                <div class="layui-form-item">
                    <label class="layui-form-label">设备型号</label>
                    <div class="layui-input-inline">
                        <input type="text" name="model" value="${itenderDevice.model!}" lay-verify="required" lay-verType="tips" placeholder="设备型号" autocomplete="off" class="layui-input">
                    </div>
                </div>
                <div class="layui-form-item">
                    <label class="layui-form-label">设备名称</label>
                    <div class="layui-input-inline">
                        <input type="text" name="name" lay-verify="required" value="${itenderDevice.name!}" lay-verType="tips" placeholder="设备名称" autocomplete="off" class="layui-input">
                    </div>
                </div>


                <div class="layui-form-item">

                    <div class="layui-inline">

                        <label class="layui-form-label">设备地址</label>
                        <div class="layui-input-inline">
                            <input style="width: 180px" value="${itenderDevice.ip!}" type="text" name="ip" lay-verify="required" lay-verType="tips" placeholder="ip" autocomplete="off" class="layui-input">
                        </div>

                        <label class="layui-form-label">设备端口</label>
                        <div class="layui-input-inline">
                            <input style="width: 180px" value="${itenderDevice.port!}" type="text" name="port" lay-verify="required" lay-verType="tips" placeholder="端口" autocomplete="off" class="layui-input">
                        </div>

                    </div>



                </div>



                <div class="layui-form-item">

                    <div class="layui-inline">

                        <label class="layui-form-label">设备账号</label>
                        <div class="layui-input-inline">
                            <input style="width: 180px" value="${itenderDevice.account!}" type="text" name="account" lay-verify="required" lay-verType="tips" placeholder="账号" autocomplete="off" class="layui-input">
                        </div>

                        <label class="layui-form-label">设备密码</label>

                        <div class="layui-input-inline">
                            <input style="width: 180px"  value="${itenderDevice.password!}" type="text" id="password" name="password" lay-verify="required" lay-verType="tips" placeholder="密码" autocomplete="off" class="layui-input">
                        </div>

                    </div>




                </div>

                <div class="layui-form-item">
                    <label class="layui-form-label">维护电话</label>
                    <div class="layui-input-inline">
                        <input type="text" name="maintenancePhone" lay-verify="phone|required" value="${itenderDevice.maintenancePhone!}" lay-verType="tips" placeholder="维护电话" autocomplete="off" class="layui-input">
                    </div>
                </div>

                <div class="layui-form-item">
                    <label class="layui-form-label">设备状态</label>
                    <div class="layui-input-inline">
                         <#if itenderDevice.roomId??>
                              <#if itenderDevice.status=='normal'>
                             <input type="checkbox" checked="" name="status" lay-skin="switch" lay-filter="switchStatus" lay-text="使用中|损坏">
                              <#else>
                          <input type="checkbox"  name="status" lay-skin="switch" lay-filter="switchStatus" lay-text="使用中|损坏">
                              </#if>
                         <#else>
                             <#if itenderDevice.status=='normal'>
                             <input type="checkbox" checked="" name="status" lay-skin="switch" lay-filter="switchStatus" lay-text="正常|损坏">
                             <#else>
                          <input type="checkbox"  name="status" lay-skin="switch" lay-filter="switchStatus" lay-text="正常|损坏">
                             </#if>
                         </#if>

                    </div>
                </div>





                <div class="layui-form-item">
                    <div class="layui-input-block">
                        <button type="submit" class="layui-btn" lay-submit lay-filter="updateDevice">提交</button>


                        <button type="reset" class="layui-btn layui-btn-primary">重置</button>
                    </div>
                </div>

            </form>
    </div>
</div>

<script>
    layui.use(['form','itenderDevice'], function () {
        var form = layui.form;
        var layer = layui.layer;
        var itenderDeviceModule = layui.itenderDevice;
        var status = "${itenderDevice.status!}";

        form.verify({
            model: function (value, item) {
                if (value.length == 0){

                    return "设备型号不能为空";
                }
            },
            name: function (value, item) {
                if (value.length == 0){
                    return "设备型号不能为空";
                }
            },

        });


        //监听指定开关
        form.on('switch(switchStatus)', function(data){

            if(this.checked){
                status = 'normal';
            }else{
                status = 'unavailable';
            }

            // layer.msg('开关checked：'+ (this.checked ? 'true' : 'false'), {
            //     offset: '6px'
            // });

        });


        form.on('submit(updateDevice)', function(data){
            var formData = data.field;
            formData.id = "${itenderDevice.id!}";
            formData.status = status;
            itenderDeviceModule.updateDevice(formData,function (res,status) {
                if(status){
                    layer.closeAll('page'); //执行关闭
                    layer.msg("保存成功!");
                }else{
                    layer.msg("保存失败!");
                }
            });
            return false;
        });
    });
</script>