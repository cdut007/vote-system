<fieldset class="layui-elem-field layui-field-title">
    <legend>招标项目信息</legend>
</fieldset>

<div class="layui-row">
    <div class="layui-col-sm6">
        <div class="grid-item">
            <label class="">项目名称:<span>${(itenderReview.name)!}</span></label>
        </div>
    </div>
    <div class="layui-col-sm6">
        <div class="grid-item">
            <label class="">招标项目名称:<span>${(itenderReview.tenderName)!}</span></label>
        </div>
    </div>

</div>

<div class="layui-row">
    <div class="layui-col-sm6">
        <div class="grid-item">
            <label class="">招标编号:<span>${(itenderReview.tenderNo)!}</span></label>
        </div>
    </div>
    <div class="layui-col-sm6">
        <div class="grid-item">
            <label class="">机构内部招标编号:<span>${(itenderReview.organizationInnerTenderNo)!}</span></label>
        </div>
    </div>

</div>

<div class="layui-row">
    <div class="layui-col-sm6">
        <div class="grid-item">
            <label class="">招标项目类型:<span>${(itenderReview.tenderType)!}</span></label>
        </div>
    </div>
    <div class="layui-col-sm6">
        <div class="grid-item">
            <label class="">申报责任人:<span>${(itenderReview.applyPerson)!}</span></label>
        </div>
    </div>

</div>

<div class="layui-row">
    <div class="layui-col-sm6">
        <div class="grid-item">
            <label class="">招标方式:<span>${(itenderReview.tenderMethod)!}</span></label>
        </div>
    </div>
    <div class="layui-col-sm6">
        <div class="grid-item">
            <label class="">招标组织形式:<span>${(itenderReview.tenderBehavior)!}</span></label>
        </div>
    </div>

</div>


<div class="layui-row">
    <div class="layui-col-sm12">
        <div class="grid-item">
            <label class="">招标内容:<span>${(itenderReview.tenderContent)!}</span></label>
        </div>
    </div>

</div>

<fieldset class="layui-elem-field layui-field-title">

</fieldset>


<div class="layui-row">
    <div class="layui-col-sm6">
        <div class="grid-item">
            <label class="">招标单位联系人:<span>${(itenderReview.tenderContact)!}</span></label>
        </div>
    </div>
    <div class="layui-col-sm6">
        <div class="grid-item">
            <label class="">招标单位联系方式:<span>${(itenderReview.tenderMobile)!}</span></label>
        </div>
    </div>

</div>

<div class="layui-row">
    <div class="layui-col-sm6">
        <div class="grid-item">
            <label class="">代理机构联系人:<span>${(itenderReview.agencyContact)!}</span></label>
        </div>
    </div>
    <div class="layui-col-sm6">
        <div class="grid-item">
            <label class="">代理机构联系方式:<span>${(itenderReview.agencyMobile)!}</span></label>
        </div>
    </div>

</div>


<div class="layui-row">
    <div class="layui-col-sm12">
        <div class="grid-item">
            <label class="">招标条件:<span>${(itenderReview.tenderCondition)!}</span></label>
        </div>
    </div>

</div>



<style>
    .grid-item {
        padding: 7.5px;
        text-align: left;
    }
</style>

<script type="text/javascript">

    layui.use(['itenderReview'], function () {


    });

</script>

