<div class="margin-top layui-fluid">
    <div class="layui-row">
        <form class="layui-form layui-form-pane" action="">
            <#if itenderIndustry??>
                <div class="layui-form-item">
                    <label class="layui-form-label">行业名称</label>
                    <div class="layui-input-block">
                        <input type="hidden" name="industryId" value="${itenderIndustry.id!}">
                        <input type="text" name="industryName" lay-verify="industryName" lay-verType="tips" autocomplete="off" class="layui-input" value="${itenderIndustry.industryName!}">
                    </div>
                </div>
                <div class="layui-form-item">
                    <div class="layui-input-block">
                        <button type="submit" class="layui-btn" lay-submit lay-filter="updateIndustry">提交</button>
                        <button type="reset" class="layui-btn layui-btn-primary">重置</button>
                    </div>
                </div>
            <#else>
                <div class="layui-form-item">
                    <label class="layui-form-label">行业名称</label>
                    <div class="layui-input-inline">
                        <input type="text" name="industryName" lay-verify="industryName" lay-verType="tips" placeholder="行业名称" autocomplete="off" class="layui-input">
                    </div>
                </div>

                <div class="layui-form-item">
                    <div class="layui-input-block">
                        <button type="submit" class="layui-btn" lay-submit lay-filter="addIndustry">提交</button>
                        <button type="reset" class="layui-btn layui-btn-primary">重置</button>
                    </div>
                </div>
            </#if>
        </form>
    </div>
</div>
<script>
    layui.use(['form','itenderIndustry'], function () {
        var form = layui.form;
        var layer = layui.layer;
        var itenderIndustry = layui.itenderIndustry;

        form.verify({
            industryName: function (value, item) {
                if (value.length == 0){
                    return "行业名称不能为空！";
                }
            }
        });
        form.on('submit(addIndustry)', function(data){
            var formData = data.field;
            itenderIndustry.addIndustry(formData,function (res,status) {
                if(status){
                    layer.closeAll('page'); //执行关闭
                    layer.msg("添加成功!");
                }else{
                    layer.msg("添加失败!");
                }
            });
            return false;
        });
        form.on('submit(updateIndustry)', function(data){
            var formData = data.field;
            itenderIndustry.updateIndustry(formData,function (res,status) {
                if(status){
                    layer.closeAll('page'); //执行关闭
                    layer.msg("更新成功!");
                }else{
                    layer.msg("更新失败!");
                }
            });
            return false;
        });
    });
</script>