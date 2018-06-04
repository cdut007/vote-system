<%@page language="java" contentType="text/html; charset=utf-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%><%@taglib prefix="util" uri="http://www.mhb.com/jsp/jstl/util"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3c.org/TR/1999/REC-html401-19991224/loose.dtd">
<html>
	<head>
	<title>我要举报</title>
	<jsp:include page="/common/link.jsp" />
	 <style type="text/css">
	 	.nav a{color:#fff;font-weight:bold;padding-left:20px;padding-right:20px;}
	 	.nav ul{line-height:35px;padding:0px;}
	 	.nav li{line-height:35px;height:35px;float:left;}
	 	#snseach h1{font-weight:normal}
		.nav a:hover{color:yellow;}
	 </style>
	 </head>
	<body>
	<div id="header">
		<div id="headerTopArea">
			<p class="login-info" id="regit">
				<span id="ECS_MEMBERZONE"> 您好，欢迎您光临${util:property('business.platformName')}电子招投标交易平台！ <c:choose>
						<c:when test="${empty CURRENT_USER_SESSION_INFO}">
							<a style=" color:#F08300" href="login.jsp">[登录]</a>
							<a style=" color:#F08300" href="user_3599307.html">[注册]</a>
						</c:when>
						<c:otherwise>
							<a style=" color:#F08300" href="user.jsp">${CURRENT_USER_SESSION_INFO.userName}</a>
							<a style=" color:#F08300" href="${pageContext.request.contextPath}/login/logout">[退出]</a>
						</c:otherwise>
					</c:choose>
				</span>
			</p>
			<ul class="headerMenu">
				<li><a name="toolbar01" class="a1" target="_blank" href="user_3599307.html">加入收藏</a></li>
				<li><a name="toolbar01" class="a1" target="_blank" href="user_3599307.html">设为首页</a></li>
				<li><a name="toolbar06" class="menuHd a1" target="_blank" href="help_3198785.html">帮助中心</a></li>
			</ul>
		</div>
	</div>
	
	<div id="masthead">
		<div id="snlogo">
			<a title="" href="index.html"><img src="/resources/tender/images/logo.gif" /></a>
		</div>
		<div id="snseach">
			<div class='blank10'></div>
			<h1>服务中心</h1>
		</div>
		<div class="phones">
			<img src="/resources/tender/images/topBgRight.gif" />
		</div>
		<div class="clear"></div>
	</div>

	<div class='block'>
		<div class='nav'>
			<ul>
				<li><a class="a1" href='./'>首页</a></li>
				<li><a class="a1" href=''>常见问题</a></li>
				<li><a class="a1" href=''>联系客服</a></li>
				<li><a class="a1" href='yjfk.jsp'>意见反馈</a></li>
				<li><a class="a1" href='jbts.jsp'>举报投诉</a></li>
			</ul>
		</div>
	   <div id="ur_here">
		        我要举报
	    </div> 
		<div class="usBox">
		<form id='tsForm' class='registerform' method='post'>
			<table style='width:98%;line-height:30px;'>
				<tr>
					<td colspan='4' style='color:red'>投诉举报声明：您提供的信息我们将会联合监督部门认真追查核实，一旦属实，将追究相关单位的责任；同时也非常感谢您对${util:property('business.platformName')}电子招投标交易平台的关注和支持！</td>
				</tr>
				<tr>
					<td class="need">*</td>
					<td>投诉对象：</td>
					<td><input type="text" value="" style='width:40%' name="tsdx00" class="inputxt" datatype="s1-100" nullmsg="请输入投诉对象！"/></td>
					<td><div class="infostyle"><span class="Validform_checktip"></span>
							<span class="dec"><s class="dec1">&#9670;</s><s class="dec2">&#9670;</s></span></div></td>
				</tr>
				<tr>
					<td class="need">*</td>
					<td>投诉类型：</td>
					<td><input type="text" value="" style='width:40%' name="tslx00" class="inputxt" datatype="s1-100" nullmsg="请选择投诉类型！"/></td>
					<td><div class="infostyle"><span class="Validform_checktip"></span>
							<span class="dec"><s class="dec1">&#9670;</s><s class="dec2">&#9670;</s></span></div></td>
				</tr>
				<tr>
					<td class="need">*</td>
					<td>投诉内容：</td>
					<td><textarea name="tsnr00" datatype="s1-1000" style="width:650px;height:160px;overflow:hidden"></textarea></td>
					<td><div class="infostyle"><span class="Validform_checktip"></span>
							<span class="dec"><s class="dec1">&#9670;</s><s class="dec2">&#9670;</s></span></div></td>
				</tr>
				<tr>
					<td></td>
					<td>是否实名举报：</td>
					<td colspan='2'>
						<input type='radio' name='sfsmjb' id='no' value='0'/><label for='no'>否</label>
						<input type='radio' name='sfsmjb' id='yes' value='1'/><label for='yes'>是</label>		
						<input type='text' name='n1' class="inputxt"/>
					</td>
				</tr>
				<tr>
					<td class="need"></td>
					<td>联系方式：</td>
					<td><input type="text" value="" style='width:40%' name="lxfs00" class="inputxt" />
						如果您愿意协助调查，记得填写上您的联系方式哦！
					</td>
					<td><div class="infostyle"><span class="Validform_checktip"></span>
							<span class="dec"><s class="dec1">&#9670;</s><s class="dec2">&#9670;</s></span></div></td>
				</tr>
			</table>
			<button id='formBtn' class='button red' >确  定</button>
		</form>
		</div>
	</div>
	<script src="${pageContext.request.contextPath}/plug-in/easyui/jquery-1.8.2.min.js" type="text/javascript"></script>
<script type="text/javascript" src="/resources/plug-in/validform/js/Validform_v5.3.2_min.js"></script>
<script type="text/javascript">
	$(function() {
		$(".registerform").Validform(
				{
					tiptype : function(msg, o, cssctl) {
						if (!o.obj.is("form")) {
							var objtip = o.obj.parents("td").next().find(".Validform_checktip");
							cssctl(objtip, o.type);
							objtip.text(msg);
							
							var infoObj=o.obj.parents("td").next().find(".infostyle");
							if(o.type==2){
								infoObj.fadeOut(200);
							}else{
								if(infoObj.is(":visible")){return;}
								var left=o.obj.offset().left,
									top=o.obj.offset().top;
				
								infoObj.css({
									left:left+170,
									top:top-45
								}).show().animate({
									top:top-35	
								},200);
							}
										
						}
					}
				});
		
		$('#formBtn').click(function(){
			$('#formBtn').text('提交中...');
			$('#tsForm').attr('action','');
			$('#tsForm').submit();
		});
	});


</script>
</body>
</html>

