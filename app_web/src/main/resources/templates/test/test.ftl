<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>交易平台 - 测试</title>
    <#include "../resource.ftl">
    <script src="/js/encryption.js"></script>
    <script src="/js/md5.js"></script>
    <link rel="stylesheet" href="/css/mui.min.css">
    <style>

        #background {
            margin-top: 1px;
            height: 100%;
            width: 100%;
            background: url("/css/img/login_bg.jpg") no-repeat;
            background-size: 100%;
            background-size:cover;
            background-position:center;

        }
        .login-label {
            text-align: center;
            font-size: 16px;
            background-color: #0154AD;
            color: white;
            border-top-left-radius:8px;
            border-top-right-radius:8px;
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
<body>

<div id="background" class="layui-container login  mui-fullscreen">
    <div align="center" class="mui-content mui-card" style="margin:0 auto;width:380px; height: 420px;background-color:#f6f6f6;z-index: 1000; margin-top: 15%;">
        <header id="exam_label_bg" class="box-label-div">
            <div  class="login-label">
               测试系统
            </div>
        </header>

        <div class="layui-row" style="">


                    <div class="layui-form-item">

                        <div class="layui-input-block">
                            <input type="text" class="layui-input" name="username" id="username" lay-verify="username" lay-verType="tips" placeholder="请输入用户名">
                        </div>
                    </div>
                    <div class="layui-form-item">

                        <div class="layui-input-block">
                            <input type="password" class="layui-input" name="password" id="password" lay-verify="password" lay-verType="tips" placeholder="请输入密码">
                        </div>
                    </div>
                    <div class="layui-form-item">
                        <div class="layui-input-block">
                            <button id="login" type="submit" class="layui-btn layui-btn-default layui-btn-block" lay-submit lay-filter="login" style="width: 100%">
                                登录
                            </button>
                        </div>
                    </div>

            <div class="layui-form-item">
                <div class="layui-input-block">

                    <button id="logout" type="submit" class="layui-btn layui-btn-default layui-btn-block" lay-submit lay-filter="login" style="width: 100%">
                        登出
                    </button>
                </div>
            </div>


            <div class="layui-form-item">
                <div class="layui-input-block">
                    <button id="createProject" type="submit" class="layui-btn layui-btn-default layui-btn-block" lay-submit lay-filter="login" style="width: 100%">
                        新建項目
                    </button>
                </div>
            </div>

        </div>
    </div>


</div>
</body>
<script>
    layui.use(['form','layer','itenderUser'], function () {
        var form = layui.form;
        var itenderUser = layui.itenderUser;
        var layer = layui.layer;

        $("#login").show();
        $("#logout").hide();

       $("#login").click(function () {
           var password = encode64($("#password").val());
           var  verify = (b64_md5(Utf8Encode($("#username").val())));
           verify = verify+(b64_md5(Utf8Encode(password)));
           var username = $("#username").val();


           $.ajax({
               url: "/test/login",
               type: "POST",
               dataType: "json",
               data: {password:password,verify:verify,username:username},
               success: function (res) {
                   if(res!=null){
                       if(res.status){
                           alert("登陸成功!");
                           $("#login").hide();
                           $("#logout").show();
                       }else{
                           alert("登陸失敗!");
                       }
                   }
               },
               error: function (xmlHttpReq, error, ex) {
                   alert("登陸失敗!");
               }
           })
       });

        $("#createProject").click(function () {

            $.ajax({
                url: "/test/createProject",
                type: "POST",
                dataType: "json",
                data: {},
                success: function (res) {

                    if(res!=null){
                        if(res.status){
                            alert("創建成功!");

                        }else{
                            alert("創建失敗!"+ res.msg);
                        }
                    }
                },
                error: function (xmlHttpReq, error, ex) {
                    alert("創建失敗!");
                }
            })
        });


        $("#logout").click(function () {

            $.ajax({
                url: "/test/logout",
                type: "POST",
                dataType: "json",
                data: {},
                success: function (res) {
                    alert("登出成功!");
                    $("#login").show();
                    $("#logout").hide();
                },
                error: function (xmlHttpReq, error, ex) {

                }
            })
        });



    });
</script>
</html>
