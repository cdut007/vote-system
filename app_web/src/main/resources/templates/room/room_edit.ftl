
<div class="margin-top layui-fluid">
    <div class="layui-row">
        <form class="layui-form layui-form-pane" action="">
            <div class="layui-form-item">
                <label class="layui-form-label">房间名</label>
                <div class="layui-input-inline">
                    <input type="text" name="name" value="${itenderRoom.name!}" lay-verify="required" lay-verType="tips" placeholder="房间名" autocomplete="off" class="layui-input">
                </div>
            </div>


                     <#list itenderDeviceList as usedDevice>
                      <div class="layui-form-item">
                         <label class="layui-form-label">已选设备</label>
                         <div class="layui-input-inline">

                         <input type="checkbox"  class="device" name="${usedDevice.id!}" value='${usedDevice.toJson()}' title="${usedDevice.name!}(${usedDevice.statusLabel!})" lay-skin="primary" checked>
                         </div>
                      </div>
                     </#list>

              <#list availableDeviceList as device>
                          <div class="layui-form-item">
                              <label class="layui-form-label">可选设备</label>
                              <div class="layui-input-inline">
                                  <input type="checkbox" class="device" name="${device.id!}" value='${device.toJson()}' title="${device.name!}(${device.statusLabel!})" lay-skin="primary">
                              </div>
                          </div>
              </#list>






            <div class="layui-form-item">
                <div class="layui-input-block">
                    <button type="submit" class="layui-btn" lay-submit lay-filter="updateRoom">提交</button>


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
        var itenderRoomModule = layui.itenderRoom;


        form.verify({
            name: function (value, item) {
                if (value.length == 0){

                    return "房间名不能为空";
                }
            },

        });
        form.on('submit(updateRoom)', function(data){
            var formData = data.field;
            formData.deviceList = [];
            formData.id = "${itenderRoom.id!}";
            var  items = document.querySelectorAll('.device');
            for(var i=0;i<items.length;i++){
                if(items[i].checked){

                    formData.deviceList.push(JSON.parse(items[i].value));
                }
            }



            itenderRoomModule.updateRoom(formData,function (res,status) {
                if(status){
                    layer.closeAll('page'); //执行关闭
                    layer.msg("编辑成功!");
                }else{
                    layer.msg("编辑失败!");
                }
            });
            return false;
        });

        form.on('select(device_select)', function(data){
            console.log(data);

            return false;
        });



    });
</script>