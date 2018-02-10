
<div class="margin-top layui-fluid">
    <div class="layui-row">
            <form class="layui-form layui-form-pane" action="">
                <div class="layui-form-item">
                    <label class="layui-form-label">房间名</label>
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
                    <label class="layui-form-label">设备地址</label>
                    <div class="layui-input-inline">
                        <input type="text" name="ip" lay-verify="required" value="${itenderDevice.ip!}" lay-verType="tips" placeholder="设备地址" autocomplete="off" class="layui-input">
                    </div>

                </div>

                <div class="layui-form-item">
                    <label class="layui-form-label">设备端口</label>
                    <div class="layui-input-inline">
                        <input type="text" name="port" lay-verify="required" value="${itenderDevice.port!}" lay-verType="tips" placeholder="设备端口" autocomplete="off" class="layui-input">
                    </div>
                </div>




                <div class="layui-form-item">
                    <label class="layui-form-label">设备账号</label>
                    <div class="layui-input-inline">
                        <input type="text" name="account" lay-verify="required" value="${itenderDevice.account!}" lay-verType="tips" placeholder="设备账号" autocomplete="off" class="layui-input">
                    </div>


                </div>

                <div class="layui-form-item">
                    <label class="layui-form-label">设备密码</label>


                    <div class="layui-input-inline">
                        <input type="password" id="password" name="password" lay-verify="required" value="${itenderDevice.password!}" lay-verType="tips" placeholder="设备密码" autocomplete="off" class="layui-input">
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
                        <input type="checkbox" checked="" name="status" lay-skin="switch" lay-filter="switchStatus" lay-text="正常|不可用">
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
            layer.msg('开关checked：'+ (this.checked ? 'true' : 'false'), {
                offset: '6px'
            });
            layer.tips('更新状态：', data.othis)
        });


        form.on('submit(updateDevice)', function(data){
            var formData = data.field;
            formData.id = "${itenderDevice.id!}";
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