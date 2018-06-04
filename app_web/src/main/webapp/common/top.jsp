<%@page pageEncoding="utf-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%><%@taglib prefix="util" uri="http://www.mhb.com/jsp/jstl/util"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@taglib prefix="util" uri="http://www.mhb.com/jsp/jstl/util"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<link href="/resources/portal/yc-css/yc-nav.css" type="text/css" rel="stylesheet"/>
<div id="header">
	<div id="headerTopArea">
		<p class="login-info" id="regit">
			<span id="ECS_MEMBERZONE"> 您好，欢迎光临${util:property('business.platformName')}电子招投标交易平台！ <c:choose>
					<c:when test="${empty CURRENT_USER_SESSION_INFO}">
						<a class="btn0" href="${util:property('sso.shiro.loginUrl')}">登录</a>
            			<a class="btn0" href="${util:property('shiro.registUrl')}">注册</a>
					</c:when>
					<c:otherwise>
						<a style=" color:#F08300" href="/home">${CURRENT_USER_SESSION_INFO.userName}</a>
						<a style=" color:#F08300" href="${util:property('shiro.logoutUrl')}">[退出]</a>
					</c:otherwise>
				</c:choose>
			</span>
		</p>
		<div id="bdshare" class="bdshare_t bds_tools get-codes-bdshare" style="margin-left:5px; height:20px; line-height:20px; overflow:hidden; float:left; position:relative; top:-2px;">
			<a class="bds_qzone" href=""></a> <a class="bds_tsina" href=""></a> <a class="bds_tqq" href=""></a> <a class="bds_renren" href=""></a> <span class="bds_more"></span> <a class="shareCount" href=""></a>
		</div>
		<!-- <script type="text/javascript" id="bdshare_js" data="type=tools&amp;uid=603029"></script>
		<script type="text/javascript" id="bdshell_js"></script>
		<script type="text/javascript">
			document.getElementById("bdshell_js").src = "http://share.baidu.com/static/js/shell_v2.js?cdnversion=" + new Date().getHours();
		</script> -->
		<ul class="headerMenu">
			<c:if test="${not empty CURRENT_USER_SESSION_INFO.organId}">
				<li class="topmycar">
					<div class="qq_jiesuan snCarNav " onmouseover="this.className='qq_jiesuan_on snCarNav '" onmouseout="this.className='qq_jiesuan snCarNav '" id="ECS_CARTINFO">
						<form id="formCart" name="formCart" method="post" action="flow.php">
							<c:set var="payItemRecordCount" value="${payItemRecordService.createPayItemRecordQuery().fromOrganId(CURRENT_USER_SESSION_INFO.organId).unPay().itemNameLike(\"平台使用费\").count()}"/>
							<a name="toolbar02" class="menuHd a1" style="width:74px;" href="${pageContext.request.contextPath}/pay/pagingUnPayItemRecord">购物车(<em id="showTotalQty">${payItemRecordCount}</em>)
							</a>
							<div class="jiesuan_t">
								<div style="padding:10px;">
									<c:choose>
										<c:when test="${payItemRecordCount==0}">
											您的购物车里还没有商品！
										</c:when>
										<c:otherwise>
											<c:forEach items="${payItemRecordService.createPayItemRecordQuery().fromOrganId(CURRENT_USER_SESSION_INFO.organId).unPay().itemNameLike(\"平台使用费\").list()}" var="item">
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
			<li><a name="toolbar01" class="a1" href="${util:property('shiro.successUrl')}">我的任务</a></li>
			<li><a name="toolbar01" class="a1" href="javascript:window.external.AddFavorite(window.location, document.title);">加入收藏</a></li>
			<!-- <li><a name="toolbar01" class="a1" href="javascript:this.style.behavior='url(#default#homepage)';this.setHomePage(window.location);">设为首页</a></li>
			<li><a name="toolbar06" class="menuHd a1" target="_blank" href="help_3198785.html">帮助中心</a></li> -->
		</ul>
	</div>
</div>
<div id="masthead">
	<div id="snlogo">
		<a title="" href="${pageContext.request.contextPath}/" style="margin-left: -40px;"><img src="/resources/portal/yc-images/yc-logo-65.png" height="65" width="340"/></a>
	</div>
	<div id="snseach">
		<div id="seachBox">
			<form id="searchForm" name="searchForm" method="get" action="/front_notice/pagingNotice" onsubmit="return checkSearchForm()">
				<input name="keywords" type="text" id="keyword" value="" onfocus="return myValue2();" class="snText" /> <input type="submit" value="搜 索" id="seachSumit" />
			</form>
		</div>
		<div id="snKeywordNew">
			<span>热门搜索：</span> 
			<c:forEach items="${searchRecordService.retrieveKeywordsTop('notice',4)}" var="keywords">
	   			<a style="color: #FF6600" href="javascript:window.location.href='/front_notice/pagingNotice?keywords='+encodeURI('${keywords}')">${fn:length(keywords)>5?fn:substring(keywords,0,5):keywords}${fn:length(keywords)>5?'...':''}</a> 
	   		</c:forEach>
		</div>
	</div>
	<div class="phones">
		<img src="/resources/tender/images/topBgRight.gif" />
	</div>
	<div class="clear"></div>
</div>

<div class="navBg_">
	<div class="navBg">
		<div class="ctr navSize ">
			<div class="nav_ left">
				<div class="nav_">
					<div class="navMain">
						<ul id="nav_all">
							<li><a href="${util:property('frontEnd')}">首页</a></li>
							<c:forEach items="${catalogueService.retrieveCatalogue()}" var="item">
								<c:if test="${item.display}">
									<li>
										<c:choose>
											<c:when test="${item.catalogueFlag eq 'notice'}">
												<a ${NAVIGATION eq item.catalogueFlag?"class='hover'":""} href="${empty item.catalogueURL?toolBean.concat('/front_notice/','pagingNotice'):item.catalogueURL}">${item}</a>
											</c:when>
											<c:otherwise>
												<a ${NAVIGATION eq item.catalogueFlag?"class='hover'":""} href="${empty item.catalogueURL?toolBean.concat('/front_article/',item.catalogueFlag,'/pagingArticle'):item.catalogueURL}">${item}</a>
											</c:otherwise>
										</c:choose>
										<c:if test="${not empty item.children}">
											<ul style="display: none;z-index:500;" id="nav_all_child">
												<!-- <li style="width: 30px;"></li> -->
												<c:forEach items="${item.children}" var="child">
													<li><a href="${child.catalogueURL}">${child}</a></li>
												</c:forEach>
											</ul>
										</c:if>
									</li>
								</c:if>
							</c:forEach>
						</ul>
					</div>
				</div>
				<script type="text/javascript">
					$(function () {
						var st = 180;
						$('#nav_all>li').hover(function () {
							$(this).find('ul').stop(false, true).slideDown(st);
						},function () {
							var ul=$(this).find('ul').stop(false, true);
							var timer=window.setTimeout(function(){
								ul.slideUp(st);
							},st*5);
							ul.one("mouseover",function(){
								clearInterval(timer);
							});
						});
					});
				</script>
			</div>
		</div>
	</div>
</div>