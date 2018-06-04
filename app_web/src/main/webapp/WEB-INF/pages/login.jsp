<%@page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="util" uri="http://www.mhb.com/jsp/jstl/util"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib prefix="sys" tagdir="/WEB-INF/tags/sys" %>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>欢迎使用${util:property('business.platformName')}电子交易平台</title>
    <link href="/resources/portal/yc-css/yc-public.css" type="text/css" rel="stylesheet"/>
    <link href="/resources/portal/yc-css/yc-main.css" type="text/css" rel="stylesheet"/>
    <script type="text/javascript" src="/resources/portal/yc-js/jquery-1.4.2.min.js"></script> 
    <script type="text/javascript" src="/resources/jquery-plugins/jquery.cookie.js"></script>
    <script type="text/javascript" src="/resources/portal/yc-js/jquery.SuperSlide.2.1.1.js"></script>
    <script type="text/javascript">
		var ctx = "${pageContext.request.contextPath}";
	</script>
	
	<link href="/resources/easyui/themes/tender/extendsEasyUI.css" rel="stylesheet" type="text/css" />
	<link href="/resources/easyui/themes/icon.css" rel="stylesheet" type="text/css" />
	<script src="/resources/easyui/jquery.easyui.min.js" type="text/javascript"></script>
	<script src="/resources/easyui/locale/easyui-lang-zh_CN.js" type="text/javascript"></script>
	<link href="/resources/validform/css/button.css" type="text/css" media="all" rel="stylesheet" />
	<script src="/resources/jquery-plugins/jquery.cookie.js" type="text/javascript"></script>
	<script src="/resources/jquery-plugins/jquery.form.min.js" type="text/javascript"></script>
	
	<script type="text/javascript" src="/resources/ca/LoadJITDsign.js"></script>
	<script type="text/javascript" src="/resources/ca/LoadSXCACertInfo.js"></script>
	<script type="text/javascript" src="/resources/md5.js"></script>
	<script type="text/javascript">
		var CertInfo = document.getElementById("CertInfo");
		function checkIsIE() {
			return /(msie\s|trident.*rv:)([\w.]+)/.exec(navigator.userAgent.toLowerCase()) != null ? !0 : !1
		}
		window.onload = function() {
			if (!checkIsIE) {
				alert("请使用IE内核的浏览器！！！");
				return;
			}
		};
		function sign(){ 
			var randomStr = "${pageContext.request.session.id}";
			JITDSignOcx.Initialize(InitParam);
			JITDSignOcx.SetCertChooseType(1);
			//调用JITDSignOcx的选择证书
//			JITDSignOcx.SetCert("SC", "", "", "", "CN=ShanXi Digital Certificate Authority,O=ShanXi Digital Certificate Authority,L=TaiYuan,S=ShanXi,C=CN", "");
			JITDSignOcx.SetCert("SC", "", "", "", "", "");
			if (JITDSignOcx.GetErrorCode() != 0) {
				alert("错误码：" + JITDSignOcx.GetErrorCode() + "　错误信息：" + JITDSignOcx.GetErrorMessage(JITDSignOcx.GetErrorCode()));
				JITDSignOcx.Finalize();
				return false;
			}
			//带原文的数字签名
			var signStr = JITDSignOcx.AttachSignStr("", randomStr);
			if (JITDSignOcx.GetErrorCode() != 0) {
				alert("错误码：" + JITDSignOcx.GetErrorCode() + " 错误信息：" + JITDSignOcx.GetErrorMessage(JITDSignOcx.GetErrorCode()));
				JITDSignOcx.Finalize();
				return false;
			}
			$("#signvalue").val(signStr);
			JITDSignOcx.Finalize();
			return true;
		}
		function add() {
		    var sumab=CertInfo.add();
			alert(sumab);
		}

		function del() {
		    CertInfo.DelContainer("HaiTai Cryptographic Service Provider 20056");
		}

		function dels() {
			CertInfo.DelContainers("HaiTai Cryptographic Service Provider 20056");
		}

		function getcsp(){
			var cspname=CertInfo.GetProviders();
			return cspname;
		}

		function removebadcsp(){
			var result=CertInfo.RemoveBadCSP();
			return result;
		}
		function checkUSBKeyInsert(){
			try{
				if(CertInfo.GetProviders()!=""){
					var certsubject=CertInfo.GetKeyCertInfo();
					if(certsubject!=""){
						var certJson=eval("("+certsubject+")");
						var organName=certJson[0]["SequenceSubject"].split(",")[0].split("=")[1];
						//var loginName=eval("("+certsubject+")")[0]["SequenceSubject"].split(",")[1].split("=")[1];
						$(".login_info").html("<marquee>您好，"+organName+"用户</marquee>");
						$(".login_info").prev().removeClass("key_no").addClass("key_yes");
						window.clearInterval(timer1);
						timer2=window.setInterval(checkUSBKeyRemove,1000);
					}
				}
			}catch(e){
				
			}
		}
		function checkUSBKeyRemove(){
			if(CertInfo.GetProviders()==""){
				$(".login_info").html("&nbsp;");
				$(".login_info").prev().addClass("key_no").removeClass("key_yes");
				window.clearInterval(timer2);
				timer1=window.setInterval(checkUSBKeyInsert,1000);
			}
		}
		var timer2=undefined;
		var timer1=window.setInterval(checkUSBKeyInsert,1000);
		
		
	</script>
