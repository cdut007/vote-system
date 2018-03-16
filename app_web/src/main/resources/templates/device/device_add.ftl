
<div class="margin-top layui-fluid">
    <div class="layui-row">
            <form class="layui-form layui-form-pane" action="">
                <div class="layui-form-item">
                    <label class="layui-form-label">设备型号</label>
                    <div class="layui-input-inline">
                        <input type="text" name="model" lay-verify="required" lay-verType="tips" placeholder="设备型号" autocomplete="off" class="layui-input">
                    </div>
                </div>
                <div class="layui-form-item">
                    <label class="layui-form-label">设备名称</label>
                    <div class="layui-input-inline">
                        <input type="text" name="name" lay-verify="required" lay-verType="tips" placeholder="设备名称" autocomplete="off" class="layui-input">
                    </div>
                </div>

                <div class="layui-form-item">

                    <div class="layui-inline">

                        <label class="layui-form-label">设备地址</label>
                        <div class="layui-input-inline">
                            <input style="width: 180px" type="text" name="ip" lay-verify="required" lay-verType="tips" placeholder="ip" autocomplete="off" class="layui-input">
                        </div>

                        <label class="layui-form-label">设备端口</label>
                        <div class="layui-input-inline">
                            <input style="width: 180px" type="text" name="port" lay-verify="required" lay-verType="tips" placeholder="端口" autocomplete="off" class="layui-input">
                        </div>

                    </div>



                </div>



                <div class="layui-form-item">

                    <div class="layui-inline">

                        <label class="layui-form-label">设备账号</label>
                        <div class="layui-input-inline">
                            <input style="width: 180px" type="text" name="account" lay-verify="required" lay-verType="tips" placeholder="账号" autocomplete="off" class="layui-input">
                        </div>

                        <label class="layui-form-label">设备密码</label>

                        <div class="layui-input-inline">
                            <input style="width: 180px" type="text" id="password" name="password" lay-verify="required" lay-verType="tips" placeholder="密码" autocomplete="off" class="layui-input">
                        </div>

                    </div>




                </div>


                <div class="layui-form-item">
                    <label class="layui-form-label">维护电话</label>
                    <div class="layui-input-inline">
                        <input type="text" name="maintenancePhone" lay-verify="phone" lay-verType="tips" placeholder="维护电话" autocomplete="off" class="layui-input">
                    </div>
                </div>

                <div class="layui-form-item">
                    <div class="layui-input-block">
                        <button type="submit" class="layui-btn" lay-submit lay-filter="addDevice">提交</button>


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
        var itenderDevice = layui.itenderDevice;

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
        form.on('submit(addDevice)', function(data){
            var formData = data.field;
            itenderDevice.addDevice(formData,function (res,status) {
                if(status){
                    layer.closeAll('page'); //执行关闭
                    layer.msg("添加成功!");
                }else{
                    layer.msg("添加失败!");
                }
            });
            return false;
        });
    });
</script>

