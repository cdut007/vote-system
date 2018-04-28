
<span class="layui-breadcrumb">
          <a id="review_nav" href="javascript:;">我的任务</a>
          <span lay-separator="">/</span>
          <a><cite id="title">用印登记</cite></a>
        </span>

<div>


    <div class="layui-row layui-col-space15" style="padding: 30px">

    <#include "review_status.ftl">
      <#if itenderReview??>
              <#include "review_verify.ftl">

      </#if>

           <#include "review_attachment_list.ftl">

    <#include "tender_info.ftl">

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
        $("#title").html(getReviewTypeName(type));

        $("#review_nav").click(function () {
            $.ajax({
                url: '/review/review_list',
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