</head>
<body>
<!--1  头部----------------------------------------------------------------------------->
<div class="headE1">
    <div class="ctr1">
        <div class="pos0 left">
            您好！欢迎使用${util:property('business.platformName')}电子招标投标交易平台。     服务热线：${util:property('hotline')}
        </div>
        <div class="right pos0">
            <a href="${util:property('frontEnd')}">返回首页</a> | <a href="${util:property('frontEnd')=='/'?'':util:property('frontEnd')}/aboutUs" target="_blank">关于我们</a>
        </div>
    </div>
</div>
<div class="clear"></div>
<!--2   LOGO+搜索----------------------------------------------------------------------->
<div class="ctr1 logoCtr1 ">
    <!--2.1 logo+名称   LOGO图标在CSS样式中-->
    <div class="logo left" style="margin-top: 30px;">
        <span>
            <!-- <p>${util:property('business.platformName')}</p>
            <p>电子招标投标交易平台</p> -->
        </span>
    </div>
</div>
<div id="codeDiv" ></div>
<div class="clear"></div>
<div class="login_main">
    <div class="ctr1 login_im">
        <div class="login_main_box">
            <div class="hd">
                <ul class="login_lab">
                    <li class="login_now" id="Simple">账号登录</li>
                    <li id="USBKey">KEY登录</li>
                </ul>
            </div>
            <div class="clear"></div>
           	<div class="bd">
                <ul>
                    <li>
                        <!--账号登录-->
                        <div class="login_form">
	                        <form action="/login" method="post" id="zhLogin" onsubmit="return encrypt();">
	                            <div style="color:#F00;height:40px;margin-top:0px;text-align:center" id="message">${message}</div>
	                            <div class="login_fo yc_username ">
	                                <span></span>
	                                <input id="loginName" type="text"  name="username" />
	                                 <input id="verify" type="hidden"  name="verify" />
	                                
	                            </div>
	                            <div class="login_fo yc_password ">
	                                <span></span>
 	                                <input id="loginPwd" type="password"  name="password" />
	                            </div>
	                            <input type="text"  name="validateCode" hidden="true" />
	                            <input type="text"  name="isVerify" hidden="true" value="${isVerify}"/>
	                            <script type="text/javascript">
	                            function foo(){  
									alert("请联系管理员，电话号码：0351-5288092");
								}  
	                            </script>
	                            <span class="right"><a onClick="return foo();">忘记密码</a></span>
	                            <div class="clear"></div>
	                            <input id="swiftLogin" class="login_fo yc_button" type="submit" value="立即登录"/>
	                            <span>没有账号？<a style="color: #1caceb;" href="/regist">免费注册</a></span>
	                       	</form>
                        </div>
                    </li>
                </ul>
                <ul>
                    <li>
                        <!--KEY登录-->
                        <div class="login_form">
                        	<form action="${util:property('backEnd')}/login" method="post" onsubmit="return sign();">
								<div style="color:#F00;height:40px;margin-top:0px;text-align:center">${message}</div>
                        		<input type="hidden" name="signvalue" id="signvalue" />
	                            <div class="key_no"></div>
	                            <div class="login_info">&nbsp;</div>
	                            <div>&nbsp;&nbsp;&nbsp;&nbsp;选择登陆角色：<select id="loginRole" name="loginRole" style="width:120px;height:23px">
	                            	<option value="1000001">招标机构</option>
	                            	<option value="1000003">投标机构</option>
	                            	<option value="1000002">代理机构</option>
	                            </select></div>
	                            <div style="height:5px;">&nbsp;</div>
	                            <input class="login_fo yc_button" type="submit" value="立即登录"/>
	                            <span>无法识别KEY？<a style="color: #1caceb;" href="/resources/ePass3003-SimpChinese.exe">下载驱动</a></span>
                        	</form>
                        </div>
                    </li>
                </ul>
        	</div>
        </div>
        <script type="text/javascript">
            jQuery(".login_main_box").slide({effect:"left",trigger:"click"});
            $(".login_lab li").bind("click",function(){
                $(this).addClass("login_now").siblings().removeClass("login_now");
                $.cookie("LOGIN_TYPE",$(this).attr("id"),{expires:7});
            });
           $("#"+$.cookie("LOGIN_TYPE")).click();
        </script>
    </div>
