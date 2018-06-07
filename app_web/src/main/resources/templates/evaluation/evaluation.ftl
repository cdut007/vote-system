<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>交易平台 - 算法测试</title>
    <#include "../resource.ftl">
    <script src="/js/encryption.js"></script>
    <script src="/js/md5.js"></script>
    <style>


        .login-label {
            text-align: center;
            font-size: 16px;
            background-color: #ff0000;
            color: white;
            padding: 12px 10px 12px 10px;
        }
        .mui-card{
            border-radius: 10px;
        }
        .layui-input-block {
            margin-left: 0px;
            margin:0 auto;
        }
        .layui-row{
            padding-left: 40px;
            padding-right: 40px;
            height: 100%;
            padding-top: 60px;
        }



    </style>
</head>
<body style="background-color: whitesmoke">

<div id="background" >

    <div  class="login-label" id="title">
        算法测试系统
    </div>

    <div align="center" class="" style="margin:0 auto;background-color:#f6f6f6;z-index: 1000; ">

         <div style="width: 900px">

             <button id="add_btn" class="layui-btn layui-btn-default layui-btn-block"   style="width: 45%;margin-top: 60px;margin-bottom: 60px">
                 添加投标单位
             </button>


             <div id="add_item" class="layui-form-item">

             </div>

         </div>


        <div class="layui-row" style="">

            <form class="layui-form" action="">

                <select id="industry_item" name="industry" lay-verify="required" lay-filter="industry_select">
                    <option value="">请选择行业类型</option>
                    <option value='2'>交通</option>
                    <option value='1'>房建</option>
                    <option value='3'>市政</option>
                </select>
            </form>

            <form class="layui-form" action="">
                <select id="strategyType_item" name="strategyType" lay-verify="required" lay-filter="strategyType_select">
                    <option value="">请选择算法类型</option>
                    <option value='1'>合理低价法</option>
                </select>
            </form>

            <form id="subStrategy" class="layui-form" action="" style="display: none">
                <select id="subStrategyType_item" name="subStrategyType" lay-verify="required" lay-filter="subStrategyType_select">
                    <option value="">评标基准价计算方法</option>
                    <option value='1'>评标基准价计算方法1</option>
                    <option value='2'>评标基准价计算方法2</option>
                    <option value='3'>评标基准价计算方法3</option>
                </select>
            </form>

            <div class="layui-inline">
                <label class="layui-form-label">最高限价</label>
                <div class="layui-input-inline">
                    <input value="66000000" type="text" class="layui-input" id="controlPrice" placeholder="输入最高限价..."  lay-verify="required">
                </div>

            </div>

            <div class="layui-inline">
                <label class="layui-form-label">下浮系数</label>
                <div class="layui-input-inline">
                    <input type="text" class="layui-input" id="controlRatio" placeholder="输入下浮系数..." value="0.03">
                </div>

            </div>

            <div class="layui-inline">
                <label class="layui-form-label">评标基准价系数</label>
                <div class="layui-input-inline">
                    <input type="text" class="layui-input" id="ratio" placeholder="输入评标基准价系数..." value="0.96">
                </div>

            </div>

            <div class="layui-inline">
                <label class="layui-form-label">加权系数</label>
                <div class="layui-input-inline">
                    <input type="text" class="layui-input" id="weightedRatio" placeholder="输入加权系数..." value="0.4">
                </div>

            </div>

            <div class="layui-inline">
                <label class="layui-form-label">评标价E值上限</label>
                <div class="layui-input-inline">
                    <input type="text" class="layui-input" id="HighERatio" placeholder="输入E值上限..." value="2">
                </div>

            </div>

            <div class="layui-inline">
                <label class="layui-form-label">评标价E值下限</label>
                <div class="layui-input-inline">
                    <input type="text" class="layui-input" id="LowERatio" placeholder="输入E值下限..." value="1">
                </div>

            </div>

                    <div class="layui-form-item">
                        <div class="layui-input-block">
                            <button id="calculate" type="submit" class="layui-btn layui-btn-default layui-btn-block" lay-submit lay-filter="calculate" style="width: 100%">
                                计算
                            </button>
                        </div>

                    </div>


        </div>

        <div  id="info" class="layui-tab-item layui-show">

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

    layui.use(['form','layer','table','laydate'], function () {
        var form = layui.form;
        var itenderUser = layui.itenderUser;
        var layer = layui.layer;
        var table = layui.table;
        var strategyType;
        var subStrategyType;
        var industry;
        var items=[];

        form.render();
        form.on('select(subStrategyType_select)', function(data){
            subStrategyType = data.value;

            return false;
        });
        form.on('select(strategyType_select)', function(data){
            strategyType = data.value;
            if(strategyType == 1){
                $("#subStrategy").show();
            }else{
                $("#subStrategy").hide();
            }
            return false;
        });

        form.on('select(industry_select)', function(data){
            industry = data.value;

            return false;
        });

        function createURL(url, param) {
            var urlLink = '';
            $.each(param, function(item, key) {
                var link = '&' + item + "=" + key;
                urlLink += link;
            })
            urlLink = url + "?" + urlLink.substr(1);
            return urlLink.replace(' ', '');
        }

        var addContainer = $('#add_item');
        $("#add_btn").click(function () {
            var index = items.length;
            items.push(index);
            var item=$(' <div class="layui-inline">\n' +
                    '                     <label class="layui-form-label">投标单位'+(index+1)+'</label>\n' +
                    '                     <div class="layui-input-inline">\n' +
                    '                         <input  id="tender'+index+'" lay-verify="required" autocomplete="off" class="layui-input" value="投标单位'+(index+1)+'">\n' +
                    '\n' +
                    '                     </div>\n' +
                    '                 </div>\n' +
                    '                 <div class="layui-inline">\n' +
                    '                     <label class="layui-form-label">投标金额</label>\n' +
                    '                     <div class="layui-input-inline">\n' +
                    '                         <input type="text" id="price'+index+'" lay-verify="required" autocomplete="off" class="layui-input" value="66000000">\n' +
                    '                     </div>\n' +
                    '                 </div>');
            addContainer.append(item);
        });


        $("#calculate").click(function () {

           if(!industry){
               layer.msg("选择行业类型!");
               return;
           }

            if(!strategyType){
                layer.msg("选择算法类型!");
                return;
            }

            var tenders=[];


            for (var i = 0; i <  items.length; i++) {
                var index = items[i];
                tenders.push( {id:$("#tender"+index).val(),price:$("#price"+index).val(),selected:true});
            }


            var data ={controlPrice:$("#controlPrice").val(),controlRatio:$("#controlRatio").val(),ratio:$("#ratio").val(),weightedRatio:$("#weightedRatio").val(),
                LowERatio:$("#LowERatio").val(),HighERatio:$("#HighERatio").val(),catagory:industry,strategyType:strategyType,strategySubType:subStrategyType}
            $.ajax({
               url: createURL("/evaluation/calculate",data),
               type: "POST",
               dataType: "json",
                contentType: "application/json",
               data: JSON.stringify(tenders),
               success: function (res) {

                   if(res!=null){
                       if(res.code == 0){
                           layer.msg("计算成功!");
                           $('#info').text('最终最高限价：'+res.data.finalControlPrice+
                                   ' 理论成本价：'+res.data.reasonableCostPrice+
                                   ' 基准价：'+res.data.benchmarkPrice);
                           //展示已知数据
                           table.render({
                               elem: '#taskTable'
                               ,cols: [[ //标题栏
                                   {field: 'id', title: 'ID', width: 280, sort: true}
                                   ,{field: 'deviationValue', title: '偏离值', width: 120}
                                   ,{field: 'price', title: '报价', minWidth: 150}
                                   ,{field: 'score', title: '得分', minWidth: 160}
                               ]]
                               ,data: res.data.tenders
                               //,skin: 'line' //表格风格
                               ,even: true
                               //,page: true //是否显示分页
                               //,limits: [5, 7, 10]
                               //,limit: 5 //每页默认显示的数量
                           });
                       }else{
                           layer.msg("错误码："+res.code+" 描述："+res.msg);
                       }
                   }
               },
               error: function (xmlHttpReq, error, ex) {

                   alert("程序计算失敗!");
               }
           })
       });



    });
</script>
</html>
