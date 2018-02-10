<style>
    /*
        多选框CSS
     */
    .layui-form select[multiple] + .layui-form-select dd { padding: 0;}
    .layui-form select[multiple] + .layui-form-select .layui-form-checkbox[lay-skin="primary"] {width:100%; text-align:left;}
    .layui-form select[multiple] + .layui-form-select .layui-form-checkbox[lay-skin="primary"] span {float: left; padding-left:30px;}
    .layui-form select[multiple] + .layui-form-select .layui-form-checkbox[lay-skin="primary"] i {position: absolute;left:10px;top: 0;}
    .layui-form select[multiple] + .layui-form-select dd.layui-disabled{ padding-left:10px;}
    .multiSelect{ line-height:normal; height:auto; padding:4px 10px; overflow:hidden;min-height:38px; margin-top:-38px; left:0; z-index:99;position:relative;background:none;}
    .multiSelect a{ padding:2px 5px; background:#908e8e; border-radius:2px; color:#fff; display:block; line-height:20px; height:20px; margin:2px 2px 2px 0; float:left;}
    .multiSelect a span{ float:left;}
    .multiSelect a i{ float:left; display:block; margin:2px 0 0 2px; border-radius:2px; width:8px; height:8px; background:url(/css/close.png) no-repeat center; background-size:65%; padding:4px;}
    .multiSelect a i:hover{ background-color:#545556;}
</style>
<div class="margin-top layui-fluid">
    <div class="layui-row">
        <form class="layui-form layui-form-pane" action="">
            <#if itenderRole??>
                <div class="layui-form-item">
                    <label class="layui-form-label">角色名</label>
                    <div class="layui-input-block">
                        <input type="hidden" id="roleId" name="roleId" value="${itenderRole.id!}">
                        <input type="text" id="roleName" name="roleName" lay-verify="roleName" lay-verType="tips" placeholder="角色名" autocomplete="off" class="layui-input" value="${itenderRole.roleName!}">
                    </div>
                </div>
                <div class="layui-form-item">
                    <label class="layui-form-label">角色属性</label>
                    <div class="layui-input-block">
                        <select id="roleTypeSelect" multiple="multiple" name="roleType">
                            <#if roleTypes??>
                                <#list roleTypes as roleType>
                                    <#if exsitTypes??>
                                        <#if exsitTypes?seq_contains(roleType.industryName)>
                                            <option value="${roleType.id}" selected>${roleType.industryName}</option>
                                        <#else>
                                            <option value="${roleType.id}">${roleType.industryName}</option>
                                        </#if>
                                    <#else>
                                        <option value="${roleType.id}">${roleType.industryName}</option>
                                    </#if>
                                </#list>
                            </#if>
                        </select>
                    </div>
                </div>
                <div class="layui-form-item">
                    <div class="layui-input-block">
                        <button type="submit" class="layui-btn" lay-submit lay-filter="updateRole">更新</button>
                        <button type="button" id="cancel" class="layui-btn layui-btn-primary">取消</button>
                    </div>
                </div>
            <#else>
                <h2>数据异常！</h2>
            </#if>
        </form>
    </div>
</div>
<script>
    layui.use(['form','itenderRole','multipleSelect'], function () {
        var form = layui.form;
        var layer = layui.layer;
        var itenderRole = layui.itenderRole;
        var multipleSelect = layui.multipleSelect;

        form.verify({
            roleName: function (value, item) {
                if (value.length == 0){
                    return "角色名不能为空";
                }
            }
        });
        form.on('submit(updateRole)', function(data){
            var roleId = $("#roleId").val();
            var roleName = $("#roleName").val();
            var roleTypeIds = $("#roleTypeSelect").val();
            var formData = {roleId:roleId,roleName:roleName,roleTypeId:roleTypeIds};
            console.log(formData);
            itenderRole.updateRole(formData,function (res,status) {
                if(status){
                    layer.closeAll('page'); //执行关闭
                    layer.msg("更新成功!");
                }else{
                    layer.msg("更新失败!"+res.msg);
                }
            });
            return false;
        });
        form.render();
        multipleSelect.render();
        $("#cancel").click(function () {
            layer.closeAll('page'); //执行关闭
        });
    });
</script>