<%@page language="java" contentType="text/html; charset=utf-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%><%@taglib prefix="util" uri="http://www.mhb.com/jsp/jstl/util"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
	<head>
	<script type='text/javascript' src='<%=request.getContextPath()%>/dwr/interface/ChatManager.js'></script>
	<script type='text/javascript' src='<%=request.getContextPath()%>/dwr/engine.js'></script>
	<script type='text/javascript' src='<%=request.getContextPath()%>/dwr/util.js'></script>
		
	<jsp:include page="/common/link.jsp" />
	 <style type="text/css">
	 	.nav a{color:#fff;font-weight:bold;padding-left:20px;padding-right:20px;}
	 	.nav ul{line-height:35px;padding:0px;}
	 	.nav li{line-height:35px;height:35px;float:left;}
	 	#snseach h1{font-weight:normal}
	 	
	 	.help_left{float:left;width:230px;border:1px solid #ccc;line-height:23px;}
	 	.help_left_head{width:230px;line-height:30px;text-align:left;}
	 	.help_left_head h3{font-weight:normal;}
	 	.help_left_item{width:230px;border-top:1px solid #ccc;line-height:30px;}
	 	.help_left_item_content{padding-left:15px;border-top:1px solid #ccc;}
	 	.help_left_item h3{font-size:14px;font-weight:normal;font-family:"微软雅黑";cursor:pointer;}
		
		.help_right{float:right;width:767px;text-align:center}
		.help_right_div{border:1px solid #ccc;line-height:28px;margin-top:0px;padding:0px;text-align:left}
		.help_right_title{width:96%;border-bottom:1px solid #ccc;line-height:28px;margin-left:auto;margin-right:auto}
		.help_right_content{padding-left:20px;padding-top:10px;}
		.help_right_content ul{list-style:none;margin-top:0px;padding:0px}
		.help_right_content li{float:left;line-height:28px;width:50%;height:28px;}
		.help_right_content span{padding-left:5px;padding-right:5px;}
		a:hover{color: #f60;}
		.nav a:hover{color:yellow;}
	 </style>
	 </head>
	<body>
	<div id="header">
		<div id="headerTopArea">
			<p class="login-info" id="regit">
				<span id="ECS_MEMBERZONE"> 您好，欢迎光临${util:property('business.platformName')}电子招投标交易平台！ <c:choose>
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
			服务中心
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
				<li><a class="a1" href='${pageContext.request.contextPath}/yjfk.jsp'>意见反馈</a></li>
				<li><a class="a1" href='${pageContext.request.contextPath}/jbts.jsp'>举报投诉</a></li>
			</ul>
		</div>
		<div class='help_left'>
			<div class='help_left_head'>
				<h4>帮助分类</h4>
				<div class='help_left_item'>
					<h4>我是招标人</h4>
				</div>
				<div class='help_left_item_content'>
					<ul>
						<li>注册与登录</li>
						<li>我要招标</li>
						<li>创建委托合同</li>
						<li>审核标书</li>
						<li>确定中标</li>
					</ul>
				</div>
				<div class='help_left_item'>
					<h4>我是代理机构</h4>
				</div>
				<div class='help_left_item_content'>
					<ul>
						<li>签订代理合同</li>
						<li>任务委派</li>
						<li>审核标书</li>
						<li>进度控制</li>
					</ul>
				</div>
				<div class='help_left_item'>
					<h4>我是代理人</h4>
				</div>
				<div class='help_left_item_content' style='display: none'>
					<ul>
						<li>任务签收</li>
						<li>标书制作</li>
						<li>标书加密解密</li>
						<li>标书上传</li>
						<li>制作招标公告</li>
					</ul>
				</div>
				<div class='help_left_item'>
					<h4>我是投标人</h4>
				</div>
				<div class='help_left_item_content' style='display: none'>
					<ul>
						<li>暂无内容！</li>
					</ul>
				</div>
			</div>
		</div>
		
		<div class='help_right'>
			<div class='help_right_div'>
				<div class='help_right_title'>
					<h4>热门问题</h4>
				</div>
				<div class='help_right_content'>
					<ul>
						<li><a href=''>~ 用户注册和登录</a></li>
						<li><a href=''>~ 标书费用支付</a></li>
						<li><a href=''>~ 保证金支付</a></li>
						<li><a href=''>~ 标书加密</a></li>
						<li><a href=''>~ 标书上传</a></li>
					</ul>
						<div style='clear:both;'></div>
				</div>
			</div>
			<div class='blank10'></div>
			<div class='help_right_div'>
				<div class='help_right_title'>
					<h4>快速引导</h4>
				</div>
				<div class='help_right_content'>
					<div style='float:left;width:50%'>
						<h4>账户管理</h4>
						<div >
							<a href=''>用户注册</a> <span>|</span> 
							<a href=''>密码忘记</a>
						</div>
					</div>
					<div style='float:left;width:50%'>
						<h4>我是投标人</h4>
						<div >
							<a href=''>标书费用支付</a><span>|</span> 
							<a href=''>招标文件下载</a><span>|</span> 
							<a href=''>标书制作</a><span>|</span> 
							<a href=''>标书加密</a><span>|</span> 
							<a href=''>标书解密</a><span>|</span>
							<a href=''>开标签到</a>
						</div>
					</div>
					<div style='float:left;width:50%'>
						<h4>我是代理人</h4>
						<div >
							<a href=''>制作招标文件</a><span>|</span> 
							<a href=''>发布招标公告</a><span>|</span> 
							<a href=''>开标确认</a>
						</div>
					</div>
					<div style='clear:both;'></div>
				</div>
			</div>
			<div class='blank10'></div>
			<div class='help_right_div'>
				<div class='help_right_title'>
					<h4>新手入门</h4>
				</div>
				<div class='help_right_content'>
					<a href=''>我要招标</a><span>|</span> 
					<a href=''>我要投标</a><span>|</span> 
					<a href=''>成为会员</a>
				</div>
			</div>
		</div>
	</div>
	<script src="${pageContext.request.contextPath}/plug-in/easyui/jquery-1.8.2.min.js" type="text/javascript"></script>
	<script type="text/javascript">
		$(function(){
			$('.help_left_item > h4').hover(function(){
				$(this).css({"cursor":"pointer"});
			}).click(function(){
				$(this).parent("div").next('.help_left_item_content').toggle();
			});
		});	
	</script>
</body>
</html>

