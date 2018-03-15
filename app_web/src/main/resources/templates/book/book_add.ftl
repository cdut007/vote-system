
<div class="margin-top layui-fluid">
    <div class="layui-row">
            <form class="layui-form layui-form-pane" action="">
                <div class="layui-form-item">
                    <label class="layui-form-label">房间名</label>
                    <div class="layui-input-inline">
                        <input readonly="true" type="text" name="room" value="${itenderRoom.name!}" lay-verify="required" lay-verType="tips" placeholder="房间名" autocomplete="off" class="layui-input">
                    </div>
                </div>

                <div class="layui-form-item">
                    <label class="layui-form-label">预订单位</label>
                    <div class="layui-input-inline">
                        <input  type="text" name="bookOrganization" lay-verify="required" lay-verType="tips" placeholder="输入预订单位" autocomplete="off" class="layui-input">
                    </div>
                </div>

                <div class="layui-form-item">
                    <label class="layui-form-label">项目名称</label>
                    <div class="layui-input-inline">
                        <input  type="text" name="content" lay-verify="required" lay-verType="tips" placeholder="输入项目名称" autocomplete="off" class="layui-input">
                    </div>
                </div>

                <div class="layui-form-item">
                    <label class="layui-form-label">预定类型</label>
                    <div class="layui-input-inline">
                        <select name="industry" id="industry"  lay-filter="industry_select" lay-verify="required">
                            <#list industryList as industry>
                                <option value='${industry.industryName!}'>${industry.industryName!}</option>
                            </#list>
                        </select>
                    </div>
                </div>

                <div class="layui-form-item">
                    <label class="layui-form-label">开始时间</label>
                    <div class="layui-input-inline">
                        <input lay-verify="required"  type="text" class="layui-input date " id="start_date" placeholder="">
                    </div>
                </div>

                <div class="layui-form-item">
                    <label class="layui-form-label">结束时间</label>
                    <div class="layui-input-inline">
                        <input lay-verify="required" type="text" class="layui-input date" id="end_date" placeholder="">
                    </div>
                </div>

                <div class="layui-form-item">
                    <label class="layui-form-label">预订人</label>
                    <div class="layui-input-inline">
                        <input  type="text" name="bookUser" lay-verify="required" lay-verType="tips" placeholder="输入预订人" autocomplete="off" class="layui-input">
                    </div>
                </div>


                <div class="layui-form-item">
                    <label class="layui-form-label">联系方式</label>
                    <div class="layui-input-inline">
                        <input  type="text" name="bookUserMobile" lay-verify="required|phone" lay-verType="tips" placeholder="输入联系方式" autocomplete="off" class="layui-input">
                    </div>
                </div>




                <div class="layui-form-item">
                    <div class="layui-input-block">
                        <button type="submit" class="layui-btn" lay-submit lay-filter="addBook">提交</button>


                        <button type="reset" class="layui-btn layui-btn-primary">重置</button>
                    </div>
                </div>
            </form>
    </div>
</div>

<script>
    layui.use(['form','itenderBook','itenderRoom','laydate'], function () {
        var form = layui.form;
        var layer = layui.layer;
        var itenderBookModule = layui.itenderBook;
        var beginTime =parseInt("${beginTime!}");
        var endTime =parseInt("${endTime!}");

        layui.laydate.render({
            elem: '#start_date'
            ,type: 'datetime'
            ,value: new Date(beginTime)
             ,min: beginTime
             ,max: endTime
            ,done: function(value, date){
                var time = Date.parse(value.replace(/-/g,"/"));

                beginTime = time;

                //{year: 2017, month: 8, date: 18, hours: 0, minutes: 0, seconds: 0}
        }
        });

        layui.laydate.render({
            elem: '#end_date'
            ,type: 'datetime'
            ,value: new Date(endTime)
            ,min: beginTime
            ,max: endTime
            ,done: function(value, date){
                var time = Date.parse(value.replace(/-/g,"/"));
                endTime = time;

                //{year: 2017, month: 8, date: 18, hours: 0, minutes: 0, seconds: 0}
            }
        });


        form.verify({
            bookOrganization: function (value, item) {
                if (value.length == 0){

                    return "预订单位不能为空";
                }
            },

        });
        form.on('submit(addBook)', function(data){
            var formData = data.field;

            if(endTime - beginTime < 3600 * 1000 ){
                layer.msg("预订时间一个小时以上");
                return false;
            }

            formData.beginTime = beginTime;
            formData.endTime = endTime;
            formData.roomId = "${itenderRoom.id!}";


            itenderBookModule.addBook(formData,function (res,status) {
                if(status){
                    layer.closeAll('page'); //执行关闭
                    layer.msg("添加成功!");
                }else{
                    layer.msg(res+" 添加失败!");
                }
            });
            return false;
        });

        form.on('select(industry_select)', function(data){


            return false;
        });



    });
</script>