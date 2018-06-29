<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>交易平台 - 抽专家服务</title>
    <#include "../resource.ftl">
    <script src="/js/encryption.js"></script>
    <script src="/js/md5.js"></script>
    <script type="text/javascript" src="/kinggrid/Loadwebsign.js"></script>

    <style>


        .login-label {
            text-align: center;
            font-size: 16px;
            background-color: #ff0000;
            color: white;
            padding: 12px 10px 12px 10px;
        }

        .mui-card {
            border-radius: 10px;
        }

        .layui-input-block {
            margin-left: 0px;
            margin: 0 auto;
        }

        .layui-row {
            padding-left: 40px;
            padding-right: 40px;
            height: 100%;
            padding-top: 60px;
        }


    </style>
</head>
<body style="background-color: whitesmoke">

<div id="background">

    <div class="login-label" id="title">
        抽专家验证系统
    </div>

    <div align="center" class="" style="margin:0 auto;background-color:#f6f6f6;z-index: 1000; ">

        <div style="width: 900px">

            <button id="apply_btn" class="layui-btn layui-btn-default layui-btn-block"
                    style="width: 45%;margin-top: 60px;margin-bottom: 60px">
                抽取专家申请表
            </button>

            <button id="expertSpecialtyEdit_btn" class="layui-btn layui-btn-default layui-btn-block"
                    style="width: 45%;margin-top: 60px;margin-bottom: 60px">
                修改抽取专家条件
            </button>

            <button id="getApplyStatus_btn" class="layui-btn layui-btn-default layui-btn-block"
                    style="width: 45%;margin-top: 60px;margin-bottom: 60px">
                查询抽取专家申请表状态
            </button>

            <button id="extract_btn" class="layui-btn layui-btn-default layui-btn-block"
                    style="width: 45%;margin-top: 60px;margin-bottom: 60px">
                发送抽取请求
            </button>

            <button id="getExtractResult_btn" class="layui-btn layui-btn-default layui-btn-block"
                    style="width: 45%;margin-top: 60px;margin-bottom: 60px">
                获取抽取结果

            </button>


            <div id="add_item" class="layui-form-item">

            </div>

        </div>


        <div class="layui-row" style="">


            <div class="layui-inline">
                <label class="layui-form-label">唯一标识（platId）</label>
                <div class="layui-input-inline">
                    <input type="text" class="layui-input" id="platId" placeholder="输入唯一标识..." lay-verify="required">
                </div>

            </div>

            <div class="layui-inline">
                <label class="layui-form-label">标段名称</label>
                <div class="layui-input-inline">
                    <input type="text" class="layui-input" id="projectItemName" placeholder="输入标段名称...">
                </div>

            </div>

            <div class="layui-inline">
                <label class="layui-form-label">公告id</label>
                <div class="layui-input-inline">
                    <input type="text" class="layui-input" id="noticeId" placeholder="输入公告Id...">
                </div>

            </div>


        </div>

        <div id="info" class="layui-tab-item layui-show">

        </div>

        <div class="layui-row">
            <div class="layui-col-md-12">
                <table class="table table-bordered table-hover" id="taskTable" lay-filter="taskTable">
                </table>
            </div>
        </div>

    </div>


</div>
</body>


<script type="text/html" id="createTimeLabel">
    {{ d.createTime}}
</script>

<script type="text/html" id="typeLabel">
</script>

