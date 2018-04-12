<fieldset class="layui-elem-field layui-field-title">
    <legend>招标项目信息</legend>
</fieldset>

<div class="layui-row">
    <div class="layui-col-sm4">
        <div class="grid-item">
            <label class="">招标项目名称:<span>{(itenderBid.name)!}</span></label>
        </div>
    </div>
    <div class="layui-col-sm4">
        <div class="grid-item">
            <label class="">公告编号:<span>{(itenderReview.noticeNo)!}</span></label>
        </div>
    </div>
    <div class="layui-col-sm4">
        <div class="grid-item">
            <label class="">土地面积:<span>{(itenderReview.area)!}平方米</span></label>
        </div>
    </div>
</div>



<style>
    .grid-item {

        text-align: left;
    }
</style>

<script type="text/javascript">

    layui.use(['itenderReview'], function () {


    });

</script>

