<%@page pageEncoding="UTF-8"%>
<%@taglib prefix="util" uri="http://www.mhb.com/jsp/jstl/util"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
        "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>欢迎使用${util:property('business.platformName')}电子交易平台</title>
    <link href="/resources/portal/yc-css/yc-public.css" type="text/css" rel="stylesheet"/>
    <link href="/resources/portal/yc-css/yc-main.css" type="text/css" rel="stylesheet"/>
    <script type="text/javascript" src="/resources/yc-js/jquery-1.4.2.min.js"></script>
</head>
<body style="background:#8ccff5; color: #ffffff;">
<div class="unusual left ">
    <div class="un404 un_im left"></div>
    <div class="unContent right">
        <span class="un_num">403</span>
        <span class="un_con">您没有权限访问此资源。</span>
        <span class="un_info left" id="unInfo">页面将在10秒后跳转至首页</span>
        <script type="text/javascript">
            var t = 10;
            var time = document.getElementById("unInfo");
            function DownTime() {
                t--;
                time.innerHTML = "页面将在" + t + "秒后跳转至首页";
                if (t <= 0) {
                    location.href = "/portal";
                    clearInterval(timeCtr);
                }
            }
            var timeCtr = setInterval("DownTime()", 1000);
        </script>
        <a href="#"><span class="un_btn left">立即跳转</span></a>
    </div>
</div>
<div class="clear"></div>
<div class="unusual_foot"></div>

</body>
</html>