<script>


    Date.prototype.format = function (format) {
        var args = {
            "M+": this.getMonth() + 1,
            "d+": this.getDate(),
            "h+": this.getHours(),
            "m+": this.getMinutes(),
            "s+": this.getSeconds(),
            "q+": Math.floor((this.getMonth() + 3) / 3),  //quarter
            "S": this.getMilliseconds()
        };
        if (/(y+)/.test(format))
            format = format.replace(RegExp.$1, (this.getFullYear() + "").substr(4 - RegExp.$1.length));
        for (var i in args) {
            var n = args[i];
            if (new RegExp("(" + i + ")").test(format))
                format = format.replace(RegExp.$1, RegExp.$1.length == 1 ? n : ("00" + n).substr(("" + n).length));
        }
        return format;
    };

    layui.use(['form', 'layer', 'table', 'laydate'], function () {
        var form = layui.form;
        var itenderUser = layui.itenderUser;
        var layer = layui.layer;
        var table = layui.table;
        var subStrategyType;
        var industry;
        var items = [];

        form.render()

        function uuid() {
            var s = [];
            var hexDigits = "0123456789abcdef";
            for (var i = 0; i < 36; i++) {
                s[i] = hexDigits.substr(Math.floor(Math.random() * 0x10), 1);
            }
            s[14] = "4";  // bits 12-15 of the time_hi_and_version field to 0010
            s[19] = hexDigits.substr((s[19] & 0x3) | 0x8, 1);  // bits 6-7 of the clock_seq_hi_and_reserved to 01
            s[8] = s[13] = s[18] = s[23] = "-";

            var uuid = s.join("");
            return uuid;
        }

        $("#platId").val(uuid());


        function createSignData(param) {
            var urlLink = '';
            $.each(param, function (item, key) {
                var link = '&' + item + "=" + key;
                urlLink += link;
            })
            urlLink = urlLink.substr(1);
            return urlLink.replace(' ', '');
        }


        function createURL(url, param) {
            var urlLink = '';
            $.each(param, function (item, key) {
                var link = '&' + item + "=" + key;
                urlLink += link;
            })
            urlLink = "/expert" + url + "?" + urlLink.substr(1);
            return urlLink.replace(' ', '');
        }

        var d1 = new Date();
        var date = d1.format('yyyyMMddhhmmss')
        var signData = {
            platId: $("#platId").val(),
            extractTerminalCode: "140000001",
            planExtractDate: date,
            bidOpenTime: date,
            bidOpenAddress: "1",
            bidEvaluateTime: date,
            bidEvaluateAddress: "1",
            tendereeOrg: "四川招标测试单位一",
            tendereePrincipal: "xhh",
            tendereePhone: "13111111111",
            agencyOrg: "四川代理机构测试1",
            agencyPrincipal: "1",
            agencyPhone: "13144444555",
            watchdogOrg: "1",
            watchdogPrincipal: "1",
            watchdogPhone: "13122222222",
            bidEvaluateCommittee: "5",
            investment: "50.0000",
            bidContent: "1",
            areaCode: "140100",
            callbackUrl: "http://www.jcebid.com/"
        }

        var expertSpecialtyWSList= [];
        var expert={"bidEvaluateTime": "-2",
            "expertCheckInAddress": "wz修改了一下",
            "expertCheckInTime": date,
            "expertCount": "5",
            "firstLevelAreaCode": "140100",
            "specialtyFirstTypeCode": "A08",
            "specialtySecondTypeCode": "A0801",
            "specialtyThirdTypeCode": "A080104"}
        expertSpecialtyWSList.push(expert);

        var avoidOrgWSList=[];
        var avoid={ "orgCode": "91140109736344762L",
            "orgName": "四川招标测试单位一"};
        avoidOrgWSList.push(avoid);
        avoid={ "orgCode": "91140109736344762L",
            "orgName": "四川投标测试单位1"};
        avoidOrgWSList.push(avoid);
        avoid={ "orgCode": "91140109736344762L",
            "orgName": "四川招标测试单位3"};
        avoidOrgWSList.push(avoid);
        avoid={ "orgCode": "91320116555505974X",
            "orgName": "投标账户2"};
        avoidOrgWSList.push(avoid);




        $("#expertSpecialtyEdit_btn").click(function () {

            var data = {}
            var editExpert={platId:$("#platId").val()};
            editExpert.expertSpecialtyWSList = expertSpecialtyWSList;
            $.ajax({
                url: createURL("/expertSpecialtyEdit", data),
                type: "POST",
                dataType: "json",
                contentType: "application/json",
                success: function (res) {

                    alert(JSON.stringify(res));
                },
                error: function (xmlHttpReq, error, ex) {

                    alert("error!=" + error);
                }
            })
        });


        $("#apply_btn").click(function () {
//设置绑定数据，content内容需严格遵守规范
            var signStr = createSignData(signData);
            console.log("signStr==" + signStr);
            //清空印章原绑定内容
            document.all.DWebSignSeal.SetSignData("-");

            document.all.DWebSignSeal.SetSignData("+DATA:" + signStr);
//设置盖章人，可以是任意值
            document.all.DWebSignSeal.SetCurrUser("盖章人");
//设置印章的位置，参数内容参考点聚WebSign开发文档
            document.all.DWebSignSeal.SetPosition(100, 10, "sealPos");
//调用盖章接口，sealName内容需严格遵守规范
            document.all.DWebSignSeal.AddSeal("", "seal");
//该方法返回签章数据，即为申请表XML节点signature 的值
            var signature = document.all.DWebSignSeal.GetStoreData();

            console.log("signature==" + signature);
            var signature = signature;
            signData.signature = signature;
            signData.remarks = $('#projectItemName').val();
            signData.expertSpecialtyWSList = expertSpecialtyWSList;
            signData.avoidOrgWSList = avoidOrgWSList;

            var relateNoticeList=[];
            var noticeId = $("#noticeId").val();
            relateNoticeList.push(noticeId);
            signData.relateNoticeList = relateNoticeList;

            var data = {platId: $("#platId").val()}
            $.ajax({
                url: createURL("/apply", data),
                type: "POST",
                dataType: "json",
                contentType: "application/json",
                data: JSON.stringify(signData),
                success: function (res) {

                    alert(JSON.stringify(res));
                },
                error: function (xmlHttpReq, error, ex) {

                    alert("error!=" + error);
                }
            })
        });


        $("#getApplyStatus_btn").click(function () {

            var data = {platId: $("#platId").val()}
            $.ajax({
                url: createURL("/getApplyStatus", data),
                type: "POST",
                dataType: "json",
                contentType: "application/json",
                success: function (res) {
                    alert(JSON.stringify(res));
                },
                error: function (xmlHttpReq, error, ex) {

                    alert("error!=" + error);
                }
            })
        });

        $("#getExtractResult_btn").click(function () {

            var data = {platId: $("#platId").val()}
            $.ajax({
                url: createURL("/getExtractResult", data),
                type: "POST",
                dataType: "json",
                contentType: "application/json",
                success: function (res) {

                    alert(JSON.stringify(res));
                },
                error: function (xmlHttpReq, error, ex) {

                    alert("error!=" + error);
                }
            })
        });

        $("#extract_btn").click(function () {

            var data = {platId: $("#platId").val()}
            $.ajax({
                url: createURL("/extract", data),
                type: "POST",
                dataType: "json",
                contentType: "application/json",
                success: function (res) {

                    alert(JSON.stringify(res));
                },
                error: function (xmlHttpReq, error, ex) {

                    alert("error!=" + error);
                }
            })
        });


    });
</script>
</html>
