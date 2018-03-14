<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>综改区监督平台 - 登录</title>
    <#include "resource.ftl">
 <#include "dashboard_top_menus.ftl">
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
            background-color: #0069ae;
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
                山西省综改区公共资源交易监督系统
            </div>
        </header>

        <div class="layui-row" style="">

                <form action="/login" method="post" class="layui-form">

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
                        <div class="layui-input-inline" style="width: 115px;font-size: 12px">
                            <input type="text" class="layui-input" name="captcha" id="captcha" lay-verify="captcha" lay-verType="tips" placeholder="输入验证码">
                        </div>
                        <div class="layui-form-mid layui-word-aux" id="verifyImgDiv"><img id="verifyImg" src="management/user/code" style="height: 35px;margin-top: -7px;" title="验证码"> (验证码)</div>
                    </div>
                    <div class="layui-form-item">
                        <div class="layui-input-block">
                            <button type="submit" class="layui-btn layui-btn-default layui-btn-block" lay-submit lay-filter="login" style="width: 100%">
                                登录
                            </button>
                        </div>
                    </div>
                </form>
        </div>
    </div>


</div>
</body>
<script>
    layui.use(['form','layer','itenderUser'], function () {
        var form = layui.form;
        var itenderUser = layui.itenderUser;
        var layer = layui.layer;

  		form.verify({
            username: function (value, item) {
                if (value.length == 0) return "用户名不能为空"
            },
            password: function (value, item) {
                if (value.length == 0) return "密码不能为空"
            },
            captcha: function (value, item) {
                if (value.length == 0) return "验证码不能为空"
            }
        });
        form.on('submit(login)', function(data){
            var formData = data.field;
			console.log(formData);
            itenderUser.userLogin(formData);//用户登录
			return false;
		});

        $("#verifyImgDiv").click(function () {
            var time = new Date().getTime();
            $("#verifyImgDiv").empty().append('<img id="verifyImg" src="management/user/code?'+time+'" style="height: 35px;margin-top: -7px;" title="点击刷新验证码"> (验证码)');
        });

	  });
</script>
</html>