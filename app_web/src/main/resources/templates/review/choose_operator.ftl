
<div class="margin-top layui-fluid">
    <div class="layui-row">
        <form class="layui-form layui-form-pane" action="">


            <select name="assigneeId" id="assigneeId"  lay-filter="assignee_select" lay-verify="required">
                            <#list itenderUsers as itenderUser>
                                <option value='${itenderUser.id!}'>${itenderUser.nickName!}</option>
                            </#list>
            </select>




            <div class="layui-form-item">
                <div class="layui-input-block">
                    <button type="submit" class="layui-btn" lay-submit lay-filter="chooseOperator">提交</button>


                    <button type="reset" class="layui-btn layui-btn-primary">重置</button>
                </div>
            </div>
        </form>
    </div>
</div>

<script>
    layui.use(['form'], function () {
        var form = layui.form;
        var layer = layui.layer;
        var reviewId = "${id}";


        form.verify({
            name: function (value, item) {
                if (value.length == 0){

                    return "用户名不能为空";
                }
            },

        });
        form.on('submit(chooseOperator)', function(data){
            var formData = data.field;
            var status = 'approved';

            if(!formData.assigneeId){
                layer.msg("请选择人员!");
                return false;
            }

            $.ajax({
                url: "/review/updateReviewStatus",
                type: "POST",
                dataType: "json",
                data: {id:reviewId,assigneeId:formData.assigneeId,status:status},
                success: function (res) {
                    if(res!=null){
                        if(res.status){
                            layer.closeAll('page'); //执行关闭
                            layer.msg("提交成功!");
                            $("#review_nav").click();
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

            return false;
        });

        form.on('select(assignee_select)', function(data){


            return false;
        });



    });
</script>