<%@page pageEncoding="utf-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%><%@taglib prefix="util" uri="http://www.mhb.com/jsp/jstl/util"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<jsp:include page="/common/link.jsp" />
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>欢迎使用金蝉科技电子交易平台</title>
<link href="/resources/css/shopping.css" type="text/css" rel="stylesheet"/>
</head>

<body>
	<div id="header">
		<div id="headerTopArea">
			<p class="login-info" id="regit">
				<span id="ECS_MEMBERZONE">
					您好，欢迎光临${util:property('business.platformName')}电子招投标交易平台！ <c:choose>
						<c:when test="${empty CURRENT_USER_SESSION_INFO}">
							<a style=" color:#F08300" href="${util:property('backEnd')}">[登录]</a>
							<a style=" color:#F08300"
								href="${util:property('backEnd')}${util:property('shiro.registUrl')}">[注册]</a>
						</c:when>
						<c:otherwise>
							<a style=" color:#F08300" href="#">${CURRENT_USER_SESSION_INFO.userName}</a>
							<a style=" color:#F08300"
								href="${util:property('shiro.logoutUrl')}">[退出]</a>
						</c:otherwise>
					</c:choose>
				</span>
			</p>
			<div id="bdshare" class="bdshare_t bds_tools get-codes-bdshare"
				style="margin-left:5px; height:20px; line-height:20px; overflow:hidden; float:left; position:relative; top:-2px;">
				<a class="bds_qzone" href=""></a> <a class="bds_tsina" href=""></a>
				<a class="bds_tqq" href=""></a> <a class="bds_renren" href=""></a> <span
					class="bds_more"></span> <a class="shareCount" href=""></a>
			</div>
			<!-- <script type="text/javascript" id="bdshare_js" data="type=tools&amp;uid=603029"></script>
		<script type="text/javascript" id="bdshell_js"></script>
		<script type="text/javascript">
			document.getElementById("bdshell_js").src = "http://share.baidu.com/static/js/shell_v2.js?cdnversion=" + new Date().getHours();
		</script> -->
			<ul class="headerMenu">
				<c:if test="${not empty CURRENT_USER_SESSION_INFO}">
					<li class="topmycar">
						<div class="qq_jiesuan snCarNav "
							onmouseover="this.className='qq_jiesuan_on snCarNav '"
							onmouseout="this.className='qq_jiesuan snCarNav '"
							id="ECS_CARTINFO">
							<form id="formCart" name="formCart" method="post"
								action="flow.php">
								<c:set var="payItemRecordCount"
									value="${payItemRecordService.createPayItemRecordQuery().fromOrganId(CURRENT_USER_SESSION_INFO.organId).unPay().count()}" />
								<a name="toolbar02" class="menuHd a1" style="width:74px;"
									href="${pageContext.request.contextPath}/pay/pagingUnPayItemRecord">购物车(<em
									id="showTotalQty">${payItemRecordCount}</em>)
								</a>
								<div class="jiesuan_t">
									<div style="padding:10px;">
										<c:choose>
											<c:when test="${payItemRecordCount==0}">
											您的购物车里还没有商品！
										</c:when>
											<c:otherwise>
												<c:forEach
													items="${payItemRecordService.createPayItemRecordQuery().fromOrganId(CURRENT_USER_SESSION_INFO.organId).unPay().list()}"
													var="item">
													<div>${item.itemName}</div>
												</c:forEach>
											</c:otherwise>
										</c:choose>
									</div>
								</div>
							</form>
						</div>
					</li>
				</c:if>
				<li><a name="toolbar01" class="a1"
					href="${util:property('shiro.successUrl')}">我的任务</a></li>
				<li><a name="toolbar01" class="a1"
					href="javascript:window.external.AddFavorite(window.location, document.title);">加入收藏</a></li>
				<!-- <li><a name="toolbar01" class="a1" href="javascript:this.style.behavior='url(#default#homepage)';this.setHomePage(window.location);">设为首页</a></li>
			<li><a name="toolbar06" class="menuHd a1" target="_blank" href="help_3198785.html">帮助中心</a></li> -->
			</ul>
		</div>
	</div>
	<div class="clearfix"></div>
	<div style="margin:0 auto;width:1000px;">
<div class="logo">
     
     <ul class="jindu">
         <li class="moren">1</li>
         <img src="/resources/images/jindutiao02.png">
         <li class="moren">2</li>
         <img src="/resources/images/jindutiao02.png">
         <li class="moren">3</li>
         <img src="/resources/images/jindutiao02.png">
         <li class="moren">4</li>
     </ul>
     <div class="wenzi">我的购物车&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;确认订单&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;付款&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;支付成功</div>
</div>
<div class="clearfix"></div>
<div class="reminder">
      <div class="red_bar">请点击“返回主页”按钮，5秒后自动跳转</div>
      <div class="reminder_wenzi"><img src="/resources/images/reminder.png"><span>恭喜您，成功交易</span></div>
      <div class="clearfix"></div>
      <div class="way">您的支付方式：<span>银联在线支付<span></div>
      <div class="order_number">您的订单号：<span>${respParam.orderId} </span></div>
      <div class="account">您的账号：<span>${respParam.accNo}</span></div>
      <div class="reminder_total">您的支付金额：<span>${(respParam.txnAmt)/100} </span></div>
      <div class="button"><a href="${util:property('shiro.successUrl')}">返回主页</a></div>
</div>
 
	
</body>
</html>   