</div>
<div class="clear"></div>
<div class="ctr1 footEr1">
	<p class="center">Copyright ® 2001-2017 版权所有 备案/许可证编号为：晋ICP备16006701号</p>
	<p class="center">山西${util:property('business.platformName')}网 山西${util:property('business.platformName')}有限公司 电话：${util:property('hotline')}</p>
</div>
<div class="clear"></div>
<!-- 7底部栏 -->
<div class="foot1"></div>
<div class="clear"></div>
<c:if test="${isVerify==1}">
	<div id="disagreeDiv" >
		<div class="login_fo yc_captcha " style="width: 300px; margin-top:10px; margin-left: 3px; ">
		<span style="width: 80px;"><img src="${pageContext.request.contextPath}/code" id='codeImage' onclick="chageCode()" title="图片看不清？点击重新得到验证码" style="cursor: pointer;">
		</span>
		<input type="text" id="captcha" />
		</div>
	</div>
</c:if>
</body>
</html>
<script type="text/javascript" src="/resources/ca/encryption.js"></script>
<script type="text/javascript" >
function chageCode(){
    $('#codeImage').attr('src','${pageContext.request.contextPath}/code?'+Math.random());//链接后添加Math.random，确保每次产生新的验证码，避免缓存问题。
}
$(function(){
	var isVerify=$("input[name='isVerify']").val();
	if(isVerify==1){
		$("#disagreeDiv").dialog({
			open : false,
			title : '验证码',
			closed:true,
			modal:true,
			width:320,
			height:180,
			buttons:[
				{text:"确定",handler:function(){
							$("#zhLogin").submit();
				}},
			]
		});
	}
});
function encrypt() {  
	if($.trim($("#loginName").val()).length==0||$.trim($("#loginPwd").val()).length==0){
		$("#message").html("用户名密码不能为空！");
	}else if($("input[name='isVerify']").val()==1&&$("#captcha").val()==""){
		$("#disagreeDiv").dialog("open");
	}else{
		$("input[name='validateCode']").val($("#captcha").val());
		$("#loginPwd").val(encode64($("#loginPwd").val()));
		$("#verify").val((b64_md5(Utf8Encode($("#loginName").val()))));
		$("#verify").val($("#verify").val()+(b64_md5(Utf8Encode($("#loginPwd").val()))));
		return  true;
	}
	return  false;
}
</script>