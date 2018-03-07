<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>综改区监督平台 - 登录</title>
    <#include "resource.ftl">
    <style>
        .login {
            margin-top: 15%;
        }
    </style>
</head>
<body>

<div class="layui-container login">
    <div class="layui-row">
        <div class="layui-col-md6 layui-col-md-offset3">
            <form action="/login" method="post" class="layui-form">
                <div class="layui-form-item">
                    <div class="layui-input-block">
                        <h2 style="text-align: center">登录</h2>
                    <div class="layui-word-aux">默认用户名和密码:admin/123</div>
                    </div>
                </div>
                <div class="layui-form-item">
                    <label class="layui-form-label" for="username">用户名</label>
                    <div class="layui-input-block">
                        <input type="text" class="layui-input" name="username" id="username" lay-verify="username" lay-verType="tips" placeholder="用户名">
                    </div>
                </div>
                <div class="layui-form-item">
                    <label class="layui-form-label" for="password">密码</label>
                    <div class="layui-input-block">
                        <input type="password" class="layui-input" name="password" id="password" lay-verify="password" lay-verType="tips" placeholder="密码">
                    </div>
                </div>
                <div class="layui-form-item">
                    <label class="layui-form-label" for="password">验证码</label>
                    <div class="layui-input-inline">
                        <input type="text" class="layui-input" name="captcha" id="captcha" lay-verify="captcha" lay-verType="tips" placeholder="验证码">
                    </div>
                    <div class="layui-form-mid layui-word-aux" id="verifyImgDiv"><img id="verifyImg" src="management/user/code" style="height: 35px;margin-top: -7px;" title="点击刷新验证码">(区分大小写)</div>
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
            $("#verifyImgDiv").empty().append('<img id="verifyImg" src="management/user/code?'+time+'" style="height: 35px;margin-top: -7px;" title="点击刷新验证码">(区分大小写)');
        });

	  });
</script>
</html>