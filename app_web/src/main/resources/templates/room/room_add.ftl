
<div class="margin-top layui-fluid">
    <div class="layui-row">
            <form class="layui-form layui-form-pane" action="">
                <div class="layui-form-item">
                    <label class="layui-form-label">房间名</label>
                    <div class="layui-input-inline">
                        <input type="text" name="name" lay-verify="required" lay-verType="tips" placeholder="房间名" autocomplete="off" class="layui-input">
                    </div>
                </div>

                <div class="layui-form-item">
                    <label class="layui-form-label">设备名</label>
                    <div class="layui-input-inline">
                        <select name="quiz1">
                            <option value="">请选择可用设备</option>
                            <option value="浙江" selected="">浙江省</option>
                            <option value="你的工号">江西省</option>
                            <option value="你最喜欢的老师">福建省</option>
                        </select>
                    </div>
                </div>




                <div class="layui-form-item">
                    <div class="layui-input-block">
                        <button type="submit" class="layui-btn" lay-submit lay-filter="addRoom">提交</button>


                        <button type="reset" class="layui-btn layui-btn-primary">重置</button>
                    </div>
                </div>
            </form>
    </div>
</div>

<script>
    layui.use(['form','itenderRoom'], function () {
        var form = layui.form;
        var layer = layui.layer;
        var itenderRoom = layui.itenderRoom;

        form.verify({
            name: function (value, item) {
                if (value.length == 0){

                    return "房间名不能为空";
                }
            },

        });
        form.on('submit(addRoom)', function(data){
            var formData = data.field;
            itenderRoom.addRoom(formData,function (res,status) {
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