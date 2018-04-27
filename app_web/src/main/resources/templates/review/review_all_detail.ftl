
<span class="layui-breadcrumb">
          <a id="review_nav" href="javascript:;">所有任务</a>
          <span lay-separator="">/</span>
          <a><cite id="title">用印登记</cite></a>
        </span>

<div >


    <div class="layui-row" style="padding: 30px">


       <#include "tender_info.ftl">
        <#include "review_attachment_list.ftl">

        <div class="layui-form-item layui-col-space15" style="padding: 30px;text-align: center">
            <button class="layui-btn" lay-event="fetch" id="fetch">认领</button>
        </div>

    </div>

</div>
<style>
    .layui-breadcrumb {
        visibility: visible;
        font-size: 14px;
    }

    .layui-breadcrumb span[lay-separator] {
        margin: 0 10px;
        color: #999;
    }

</style>




<script type="text/html" id="bitTime">
    {{ new Date(d.createTime).format("yyyy/MM/dd hh:mm:ss") }}
</script>





<script type="text/javascript">


    layui.use( ['table','util', 'itenderReview','element'], function () {
        var type = "${(itenderReview.type)!}";
        var reviewId = "${(itenderReview.id)!}";
        $("#title").html(getReviewTypeName(type));
        var assigneeId = "${(user.id)!}";

        $("#fetch").click(function () {

            layer.open({
                type: 1
                ,title: '认领任务'
                ,offset: 'auto' //具体配置参考：http://www.layui.com/doc/modules/layer.html#offset
                ,id: 'dashauto' //防止重复弹出
                ,content: '<div style="padding: 20px 100px;">确认认领该任务？</div>'
                ,btn: '确认'
                ,btnAlign: 'c' //按钮居中
                ,shade: 0 //不显示遮罩
                ,yes: function(){
                    $.ajax({
                        url: "/review/updateReviewStatus",
                        type: "POST",
                        dataType: "json",
                        data: {id:reviewId,assigneeId:assigneeId,status:'approved'},
                        success: function (res) {
                            if(res!=null){
                                if(res.status){
                                    layer.closeAll('page'); //执行关闭
                                    layer.msg("提交成功!");
                                    $("#review").click();
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

                }
            });
        });

        $("#review_nav").click(function () {
            $.ajax({
                url: '/review/review_all_list',
                type:"GET",
                cache:false,
                success: function (res) {
                    //console.log(res);
                    // $('#content').html(res);
                    layui.element.tabDelete('tabBody', 'list-review');
                    layui.element.tabAdd('tabBody', {//添加新Tap
                        title:'审批管理',
                        content: res
                        ,id: 'list-review'
                    });
                    layui.element.tabChange('tabBody', 'list-review');

                },
                error: function (xmlHttpReq, error, ex) {

                }
            })

        });




    });

</script>

